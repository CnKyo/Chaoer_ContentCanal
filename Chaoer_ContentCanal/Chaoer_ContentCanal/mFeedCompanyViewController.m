//
//  mFeedCompanyViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mFeedCompanyViewController.h"
#import "dataModel.h"
@interface mFeedCompanyViewController ()

@end

@implementation mFeedCompanyViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /**
     IQKeyboardManager为自定义收起键盘
     **/
    [[IQKeyboardManager sharedManager] setEnable:YES];///视图开始加载键盘位置开启调整
    [[IQKeyboardManager sharedManager]setEnableAutoToolbar:YES];///是否启用自定义工具栏
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;///启用手势
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];///视图消失键盘位置取消调整
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];///关闭自定义工具栏
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.Title = self.mPageName = @"对公司的建议";
    
    self.mReason.placeholder = @"在此写上您宝贵的建议:";
    [self.mReason setHolderToTop];
    
    self.mSendBtn.layer.masksToBounds = YES;
    self.mSendBtn.layer.cornerRadius = 3;
    
    [self initTap];

}
- (IBAction)mbtnAction:(id)sender {
    
    if (self.mReason.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"投诉内容不能为空！"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在提交..." maskType:SVProgressHUDMaskTypeClear];

    [mUserInfo feedCompany:[mUserInfo backNowUser].mUserId andContent:self.mReason.text block:^(mBaseData *resb) {
        [SVProgressHUD dismiss];
        if (resb.mSucess) {
            [SVProgressHUD showSuccessWithStatus:resb.mMessage];
            [self popViewController];
        }else{
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
        }
    }];
    
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
-(void)initTap{
    
    UITapGestureRecognizer *ttt = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mTapAction)];
    [self.view addGestureRecognizer:ttt];
}
- (void)mTapAction{
    [self.mReason resignFirstResponder];
}
@end
