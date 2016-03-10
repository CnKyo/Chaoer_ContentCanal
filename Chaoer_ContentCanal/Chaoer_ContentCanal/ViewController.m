//
//  ViewController.m
//  O2O_XiCheSeller
//
//  Created by 密码为空！ on 15/6/18.
//  Copyright (c) 2015年 zongyoutec.com. All rights reserved.
//

#import "ViewController.h"
#import "MyViewController.h"
#import "WebVC.h"
#import "pwdViewController.h"
#import "forgetAndChangePwdView.h"
#import "AppDelegate.h"

#import "MyViewController.h"

@interface ViewController ()<UITextFieldDelegate>

@end

@implementation ViewController{
    ///判断验证码发送时间
    NSTimer   *timer;
    
    int ReadTime;
    BOOL _bneedhidstatusbar;

}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showFrist];

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
    self.mPageName = self.Title =  @"登录";
    ReadTime = 61;
    self.hiddenBackBtn = YES;
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.navBar.rightBtn.frame = CGRectMake(DEVICE_Width-100, 20, 120, 44);
    self.rightBtnTitle = @"密码登录";
    [self initView];
    

}
- (void)initView{

    self.phoneView.layer.masksToBounds = YES;
    self.phoneView.layer.borderColor = [UIColor colorWithHue:0.028 saturation:0.031 brightness:0.757 alpha:1].CGColor;
    self.phoneView.layer.borderWidth = 0.75f;
    self.phoneView.layer.cornerRadius = 5.0f;
    
    self.codeView.layer.masksToBounds = YES;
    self.codeView.layer.borderColor = [UIColor colorWithHue:0.028 saturation:0.031 brightness:0.757 alpha:1].CGColor;
    self.codeView.layer.borderWidth = 0.75f;
    self.codeView.layer.cornerRadius = 5.0f;

    
    [self.phoneTx setKeyboardType:UIKeyboardTypeNumberPad];
    self.phoneTx.clearButtonMode = UITextFieldViewModeUnlessEditing;
    self.phoneTx.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTx.delegate = self;
    
    self.codeTx.clearButtonMode = UITextFieldViewModeUnlessEditing;
    [self.codeTx setSecureTextEntry:YES];
//    self.codeTx.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTx.delegate = self;
    
    UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tapAction];

    [self.loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.codeBtn addTarget:self action:@selector(codeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mianzeBtn addTarget:self action:@selector(mianzeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.connectionBtn addTarget:self action:@selector(ConnectionAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSDictionary *mStyle1 = @{@"Action":[WPAttributedStyleAction styledActionWithAction:^{
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[GInfo shareClient].mServiceTel];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        MLLog(@"打电话");
    }],@"color": M_CO};
    
    NSDictionary *mStyle2 = @{@"Action":[WPAttributedStyleAction styledActionWithAction:^{
        WebVC* vc = [[WebVC alloc]init];
        vc.mName = @"免责声明";
        vc.mUrl = [GInfo shareClient].mProtocolUrl;
        [self pushViewController:vc];
    }],@"color": M_CO};
    
    WPHotspotLabel *wkFCode = [WPHotspotLabel new];
    wkFCode.hidden = YES;
    wkFCode.font = [UIFont systemFontOfSize:14];
    wkFCode.numberOfLines = 0;
    wkFCode.textColor = M_TextColor;
    wkFCode.attributedText = [[NSString stringWithFormat:@"%@<Action> %@</Action>",@"无法获得验证码，请联系客服",[GInfo shareClient].mServiceTel] attributedStringWithStyleBook:mStyle1];
    [self.view addSubview:wkFCode];
    
    WPHotspotLabel *wkFmianze = [WPHotspotLabel new];
    wkFmianze.hidden = YES;
    wkFmianze.font = [UIFont systemFontOfSize:14];
    wkFmianze.numberOfLines = 0;
    wkFmianze.textColor = M_TextColor;
    wkFmianze.attributedText = [[NSString stringWithFormat:@"%@<Action>《免责申明》</Action>",@"点击“登录”，即表示您同意"] attributedStringWithStyleBook:mStyle2];
    [self.view addSubview:wkFmianze];
    
    [wkFCode makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.bottom).with.offset(10);
        make.left.equalTo(self.view.left).with.offset(15);
        make.right.equalTo(self.view.right).with.offset(-15);
        make.height.offset(@45);
    }];
    
    [wkFmianze makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(wkFCode).with.offset(30);
        make.top.equalTo(self.loginBtn.bottom).with.offset(10);

        make.left.equalTo(self.view.left).with.offset(15);
        make.right.equalTo(self.view.right).with.offset(-15);
        make.height.offset(@45);
    }];
    
    
}
- (void)rightBtnTouched:(id)sender{
    pwdViewController *p = [pwdViewController new];
    [self pushViewController:p];

//    washYiXieViewController *w = [washYiXieViewController new];
//    [self pushViewController:w];
    
}
#pragma mark----登录事件
- (void)loginAction:(UIButton *)sender{
    
    [_phoneTx resignFirstResponder];
    [_codeTx resignFirstResponder];
    
    MLLog(@"登录");
    if (self.phoneTx.text == nil || [self.phoneTx.text isEqualToString:@""]) {
        [self showErrorStatus:@"手机号码不能为空"];
//        [self.phoneTx becomeFirstResponder];
        return;
    }
    if (![Util isMobileNumber:self.phoneTx.text]) {
        [self showErrorStatus:@"请输入合法的手机号码"];
//        [self.phoneTx becomeFirstResponder];
        return;
    }
    if (self.codeTx.text == nil || [self.codeTx.text isEqualToString:@""]) {
        [self showErrorStatus:@"密码不能为空"];
//        [self.codeTx becomeFirstResponder];
        return;
    }

    [SVProgressHUD showWithStatus:@"正在登录..." maskType:SVProgressHUDMaskTypeClear];
    [SUser loginWithPhone:_phoneTx.text psw:_codeTx.text block:^(SResBase *resb, SUser *user) {
        if( resb.msuccess )
        {
            [SVProgressHUD showSuccessWithStatus:resb.mmsg];
            [self loginOk];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:resb.mmsg];
        }
    }];

}

