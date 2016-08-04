//
//  APIClient.m
//  EasySearch
//
//  Created by 瞿伦平 on 16/3/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "APIClient.h"

#pragma mark -
#pragma mark NSMutableDictionary
@implementation NSMutableDictionary (APIClient_MyAdditions)

+(NSMutableDictionary *)quDic
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"104ef5c579850" forKey:@"key"];
    return dic;
}

+(NSMutableDictionary *)quDicWithPage:(int)page pageRow:(int)row
{
    NSMutableDictionary *dic = [NSMutableDictionary quDic];
    [dic addCustomTableParamWithPage:page row:row];
    return dic;
}

-(void)addCustomTableParamWithPage:(int)page row:(int)row
{
    [self setValue:StringWithInt(page) forKey:@"page"]; //起始页
    [self setValue:StringWithInt(row) forKey:@"size"]; //默认每一次取20条数据
}

@end



#pragma mark -
#pragma mark APIClient
@implementation APIClient

+ (instancetype)sharedClient {
    static APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //[APIClient loadDefault];
        _sharedClient = [[APIClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://apicloud.mob.com"]];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        
        
        //_sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedClient.requestSerializer.HTTPShouldHandleCookies = YES;
        //_sharedClient.requestSerializer.Content = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    });
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        self.requestSerializer.HTTPShouldHandleCookies = YES;
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        //self.requestSerializer = [AFHTTPRequestSerializer serializer];
        //self.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.conDic = [NSMutableDictionary dictionary];
    }
    return self;
}


#pragma mark -
- (void)cancelHttpOpretion:(NSURLSessionDataTask *)http
{
    for (NSOperation *operation in [self.operationQueue operations]) {
        if (![operation isKindOfClass:[NSURLSessionDataTask class]]) {
            continue;
        }
        if ([operation isEqual:http]) {
            [operation cancel];
            break;
        }
    }
}

- (void)addConnection:(NSURLSessionDataTask *)operation group:(NSString *)key
{
    NSMutableArray *arr = [self.conDic objectForKey:key];
    if (arr == nil)
        arr = [[NSMutableArray alloc] init];
    [arr addObject:operation];
    
    if (key==nil || key.length==0)
        key = @"defaultKey";
    
    [self.conDic setObject:arr forKey:key];
}

- (void)removeConnection:(NSURLSessionDataTask *)operation group:(NSString *)key
{
    NSMutableArray *arr = [self.conDic objectForKey:key];
    if ([arr containsObject:operation]) {
        [arr removeObject:operation];
        [self.conDic setObject:arr forKey:key];
    }
}

- (void)removeConnections:(NSString *)key
{
    NSMutableArray *arr = [self.conDic objectForKey:key];
    if (arr != nil) {
        for (NSURLSessionDataTask *operation in arr)
            [self cancelHttpOpretion:operation];
        [self.conDic removeObjectForKey:key];
    }
}


-(void)urlGroupKey:(NSString *)key path:(NSString *)URLString parameters:(id)parameters call:(void (^)(NSError *error, id responseObject))callback
{
    id operation = nil;
    operation = [self POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback(nil, responseObject);
        [self removeConnection:operation group:key];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callback(error, nil);
        [self removeConnection:operation group:key];
    }];
    [self addConnection:operation group:key];
}

-(void)postWithGroup:(NSString *)key path:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlockBack:(void (^)(id <AFMultipartFormData> formData))block call:(void (^)(NSError *error, id responseObject))callback
{
    id operation = nil;
    operation = [self POST:URLString parameters:parameters constructingBodyWithBlock:block progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback(nil, responseObject);
        [self removeConnection:operation group:key];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callback(error, nil);
        [self removeConnection:operation group:key];
    }];
    [self addConnection:operation group:key];
}

-(void)loadWithTag:(NSObject *)tag path:(NSString *)URLString parameters:(id)parameters call:(void (^)(APIObject* info))callback
{
    NSMutableDictionary* paramDic = [NSMutableDictionary quDic];
    if ([parameters isKindOfClass:[NSDictionary class]])
        [paramDic addEntriesFromDictionary:parameters];
    [self urlGroupKey:NSStringFromClass([tag class]) path:URLString parameters:paramDic call:^(NSError *error, id responseObject) {
        APIObject *info = nil;
        if (error == nil) {
            NSLog(@"\n\n ---APIObject----result:-----------%@", responseObject);
            //        NSString *result = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
            //        NSLog(@"\n\n ---APIObject----result:-----------%@", result);
            info = [APIObject mj_objectWithKeyValues:responseObject];
            if (info==nil)
                info = [APIObject infoWithErrorMessage:@"网络错误"];
            //        else if (info.data == nil)
            //            info.state = BOOL_NO;
        } else {
            NSLog(@"\n\n ---APIObject----result error:-----------%@", error);
            info = [APIObject infoWithError:error];
        }
        
        callback(info);
    }];
}

