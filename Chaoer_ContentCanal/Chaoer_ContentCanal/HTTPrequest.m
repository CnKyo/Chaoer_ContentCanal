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
#pragma mark -
#pragma mark APIClient

static NSString* const  kAFAppDotNetAPIBaseURLString    = @"http://192.168.1.110/";

//static NSString* const  kAFAppDotNetAPIBaseURLString    = @"http://192.168.1.230:8080/";

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
    
    NSLog(@"请求地址：%@-------请求参数：%@",URLString,parameters);
    
    [self POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"URL%@ data:%@",operation.response.URL,responseObject);

        mBaseData   *retob = [[mBaseData alloc]initWithObj:responseObject];
                
        if( retob.mState == 400301 )
        {//需要登陆
            id oneid = [UIApplication sharedApplication].delegate;
            [oneid performSelector:@selector(gotoLogin) withObject:nil afterDelay:0.4f];
        }
        callback(  retob );
        
    }
       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           
           NSLog(@"url:%@ error:%@",operation.response.URL,error.description);
           callback( [mBaseData infoWithError:@"网络请求错误"] );
           
       }];
}

- (void)postUrlWithString:(NSString *)urlString andFileName:(NSData *)mFileName andPara:(id)para block:(void (^)( mBaseData* info))callback{
    NSLog(@"请求地址：%@-------请求参数：%@",urlString,para);
    NSString *urlStri = [NSString stringWithFormat:@"%@%@",kAFAppDotNetAPIBaseURLString,urlString];
    NSURLRequest *request = [[HTTPrequest sharedClient].requestSerializer multipartFormRequestWithMethod:@"POST" URLString:urlStri parameters:para constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
        // 要解决此问题，
        // 可以在上传时使用当前的系统事件作为文件名
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        if (mFileName) {
            [formData appendPartWithFileData:mFileName name:@"file" fileName:fileName mimeType:@"image/png"];

        }
        
    } error:nil];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPRequestOperation *op = [[HTTPrequest sharedClient]HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

        NSLog(@"URL%@ data:%@",operation.response.URL,responseObject);
        
        mBaseData   *retob = [[mBaseData alloc]initWithObj:responseObject];
        
        if( retob.mState == 400301 )
        {//需要登陆
            id oneid = [UIApplication sharedApplication].delegate;
            [oneid performSelector:@selector(gotoLogin) withObject:nil afterDelay:0.4f];
        }
        callback(  retob );
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"url:%@ error:%@",operation.response.URL,error.description);
        NSLog(@"request的url是：%@",request.URL);
        callback( [mBaseData infoWithError:@"网络请求错误"] );
    }];
    
    [op start];
}

+ (NSString *)returnNowURL{
    return @"http://192.168.1.130:8080/zm";
}

@end
