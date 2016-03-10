//
//  WebVC.m
//  YiZanService
//
//  Created by zzl on 15/3/29.
//  Copyright (c) 2015年 zywl. All rights reserved.
//

#import "WebVC.h"

@interface WebVC ()<UIWebViewDelegate>
{
    UIWebView* itwebview;
}

@end

@implementation WebVC

-(void)loadView
{
    self.hiddenTabBar = YES;
    [super loadView];
}
- (void)viewDidLoad {
    self.mPageName = @"WEB浏览";
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hiddenlll = YES;
    self.Title = self.mName;
    itwebview = [[UIWebView alloc]initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:itwebview];
    
    if( _itblock || _itgoodsblock )
    {
        self.hiddenRightBtn = NO;
        self.rightBtnTitle = @"完成";
    }
    
    itwebview.delegate = self;
    [SVProgressHUD showWithStatus:@"加载中..."];
    [itwebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.mUrl]]];
}
-(void)rightBtnTouched:(id)sender
{
    if( self.itblock )
    {
        NSString* retobj  = [itwebview stringByEvaluatingJavaScriptFromString:@"getMapPos()"];
        
        NSError* jsonerrr = nil;
        NSDictionary* datobj = [NSJSONSerialization JSONObjectWithData:[retobj dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&jsonerrr];
        
        NSString* addr = [datobj objectForKey:@"address"];
        NSString* points = [datobj objectForKey:@"mapPos"];
        if( addr.length == 0 || points.length == 0 )
        {
            [SVProgressHUD showErrorWithStatus:@"请先设置范围"];
            return;
        }
        
        self.itblock( addr,points );
        [self leftBtnTouched:nil];
        
    }
    else if( self.itgoodsblock )
    {
        NSString* retobj  = [itwebview stringByEvaluatingJavaScriptFromString:@"getBrief()"];
        
        if( retobj.length == 0 )
        {
            [SVProgressHUD showErrorWithStatus:@"请添加商品描述"];
            return;
        }
        
        self.itgoodsblock( retobj );
        [self leftBtnTouched:nil];
    }
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD showWithStatus:@"加载中..."];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [SVProgressHUD showErrorWithStatus:error.description];
}
-(void)leftBtnTouched:(id)sender
{
    if( _mBWebStack )
    {
        if ([itwebview canGoBack]) {
            [itwebview goBack];
        } else {
            //退出
            [super leftBtnTouched:sender];
        }
    }
    else
    {
        [super leftBtnTouched:sender];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
