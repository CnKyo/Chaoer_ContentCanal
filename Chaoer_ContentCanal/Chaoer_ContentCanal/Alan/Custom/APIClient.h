//
//  APIClient.h
//  EasySearch
//
//  Created by 瞿伦平 on 16/3/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "AFNetworking.h"
#import "APIObjectDefine.h"


typedef void (^TableArrBlock)(NSArray *tableArr, APIObject* info);
typedef void (^TableBlock)(int totalpage, NSArray *tableArr, APIObject* info);



@interface NSMutableDictionary (APIClient_MyAdditions)
+(NSMutableDictionary *)quDic;
+(NSMutableDictionary *)quDicWithPage:(int)page pageRow:(int)row;
-(void)addCustomTableParamWithPage:(int)page row:(int)row;
@end


@interface APIClient : AFHTTPSessionManager
@property(nonatomic, strong) NSMutableDictionary *conDic;//存网络链接，便于取消

+ (instancetype)sharedClient;


/**
 *  清除所有的所属组链接
 *
 *  @param key 网络链接所属于的组
 */
- (void)removeConnections:(NSString *)key;
/**
 *  上传图片方法
 *
 *  @param tag        tag
 *  @param URLString  请求地址
 *  @param parameters 参数
 *  @param block      返回值
 *  @param callback   返回值
 */
-(void)postWithTag:(NSObject *)tag path:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlockBack:(void (^)(id <AFMultipartFormData> formData))block call:(void (^)(NSError *error, id responseObject))callback;


-(void)cookCategoryQueryWithTag:(NSObject *)tag call:(void (^)(CookCategoryObject* item, APIObject* info))callback;
-(void)cookListWithTag:(NSObject *)tag cookId:(NSString *)cid name:(NSString *)name pageIndex:(int)page call:(TableBlock)callback;
-(void)cookInfoWithTag:(NSObject *)tag cookId:(NSString *)cid call:(void (^)(CookObject* item, APIObject* info))callback;

-(void)userUpdateProfilePhotoWithTag:(NSObject *)tag photo:(UIImage *)img call:( void(^)(APIObject* info))callback;

@end