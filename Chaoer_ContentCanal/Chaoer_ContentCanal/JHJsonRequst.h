//
//  JHJsonRequst.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "AFURLResponseSerialization.h"
#import "dataModel.h"
#import "AFNetworking.h"
#import "AFAppDotNetAPIClient.h"

@class mBaseData;

@interface JHJsonRequst : AFHTTPRequestOperationManager

+ (JHJsonRequst *)sharedClient;

-(void)postUrl:(NSString *)URLString parameters:(id)parameters call:(void (^)( mJHBaseData* info))callback;

- (void)postUrlWithString:(NSString *)urlString andFileName:(NSData *)mFileName andPara:(id)para block:(void (^)( mBaseData* info))callback;

+ (NSString *)returnNowURL;

@end
