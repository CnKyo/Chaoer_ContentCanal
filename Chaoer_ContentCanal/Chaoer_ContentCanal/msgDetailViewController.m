//
//  msgDetailViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/6.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "msgDetailViewController.h"

@interface msgDetailViewController ()

@end

@implementation msgDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"消息心详情";
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    self.hiddenTabBar = YES;
    
    
    self.mBgkView.layer.masksToBounds = YES;
    self.mBgkView.layer.cornerRadius = 3;
    
    self.mBgkView.layer.borderColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1.00].CGColor;
    self.mBgkView.layer.borderWidth = 0.5;
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
