//
//  mBalanceViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mBalanceViewController.h"
#import "mUserTopupViewController.h"
@interface mBalanceViewController ()<UITextFieldDelegate>

@end

@implementation mBalanceViewController
{
    UIScrollView *mScrollerView;
    
    mAddressView *mView;
    
    NSMutableArray *mTT;

    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /**
     IQKeyboardManager为自定义收起键盘
     **/
    [[IQKeyboardManager sharedManager] setEnable:YES];///视图开始加载键盘位置开启调整
    [[IQKeyboardManager sharedManager]setEnableAutoToolbar:YES];///是否启用自定义工具栏
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;///启用手势
    //    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];///视图消失键盘位置取消调整
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];///关闭自定义工具栏
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Title = self.mPageName = @"余额充值";
    self.hiddenTabBar = YES;
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    mTT = [NSMutableArray new];

    [self initView];
}
- (void)initView{
    
    
    mScrollerView = [UIScrollView new];
    mScrollerView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height);
    mScrollerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mScrollerView];
    
    
    mView = [mAddressView sharePayView];
    mView.frame = CGRectMake(0, 0, DEVICE_Width, 568);
    
    NSString *url = [NSString stringWithFormat:@"%@%@",[HTTPrequest returnNowURL],[mUserInfo backNowUser].mUserImgUrl];
    
    [mView.mLogo sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];

    mView.mName.text = [mUserInfo backNowUser].mPhone;
    mView.mBalance.text = [NSString stringWithFormat:@"%d元",[mUserInfo backNowUser].mMoney];
    
    [mScrollerView addSubview:mView];
    
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 568);
    
    
    [mView.bankBtn addTarget:self action:@selector(bankAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.alipayBtn addTarget:self action:@selector(bankAction:) forControlEvents:UIControlEventTouchUpInside];

    [mView.wechatBtn addTarget:self action:@selector(bankAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mPayBtn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];

}
#pragma mark----银行卡
- (void)bankAction:(UIButton *)sender{
    [mTT removeAllObjects];
    switch (sender.tag) {
        case 1:
        {
            if (sender.selected == NO) {
                mView.bankBtn.selected = YES;
                mView.alipayBtn.selected = NO;
                mView.wechatBtn.selected = NO;
                [mTT addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            }else{
                sender.selected = NO;
                [mTT removeObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
                
            }
        }
            break;
        case 2:
        {
            if (sender.selected == NO) {
                mView.bankBtn.selected = NO;
                mView.alipayBtn.selected = YES;
                mView.wechatBtn.selected = NO;
                [mTT addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            }else{
                sender.selected = NO;
                [mTT removeObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
                
            }
        }
            break;
        case 3:
        {
            if (sender.selected == NO) {
                mView.bankBtn.selected = NO;
                mView.alipayBtn.selected = NO;
                mView.wechatBtn.selected = YES;
                [mTT addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            }else{
                sender.selected = NO;
                [mTT removeObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
                
            }
            
        }
            break;
        default:
            break;
    }


}

- (void)payAction:(UIButton *)sender{
    
    if (mView.mMoneyTx.text.length == 0) {
        [self showErrorStatus:@"请输入充值金额！"];
        [mView.mMoneyTx becomeFirstResponder];
        return;
    }
    
    mUserTopupViewController *ppp = [[mUserTopupViewController alloc] initWithNibName:@"mUserTopupViewController" bundle:nil];
    ppp.mPayMoney = [[NSString stringWithFormat:@"%@",mView.mMoneyTx.text] intValue];
    [self pushViewController:ppp];
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
