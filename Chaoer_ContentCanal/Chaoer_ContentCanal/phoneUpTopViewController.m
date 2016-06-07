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
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    
}

- (void)loadData{
    [SVProgressHUD showWithStatus:@"正在验证..." maskType:SVProgressHUDMaskTypeClear];
    [mUserInfo verifyUserPhone:self.mPhoneT.text andNum:[[mTT lastObject] floatValue] block:^(mBaseData *resb) {
        if (resb.mSucess) {
            [SVProgressHUD showSuccessWithStatus:resb.mMessage];
            [self topup];
        }else{
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
        }
    }];

}

- (void)topup{
    [SVProgressHUD showWithStatus:@"正在充值..." maskType:SVProgressHUDMaskTypeClear];
    [mUserInfo topUpPhone:self.mPhoneT.text andNum:[[mTT lastObject] floatValue] andUserId:[mUserInfo backNowUser].mUserId block:^(mBaseData *resb) {
        if (resb.mSucess) {
            [SVProgressHUD showSuccessWithStatus:resb.mMessage];

        }else{
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
        }
    }];

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

    self.mGopayBtn.layer.masksToBounds = YES;
    self.mGopayBtn.layer.cornerRadius = 3;
    
    self.mPhoneT.text = [mUserInfo backNowUser].mPhone;
    self.mBalance.text = [NSString stringWithFormat:@"%.2f元",[mUserInfo backNowUser].mMoney];
    self.mBgkView.layer.masksToBounds = YES;
    self.mBgkView.layer.borderWidth = 0.5;
    self.mBgkView.layer.borderColor = [UIColor colorWithRed:0.82 green:0.82 blue:0.83 alpha:1].CGColor;
    
    
    if ([mUserInfo backNowUser].mMoney <= 0.0) {

        self.mGopayBtn.enabled = NO;
        self.mGopayBtn.backgroundColor = [UIColor lightGrayColor];
    }else{
        self.mGopayBtn.enabled = YES;
        self.mGopayBtn.backgroundColor = M_CO;
    }
    
    [self.mThirty addTarget:self action:@selector(mBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mFifty addTarget:self action:@selector(mBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mHundred addTarget:self action:@selector(mBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mGopayBtn addTarget:self action:@selector(mGoPayAction:) forControlEvents:UIControlEventTouchUpInside];

    
}
- (void)mBtnAction:(UIButton *)sender{
    if ([mUserInfo backNowUser].mMoney <= 0.0) {
        
        [LCProgressHUD showInfoMsg:@"您的余额不足！"];
        return;
    }

    [mTT removeAllObjects];
    switch (sender.tag) {
        case 30:
        {
            if (sender.selected == NO) {
                self.mThirty.selected = YES;
                self.mFifty.selected = NO;
                self.mHundred.selected = NO;
                [mTT addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            }else{
                sender.selected = NO;
                [mTT removeObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];

            }
        }
            break;
        case 50:
        {
            if (sender.selected == NO) {
                self.mThirty.selected = NO;
                self.mFifty.selected = YES;
                self.mHundred.selected = NO;
                [mTT addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            }else{
                sender.selected = NO;
                [mTT removeObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
                
            }
        }
            break;
        case 100:
        {
            if (sender.selected == NO) {
                self.mThirty.selected = NO;
                self.mFifty.selected = NO;
                self.mHundred.selected = YES;
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
- (void)mGoPayAction:(UIButton *)sender{
    if (self.mPhoneT.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您要充值的手机号码！"];
        return;
    }
    if (mTT.count <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择充值金额！"];
        return;
    }

    MLLog(@"选择了%@",[mTT lastObject]);
    [self loadData];
    
    

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
