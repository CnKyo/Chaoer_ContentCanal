//
//  cashViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/24.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "cashViewController.h"

@interface cashViewController ()

@end

@implementation cashViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.mOkBtn.selected = NO;
    [self loadData];
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
- (void)loadData{

    [SVProgressHUD showWithStatus:@"正在验证..." maskType:SVProgressHUDMaskTypeClear];
    [mUserInfo getBundleMsg:[mUserInfo backNowUser].mUserId block:^(mBaseData *resb, SVerifyMsg *info) {
        [self headerEndRefresh];
        if (resb.mSucess) {
            [SVProgressHUD dismiss];
//            [SVProgressHUD showSuccessWithStatus:@"验证成功！"];
            self.mBankCode.text = [resb.mData objectForKey:@"bankCard"];

        }else{
            [SVProgressHUD showErrorWithStatus:@"数据验证失败！"];
            
            [self performSelector:@selector(leftBtnTouched:) withObject:nil afterDelay:1];
            
            
        };
        
    }];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.Title = self.mPageName = @"余额提现";
    
    self.mOkBtn.layer.masksToBounds = YES;
    self.mOkBtn.layer.cornerRadius = 3;
    
    self.mBalance.text = [NSString stringWithFormat:@"%.2f元",[mUserInfo backNowUser].mMoney];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.95 alpha:1.00];
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
- (IBAction)mTimeAction:(id)sender {
    
    return;
    
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"请选择到账时间" style:MHSheetStyleWeiChat itemTitles:@[@"24小时内到账",@"2小时内到账",@"2小时内到账"]];
    actionSheet.cancleTitle = @"取消选择";
    
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        NSString *text = title;
        NSLog(@"%@",text);
       
        [self.mTimeBtn setTitle:text forState:0];
        
    }];

}

- (void)leftBtnTouched:(id)sender{
    [self popViewController];
}

- (IBAction)okbtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    [SVProgressHUD showWithStatus:@"正在操作中..." maskType:SVProgressHUDMaskTypeClear];
    
    [mUserInfo  getCash:[mUserInfo backNowUser].mUserId andMoney:self.mMoneyTx.text andPresentManner:@"0" block:^(mBaseData *resb) {
        
        if (resb.mSucess) {
            [SVProgressHUD showSuccessWithStatus:resb.mMessage];
        }else{
        
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
        }
        
    }];

    
}

@end
