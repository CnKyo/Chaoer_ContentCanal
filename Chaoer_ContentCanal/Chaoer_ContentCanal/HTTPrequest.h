//
//  HTTPrequest.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "AFURLResponseSerialization.h"
#import "dataModel.h"
#import "AFNetworking.h"
#import "AFAppDotNetAPIClient.h"
@class mBaseData;

@interface HTTPrequest : AFHTTPRequestOperationManager

+ (HTTPrequest *)sharedClient;

-(void)postUrl:(NSString *)URLString parameters:(id)parameters call:(void (^)( mBaseData* info))callback;

- (void)getUrl:(NSString *)URLString parameters:(id)parameters call:(void (^)( mBaseData* info))callback;


/**
 *  上传表单数据
 *
 *  @param urlString 链接
 *  @param mFileName 文件
 *  @param para      参数
 *  @param callback  返回值
 */
- (void)postUrlWithString:(NSString *)urlString andFileName:(NSString *)mFileName andData:(NSData *)mData andFilePath:(NSURL *)mPath andPara:(id)para block:(void (^)( mBaseData* info))callback;

+ (NSString *)returnNowURL;

@end
