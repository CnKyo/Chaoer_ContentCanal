//
//  TFFileUploadManager.h
//  UploadFileTest
//
//  Created by shiwei on 16/2/21.
//  Copyright © 2016年 shiwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol THHHTTPDelegate <NSObject>

- (void)block:(mBaseData *)resb;

@end

@interface TFFileUploadManager : NSObject<NSURLConnectionDataDelegate>
@property (nonatomic,strong) id <THHHTTPDelegate> delegate;

+(instancetype)shareInstance;

-(void)uploadFileWithURL:(NSString*)urlString params:(NSDictionary*)params andData:(NSData *)mData fileKey:(NSString*)fileKey filePath:(NSString*)filePath completeHander:(void(^)(NSURLResponse *response, NSData *data, NSError *connectionError))completeHander;


-(void)uploadFileWithURL:(NSString*)urlString params:(NSDictionary*)params andData:(NSData *)mData andVideoData:(NSData *)mVideoData imgFileKey:(NSString*)imgfileKey andVideoFileKey:(NSString *)videoKey andVideoPath:(NSString *)videoPath filePath:(NSString*)filePath completeHander:(void(^)(NSURLResponse *response, NSData *data, NSError *connectionError))completeHander;

@end
