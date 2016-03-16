//
//  mBundleViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mBundleViewController.h"

@interface mBundleViewController ()

@end

@implementation mBundleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.Title = self.mPageName = @"帐号绑定";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
    
    self.mBgkView.layer.masksToBounds = YES;
    self.mBgkView.layer.borderColor = [UIColor colorWithRed:0.88 green:0.87 blue:0.89 alpha:1].CGColor;
    self.mBgkView.layer.borderWidth = 1;
    
    
//    
//    [self.mTecentBtn setTitle:@"未绑定" forState:UIControlStateNormal];
//    [self.mWechatbtn setTitle:@"未绑定" forState:UIControlStateNormal];
//    [self.mSinaBtn setTitle:@"未绑定" forState:UIControlStateNormal];
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
