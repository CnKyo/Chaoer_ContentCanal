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

static NSString* const  kAFAppDotNetAPIBaseURLString    = @"http://app.china-cr.com/";

//static NSString* const  kAFAppDotNetAPIBaseURLString    = @"http://192.168.1.108/";

//static NSString* const  kAFAppDotNetAPIBaseURLString    = @"http://192.168.1.183/";

//static NSString* const  kAFAppDotNetAPIBaseURLString    = @"http://192.168.1.120/";


//static NSString* const  kAFAppDotNetAPIBaseURLString    = @"http://192.168.1.230:8080/";

/**
 *  资源路径
 */
static NSString* const  kAFASourceUrl    = @"http://app.china-cr.com/resource/";

@interface HTTPrequest()

@end


@implementation HTTPrequest
HDSingletonM(HDNetworking) // 单例实现

#pragma mark -

-(void)postUrl:(NSString *)URLString parameters:(id)parameters call:(void (^)(mBaseData  * info))callback
{
    [[HTTPrequest sharedHDNetworking] networkStatusUnknown:^{
        MLLog(@"未知网络连接");
    } reachable:^{
        MLLog(@"reachable");
    } reachableViaWWAN:^{
        MLLog(@"移动蜂窝网络");
    } reachableViaWiFi:^{
        MLLog(@"WiFi");
    }];

    MLLog(@"请求地址：%@-------请求参数：%@",URLString,parameters);
//    
//    if ([URLString isEqualToString:@"app/login/applogin"]) {
//        [self getRSAKey];
//    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
    [contentTypes addObject:@"text/html"];
    [contentTypes addObject:@"text/plain"];
    
    manager.responseSerializer.acceptableContentTypes = self.acceptableContentTypes;
    manager.requestSerializer.timeoutInterval = (self.timeoutInterval ? self.timeoutInterval : 20);
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES]; // 开启状态栏动画
    
    [manager POST:[NSString stringWithFormat:@"%@/%@",[HTTPrequest returnNowURL],URLString] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *resbObj = [self deleteEmpty:responseObject];
        
        MLLog(@"去掉字典里的null值之后的数据---%@",resbObj);
        
        mBaseData   *retob = [[mBaseData alloc]initWithObj:resbObj];
        
        //        if( retob.mState == 400301 )
        //        {//需要登陆
        //            id oneid = [UIApplication sharedApplication].delegate;
        //            [oneid performSelector:@selector(gotoLogin) withObject:nil afterDelay:0.4f];
        //        }
        callback(  retob );
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        MLLog(@" error:%@",error.description);
        callback( [mBaseData infoWithError:@"网络请求错误"] );
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
    }];

    
    
}
- (void)getUrl:(NSString *)URLString parameters:(id)parameters call:(void (^)( mBaseData* info))callback{
    [[HTTPrequest sharedHDNetworking] networkStatusUnknown:^{
        MLLog(@"未知网络连接");
    } reachable:^{
        MLLog(@"reachable");
    } reachableViaWWAN:^{
        MLLog(@"移动蜂窝网络");
    } reachableViaWiFi:^{
        MLLog(@"WiFi");
    }];
    MLLog(@"请求地址：%@-------请求参数：%@",URLString,parameters);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
    [contentTypes addObject:@"text/html"];
    [contentTypes addObject:@"text/plain"];
    
    manager.responseSerializer.acceptableContentTypes = self.acceptableContentTypes;
    manager.requestSerializer.timeoutInterval = (self.timeoutInterval ? self.timeoutInterval : 20);
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [manager GET:[NSString stringWithFormat:@"%@/%@",[HTTPrequest returnNowURL],URLString] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        MLLog(@"data:%@",responseObject);
        
        NSDictionary *resbObj = [self deleteEmpty:responseObject];
        
        MLLog(@"去掉字典里的null值之后的数据：%@",resbObj);
        
        mBaseData   *retob = [[mBaseData alloc]initWithObj:resbObj];
        
        
        //        if( retob.mState == 400301 )
        //        {//需要登陆
        //            id oneid = [UIApplication sharedApplication].delegate;
        //            [oneid performSelector:@selector(gotoLogin) withObject:nil afterDelay:0.4f];
        //        }
        callback(  retob );
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        MLLog(@"error:%@",error.description);
        callback( [mBaseData infoWithError:@"网络请求错误"] );

        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];

    
    
    
}



