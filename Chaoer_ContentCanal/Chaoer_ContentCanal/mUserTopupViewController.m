//
//  mUserTopupViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mUserTopupViewController.h"
#import "mTopUpBalanceView.h"
#import "CardIOPaymentViewControllerDelegate.h"
#import "CardIO.h"

@interface mUserTopupViewController ()<MZTimerLabelDelegate,UITextFieldDelegate,CardIOPaymentViewControllerDelegate>

@end

@implementation mUserTopupViewController
{

    UIScrollView *mScrollerView;

    mTopUpBalanceView *mView;

    UILabel *timer_show;//倒计时label
    
    NSString *orderCode;
    NSString *ybOrderCode;
    
    
    NSString    *_previousTextFieldContent;
    UITextRange *_previousSelection;

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [CardIOUtilities preload];

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
    // Do any additional setup after loading the view from its nib.
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.hiddenRightBtn = YES;
    self.Title = self.mPageName = @"银行卡充值";
    [self initView];
    [self loadData];
}
- (void)loadData{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",[HTTPrequest currentResourceUrl],[mUserInfo backNowUser].mUserImgUrl];
    
    [mView.mHeader sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];

    mView.mName.text = [NSString stringWithFormat:@"帐号：%@",[mUserInfo backNowUser].mPhone];
    mView.mBalance.text = [NSString stringWithFormat:@"帐户余额：%.2f",[mUserInfo backNowUser].mMoney];
    
    
    
}
- (void)initView{
    UIImageView *iii = [UIImageView new];
    iii.image = [UIImage imageNamed:@"mBaseBgkImg"];
    iii.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height);
    [self.view addSubview:iii];
    
    mScrollerView = [UIScrollView new];
    mScrollerView.backgroundColor = [UIColor clearColor];
    mScrollerView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-50);
    [self.view addSubview:mScrollerView];
    
    
    
    mView = [mTopUpBalanceView shareView];
    mView.frame = CGRectMake(0, 0, DEVICE_Width, mScrollerView.mheight);
    
    mView.mPhone.delegate = mView.mBankCard.delegate = mView.mIdentify.delegate = self;
    
    mView.mTime.tag = 5;
    
    mView.mCVV.delegate = self;
    mView.mTime.delegate = self;
    mView.mBankCard.delegate = self;
    
    //当编辑改变的时候，进行字符校验
    [mView.mTime addTarget:self action:@selector(reformatAsPhoneNumber:) forControlEvents:UIControlEventEditingChanged];
    
    [mView.mPhotoBtn addTarget:self action:@selector(scanAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [mView.mPayBtn addTarget:self action:@selector(mPayAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mCodeBtn addTarget:self action:@selector(mCodeAction:) forControlEvents:UIControlEventTouchUpInside];

    [mScrollerView addSubview:mView];
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 568);

}
#pragma mark----扫描
- (void)scanAction:(UIButton *)sender{
    CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    scanViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:scanViewController animated:YES completion:nil];
}

#pragma mark - CardIOPaymentViewControllerDelegate

- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)info inPaymentViewController:(CardIOPaymentViewController *)paymentViewController {
    MLLog(@"Scan succeeded with info: %@", info);
    // Do whatever needs to be done to deliver the purchased items.
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSString *mTT = [NSString stringWithFormat:@"Received card info. Number: %@, expiry: %02lu/%lu, cvv: %@.", info.redactedCardNumber, (unsigned long)info.expiryMonth, (unsigned long)info.expiryYear, info.cvv];
    MLLog(@"最后扫描出来的信息是：%@",mTT);
    
    mView.mBankCard.text = info.cardNumber;
    mView.mTime.text = [NSString stringWithFormat:@"%02lu/%lu",(unsigned long)info.expiryMonth, (unsigned long)info.expiryYear];
    mView.mCVV.text = info.cvv;
}

- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)paymentViewController {
    MLLog(@"User cancelled scan");
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark----验证吗按钮
- (void)mCodeAction:(UIButton *)sender{
    if (mView.mBankCard.text.length == 0) {
        [mView.mBankCard becomeFirstResponder];
        [self showErrorStatus:@"银行卡不能为空"];
        return;
    }
    if (mView.mTime.text.length == 0) {
        [mView.mTime becomeFirstResponder];
        [self showErrorStatus:@"有效期不能为空"];
        return;
    }
    if (mView.mCVV.text.length == 0) {
        [mView.mCVV becomeFirstResponder];
        [self showErrorStatus:@"CVV码不能为空"];
        return;
    }
    if (mView.mNameTx.text.length == 0) {
        [mView.mNameTx becomeFirstResponder];
        [self showErrorStatus:@"姓名不能为空"];
        return;
    }
    if (mView.mIdentify.text.length == 0) {
        [mView.mIdentify becomeFirstResponder];
        [self showErrorStatus:@"身份证不能为空"];
        return;
    }
    if (mView.mPhone.text.length == 0) {
        [mView.mPhone becomeFirstResponder];
        [self showErrorStatus:@"手机号不能为空"];
        return;
    }
    if (![Util isMobileNumber:mView.mPhone.text]) {
        [mView.mPhone becomeFirstResponder];
        [self showErrorStatus:@"请输入合法的手机号码"];
        return;
    }
    if (![Util checkIdentityCardNo:mView.mIdentify.text]) {
        [mView.mIdentify becomeFirstResponder];
        [self showErrorStatus:@"请输入合法的身份证号码"];
        return;
    }
    if (![Util checkBankCard:mView.mBankCard.text]) {
        [mView.mBankCard becomeFirstResponder];
        [self showErrorStatus:@"请输入合法的银行卡号"];
        return;
    }
    if (self.mPayMoney <= 0 ) {
        [self showErrorStatus:@"请输入充值金额"];
        [self leftBtnTouched:nil];
        return;
    }
    if (mView.mTime.text.length <= 4) {
        [self showErrorStatus:@"请输入正确的有效期"];
        [mView.mTime becomeFirstResponder];
        return;

    }
    [SVProgressHUD showWithStatus:@"正在获取..." maskType:SVProgressHUDMaskTypeClear];

    [mUserInfo getBalanceVerifyCode:@"超尔物管通" andLoginName:[mUserInfo backNowUser].mPhone andPayMoney:self.mPayMoney andPayName:mView.mNameTx.text andIdentify:mView.mIdentify.text andPhone:mView.mPhone.text andBalance:[mUserInfo backNowUser].mMoney andBankCard:mView.mBankCard.text andBankTime:mView.mTime.text andCVV:mView.mCVV.text block:^(mBaseData *resb) {
        if (resb.mSucess) {
            [SVProgressHUD showSuccessWithStatus:resb.mMessage];
            [self timeCount];
            
            ybOrderCode = [resb.mData objectForKey:@"ybOrderCode"];
            
            orderCode = [resb.mData objectForKey:@"orderCode"];

        }else{
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
        }
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark----支付按钮
- (void)mPayAction:(UIButton *)sender{

    if (mView.mBankCard.text.length == 0) {
        [mView.mBankCard becomeFirstResponder];
        [self showErrorStatus:@"银行卡不能为空"];
        return; 
    }
    if (mView.mTime.text.length == 0) {
        [mView.mTime becomeFirstResponder];
        [self showErrorStatus:@"有效期不能为空"];
        return;
    }
    if (mView.mCVV.text.length == 0) {
        [mView.mCVV becomeFirstResponder];
        [self showErrorStatus:@"CVV码不能为空"];
        return;
    }
    if (mView.mNameTx.text.length == 0) {
        [mView.mNameTx becomeFirstResponder];
        [self showErrorStatus:@"姓名不能为空"];
        return;
    }
    if (mView.mIdentify.text.length == 0) {
        [mView.mIdentify becomeFirstResponder];
        [self showErrorStatus:@"身份证不能为空"];
        return;
    }
    if (mView.mPhone.text.length == 0) {
        [mView.mPhone becomeFirstResponder];
        [self showErrorStatus:@"手机号不能为空"];
        return;
    }
    if (mView.mCode.text.length == 0) {
        [mView.mCode becomeFirstResponder];
        [self showErrorStatus:@"验证码不能为空"];
        return;
    }
    
    if (![Util isMobileNumber:mView.mPhone.text]) {
        [mView.mPhone becomeFirstResponder];
        [self showErrorStatus:@"请输入合法的手机号码"];
        return;
    }
    if (![Util checkIdentityCardNo:mView.mIdentify.text]) {
        [mView.mIdentify becomeFirstResponder];
        [self showErrorStatus:@"请输入合法的身份证号码"];
        return;
    }
    if (![Util checkBankCard:mView.mBankCard.text]) {
        [mView.mBankCard becomeFirstResponder];
        [self showErrorStatus:@"请输入合法的银行卡号"];
        return;
    }
    
    if (orderCode.length == 0 || [orderCode isEqualToString:@""]) {
        [self showErrorStatus:@"订单编号错误！请重新提交！"];
        return;
    }
    if (ybOrderCode.length == 0 || [ybOrderCode isEqualToString:@""]) {
        [self showErrorStatus:@"订单编号错误！请重新提交！"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在充值..." maskType:SVProgressHUDMaskTypeClear];

    [mUserInfo getCodeAndPay:orderCode andYBOrderCode:ybOrderCode andPhoneCode:mView.mCode.text block:^(mBaseData *resb) {
        if (resb.mSucess) {
            [SVProgressHUD showSuccessWithStatus:resb.mMessage];
            [self popViewController_2];
        }else{
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
        }
    }];
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)timeCount{//倒计时函数
    
    [mView.mCodeBtn setTitle:nil forState:UIControlStateNormal];//把按钮原先的名字消掉
    timer_show = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, mView.mCodeBtn.frame.size.width, mView.mCodeBtn.frame.size.height)];//UILabel设置成和UIButton一样的尺寸和位置
    [mView.mCodeBtn addSubview:timer_show];//把timer_show添加到_dynamicCode_btn按钮上
    MZTimerLabel *timer_cutDown = [[MZTimerLabel alloc] initWithLabel:timer_show andTimerType:MZTimerLabelTypeTimer];//创建MZTimerLabel类的对象timer_cutDown
    [timer_cutDown setCountDownTime:60];//倒计时时间60s
    timer_cutDown.timeFormat = @"ss秒后再试";//倒计时格式,也可以是@"HH:mm:ss SS"，时，分，秒，毫秒；想用哪个就写哪个
    timer_cutDown.timeLabel.textColor = [UIColor whiteColor];//倒计时字体颜色
    timer_cutDown.timeLabel.font = [UIFont systemFontOfSize:17.0];//倒计时字体大小
    timer_cutDown.timeLabel.textAlignment = NSTextAlignmentCenter;//剧中
    timer_cutDown.delegate = self;//设置代理，以便后面倒计时结束时调用代理
    mView.mCodeBtn.userInteractionEnabled = NO;//按钮禁止点击
    [timer_cutDown start];//开始计时
}
//倒计时结束后的代理方法
- (void)timerLabel:(MZTimerLabel *)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    [mView.mCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];//倒计时结束后按钮名称改为"发送验证码"
    [timer_show removeFromSuperview];//移除倒计时模块
    mView.mCodeBtn.userInteractionEnabled = YES;//按钮可以点击
    [mView.mCodeBtn setBackgroundImage:[UIImage imageNamed:@"3-1"] forState:0];
    
}



///限制电话号码输入长度
#define PHONE_MAXLENGTH 11
///限制验证码输入长度
#define IDENTIFY_LENGHT 18
#define Time_LENGHT 4
#define CVV_LENGHT 3
#pragma mark **----键盘代理方法
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *new = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSInteger res;
    if (textField.tag==18) {
        res= IDENTIFY_LENGHT-[new length];
        
        
    }
    else if (textField.tag == 4){
        res= Time_LENGHT-[new length];
        
        _previousSelection = textField.selectedTextRange;
        _previousTextFieldContent = textField.text;
        
        if(range.location==0) {
            if(string.integerValue >1)
            {
                return NO;
            }
        }


    }
    else if (textField.tag == 3){
        res= CVV_LENGHT-[new length];
    
        
        
    }
    else
    {
        res= PHONE_MAXLENGTH-[new length];
        
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



-(void)reformatAsPhoneNumber:(UITextField *)textField {
    /**
     *  判断正确的光标位置
     */
    NSUInteger targetCursorPostion = [textField offsetFromPosition:textField.beginningOfDocument toPosition:textField.selectedTextRange.start];
    NSString *phoneNumberWithoutSpaces = [self removeNonDigits:textField.text andPreserveCursorPosition:&targetCursorPostion];
    
    
    if([phoneNumberWithoutSpaces length]>4) {
        /**
         *  避免超过11位的输入
         */
        
        [textField setText:_previousTextFieldContent];
        textField.selectedTextRange = _previousSelection;
        
        return;
    }
    
    
    NSString *phoneNumberWithSpaces = [self insertSpacesEveryFourDigitsIntoString:phoneNumberWithoutSpaces andPreserveCursorPosition:&targetCursorPostion];
    
    textField.text = phoneNumberWithSpaces;
    UITextPosition *targetPostion = [textField positionFromPosition:textField.beginningOfDocument offset:targetCursorPostion];
    [textField setSelectedTextRange:[textField textRangeFromPosition:targetPostion toPosition:targetPostion]];
    
}

/**
 *  除去非数字字符，确定光标正确位置
 *
 *  @param string         当前的string
 *  @param cursorPosition 光标位置
 *
 *  @return 处理过后的string
 */
- (NSString *)removeNonDigits:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition {
    NSUInteger originalCursorPosition =*cursorPosition;
    NSMutableString *digitsOnlyString = [NSMutableString new];
    
    for (NSUInteger i=0; i<string.length; i++) {
        unichar characterToAdd = [string characterAtIndex:i];
        
        if(isdigit(characterToAdd)) {
            NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
            [digitsOnlyString appendString:stringToAdd];
        }
        else {
            if(i<originalCursorPosition) {
                (*cursorPosition)--;
            }
        }
    }
    return digitsOnlyString;
}

/**
 *  将空格插入我们现在的string 中，并确定我们光标的正确位置，防止在空格中
 *
 *  @param string         当前的string
 *  @param cursorPosition 光标位置
 *
 *  @return 处理后有空格的string
 */
- (NSString *)insertSpacesEveryFourDigitsIntoString:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition{
    NSMutableString *stringWithAddedSpaces = [NSMutableString new];
    NSUInteger cursorPositionInSpacelessString = *cursorPosition;
    
    for (NSUInteger i=0; i<string.length; i++) {
        if(i>0)
        {
            if(i==2) {
                [stringWithAddedSpaces appendString:@"/"];
                
                if(i<cursorPositionInSpacelessString) {
                    (*cursorPosition)++;
                }
            }
        }
        
        unichar characterToAdd = [string characterAtIndex:i];
        NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
        [stringWithAddedSpaces appendString:stringToAdd];
    }
    return stringWithAddedSpaces;
}



@end
