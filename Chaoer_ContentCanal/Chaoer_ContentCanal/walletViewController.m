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
#import "myRedBagViewController.h"

#import "valleteHistoryViewController.h"

#import "phoneUpTopViewController.h"

#import "cashViewController.h"
#import "needCodeViewController.h"
#import "verifyBankViewController.h"
@interface walletViewController ()
@property (nonatomic, strong) LXCircleAnimationView *circleProgressView;
@property (nonatomic, strong) LXCircleAnimationView *circleProgressView2;
@property (nonatomic, strong) LXCircleAnimationView *circleProgressView3;
@end

@implementation walletViewController
{
    walletView *mView;
    
}
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    [self loadData];
    [self upDateUserInfo];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.Title = self.mPageName = @"钱包";
    self.hiddenBackBtn = YES;
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    self.navBar.hidden = YES;
    [self loadData];
    [self initView];
    
}
- (void)upDateUserInfo{
    
    [[mUserInfo backNowUser] getNowUserInfo:^(mBaseData *resb, mUserInfo *user) {
        
        
        if (resb.mSucess) {
            
        }else{
            
        }
    }];
}
- (void)loadData{

//    [SVProgressHUD showWithStatus:@"正在加载中..." maskType:SVProgressHUDMaskTypeClear];
    
    [[mUserInfo backNowUser] getWallete:[mUserInfo backNowUser].mUserId block:^(mBaseData *resb) {
        if (resb.mSucess) {
            [SVProgressHUD dismiss];
//            [SVProgressHUD showSuccessWithStatus:resb.mMessage];
            
            [mUserInfo backNowUser].mUserId = [[resb.mData objectForKey:@"user_id"] intValue];
            [mUserInfo backNowUser].mMoney = [[resb.mData objectForKey:@"money"] floatValue];
            [mUserInfo backNowUser].mCredit = [[resb.mData objectForKey:@"score"] intValue];
            
            
            
            mView.mBalanceLb.method = UILabelCountingMethodEaseInOut;
            mView.mBalanceLb.format = @"¥%.1f";
            [mView.mBalanceLb countFrom:0 to:[mUserInfo backNowUser].mMoney];
            
            
            mView.mScore.method = UILabelCountingMethodEaseInOut;
            mView.mScore.format = @"积分：%d";
            [mView.mScore countFrom:0 to:[mUserInfo backNowUser].mCredit];
            
        }else{
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
        }
    }];
}

