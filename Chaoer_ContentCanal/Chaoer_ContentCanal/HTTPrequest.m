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

//static NSString* const  kAFAppDotNetAPIBaseURLString    = @"http://120.27.111.122/";

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
        
//        NSLog(@"去掉字典里的null值之前的数据---URL%@ data:%@",operation.response.URL,responseObject);

        NSDictionary *resbObj = [self deleteEmpty:responseObject];
        
        NSLog(@"去掉字典里的null值之后的数据---%@",resbObj);

        mBaseData   *retob = [[mBaseData alloc]initWithObj:resbObj];
                
//        if( retob.mState == 400301 )
//        {//需要登陆
//            id oneid = [UIApplication sharedApplication].delegate;
//            [oneid performSelector:@selector(gotoLogin) withObject:nil afterDelay:0.4f];
//        }
        callback(  retob );
        
    }
       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           
           NSLog(@"url:%@ error:%@",operation.response.URL,error.description);
           callback( [mBaseData infoWithError:@"网络请求错误"] );
           
       }];
}
- (void)getUrl:(NSString *)URLString parameters:(id)parameters call:(void (^)( mBaseData* info))callback{

    NSLog(@"请求地址：%@-------请求参数：%@",URLString,parameters);
    
    [self GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"URL%@ data:%@",operation.response.URL,responseObject);
        
        NSDictionary *resbObj = [self deleteEmpty:responseObject];
        
        NSLog(@"去掉字典里的null值之后的数据：%@",resbObj);
        
        mBaseData   *retob = [[mBaseData alloc]initWithObj:resbObj];
        
        
        //        if( retob.mState == 400301 )
        //        {//需要登陆
        //            id oneid = [UIApplication sharedApplication].delegate;
        //            [oneid performSelector:@selector(gotoLogin) withObject:nil afterDelay:0.4f];
        //        }
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

@end
