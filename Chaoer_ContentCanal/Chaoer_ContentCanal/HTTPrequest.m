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

static NSString* const  kAFAppDotNetAPIBaseURLString    = @"http://192.168.1.172/";



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
    _sharedClient.requestSerializer.timeoutInterval = 60;
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
  
  
   
}

+ (NSString *)returnNowURL{
    return kAFAppDotNetAPIBaseURLString;
}

@end