- (void)initView{

    mView = [walletView shareView];
    mView.frame = CGRectMake(0, 0, DEVICE_Width, DEVICE_Height);
    
    
    [mView.withdrawalBtn addTarget:self action:@selector(tixianAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.topupBtn addTarget:self action:@selector(topupAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mOrderBtn addTarget:self action:@selector(orderAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mHistoryBtn addTarget:self action:@selector(historyAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mRedBagBtn addTarget:self action:@selector(redbagAction:) forControlEvents:UIControlEventTouchUpInside];

    
    [self.view addSubview:mView];

    mView.mBalanceLb.method = UILabelCountingMethodEaseInOut;
    mView.mBalanceLb.format = @"¥%.1f";
    [mView.mBalanceLb countFrom:0 to:[mUserInfo backNowUser].mMoney];
    
    
    mView.mScore.method = UILabelCountingMethodEaseInOut;
    mView.mScore.format = @"积分：%d";
    [mView.mScore countFrom:0 to:[mUserInfo backNowUser].mCredit];
    
    
    CGFloat mLevel;
    if ([mUserInfo backNowUser].mMoney <= 100) {
        mLevel = [mUserInfo backNowUser].mMoney+0.01;
    }else if ([mUserInfo backNowUser].mMoney >= 100){
        mLevel = [mUserInfo backNowUser].mMoney*0.1+0.01;
    }else if ([mUserInfo backNowUser].mMoney >= 1000){
        mLevel = [mUserInfo backNowUser].mMoney*0.01+0.01;
    }
    
    
    self.circleProgressView = [[LXCircleAnimationView alloc] initWithFrame:CGRectMake(0, 0, mView.mBalanceView.mwidth, mView.mBalanceView.mheight)];
    self.circleProgressView.percent = mLevel;
    [mView.mBalanceView addSubview:self.circleProgressView];
    
    self.circleProgressView2 = [[LXCircleAnimationView alloc] initWithFrame:CGRectMake(8.f,8.f, mView.mBalanceView.mwidth-16, mView.mBalanceView.mheight-16)];
    self.circleProgressView2.percent = mLevel;
    [mView.mBalanceView addSubview:self.circleProgressView2];
    
    self.circleProgressView3 = [[LXCircleAnimationView alloc] initWithFrame:CGRectMake(10.f,10.f, mView.mBalanceView.mwidth-20, mView.mBalanceView.mheight-20)];
    self.circleProgressView3.percent = mLevel;
    [mView.mBalanceView addSubview:self.circleProgressView3];

    
}

#pragma mark----提现
- (void)tixianAction:(UIButton *)sender{
  
    
    if ([mUserInfo backNowUser].mIsRegist == 0 ) {
    
        
        [self AlertViewShow:@"找不到银行卡！" alertViewMsg:@"需要绑定银行卡才！" alertViewCancelBtnTiele:@"取消" alertTag:12];

        return;
            
        
    }else{
        if (![mUserInfo backNowUser].mIsHousingAuthentication) {
            
            [self AlertViewShow:@"未实名认证！" alertViewMsg:@"实名认证之后才能提现！" alertViewCancelBtnTiele:@"取消" alertTag:13];
            
            return;
        }else{
            
            cashViewController *ccc = [[cashViewController alloc] initWithNibName:@"cashViewController" bundle:nil];
            [self pushViewController:ccc];
            
        }
        
    }
    

}
#pragma mark----充值
- (void)topupAction:(UIButton *)sender{
  
    
    mBalanceViewController *ppp = [[mBalanceViewController alloc] initWithNibName:@"mBalanceViewController" bundle:nil];
    [self pushViewController:ppp];
}
#pragma mark----我的积分
- (void)orderAction:(UIButton *)sender{
 
    
    valleteHistoryViewController *vvv = [[valleteHistoryViewController alloc] initWithNibName:@"valleteHistoryViewController" bundle:nil];
    vvv.mType = 2;
    [self pushViewController:vvv];
}
#pragma mark----我的红包
- (void)redbagAction:(UIButton *)sender{

    
    myRedBagViewController *mmm = [[myRedBagViewController alloc] initWithNibName:@"myRedBagViewController" bundle:nil];
    [self pushViewController:mmm];
    
}
#pragma mark----交易记录
- (void)historyAction:(UIButton *)sender{

    valleteHistoryViewController *vvv = [[valleteHistoryViewController alloc] initWithNibName:@"valleteHistoryViewController" bundle:nil];
    vvv.mType = 1;
    [self pushViewController:vvv];
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
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 12) {
        if( buttonIndex == 1)
        {
            
            verifyBankViewController *vvv = [[verifyBankViewController alloc] initWithNibName:@"verifyBankViewController" bundle:nil];
            [self pushViewController:vvv];
            
            
        }
    }else{
        if( buttonIndex == 1)
        {
            needCodeViewController *nnn = [[needCodeViewController alloc] initWithNibName:@"needCodeViewController" bundle:nil];
            nnn.Type = 1;
            
            [self pushViewController:nnn];
            
            
        }
    }
    
  
}

- (void)AlertViewShow:(NSString *)alerViewTitle alertViewMsg:(NSString *)msg alertViewCancelBtnTiele:(NSString *)cancelTitle alertTag:(int)tag{
    
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:alerViewTitle message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:@"去绑定", nil];
    al.delegate = self;
    al.tag = tag;
    [al show];
}

@end
