//
//  changePhoneViewController.m
//  O2O_Communication_seller
//
//  Created by 密码为空！ on 15/10/14.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "changePhoneViewController.h"

@interface changePhoneViewController ()

@end

@implementation changePhoneViewController
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
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.Title = self.mPageName = @"修改手机号码";
    self.view.backgroundColor = M_BGCO;
    
    
    self.mView1.layer.masksToBounds = YES;
    self.mView1.layer.borderColor = [UIColor colorWithHue:0.028 saturation:0.031 brightness:0.757 alpha:1].CGColor;
    self.mView1.layer.borderWidth = 0.75f;
    self.mView1.layer.cornerRadius = 5.0f;
    
    self.mView2.layer.masksToBounds = YES;
    self.mView2.layer.borderColor = [UIColor colorWithHue:0.028 saturation:0.031 brightness:0.757 alpha:1].CGColor;
    self.mView2.layer.borderWidth = 0.75f;
    self.mView2.layer.cornerRadius = 5.0f;
    
    self.mCodeTx.clearButtonMode = UITextFieldViewModeUnlessEditing;
    self.mCodeTx.delegate = self;
    
    self.mPhoneTx.clearButtonMode = UITextFieldViewModeUnlessEditing;
    self.mPhoneTx.delegate = self;
    
    [self.mCodeBtn addTarget:self action:@selector(codeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mOkBtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark----获取验证吗
- (void)codeAction:(UIButton *)sender{
    if (![Util isMobileNumber:self.mPhoneTx.text]) {
        [self showErrorStatus:@"请输入合法的手机号码"];
        [self.mPhoneTx becomeFirstResponder];
        return;
    }
    self.mCodeBtn.userInteractionEnabled = NO;
    
    [SVProgressHUD showWithStatus:@"正在发送验证码..." maskType:SVProgressHUDMaskTypeClear];
    
//    [SUser sendSM:self.mPhoneTx.text block:^(SResBase *resb) {
//        
//        if( resb.msuccess )
//        {
//            [SVProgressHUD showSuccessWithStatus:resb.mmsg];
//            [self timeCount];
//
//            [sender setBackgroundImage:[UIImage imageNamed:@"16"] forState:0];
//        }
//        
//        else
//        {
//            [SVProgressHUD showErrorWithStatus:resb.mmsg];
//            self.mCodeBtn.userInteractionEnabled = YES;
//            [sender setBackgroundImage:[UIImage imageNamed:@"3-1"] forState:0];
//            
//        }
//        
//        
//    }];
    
}

- (void)timeCount{//倒计时函数
    
    [self.mCodeBtn setTitle:nil forState:UIControlStateNormal];//把按钮原先的名字消掉
    timer_show = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.mCodeBtn.frame.size.width, self.mCodeBtn.frame.size.height)];//UILabel设置成和UIButton一样的尺寸和位置
    [self.mCodeBtn addSubview:timer_show];//把timer_show添加到_dynamicCode_btn按钮上
    MZTimerLabel *timer_cutDown = [[MZTimerLabel alloc] initWithLabel:timer_show andTimerType:MZTimerLabelTypeTimer];//创建MZTimerLabel类的对象timer_cutDown
    [timer_cutDown setCountDownTime:60];//倒计时时间60s
    timer_cutDown.timeFormat = @"ss秒后再试";//倒计时格式,也可以是@"HH:mm:ss SS"，时，分，秒，毫秒；想用哪个就写哪个
    timer_cutDown.timeLabel.textColor = [UIColor whiteColor];//倒计时字体颜色
    timer_cutDown.timeLabel.font = [UIFont systemFontOfSize:17.0];//倒计时字体大小
    timer_cutDown.timeLabel.textAlignment = NSTextAlignmentCenter;//剧中
    timer_cutDown.delegate = self;//设置代理，以便后面倒计时结束时调用代理
    self.mCodeBtn.userInteractionEnabled = NO;//按钮禁止点击
    [timer_cutDown start];//开始计时
}
//倒计时结束后的代理方法
- (void)timerLabel:(MZTimerLabel *)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    [self.mCodeBtn setTitle:@"重新发送验证码" forState:UIControlStateNormal];//倒计时结束后按钮名称改为"发送验证码"
    [timer_show removeFromSuperview];//移除倒计时模块
    self.mCodeBtn.userInteractionEnabled = YES;//按钮可以点击
    [self.mCodeBtn setBackgroundImage:[UIImage imageNamed:@"3-1"] forState:0];
    
}


#pragma mark----确定
- (void)okAction:(UIButton *)sender{

//    [SUser changePhone:self.mPhoneTx.text andOldphone:[SUser currentUser].mPhone andCode:self.mCodeTx.text block:^(SResBase *resb) {
//        
//        if (resb.msuccess) {
//            [SVProgressHUD showSuccessWithStatus:resb.mmsg];
//            [self popViewController_2];
//            
//        }else{
//            [SVProgressHUD showErrorWithStatus:resb.mmsg];
//        }
//    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///限制电话号码输入长度
#define TEXT_MAXLENGTH 11
#define CodeLength 6
#pragma mark **----键盘代理方法
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *new = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSInteger res = 0;
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
