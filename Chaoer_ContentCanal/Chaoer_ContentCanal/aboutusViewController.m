//
//  aboutusViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/18.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "aboutusViewController.h"

#import "aboutusView.h"
@interface aboutusViewController ()

@end

@implementation aboutusViewController
{
    UIScrollView    *mScrollerView;
    
    aboutusView     *mView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Title = self.mPageName = @"关于我们";
    self.hiddenBackBtn = YES;
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    self.navBar.hidden = NO;
    [self initView];
}

- (void)initView{

    mScrollerView = [UIScrollView new];
    mScrollerView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
    mScrollerView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-50);
    [self.view addSubview:mScrollerView];
    
    
    mView = [aboutusView shareView];
    mView.frame = CGRectMake(0, 0, DEVICE_Width, mScrollerView.mheight);
    [mView.mWechatBtn addTarget:self action:@selector(shareWechat:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mtencentBtn addTarget:self action:@selector(shareTencent:) forControlEvents:UIControlEventTouchUpInside];
    [mScrollerView addSubview:mView];
    
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 600);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark----分享到微信
- (void)shareWechat:(UIButton *)sender{

}
#pragma mark----分享到qq
- (void)shareTencent:(UIButton *)sender{
    
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
