//
//  registViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "registViewController.h"

@interface registViewController ()<UITextFieldDelegate,MZTimerLabelDelegate>

@end

@implementation registViewController
{
    UILabel *timer_show;//倒计时label
    
    NSMutableArray *mIdentify;
    
    
    NSString *mCode;
    

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
    
    mIdentify = [NSMutableArray new];
    
    NSString    *sss = nil;
    if (_mType == 1 || _mType == 3) {
        sss = @"注册";
        self.mBgkH.constant = 186;
        self.mLastLine.hidden = NO;
    }else{
    
        sss = @"忘记密码";
        self.mBgkH.constant = 186;
        self.mLastLine.hidden = YES;
    }
    
    self.Title = self.mPageName =sss;
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
    
    self.mBgkView.layer.masksToBounds = YES;
    self.mBgkView.layer.borderColor = [UIColor colorWithRed:0.88 green:0.87 blue:0.89 alpha:1].CGColor;
    self.mBgkView.layer.borderWidth = 1;
    
    self.mPhone.delegate = self;
    
    self.mCodeBtn.layer.masksToBounds = self.mRegistBtn.layer.masksToBounds = YES;
    self.mCodeBtn.layer.cornerRadius = self.mRegistBtn.layer.cornerRadius = 3;
    
    

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)mgetCode:(id)sender {
    if (![Util isMobileNumber:self.mPhone.text]) {
        [self showErrorStatus:@"请输入合法的手机号码"];
        [self.mPhone becomeFirstResponder];
        return;
    }
    [SVProgressHUD showWithStatus:@"正在获取验证码..." maskType:SVProgressHUDMaskTypeClear];

    [mUserInfo getRegistVerifyCode:self.mPhone.text block:^(mBaseData *resb) {
        if (resb.mData) {
            [SVProgressHUD showSuccessWithStatus:resb.mMessage];

            mCode = [NSString stringWithFormat:@"%@",resb.mData];
            
            [self timeCount];
        }else{
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
        }
    }];
    
}
- (IBAction)mOkBtnAction:(id)sender {
    
    
    if (![Util isMobileNumber:self.mPhone.text]) {
        [self showErrorStatus:@"请输入合法的手机号码"];
        [self.mPhone becomeFirstResponder];
        return;
    }
    else if (self.mCode.text == nil || [self.mCode.text isEqualToString:@""]) {
        [self showErrorStatus:@"验证码不能为空"];
        [self.mCode becomeFirstResponder];
        return;
    }
   else if (self.mComfirPwd.text.length != self.mPwd.text.length) {
        [self showErrorStatus:@"2次输入密码不一致"];
        [self.mPwd becomeFirstResponder];
        return;
    }
    else if(self.mType == 1){
//        if (!mIdentify.count) {
//            [self showErrorStatus:@"请选择您的身份"];
//            return;
//        }
    }
    
    if (![self.mCode.text isEqualToString:mCode]) {
        [self showErrorStatus:@"验证码输入错误!"];
        [self.mCode becomeFirstResponder];
        return;

    }
    
    if (self.mComfirPwd.text.length < 6) {
        [self showErrorStatus:@"请输入6-15位密码！"];
        return;
    }
    

    if (_mType == 1) {
        [SVProgressHUD showWithStatus:@"正在注册..." maskType:SVProgressHUDMaskTypeClear];

        [mUserInfo mUserRegist:self.mPhone.text andCode:self.mCode.text andPwd:self.mComfirPwd.text andIdentity:@"1" block:^(mBaseData *resb) {
            if (resb.mSucess) {
                [SVProgressHUD showSuccessWithStatus:@"注册成功，即将重新登录!"];
                self.block(self.mPhone.text,self.mComfirPwd.text);
                
                [self dismissViewController];
                
                
            }else{
                [SVProgressHUD showErrorWithStatus:resb.mMessage];
            }
        }];
    }else if(_mType == 2){
        [SVProgressHUD showWithStatus:@"正在操作..." maskType:SVProgressHUDMaskTypeClear];

        [mUserInfo mForgetPwd:self.mPhone.text andNewPwd:self.mComfirPwd.text block:^(mBaseData *resb) {
            if (resb.mSucess) {
                [SVProgressHUD showSuccessWithStatus:resb.mMessage];
                self.block(self.mPhone.text,self.mComfirPwd.text);
                
                [self dismissViewController];
                
                
            }else{
                [SVProgressHUD showErrorWithStatus:resb.mMessage];
            }

        }];
    }else{
        
        NSMutableDictionary *para = [NSMutableDictionary new];
        [para setObject:self.mPhone.text forKey:@"loginName"];
        [para setObject:self.mCode.text forKey:@"verfyCode"];
        [para setObject:self.mComfirPwd.text forKey:@"passWord"];
        [para setObject:mIdentify[0] forKey:@"identity"];

        [para setObject:self.mOpenid forKey:@"openid"];
        [para setObject:self.mNickName forKey:@"nickname"];
        [para setObject:self.mSex forKey:@"sex"];
        [para setObject:self.mHeaderUrl forKey:@"headimgurl"];

        [SVProgressHUD showWithStatus:@"正在注册..." maskType:SVProgressHUDMaskTypeClear];
        [mUserInfo mWechatRegist:para block:^(mBaseData *resb) {
            if (resb.mSucess) {
                [SVProgressHUD showSuccessWithStatus:@"注册成功，即将重新登录!"];
                self.block(self.mPhone.text,self.mComfirPwd.text);
                
                [self dismissViewController];
                
            }else{
                [SVProgressHUD showErrorWithStatus:resb.mMessage];
            }

        }];
        
        
        
        
    }
    


}
- (void)timeCount{//倒计时函数
    
    [self.mCodeBtn setTitle:nil forState:UIControlStateNormal];//把按钮原先的名字消掉
    timer_show = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.mCodeBtn.frame.size.width, self.mCodeBtn.frame.size.height)];//UILabel设置成和UIButton一样的尺寸和位置
    [self.mCodeBtn addSubview:timer_show];//把timer_show添加到_dynamicCode_btn按钮上
    MZTimerLabel *timer_cutDown = [[MZTimerLabel alloc] initWithLabel:timer_show andTimerType:MZTimerLabelTypeTimer];//创建MZTimerLabel类的对象timer_cutDown
    [timer_cutDown setCountDownTime:60];//倒计时时间60s
    timer_cutDown.timeFormat = @"ss秒后再试";//倒计时格式,也可以是@"HH:mm:ss SS"，时，分，秒，毫秒；想用哪个就写哪个
    timer_cutDown.timeLabel.textColor = [UIColor lightGrayColor];//倒计时字体颜色
    timer_cutDown.timeLabel.font = [UIFont systemFontOfSize:17.0];//倒计时字体大小
    timer_cutDown.timeLabel.textAlignment = NSTextAlignmentCenter;//剧中
    timer_cutDown.delegate = self;//设置代理，以便后面倒计时结束时调用代理
    self.mCodeBtn.userInteractionEnabled = NO;//按钮禁止点击
    [timer_cutDown start];//开始计时
}
//倒计时结束后的代理方法
- (void)timerLabel:(MZTimerLabel *)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    [self.mCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];//倒计时结束后按钮名称改为"发送验证码"
    [timer_show removeFromSuperview];//移除倒计时模块
    self.mCodeBtn.userInteractionEnabled = YES;//按钮可以点击
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnAction:(UIButton *)sender {
    [mIdentify removeAllObjects];
    switch (sender.tag) {
        case 1:
        {
            if (sender.selected == NO) {
                self.mMasterBtn.selected = YES;
                self.mVisiterBtn.selected = NO;
                [mIdentify addObject:NumberWithFloat(sender.tag)];
            }else{
                sender.selected = NO;
                [mIdentify removeObject:NumberWithFloat(sender.tag)];

            }
        }
            break;
        case 2:
        {
            if (sender.selected == NO) {
                self.mMasterBtn.selected = NO;
                self.mVisiterBtn.selected = YES;
                [mIdentify addObject:NumberWithFloat(sender.tag)];

            }else{
                sender.selected = NO;
                [mIdentify removeObject:NumberWithFloat(sender.tag)];

            }
        }
            break;
   
        default:
            break;
    }

}

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
    [self dismissViewController];

}

@end
