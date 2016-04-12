//
//  forgetAndChangePwdView.m
//  O2O_JiazhengSeller
//
//  Created by 密码为空！ on 15/8/6.
//  Copyright (c) 2015年 zongyoutec.com. All rights reserved.
//

#import "forgetAndChangePwdView.h"
#import "MZTimerLabel.h"

@interface forgetAndChangePwdView ()<UITextFieldDelegate,MZTimerLabelDelegate>
@property (weak, nonatomic) IBOutlet UITextField *wkPhoneTX;
@property (weak, nonatomic) IBOutlet UITextField *wkCodeTx;
@property (weak, nonatomic) IBOutlet UITextField *wkNewPWD;
@property (weak, nonatomic) IBOutlet UITextField *wkComfirPWD;

@property (weak, nonatomic) IBOutlet UIButton *wkLoginBtn;

@property (weak, nonatomic) IBOutlet UIImageView *mPwdImg;

@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

@property (weak, nonatomic) IBOutlet UIView *wkV1;
@property (weak, nonatomic) IBOutlet UIView *wkV2;
@property (weak, nonatomic) IBOutlet UIView *wkV3;
@property (weak, nonatomic) IBOutlet UIView *wkV4;

@property (weak, nonatomic) IBOutlet UILabel *mPhoneLb;
@end

@implementation forgetAndChangePwdView
{
    UILabel *timer_show;//倒计时label

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
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}

- (void)viewDidLoad {
    
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.945 green:0.945 blue:0.945 alpha:1];

    self.hiddenlll = YES;
    
    if (self.wkType == 1) {
        self.mPageName = self.Title = @"修改密码";
        self.wkV1.hidden = YES;
        self.mPhoneLb.hidden = NO;
//        self.mPhoneLb.text = [NSString stringWithFormat:@"当前手机号：%@",[SUser currentUser].mPhone];
        [self.wkLoginBtn setTitle:@"确定修改" forState:0];
    }else{
        self.wkV1.hidden = NO;
        self.mPhoneLb.hidden = YES;
        self.mPageName = self.Title = @"修改密码";
    }

    [self initView];

}