+ (NSString *)returnNowURL{
    
    NSArray *mUrl = [kAFAppDotNetAPIBaseURLString componentsSeparatedByString:@"/"];
    NSString *mRsetUrl = [NSString stringWithFormat:@"%@//%@%@",[mUrl objectAtIndex:0],[mUrl objectAtIndex:1],[mUrl objectAtIndex:2]];

    return mRsetUrl;
}
#pragma mark----返回资源url
/**
 *  返回资源url
 *
 *  @return 返回资源url
 */
+ (NSString *)currentResourceUrl{

    
    return kAFASourceUrl;
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
#pragma mark----HDNetWork
/**
 *  网络监测(在什么网络状态)
 *
 *  @param unknown          未知网络
 *  @param reachable        无网络
 *  @param reachableViaWWAN 蜂窝数据网
 *  @param reachableViaWiFi WiFi网络
 */
- (void)networkStatusUnknown:(Unknown)unknown reachable:(Reachable)reachable reachableViaWWAN:(ReachableViaWWAN)reachableViaWWAN reachableViaWiFi:(ReachableViaWiFi)reachableViaWiFi;
{
    // 创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 监测到不同网络的情况
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown:
                unknown();
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                reachable();
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                reachableViaWWAN();
                
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                reachableViaWiFi();
                break;
                
            default:
                break;
        }
    }] ;
    
    // 开始监听网络状况
    [manager startMonitoring];
}

/**
 *  封装的get请求
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
- (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
    [contentTypes addObject:@"text/html"];
    [contentTypes addObject:@"text/plain"];
    
    manager.responseSerializer.acceptableContentTypes = self.acceptableContentTypes;
    manager.requestSerializer.timeoutInterval = (self.timeoutInterval ? self.timeoutInterval : 20);
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [manager GET:[NSString stringWithFormat:@"%@/%@",[HTTPrequest returnNowURL],URLString] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success)
        {
            success(responseObject);
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
        {
            failure(error);
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
}

/**
 *  封装的POST请求
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
    [contentTypes addObject:@"text/html"];
    [contentTypes addObject:@"text/plain"];
    
    manager.responseSerializer.acceptableContentTypes = self.acceptableContentTypes;
    manager.requestSerializer.timeoutInterval = (self.timeoutInterval ? self.timeoutInterval : 20);
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES]; // 开启状态栏动画
    
    [manager POST:[NSString stringWithFormat:@"%@/%@",[HTTPrequest returnNowURL],URLString] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success)
        {
            success(responseObject);
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
        {
            failure(error);
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
    }];
}

/**
 *  封装POST图片上传(多张图片) // 可扩展成多个别的数据上传如:mp3等
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param picArray   存放图片模型(HDPicModle)的数组
 *  @param progress   进度的回调
 *  @param success    发送成功的回调
 *  @param failure    发送失败的回调
 */
- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters andPicArray:(NSArray<HDPicModle *> *)picArray progress:(Progress)progress success:(Success)success failure:(Failure)failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = self.acceptableContentTypes;
    manager.requestSerializer.timeoutInterval = (self.timeoutInterval ? self.timeoutInterval : 20);
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 请求不使用AFN默认转换,保持原有数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // 响应不使用AFN默认转换,保持原有数据
    
    [manager POST:[NSString stringWithFormat:@"%@/%@",[HTTPrequest returnNowURL],URLString] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSInteger count = picArray.count;
        NSString *fileName = @"";
        NSData *data = [NSData data];
        
        for (int i = 0; i < count; i++)
        {
            @autoreleasepool {
                HDPicModle *picModle = picArray[i];
                fileName = [NSString stringWithFormat:@"pic%02d.png", i];
                /**
                 *  压缩图片然后再上传(1.0代表无损 0~~1.0区间)
                 */
                data = UIImageJPEGRepresentation(picModle.mPicImage, 1.0);
                CGFloat precent = self.picSize / (data.length / 1024.0);
                if (precent > 1)
                {
                    precent = 1.0;
                }
                data = nil;
                data = UIImageJPEGRepresentation(picModle.mPicImage, precent);
                
                [formData appendPartWithFileData:data name:picModle.mPicName fileName:fileName mimeType:@"image/png"];
                data = nil;
                picModle.mPicImage = nil;
            }
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress)
        {
            progress(uploadProgress); // HDLog(@"%lf", 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success)
        {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
        {
            failure(error);
        }
    }];
}

