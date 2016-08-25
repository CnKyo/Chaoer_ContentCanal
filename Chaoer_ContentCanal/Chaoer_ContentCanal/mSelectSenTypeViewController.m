//
//  mSelectSenTypeViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mSelectSenTypeViewController.h"

@interface mSelectSenTypeViewController ()

@end

@implementation mSelectSenTypeViewController

- (void)viewDidLoad {
    self.hiddenTabBar = YES;

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.Title = self.mPageName = @"选择配送方式";
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.94 blue:0.93 alpha:1.00];
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

- (IBAction)mPPTAction:(UIButton *)sender {
    
    self.block(@"跑跑腿配送",@"2",NO);

    [self leftBtnTouched:nil];
}

- (IBAction)mSelfAction:(UIButton *)sender {
    self.block(@"上门自取",@"1",NO);

    [self leftBtnTouched:nil];
}

- (IBAction)mStoreAction:(UIButton *)sender {
    self.block(@"店铺配送",@"3",YES);

    
    [self leftBtnTouched:nil];
}

@end