- (void)initView
{
    self.wkV1.layer.masksToBounds = YES;
    self.wkV1.layer.borderColor = [UIColor colorWithHue:0.028 saturation:0.031 brightness:0.757 alpha:1].CGColor;
    self.wkV1.layer.borderWidth = 0.75f;
    self.wkV1.layer.cornerRadius = 5.0f;
    
    self.wkV2.layer.masksToBounds = YES;
    self.wkV2.layer.borderColor = [UIColor colorWithHue:0.028 saturation:0.031 brightness:0.757 alpha:1].CGColor;
    self.wkV2.layer.borderWidth = 0.75f;
    self.wkV2.layer.cornerRadius = 5.0f;
    
    self.wkV3.layer.masksToBounds = YES;
    self.wkV3.layer.borderColor = [UIColor colorWithHue:0.028 saturation:0.031 brightness:0.757 alpha:1].CGColor;
    self.wkV3.layer.borderWidth = 0.75f;
    self.wkV3.layer.cornerRadius = 5.0f;
    
    self.wkV4.layer.masksToBounds = YES;
    self.wkV4.layer.borderColor = [UIColor colorWithHue:0.028 saturation:0.031 brightness:0.757 alpha:1].CGColor;
    self.wkV4.layer.borderWidth = 0.75f;
    self.wkV4.layer.cornerRadius = 5.0f;
    
    [self.wkPhoneTX setKeyboardType:UIKeyboardTypeNumberPad];
    self.wkPhoneTX.clearButtonMode = UITextFieldViewModeUnlessEditing;
    self.wkPhoneTX.keyboardType = UIKeyboardTypeNumberPad;

    self.wkPhoneTX.delegate = self;
    
    self.wkCodeTx.clearButtonMode = UITextFieldViewModeUnlessEditing;
//    [self.wkCodeTx setSecureTextEntry:YES];
    self.wkCodeTx.keyboardType = UIKeyboardTypeNumberPad;
    self.wkCodeTx.delegate = self;
    
    self.wkNewPWD.clearButtonMode = UITextFieldViewModeUnlessEditing;
    [self.wkNewPWD setSecureTextEntry:YES];
    self.wkNewPWD.delegate = self;
    
    self.wkComfirPWD.clearButtonMode = UITextFieldViewModeUnlessEditing;
    [self.wkComfirPWD setSecureTextEntry:YES];
    self.wkComfirPWD.delegate = self;
    
    if (self.wkType == 1) {
        self.mPwdImg.image = [UIImage imageNamed:@"passwd"];
        self.wkNewPWD.placeholder = @"请输入新密码";
    }else{
//        self.mPwdImg.image = [UIImage imageNamed:@"phone"];
//        self.wkNewPWD.placeholder = @"请输入新手机号码";
        self.mPwdImg.image = [UIImage imageNamed:@"passwd"];
        self.wkNewPWD.placeholder = @"请输入新密码";

    }
    
    NSDictionary *mStyle1 = @{@"Action":[WPAttributedStyleAction styledActionWithAction:^{
//        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[GInfo shareClient].mServiceTel];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        MLLog(@"打电话");
    }],@"color": M_CO,@"xiahuaxian":@[M_CO,@{NSUnderlineStyleAttributeName : @(kCTUnderlineStyleSingle|kCTUnderlinePatternSolid)}]};
    
    WPHotspotLabel *wkFCode = [WPHotspotLabel new];
    wkFCode.hidden = YES;
    wkFCode.font = [UIFont systemFontOfSize:14];
    wkFCode.numberOfLines = 0;
    wkFCode.textColor = M_TextColor;
//    wkFCode.attributedText = [[NSString stringWithFormat:@"%@<Action> %@</Action>",@"无法获得验证码，请联系客服",[GInfo shareClient].mServiceTel] attributedStringWithStyleBook:mStyle1];
    [self.view addSubview:wkFCode];
    
    [wkFCode makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wkLoginBtn.bottom).with.offset(10);
        make.left.equalTo(self.view.left).with.offset(15);
        make.right.equalTo(self.view.right).with.offset(-15);
        make.height.offset(@45);
    }];
    
    UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tapAction];
    
    [self.wkLoginBtn addTarget:self action:@selector(LoginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.codeBtn addTarget:self action:@selector(codeAction:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)LoginAction{
    [self.wkPhoneTX resignFirstResponder];
    [self.wkCodeTx resignFirstResponder];
    [self.wkNewPWD resignFirstResponder];
    [self.wkComfirPWD resignFirstResponder];
    MLLog(@"确认修改");
    
    if (_wkType == 1) {
        if (self.wkCodeTx.text == nil || [self.wkCodeTx.text isEqualToString:@""]) {
            [self showErrorStatus:@"验证码不能为空"];
            [self.wkCodeTx becomeFirstResponder];
            return;
        }
//        [SUser reSetPswWithPhone:[SUser currentUser].mPhone newpsw:_wkNewPWD.text smcode:_wkCodeTx.text block:^(SResBase *resb, SUser *user) {
//            if( resb.msuccess )
//            {
//                [SVProgressHUD showSuccessWithStatus:resb.mmsg];
//                [self popToRootViewController];
//            }
//            else
//            {
//                [SVProgressHUD showErrorWithStatus:resb.mmsg];
//            }
//        }];

    }else{
        if (![Util isMobileNumber:self.wkPhoneTX.text]) {
            [self showErrorStatus:@"请输入合法的手机号码"];
            [self.wkPhoneTX becomeFirstResponder];
            return;
        }
        if (self.wkCodeTx.text == nil || [self.wkCodeTx.text isEqualToString:@""]) {
            [self showErrorStatus:@"验证码不能为空"];
            [self.wkCodeTx becomeFirstResponder];
            return;
        }
//        if (self.wkNewPWD.text != self.wkComfirPWD.text) {
//            [self showErrorStatus:@"2次输入密码不一致"];
//            [self.wkCodeTx becomeFirstResponder];
//            return;
//        }
//        
//        [SUser reSetPswWithPhone:_wkPhoneTX.text newpsw:_wkNewPWD.text smcode:_wkCodeTx.text block:^(SResBase *resb, SUser *user) {
//            if( resb.msuccess )
//            {
//                [SVProgressHUD showSuccessWithStatus:resb.mmsg];
//                [self popToRootViewController];
//            }
//            else
//            {
//                [SVProgressHUD showErrorWithStatus:resb.mmsg];
//            }
//        }];
        
    }
    
}
#pragma 验证码事件
- (void)codeAction:(UIButton *)sender{
    
    [self.wkPhoneTX resignFirstResponder];
    [self.wkCodeTx resignFirstResponder];
    [self.wkNewPWD resignFirstResponder];
    [self.wkComfirPWD resignFirstResponder];
    
    if ([Util isMobileNumber:self.wkPhoneTX.text]) {
        [self showErrorStatus:@"请输入合法的手机号码"];
        [self.wkPhoneTX becomeFirstResponder];
        return;
    }
    
    MLLog(@"验证码");
    [SVProgressHUD showWithStatus:@"正在发送验证码..." maskType:SVProgressHUDMaskTypeClear];

//    if (_wkType == 1) {
    
        _codeBtn.userInteractionEnabled = NO;
        [mUserInfo getRegistVerifyCode:self.wkPhoneTX.text block:^(mBaseData *resb) {
            if( resb.mSucess )
            {
                [SVProgressHUD showSuccessWithStatus:resb.mMessage];
                [self timeCount];
                [sender setBackgroundImage:[UIImage imageNamed:@"16"] forState:0];
            }
            
            else
            {
                [SVProgressHUD showErrorWithStatus:resb.mMessage];
                _codeBtn.userInteractionEnabled = YES;
                [sender setBackgroundImage:[UIImage imageNamed:@"3-1"] forState:0];
                
            }

        }];
        

        
//    }else{
//            _codeBtn.userInteractionEnabled = NO;
    
        
//        [SUser sendSM:_wkPhoneTX.text block:^(SResBase *resb) {
//            
//            if( resb.msuccess )
//            {
//                [SVProgressHUD showSuccessWithStatus:resb.mmsg];
//                [self timeCount];
//                [sender setBackgroundImage:[UIImage imageNamed:@"16"] forState:0];
//            }
//            
//            else
//            {
//                [SVProgressHUD showErrorWithStatus:resb.mmsg];
//                _codeBtn.userInteractionEnabled = YES;
//                [sender setBackgroundImage:[UIImage imageNamed:@"3-1"] forState:0];
//                
//            }
//            
//            
//        }];
//
//    }

    
    
}

- (void)timeCount{//倒计时函数
    
    [_codeBtn setTitle:nil forState:UIControlStateNormal];//把按钮原先的名字消掉
    timer_show = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _codeBtn.frame.size.width, _codeBtn.frame.size.height)];//UILabel设置成和UIButton一样的尺寸和位置
        [_codeBtn addSubview:timer_show];//把timer_show添加到_dynamicCode_btn按钮上
    MZTimerLabel *timer_cutDown = [[MZTimerLabel alloc] initWithLabel:timer_show andTimerType:MZTimerLabelTypeTimer];//创建MZTimerLabel类的对象timer_cutDown
    [timer_cutDown setCountDownTime:60];//倒计时时间60s
    timer_cutDown.timeFormat = @"ss秒后再试";//倒计时格式,也可以是@"HH:mm:ss SS"，时，分，秒，毫秒；想用哪个就写哪个
    timer_cutDown.timeLabel.textColor = [UIColor whiteColor];//倒计时字体颜色
    timer_cutDown.timeLabel.font = [UIFont systemFontOfSize:17.0];//倒计时字体大小
    timer_cutDown.timeLabel.textAlignment = NSTextAlignmentCenter;//剧中
    timer_cutDown.delegate = self;//设置代理，以便后面倒计时结束时调用代理
    _codeBtn.userInteractionEnabled = NO;//按钮禁止点击
    [timer_cutDown start];//开始计时
}
//倒计时结束后的代理方法
- (void)timerLabel:(MZTimerLabel *)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    [_codeBtn setTitle:@"重新发送验证码" forState:UIControlStateNormal];//倒计时结束后按钮名称改为"发送验证码"
    [timer_show removeFromSuperview];//移除倒计时模块
    _codeBtn.userInteractionEnabled = YES;//按钮可以点击
    [_codeBtn setBackgroundImage:[UIImage imageNamed:@"3-1"] forState:0];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark -----键盘消失
- (void)tapAction{
    
    [self.wkPhoneTX resignFirstResponder];
    [self.wkCodeTx resignFirstResponder];
    [self.wkNewPWD resignFirstResponder];
    [self.wkComfirPWD resignFirstResponder];

}
///限制电话号码输入长度
#define TEXT_MAXLENGTH 11
///限制密码输入长度
#define PASS_LENGHT 20
#define CodeLength 6
#pragma mark **----键盘代理方法
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *new = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSInteger res = 0;
    if (textField.tag==20) {
        res= PASS_LENGHT-[new length];
        
        
    }
    if (textField.tag == 11) {
        res= TEXT_MAXLENGTH-[new length];

    }
    if (textField.tag == 6)
    {
        res= CodeLength-[new length];
        
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

@end
