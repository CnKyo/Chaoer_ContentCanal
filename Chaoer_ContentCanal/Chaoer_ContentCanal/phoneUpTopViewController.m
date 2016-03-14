//
//  phoneUpTopViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "phoneUpTopViewController.h"

@interface phoneUpTopViewController ()

@end

@implementation phoneUpTopViewController
{
    NSMutableArray *mTT;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.hiddenRightBtn = YES;
    self.Title = self.mPageName = @"手机充值";
    
    mTT = [NSMutableArray new];
    
    [self initView];
}
- (void)initView{

    self.mBgkView.layer.masksToBounds = YES;
    self.mBgkView.layer.borderWidth = 0.5;
    self.mBgkView.layer.borderColor = [UIColor colorWithRed:0.82 green:0.82 blue:0.83 alpha:1].CGColor;
    
    
    [self.mThirty addTarget:self action:@selector(mBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mFifty addTarget:self action:@selector(mBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mHundred addTarget:self action:@selector(mBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mGopayBtn addTarget:self action:@selector(mGoPayAction:) forControlEvents:UIControlEventTouchUpInside];

    
}
- (void)mBtnAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [mTT addObject:NumberWithInt(sender.tag)];
    }else{
        [mTT removeObject:NumberWithInt(sender.tag)];
    }
}
- (void)mGoPayAction:(UIButton *)sender{
    if (mTT.count <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择充值金额！"];
        return;
    }

    NSLog(@"选择了%@",[mTT lastObject]);


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