#pragma 验证码事件
- (void)codeAction:(UIButton *)sender{
    
    [_phoneTx resignFirstResponder];
    [_codeTx resignFirstResponder];
    MLLog(@"验证码");
    if (![Util isMobileNumber:_phoneTx.text]) {
        [self showErrorStatus:@"请输入合法的手机号码"];
//        [_phoneTx becomeFirstResponder];
        return;
    }
    _codeBtn.userInteractionEnabled = NO;
    
    [SVProgressHUD showWithStatus:@"正在发送验证码..." maskType:SVProgressHUDMaskTypeClear];
    [SUser sendSM:_phoneTx.text block:^(SResBase *resb) {
        
        if( resb.msuccess )
        {
            [SVProgressHUD showSuccessWithStatus:resb.mmsg];

        }
        
        else
        {
            [SVProgressHUD showErrorWithStatus:resb.mmsg];
            _codeBtn.userInteractionEnabled = YES;
        }
    
    }];


}
#pragma mark----忘记密码
- (void)ConnectionAction:(UIButton *)sender{
    UIStoryboard *secondStroyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    forgetAndChangePwdView *f =[secondStroyBoard instantiateViewControllerWithIdentifier:@"forget"];
    f.wkType = 2;
    [self.navigationController pushViewController:f animated:YES];
}
#pragma 免责声明事件
- (void)mianzeAction:(UIButton *)sender{
    MLLog(@"免责");
    WebVC* vc = [[WebVC alloc]init];
    vc.mName = @"免责声明";
    vc.mUrl = [GInfo shareClient].mProtocolUrl;
    [self pushViewController:vc];
}
#pragma mark----登录成功跳转
- (void)loginOk{
    

    self.tabBarController.selectedIndex = 1;

    
    if( self.quikTagVC )
    {
        [self setToViewController_2:self.quikTagVC];
    }
    else
    {
        [self popViewController_2];
    }
    
    
    [((AppDelegate*)[UIApplication sharedApplication].delegate) dealFuncTab];
  
    
    
    
    
}
#pragma  mark -----键盘消失
- (void)tapAction{
    
    [self.phoneTx resignFirstResponder];
    [self.codeTx resignFirstResponder];
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
    if (textField.tag==6) {
        res= PASS_LENGHT-[new length];
        
        
    }else
    {
        res= TEXT_MAXLENGTH-[new length];
        
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)showFrist
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSString* v = [def objectForKey:@"showed"];
    NSString* nowver = [Util getAppVersion];
    if( ![v isEqualToString:nowver] )
    {
        UIScrollView* firstview = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        firstview.showsHorizontalScrollIndicator = NO;
        firstview.backgroundColor = [UIColor colorWithRed:0.937 green:0.922 blue:0.918 alpha:1.000];
        firstview.pagingEnabled = YES;
        firstview.bounces = NO;
        NSArray* allimgs = [self getFristImages];
        
        CGFloat x_offset = 0.0f;
        CGRect f;
        UIImageView* last = nil;
        for ( NSString* oneimgname in allimgs ) {
            UIImageView* itoneimage = [[UIImageView alloc] initWithFrame:firstview.bounds];
            itoneimage.image = [UIImage imageNamed: oneimgname];
            f = itoneimage.frame;
            f.origin.x = x_offset;
            itoneimage.frame = f;
            x_offset += firstview.frame.size.width;
            [firstview addSubview: itoneimage];
            last  = itoneimage;
        }
        UITapGestureRecognizer* guset = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fristTaped:)];
        last.userInteractionEnabled = YES;
        [last addGestureRecognizer: guset];
        
        CGSize cs = firstview.contentSize;
        cs.width = x_offset;
        firstview.contentSize = cs;
        
        _bneedhidstatusbar = YES;
        [self setNeedsStatusBarAppearanceUpdate];
        
        
        [((UIWindow*)[UIApplication sharedApplication].delegate).window addSubview: firstview];
    }
    
}
-(void)fristTaped:(UITapGestureRecognizer*)sender
{
    UIView* ttt = [sender view];
    UIView* pview = [ttt superview];
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect f = pview.frame;
        f.origin.y = -pview.frame.size.height;
        pview.frame = f;
        
    } completion:^(BOOL finished) {
        
        [pview removeFromSuperview];
        
        NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
        NSString* nowver = [Util getAppVersion];
        [def setObject:nowver forKey:@"showed"];
        [def synchronize];
        _bneedhidstatusbar = NO;
        [self setNeedsStatusBarAppearanceUpdate];
        
    }];
}
-(NSArray*)getFristImages
{
    if( DeviceIsiPhone() )
    {
        return @[@"replash-1.png",@"replash.png"];
    }
    else
    {
        return @[@"replash-1.png",@"replash.png"];
    }
    
}

@end
