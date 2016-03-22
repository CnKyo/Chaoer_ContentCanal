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

#import "mLoginView.h"

#import "registViewController.h"

@interface ViewController ()<UITextFieldDelegate>

@end

@implementation ViewController{
    ///判断验证码发送时间
    NSTimer   *timer;
    
    int ReadTime;
    BOOL _bneedhidstatusbar;
    
    UIScrollView    *mScrollerView;
    
    mLoginView  *mLoginV;
    
    mCustomAlertView *mAlertView;

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
    
}


- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    
    [super viewDidLoad];

    self.navBar.hidden = YES;
    self.mPageName = self.Title =  @"登录";
    ReadTime = 61;
    self.hiddenBackBtn = YES;
    self.hiddenRightBtn = YES;
    self.navBar.rightBtn.frame = CGRectMake(DEVICE_Width-100, 20, 120, 44);
    self.rightBtnTitle = @"密码登录";
    
    [self initView];
    
    [self initAlertView];

}
- (void)initView{


    mScrollerView = [UIScrollView new];
    mScrollerView.frame = self.view.bounds;
    mScrollerView.backgroundColor = [UIColor colorWithRed:0.91 green:0.53 blue:0.17 alpha:1];
    [self.view addSubview:mScrollerView];
    
    mLoginV = [mLoginView shareView];
    mLoginV.frame = CGRectMake(0, 0, mScrollerView.mwidth, 568);
    
    mLoginV.phoneTx.delegate = mLoginV.codeTx.delegate = self;
    
    [mLoginV.loginBtn addTarget:self action:@selector(mLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [mLoginV.mRegistBtn addTarget:self action:@selector(registAction:) forControlEvents:UIControlEventTouchUpInside];
    [mLoginV.mForgetBtn addTarget:self action:@selector(forgetAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [mScrollerView addSubview:mLoginV];
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 568);
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
    
    
}
#pragma mark----忘记密码
- (void)forgetAction:(UIButton *)sender{
    registViewController *rrr = [[registViewController alloc] initWithNibName:@"registViewController" bundle:nil];
    rrr.mType = 2;
    [self pushViewController:rrr];
}
#pragma mark----注册
- (void)registAction:(UIButton *)sender{
    registViewController *rrr = [[registViewController alloc] initWithNibName:@"registViewController" bundle:nil];
    rrr.mType = 1;
    [self pushViewController:rrr];
}
#pragma mark----登录
- (void)mLoginAction:(UIButton *)sender{
    MLLog(@"登录");
    if (mLoginV.phoneTx.text == nil || [mLoginV.phoneTx.text isEqualToString:@""]) {
        [self showErrorStatus:@"手机号码不能为空"];
        [mLoginV.phoneTx becomeFirstResponder];
        return;
    }
    if (![Util isMobileNumber:mLoginV.phoneTx.text]) {
        [self showErrorStatus:@"请输入合法的手机号码"];
        return;
    }
    if (mLoginV.codeTx.text == nil || [mLoginV.codeTx.text isEqualToString:@""]) {
        [self showErrorStatus:@"密码不能为空"];
        [mLoginV.codeTx becomeFirstResponder];
        
        return;
    }
    
    
    [SVProgressHUD showWithStatus:@"正在登录..." maskType:SVProgressHUDMaskTypeClear];
    


}
#pragma  mark -----键盘消失
- (void)tapAction{
    [mLoginV.phoneTx resignFirstResponder];
    [mLoginV.codeTx resignFirstResponder];
    
   
}
- (void)rightBtnTouched:(id)sender{
    pwdViewController *p = [pwdViewController new];
    [self pushViewController:p];
    
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
//    vc.mUrl = [GInfo shareClient].mProtocolUrl;
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
    
    
//    [((AppDelegate*)[UIApplication sharedApplication].delegate) dealFuncTab];
  
    
    
    
    
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









- (void)initAlertView{
    mAlertView = [mCustomAlertView shareView];
    mAlertView.alpha = 0;

    mAlertView.frame = self.view.bounds;
    mAlertView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.75];
    [self.view addSubview:mAlertView];
    
}

- (void)showSucsess:(NSString *)message{
    
    [UIView animateWithDuration:1 animations:^{
        mAlertView.alpha = 1;
        mAlertView.mStatusImg.image = [UIImage imageNamed:@"finish"];
        mAlertView.mContent.text = message;
    } completion:^(BOOL finished) {
        mAlertView.alpha = 1;
    }];
}

- (void)showError:(NSString *)message{

    [UIView animateWithDuration:1 animations:^{
        mAlertView.alpha = 1;
        mAlertView.mStatusImg.image = [UIImage imageNamed:@"error"];
        mAlertView.mContent.text = message;
    } completion:^(BOOL finished) {
        mAlertView.alpha = 1;
    }];
}
- (void)dismissAlertView{
    [UIView animateWithDuration:0.2 animations:^{
        mAlertView.alpha = 0;
    }];
}

@end
