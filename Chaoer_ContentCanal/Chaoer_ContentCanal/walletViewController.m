//
//  walletViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/4/5.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "walletViewController.h"
#import "walletView.h"

#import "LXCircleAnimationView.h"

#import "UILabel+FlickerNumber.h"

@interface walletViewController ()
@property (nonatomic, strong) LXCircleAnimationView *circleProgressView;
@property (nonatomic, strong) LXCircleAnimationView *circleProgressView2;
@property (nonatomic, strong) LXCircleAnimationView *circleProgressView3;
@end

@implementation walletViewController
{
    walletView *mView;
    
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.Title = self.mPageName = @"钱包";
    self.hiddenBackBtn = YES;
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    self.navBar.hidden = YES;
    [self initView];
}
- (void)initView{

    mView = [walletView shareView];
    mView.frame = CGRectMake(0, 0, DEVICE_Width, DEVICE_Height);
    
    
    [mView.withdrawalBtn addTarget:self action:@selector(tixianAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.topupBtn addTarget:self action:@selector(topupAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mOrderBtn addTarget:self action:@selector(orderAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mHistoryBtn addTarget:self action:@selector(historyAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:mView];
    CGFloat num = 123.4567;
    [mView.mBalanceLb dd_setNumber:@(num) formatter:nil];

    
    self.circleProgressView = [[LXCircleAnimationView alloc] initWithFrame:CGRectMake(0, 0, mView.mBalanceView.mwidth, mView.mBalanceView.mheight)];
    self.circleProgressView.percent = 84.f;
    [mView.mBalanceView addSubview:self.circleProgressView];
    
    self.circleProgressView2 = [[LXCircleAnimationView alloc] initWithFrame:CGRectMake(8.f,8.f, mView.mBalanceView.mwidth-16, mView.mBalanceView.mheight-16)];
    self.circleProgressView2.percent = 84.f;
    [mView.mBalanceView addSubview:self.circleProgressView2];
    
    self.circleProgressView3 = [[LXCircleAnimationView alloc] initWithFrame:CGRectMake(10.f,10.f, mView.mBalanceView.mwidth-20, mView.mBalanceView.mheight-20)];
    self.circleProgressView3.percent = 84.f;
    [mView.mBalanceView addSubview:self.circleProgressView3];

    
}

#pragma mark----提现
- (void)tixianAction:(UIButton *)sender{

}
#pragma mark----充值
- (void)topupAction:(UIButton *)sender{

}
#pragma mark----我的订单
- (void)orderAction:(UIButton *)sender{
    
}
#pragma mark----交易记录
- (void)historyAction:(UIButton *)sender{
    
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