-(void)tableListWithTag:(NSObject *)tag path:(NSString *)URLString parameters:(NSDictionary *)parameters pageIndex:(int)page subClass:(Class)aClass call:(TableBlock)callback
{
    NSMutableDictionary *dic = [NSMutableDictionary quDicWithPage:page pageRow:TABLE_PAGE_ROW];
    if ([parameters isKindOfClass:[NSDictionary class]])
        [dic addEntriesFromDictionary:parameters];
    [self loadWithTag:tag path:URLString parameters:dic call:^(APIObject *info) {
        int newPage = kNoneNumber;
        int total = kNoneNumber;
        NSArray *newArr = nil;
        if (info.retCode == RETCODE_SUCCESS && [info.result isKindOfClass:[NSDictionary class]]) {
            total = [[info.result objectWithKey:@"total"] intValue];
            newPage = [[info.result objectWithKey:@"curPage"] intValue];
            NSArray *list = [info.result objectWithKey:@"list"];
            if (list.count > 0)
                newArr = [aClass mj_objectArrayWithKeyValuesArray:list];
        }
        callback(total, newArr, info);
    }];
}






#pragma mark - 菜谱

/**
 *  菜谱分类标签查询
 *
 *  @param tag      url链接对象
 *  @param callback 返回分类信息
 */
-(void)cookCategoryQueryWithTag:(NSObject *)tag call:(void (^)(CookCategoryObject* item, APIObject* info))callback
{
    [self loadWithTag:tag path:@"/v1/cook/category/query" parameters:nil call:^(APIObject *info) {
        CookCategoryObject *it = [CookCategoryObject mj_objectWithKeyValues:info.result];
        callback(it, info);
    }];
}


/**
 *  按标签查询菜谱接口  备注说明：根据标签ID/菜谱名称查询菜谱详情。
 *
 *  @param tag      url链接对象
 *  @param cid      标签ID(末级分类标签)
 *  @param name     菜谱名称
 *  @param page     页码数
 *  @param callback 返回订单列表
 */
-(void)cookListWithTag:(NSObject *)tag cookId:(NSString *)cid name:(NSString *)name pageIndex:(int)page call:(TableBlock)callback
{
    NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
    if (name.length > 0)
        [paramDic setValidStr:name forKey:@"name"];
    else if (cid.length > 0)
        [paramDic setValidStr:cid forKey:@"cid"];
    [self tableListWithTag:tag path:@"/v1/cook/menu/search" parameters:paramDic pageIndex:page subClass:[CookObject class] call:^(int totalpage, NSArray *tableArr, APIObject *info) {
        callback(totalpage, tableArr, info);
    }];
}



/**
 *  菜谱查询接口
 *
 *  @param tag      url链接对象
 *  @param cid      菜谱ID
 *  @param callback 返回菜谱信息
 */
-(void)cookInfoWithTag:(NSObject *)tag cookId:(NSString *)cid call:(void (^)(CookObject* item, APIObject* info))callback
{
    NSMutableDictionary* paramDic = [NSMutableDictionary dictionary];
    [paramDic setValidStr:cid forKey:@"cid"];
    [self loadWithTag:tag path:@"/v1/cook/menu/query" parameters:paramDic call:^(APIObject *info) {
        CookObject *it = [CookObject mj_objectWithKeyValues:info.result];
        callback(it, info);
    }];
}



-(void)userUpdateProfilePhotoWithTag:(NSObject *)tag photo:(UIImage *)img call:( void(^)(APIObject* info))callback
{
    [self postWithGroup:NSStringFromClass([tag class]) path:@"http://120.27.111.122/resource/userInfo/uploadUserProfileImg" parameters:nil constructingBodyWithBlockBack:^(id<AFMultipartFormData> formData) {
        NSData *imgData = UIImageJPEGRepresentation(img, 1.0);
        [formData appendPartWithFileData:imgData name:@"pic" fileName:@"img.png" mimeType:@"image/png"];
    } call:^(NSError *error, id responseObject) {
        
    }];
}


@end
