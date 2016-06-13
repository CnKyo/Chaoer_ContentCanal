//
//  HTTPrequest.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "HTTPrequest.h"
#import "CBCUtil.h"
#import "NSObject+myobj.h"
#import "CustomDefine.h"
#import "Util.h"

#import "dataModel.h"

#import "MJExtension.h"

#pragma mark -
#pragma mark APIClient

//static NSString* const  kAFAppDotNetAPIBaseURLString    = @"http://app.china-cr.com/";

static NSString* const  kAFAppDotNetAPIBaseURLString    = @"http://192.168.1.175/";

//static NSString* const  kAFAppDotNetAPIBaseURLString    = @"http://192.168.1.183/";

//static NSString* const  kAFAppDotNetAPIBaseURLString    = @"http://192.168.1.110/";


//static NSString* const  kAFAppDotNetAPIBaseURLString    = @"http://192.168.1.230:8080/";

/**
 *  资源路径
 */
static NSString* const  kAFASourceUrl    = @"http://app.china-cr.com/";

@interface HTTPrequest()

@end


@implementation HTTPrequest
#pragma mark -
+ (instancetype)sharedClient {
    static HTTPrequest *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[HTTPrequest alloc] initWithBaseURL:[NSURL URLWithString:kAFAppDotNetAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    });
    _sharedClient.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"text/json",@"text/html",@"charset=UTF-8",@"text/plain",@"application/json",nil];;
    _sharedClient.requestSerializer.timeoutInterval = 10;
    return _sharedClient;
}

- (void)cancelHttpOpretion:(AFHTTPRequestOperation *)http
{
    for (NSOperation *operation in [self.operationQueue operations]) {
        if (![operation isKindOfClass:[AFHTTPRequestOperation class]]) {
            continue;
        }
        if ([operation isEqual:http]) {
            [operation cancel];
            break;
        }
    }
}

-(void)postUrl:(NSString *)URLString parameters:(id)parameters call:(void (^)(mBaseData  * info))callback
{
    
    MLLog(@"请求地址：%@-------请求参数：%@",URLString,parameters);
    [self POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"去掉字典里的null值之前的数据---URL%@ data:%@",operation.response.URL,responseObject);

        NSDictionary *resbObj = [self deleteEmpty:responseObject];
        
        MLLog(@"去掉字典里的null值之后的数据---%@",resbObj);

        mBaseData   *retob = [[mBaseData alloc]initWithObj:resbObj];
                
//        if( retob.mState == 400301 )
//        {//需要登陆
//            id oneid = [UIApplication sharedApplication].delegate;
//            [oneid performSelector:@selector(gotoLogin) withObject:nil afterDelay:0.4f];
//        }
        callback(  retob );
        
    }
       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           
           MLLog(@"url:%@ error:%@",operation.response.URL,error.description);
           callback( [mBaseData infoWithError:@"网络请求错误"] );
           
       }];
}
- (void)getUrl:(NSString *)URLString parameters:(id)parameters call:(void (^)( mBaseData* info))callback{

    MLLog(@"请求地址：%@-------请求参数：%@",URLString,parameters);
    
    [self GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        MLLog(@"URL%@ data:%@",operation.response.URL,responseObject);
        
        NSDictionary *resbObj = [self deleteEmpty:responseObject];
        
        MLLog(@"去掉字典里的null值之后的数据：%@",resbObj);
        
        mBaseData   *retob = [[mBaseData alloc]initWithObj:resbObj];
        
        
        //        if( retob.mState == 400301 )
        //        {//需要登陆
        //            id oneid = [UIApplication sharedApplication].delegate;
        //            [oneid performSelector:@selector(gotoLogin) withObject:nil afterDelay:0.4f];
        //        }
        callback(  retob );
        
    }
       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           
           MLLog(@"url:%@ error:%@",operation.response.URL,error.description);
           callback( [mBaseData infoWithError:@"网络请求错误"] );
           
       }];
}

- (void)postUrlWithString:(NSString *)urlString andFileName:(NSString *)mFileName andData:(NSData *)mData andFilePath:(NSURL *)mPath andPara:(id)para block:(void (^)( mBaseData* info))callback{
  
    urlString = [NSString stringWithFormat:@"%@%@",kAFAppDotNetAPIBaseURLString,urlString];
    MLLog(@"请求地址：%@-------请求参数：%@",urlString,para);

    

    
    NSURLRequest *request = [[HTTPrequest sharedClient].requestSerializer multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:para constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        
        if (mData) {
            [formData appendPartWithFileData:mData name:@"file" fileName:mFileName mimeType:@"image/png"];
        }
        
    } error:nil];
    
    // 3. operation包装的urlconnetion
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
        MLLog(@"%@",responseObject);
        MLLog(@"上传完成");
        
        NSDictionary *resbObj = [self deleteEmpty:responseObject];
        
        MLLog(@"去掉字典里的null值之后的数据：%@",resbObj);
        
        mBaseData   *retob = [[mBaseData alloc]initWithObj:resbObj];
        
        callback (retob);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MLLog(@"url:%@ error:%@",operation.response.URL,error.description);
        callback( [mBaseData infoWithError:error.description] );
        
    }];
    
    //执行
    
    [[HTTPrequest sharedClient].operationQueue addOperation:op];
    
    
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    // formData是遵守了AFMultipartFormData的对象
//    [manager POST:urlString parameters:para constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileData:mData name:@"file" fileName:mFileName mimeType:@"image/png"];
//        
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//
//        NSLog(@"完成 %@ ,,", result);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"错误 %@", error.localizedDescription);
//    }];
    
    
}

