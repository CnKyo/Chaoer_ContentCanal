//
//  JHJsonRequst.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "JHJsonRequst.h"

@implementation JHJsonRequst
//该方法同步请求服务器,需要在主线程中创建其它线程完成请求,否则会阻塞主线程导致UI卡住
+(NSString*) httpAsynchronousRequestUrl:(NSString*) spec postStr:(NSString *)sData
{
    NSURL *url = [NSURL URLWithString:spec];
    NSMutableURLRequest *requst = [NSMutableURLRequest requestWithURL:url];
    [requst setHTTPMethod:@"POST"];
    NSData *postData = [sData dataUsingEncoding:NSUTF8StringEncoding];
    [requst setHTTPBody:postData];
    [requst setTimeoutInterval:15.0];
    
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;
    //如果使用局部变量指针需要传指针的地址
    NSData *data = [NSURLConnection sendSynchronousRequest:requst returningResponse:&urlResponse error:&error];
    NSString *returnStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"code:%ld",[urlResponse statusCode]);
    if ([urlResponse statusCode] == 200) {
        return returnStr;
    }
    return nil;
}

//该方法为异步请求服务器，不用在主线程创建其它线程
+(void) httpNsynchronousRequestUrl:(NSString*) spec postStr:(NSString*)sData finshedBlock:(FinishBlock)block
{
    JHJsonRequst *http = [[JHJsonRequst alloc]init];
    http.finishBlock = block;
    //初始HTTP
    NSURL *url = [NSURL URLWithString:spec];
    NSMutableURLRequest *requst = [NSMutableURLRequest requestWithURL:url];
    [requst setHTTPMethod:@"POST"];
    NSData *postData = [sData dataUsingEncoding:NSUTF8StringEncoding];
    [requst setHTTPBody:postData];
    [requst setTimeoutInterval:15.0];
    //连接
    NSURLConnection *con = [[NSURLConnection alloc]initWithRequest:requst delegate:http];
    NSLog(con ? @"连接创建成功" : @"连接创建失败");
}

//收到服务器传输数据的时候调用，此方法根据数据大小执行若干次
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"didReceiveData");
    [self.resultData appendData:data];
}

//接收到服务器回应的时回调
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"didReceiveResponse");
    if (self.resultData == nil) {
        self.resultData = [[NSMutableData alloc]init];
    }else{
        [self.resultData setLength:0];
    }
}

//数据传完之后调用此方法
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading");
    NSString *retStr = [[NSString alloc]initWithData:self.resultData encoding:NSUTF8StringEncoding];
    if(self.finishBlock != nil)
        self.finishBlock(retStr);
}

//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError");
    if(self.finishBlock != nil)
        self.finishBlock(nil);
}

@end
