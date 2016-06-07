//
//  TFFileUploadManager.m
//  UploadFileTest
//
//  Created by shiwei on 16/2/21.
//  Copyright © 2016年 shiwei. All rights reserved.
//

#import "TFFileUploadManager.h"
#import <MobileCoreServices/UTType.h>

@implementation TFFileUploadManager{
    NSMutableURLRequest *request;
    NSOperationQueue *queue;
    NSURLConnection *_connection;
    NSMutableData *_reveivedData;
}

+(instancetype)shareInstance{
    static TFFileUploadManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TFFileUploadManager alloc]init];
    });
    
    return manager;
}

-(void)uploadFileWithURL:(NSString*)urlString params:(NSDictionary*)params andData:(NSData *)mData fileKey:(NSString*)fileKey filePath:(NSString*)filePath completeHander:(void(^)(NSURLResponse *response, NSData *data, NSError *connectionError))completeHander{

    NSURL *URL = [[NSURL alloc]initWithString:urlString];
    request = [[NSMutableURLRequest alloc]initWithURL:URL cachePolicy:(NSURLRequestUseProtocolCachePolicy) timeoutInterval:30];
    NSString *boundary = @"wfWiEWrgEFA9A78512weF7106A";
        
    request.HTTPMethod = @"POST";
    request.allHTTPHeaderFields = @{
                                    @"Content-Type":[NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary]
                                    };
    
    //multipart/form-data格式按照构建上传数据
    NSMutableData *postData = [[NSMutableData alloc]init];
    for (NSString *key in params) {
        NSString *pair = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n",boundary,key];
        [postData appendData:[pair dataUsingEncoding:NSUTF8StringEncoding]];
        
        id value = [params objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            [postData appendData:[value dataUsingEncoding:NSUTF8StringEncoding]];
        }else if ([value isKindOfClass:[NSData class]]){
            [postData appendData:value];
        }
        [postData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    //文件部分
    NSString *filename = [filePath lastPathComponent];
    NSString *contentType = AFContentTypeForPathExtension([filePath pathExtension]);
    
    NSString *filePair = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"; filename=\"%@\";Content-Type=%@\r\n\r\n",boundary,fileKey,filename,contentType];
    [postData appendData:[filePair dataUsingEncoding:NSUTF8StringEncoding]];
    
    //[postData appendData:[@"测试文件数据" dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:mData]; //加入文件的数据
    
    [postData appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        request.HTTPBody = postData;
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)postData.length] forHTTPHeaderField:@"Content-Length"];
    
    _connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [_connection start];
}


-(void)uploadFileWithURL:(NSString*)urlString params:(NSDictionary*)params andData:(NSData *)mData andVideoData:(NSData *)mVideoData imgFileKey:(NSString*)imgfileKey andVideoFileKey:(NSString *)videoKey andVideoPath:(NSString *)videoPath filePath:(NSString*)filePath completeHander:(void(^)(NSURLResponse *response, NSData *data, NSError *connectionError))completeHander{

    NSURL *URL = [[NSURL alloc]initWithString:urlString];
    request = [[NSMutableURLRequest alloc]initWithURL:URL cachePolicy:(NSURLRequestUseProtocolCachePolicy) timeoutInterval:30];
    NSString *boundary = @"wfWiEWrgEFA9A78512weF7106A";

    request.HTTPMethod = @"POST";
    request.allHTTPHeaderFields = @{
                                    @"Content-Type":[NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary]
                                    };
    
    //multipart/form-data格式按照构建上传数据
    NSMutableData *postData = [[NSMutableData alloc]init];
    for (NSString *key in params) {

        NSString *pair = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n",boundary,key];
        
//        [pair appendFormat:@"Content-Type:image/png, video/mp4\r\n\r\n"];
        
        [postData appendData:[pair dataUsingEncoding:NSUTF8StringEncoding]];
        
        id value = [params objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            [postData appendData:[value dataUsingEncoding:NSUTF8StringEncoding]];
        }else if ([value isKindOfClass:[NSData class]]){
            [postData appendData:value];
        }
        [postData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if (mData) {
        
            
        //文件部分
        NSString *filename = [filePath lastPathComponent];
//        NSString *contentType = AFContentTypeForPathExtension([filePath pathExtension]);
        NSString *contentType = @"image/png";

        NSString *filePair = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"; filename=\"%@\";Content-Type=%@\r\n\r\n",boundary,imgfileKey,filename,contentType];
        [request addValue:@"image/png" forHTTPHeaderField:@"Content-Type"];

        [postData appendData:[filePair dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:mData]; //加入文件的数据

    }
    

    
    [postData appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];

    
    request.HTTPBody = postData;
    
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)postData.length] forHTTPHeaderField:@"Content-Length"];
    
    _connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [_connection start];
    


}


#pragma mark - connection delegate

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    MLLog(@"reveive Response:\n%@",response);
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    _reveivedData = [[NSMutableData alloc]init];
    
    [_reveivedData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    MLLog(@"received Data:\n%@",[[NSString alloc] initWithData:_reveivedData encoding:NSUTF8StringEncoding]);
    MLLog(@"%@",_reveivedData);
  
    MLLog(@"RESPONSE　DATA: %@", [Util dictionaryWithJsonString:[[NSString alloc] initWithData:_reveivedData encoding:NSUTF8StringEncoding]]);
    mBaseData *mdata = [[mBaseData alloc] initWithObj:[Util dictionaryWithJsonString:[[NSString alloc] initWithData:_reveivedData encoding:NSUTF8StringEncoding]]];

    [self.delegate block:mdata];

}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    MLLog(@"fail connect:\n%@",error);
//    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"fail connect:\n%@",error]];
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:[NSString stringWithFormat:@"fail connect:\n%@",error] forKey:@"error"];

    [self.delegate block:[mBaseData infoWithError:[NSString stringWithFormat:@"%@",error]]];

    
}


static inline NSString * AFContentTypeForPathExtension(NSString *extension) {
#ifdef __UTTYPE__
    NSString *UTI = (__bridge_transfer NSString *)UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)extension, NULL);
    NSString *contentType = (__bridge_transfer NSString *)UTTypeCopyPreferredTagWithClass((__bridge CFStringRef)UTI, kUTTagClassMIMEType);
    if (!contentType) {
        return @"application/octet-stream";
    } else {
        return contentType;
    }
#else
#pragma unused (extension)
    return @"application/octet-stream";
#endif
}


@end
