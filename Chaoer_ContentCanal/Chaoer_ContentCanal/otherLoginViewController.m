//
//  otherLoginViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/27.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "otherLoginViewController.h"

#import "mBundleView.h"
@interface otherLoginViewController ()<UITextFieldDelegate>

@end

@implementation otherLoginViewController
{

    mBundleView *mView;
    
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
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
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
    
    self.Title = self.mPageName =@"绑定手机号";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;

    [self initView];
    
}

- (void)initView{

    mView = [mBundleView shareView];
    [self.view addSubview:mView];
    [mView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(@0);
        make.top.equalTo(self.view).offset(@64);
        make.bottom.equalTo(self.view).offset(@0);
    }];
    
    mView.mPwdTx.delegate = mView.mPhoneTx.delegate = self;
    
    [mView.mBundleBtn addTarget:self action:@selector(bundleAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)bundleAction:(UIButton *)sender{

    if (mView.mPhoneTx.text.length == 0 || [mView.mPhoneTx.text isEqualToString:@" "]) {
        [LCProgressHUD showInfoMsg:@"手机号码不能为空"];
        return;
    
    }
    if (![Util isMobileNumber:mView.mPhoneTx.text]) {
        [LCProgressHUD showInfoMsg:@"请输入合法的手机号码"];
        
        return;
    }
    if (mView.mPwdTx.text.length == [mView.mPwdTx.text isEqualToString:@" "] ) {
        [LCProgressHUD showInfoMsg:@"密码不能为空"];
        return;
    }
    if (self.mOpenId == nil || [self.mOpenId isEqualToString:@""]) {
        MLLog(@"openid是%@",self.mOpenId);

        [LCProgressHUD showInfoMsg:@"用户标志码错误！"];
        return;
    }

    [LBProgressHUD showHUDto:self.view withTips:@"正在登录中..." animated:YES];
    [mUserInfo mLoginWithWechat:mView.mPhoneTx.text andPassword:mView.mPwdTx.text andOpenId:self.mOpenId block:^(mBaseData *resb, mUserInfo *mUser) {
        [LBProgressHUD hideAllHUDsForView:self.view animated:YES];

        if (resb.mSucess) {
            [LCProgressHUD showSuccess:@"绑定成功"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"back"object:self];
            
            [self popViewController];

        }else{
            [LCProgressHUD showFailure:resb.mMessage];
            
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
///限制电话号码输入长度
#define TEXT_MAXLENGTH 11
///限制验证码输入长度
#define PASS_LENGHT 20
#pragma mark **----键盘代理方法
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *new = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSInteger res;
    if (textField.tag==11) {
        res= TEXT_MAXLENGTH-[new length];
        
        
    }else
    {
        res= PASS_LENGHT-[new length];
        
    }
    if(res >= 0){
        return YES;
    }
    else{
        NSRange rg = {0,[string length]+res};
        if (rg.length>0) {
            NSString *s = [string substringWithRange:rg];
            [textField setText:[textField.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    
}


- (void)leftBtnTouched:(id)sender{

    [self popViewController];
}
@end