+ (NSString *)returnNowURL{
    
    NSArray *mUrl = [kAFAppDotNetAPIBaseURLString componentsSeparatedByString:@"/"];
    NSString *mRsetUrl = [NSString stringWithFormat:@"%@//%@%@",[mUrl objectAtIndex:0],[mUrl objectAtIndex:1],[mUrl objectAtIndex:2]];
    
    
    return mRsetUrl;
}
#pragma mark----删除字典里的null值
- (NSDictionary *)deleteEmpty:(NSDictionary *)dic
{
    NSMutableDictionary *mdic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    NSMutableArray *set = [[NSMutableArray alloc] init];
    NSMutableDictionary *dicSet = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *arrSet = [[NSMutableDictionary alloc] init];
    for (id obj in mdic.allKeys)
    {
        id value = mdic[obj];
        if ([value isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *changeDic = [self deleteEmpty:value];
            [dicSet setObject:changeDic forKey:obj];
        }
        else if ([value isKindOfClass:[NSArray class]])
        {
            NSArray *changeArr = [self deleteEmptyArr:value];
            [arrSet setObject:changeArr forKey:obj];
        }
        else
        {
            if ([value isKindOfClass:[NSNull class]]) {
                [set addObject:obj];
            }
        }
    }
    for (id obj in set)
    {
        mdic[obj] = @"";
    }
    for (id obj in dicSet.allKeys)
    {
        mdic[obj] = dicSet[obj];
    }
    for (id obj in arrSet.allKeys)
    {
        mdic[obj] = arrSet[obj];
    }
    
    return mdic;
}

#pragma mark----删除数组中的null值
- (NSArray *)deleteEmptyArr:(NSArray *)arr
{
    NSMutableArray *marr = [NSMutableArray arrayWithArray:arr];
    NSMutableArray *set = [[NSMutableArray alloc] init];
    NSMutableDictionary *dicSet = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *arrSet = [[NSMutableDictionary alloc] init];
    
    for (id obj in marr)
    {
        if ([obj isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *changeDic = [self deleteEmpty:obj];
            NSInteger index = [marr indexOfObject:obj];
            [dicSet setObject:changeDic forKey:@(index)];
        }
        else if ([obj isKindOfClass:[NSArray class]])
        {
            NSArray *changeArr = [self deleteEmptyArr:obj];
            NSInteger index = [marr indexOfObject:obj];
            [arrSet setObject:changeArr forKey:@(index)];
        }
        else
        {
            if ([obj isKindOfClass:[NSNull class]]) {
                NSInteger index = [marr indexOfObject:obj];
                [set addObject:@(index)];
            }
        }
    }
    for (id obj in set)
    {
        marr[(int)obj] = @"";
    }
    for (id obj in dicSet.allKeys)
    {
        int index = [obj intValue];
        marr[index] = dicSet[obj];
    }
    for (id obj in arrSet.allKeys)
    {
        int index = [obj intValue];
        marr[index] = arrSet[obj];
    }
    return marr;
}
#pragma mark----测试上传文件方法
+ (NSMutableURLRequest *)constructFormDataRequestWithUrlString:(NSString *)urlString
                                                          data:(NSData *)data
                                                          name:(NSString *)name
                                                      fileName:(NSString *)fileName
                                                      mimeType:(NSString *)mimeType
                                                    parameters:(NSDictionary *)parameters
{
    NSString *boundary = [NSString stringWithFormat:@"Boundary+%08X%08X", arc4random(), arc4random()];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kAFAppDotNetAPIBaseURLString,urlString]]];
    request.HTTPMethod = @"POST";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    [request addValue:[NSString stringWithFormat:@"%lud", (unsigned long)data.length] forHTTPHeaderField:@"Content-Length"];
    
    NSMutableData *postBody = [NSMutableData data];
    // body 参数
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@", obj] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }];
    
    MLLog(@"%@", [[NSString alloc] initWithData:postBody encoding:NSUTF8StringEncoding]);
    
    // body data
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\";filename=\"%@\"\r\n", name, fileName] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", mimeType] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:data];
    [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postBody];
    return request;
    
}
@end