/**
 *  封装POST图片上传(单张图片) // 可扩展成单个别的数据上传如:mp3等
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param picModle   上传的图片模型
 *  @param progress   进度的回调
 *  @param success    发送成功的回调
 *  @param failure    发送失败的回调
 */
- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters andPic:(HDPicModle *)picModle progress:(Progress)progress success:(Success)success failure:(Failure)failure call:(void (^)( mBaseData* info))callback
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = self.acceptableContentTypes;
    manager.requestSerializer.timeoutInterval = (self.timeoutInterval ? self.timeoutInterval : 20);
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 请求不使用AFN默认转换,保持原有数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // 响应不使用AFN默认转换,保持原有数据
    
    [manager POST:[NSString stringWithFormat:@"%@/%@",[HTTPrequest returnNowURL],URLString] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        /**
         *  压缩图片然后再上传(1.0代表无损 0~~1.0区间)
         */
        NSData *data = UIImageJPEGRepresentation(picModle.mPicImage, 1.0);
        CGFloat precent = self.picSize / (data.length / 1024.0);
        if (precent > 1)
        {
            precent = 1.0;
        }
        data = nil;
        data = UIImageJPEGRepresentation(picModle.mPicImage, precent);
        
        NSString *fileName = picModle.mPicName;
        
        [formData appendPartWithFileData:data name:picModle.mPicName fileName:fileName mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress)
        {
            progress(uploadProgress);
            HDLog(@"%lf", 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success)
        {
            success(responseObject);
            
            NSDictionary *resbObj = [self deleteEmpty:responseObject];
            
            MLLog(@"去掉字典里的null值之后的数据---%@",resbObj);
            
            mBaseData   *retob = [[mBaseData alloc]initWithObj:resbObj];

            callback(  retob );

        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
        {
            failure(error);
            MLLog(@"error:%@",error.description);
            callback( [mBaseData infoWithError:@"网络请求错误"] );

        }
    }];
}

/**
 *  封装POST上传url资源
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param picModle   上传的图片模型(资源的url地址)
 *  @param progress   进度的回调
 *  @param success    发送成功的回调
 *  @param failure    发送失败的回调
 */
- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters andPicUrl:(HDPicModle *)picModle progress:(Progress)progress success:(Success)success failure:(Failure)failure;
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = self.acceptableContentTypes;
    manager.requestSerializer.timeoutInterval = (self.timeoutInterval ? self.timeoutInterval : 20);
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 请求不使用AFN默认转换,保持原有数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // 响应不使用AFN默认转换,保持原有数据
    
    [manager POST:[NSString stringWithFormat:@"%@/%@",[HTTPrequest returnNowURL],URLString] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSString *fileName = [NSString stringWithFormat:@"%@.png", picModle.mPicName];
        // 根据本地路径获取url(相册等资源上传)
        NSURL *url = [NSURL fileURLWithPath:picModle.mPicUrl]; // [NSURL URLWithString:picModle.url] 可以换成网络的图片在上传
        
        [formData appendPartWithFileURL:url name:picModle.mPicName fileName:fileName mimeType:@"application/octet-stream" error:nil];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress)
        {
            progress(uploadProgress); // HDLog(@"%lf", 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success)
        {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
        {
            failure(error);
        }
    }];
}

/**
 *  下载
 *
 *  @param URLString       请求的链接
 *  @param progress        进度的回调
 *  @param destination     返回URL的回调
 *  @param downLoadSuccess 发送成功的回调
 *  @param failure         发送失败的回调
 */
- (NSURLSessionDownloadTask *)downLoadWithURL:(NSString *)URLString progress:(Progress)progress destination:(Destination)destination downLoadSuccess:(DownLoadSuccess)downLoadSuccess failure:(Failure)failure;
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURL *url = [NSURL URLWithString:URLString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progress)
        {
            progress(downloadProgress); // HDLog(@"%lf", 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        }
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        if (destination)
        {
            return destination(targetPath, response);
        }
        else
        {
            return nil;
        }
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error)
        {
            failure(error);
        }
        else
        {
            downLoadSuccess(response, filePath);
        }
    }];
    
    // 开始启动任务
    [task resume];
    
    return task;
}


#pragma mark----获取rsakey

- (NSString *)getRSAKey{

    NSString *key = nil;
    
    [mUserInfo getRSAKey:^(mBaseData *resb) {
        
        if (resb.mSucess) {
            
        }else{
        
        }
        
    }];
    
    return key;
}
@end
