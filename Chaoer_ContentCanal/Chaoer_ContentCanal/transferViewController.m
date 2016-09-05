//
//  transferViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/22.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "transferViewController.h"

@interface transferViewController ()<UITextFieldDelegate>
/**
 *  账户tx
 */
@property (weak, nonatomic) IBOutlet UITextField *mAcountTx;
/**
 *  金额tx
 */
@property (weak, nonatomic) IBOutlet UITextField *mMoneyTx;
/**
 *  提示
 */
@property (weak, nonatomic) IBOutlet UILabel *mAtention;
/**
 *  确认按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mOkBtn;

@end

@implementation transferViewController
{

    BOOL mSucess;
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
    self.hiddenTabBar   = YES;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Title = self.mPageName = @"转账";
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    mSucess = NO;
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
    self.mOkBtn.layer.masksToBounds = YES;
    self.mOkBtn.layer.cornerRadius = 3;
    
    self.mAcountTx.delegate = self.mMoneyTx.delegate = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
///限制电话号码输入长度
#define PHONE_MAXLENGTH 11
///限制验证码输入长度
#define MONEY_LENGHT 4
#pragma mark **----键盘代理方法
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *new = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSInteger res;
    if (textField.tag==11) {
        res= PHONE_MAXLENGTH-[new length];
        
        
    }else
    {
        res= MONEY_LENGHT-[new length];
        
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
- (void)textFieldDidEndEditing:(UITextField *)textField{

    if (textField == self.mAcountTx) {
    
        if (![Util isMobileNumber:textField.text]) {
            [LCProgressHUD showInfoMsg:@"请输入合法的手机账户"];
            
            return;
        }
        
        [self showWithStatus:@"正在验证账户..."];
        [[mUserInfo backNowUser] codeAcount:textField.text block:^(mBaseData *resb) {
            if (resb.mSucess) {
                mSucess = YES;
                [self showSuccessStatus:resb.mMessage];
                [self.mMoneyTx becomeFirstResponder];
                self.mAtention.text = resb.mMessage;

            }
            else{
                
                [self showErrorStatus:resb.mMessage];
                self.mAtention.text = resb.mMessage;
            }
        }];
        

        
        MLLog(@"输入的结果是:%@",textField.text);
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{

    if (textField == self.mAcountTx) {
        
    }else{
        if (self.mAcountTx.text.length == 0 || mSucess == NO) {
            [self showErrorStatus:@"请输入转入的手机账户!"];
            [self.mAcountTx becomeFirstResponder];
        }
    }
}
- (IBAction)mOkAction:(UIButton *)sender {
    
    if (![Util isMobileNumber:self.mAcountTx.text]) {
        [LCProgressHUD showInfoMsg:@"请输入合法的手机账户"];
        [self.mAcountTx becomeFirstResponder];
        
        return;
    }

    if (self.mMoneyTx.text.length == 0) {
        [self showErrorStatus:@"转账金额不能为空!"];
        [self.mMoneyTx becomeFirstResponder];
        return;
    }
    if ([[NSString stringWithFormat:@"%@",self.mMoneyTx.text] intValue] > 5000) {
        [self showErrorStatus:@"转账金额不能大于5000元!"];
        [self.mMoneyTx becomeFirstResponder];
        return;
    }
    
    [self showWithStatus:@"正在操作中..."];
    [[mUserInfo backNowUser] transferMoney:self.mAcountTx.text andMoney:[[NSString stringWithFormat:@"%@",self.mMoneyTx.text] intValue] block:^(mBaseData *resb) {
        
        if (resb.mSucess) {
            [[NSNotificationCenter defaultCenter] postNotificationName:MyUserNeedUpdateNotification object:nil];
            
            [self showSuccessStatus:resb.mMessage];
            [self popViewController];
        }
        else{
            
            [self showErrorStatus:resb.mMessage];
        }
    }];
    
}

@end
