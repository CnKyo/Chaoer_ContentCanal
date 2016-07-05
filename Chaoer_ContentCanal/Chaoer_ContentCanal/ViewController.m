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
#import "dataModel.h"

#import "otherLoginViewController.h"
#import "AppDelegate.h"
#import "WJAdsView.h"
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"

#import "CRSA.h"
#import "Base64.h"


#import "RSAEncryptor.h"


@interface ViewController ()<UITextFieldDelegate,WJAdsViewDelegate>

@end

@implementation ViewController{
    ///判断验证码发送时间
    NSTimer   *timer;
    
    int ReadTime;
    BOOL _bneedhidstatusbar;
    
    UIScrollView    *mScrollerView;
    
    mLoginView  *mLoginV;
    
    mCustomAlertView *mAlertView;
    
    
    NSString    *mCodeStr;
    
    
    /**
     *  微信openid
     */
    NSString *mOpenID;
    /**
     *  昵称
     */
    NSString *mNickName;
    /**
     *  性别
     */
    NSString *mSex;
    /**
     *  头像
     */
    NSString *mHeaderUrl;
    
    int mType;
    
    
    NSString *mRSAKey;

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
    
    UIImageView *mBgk = [UIImageView new];
    mBgk.frame = self.view.bounds;
    mBgk.image = [UIImage imageNamed:@"login_bgk"];
    [self.view addSubview:mBgk];
    
    mRSAKey = nil;
    [self getRSAKey];
    [self initView];
    
    [self initAlertView];

}
- (void)initView{


    mScrollerView = [UIScrollView new];
    mScrollerView.frame = self.view.bounds;
    mScrollerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mScrollerView];
    
    mLoginV = [mLoginView shareView];
    mLoginV.frame = CGRectMake(0, 0, mScrollerView.mwidth, 568);
    
    
    if ([mUserInfo backNowUser].mPhone) {
        mLoginV.phoneTx.text = [mUserInfo backNowUser].mPhone;

    }
    

    mLoginV.phoneTx.delegate = mLoginV.codeTx.delegate = self;
    
    [mLoginV.loginBtn addTarget:self action:@selector(mLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [mLoginV.mRegistBtn addTarget:self action:@selector(registAction:) forControlEvents:UIControlEventTouchUpInside];
    [mLoginV.mForgetBtn addTarget:self action:@selector(forgetAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [mLoginV.mWechatLogin addTarget:self action:@selector(wechatAction:) forControlEvents:UIControlEventTouchUpInside];

    [mLoginV.mTencentLogin addTarget:self action:@selector(tencentAction:) forControlEvents:UIControlEventTouchUpInside];
    [mLoginV.mSinaLogin addTarget:self action:@selector(sinaAction:) forControlEvents:UIControlEventTouchUpInside];

    
    [mScrollerView addSubview:mLoginV];
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 568);
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
    
    
}
#pragma mark----微信登录
- (void)wechatAction:(UIButton *)sender{

    [self loginWithType:SSDKPlatformTypeWechat];
}
#pragma mark----qq登录
- (void)tencentAction:(UIButton *)sender{
    
    [self loginWithType:SSDKPlatformTypeQQ];
    
}

#pragma mark----新浪登录
- (void)sinaAction:(UIButton *)sender{
    //    [LBProgressHUD showHUDto:self.view withTips:@"正在登录中..." animated:YES];
    //
    //    ///新浪登录
    //    [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo
    //           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
    //     {
    //         [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
    //
    //         if (state == SSDKResponseStateSuccess)
    //         {
    //
    //             NSLog(@"返回的用户信息：%@",user);
    //
    //         }
    //
    //         else
    //         {
    //             NSLog(@"%@",error);
    //             [self showErrorStatus:[NSString stringWithFormat:@"%@",error]];
    //
    //         }
    //         
    //     }];
    [LCProgressHUD showInfoMsg:@"未授权..."];
    
}

- (void)loginWithType:(SSDKPlatformType)type{
    [LBProgressHUD showHUDto:self.view withTips:@"正在登录中..." animated:YES];
    
    
    [SSEThirdPartyLoginHelper loginByPlatform:type
                                   onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
                                       [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                       
                                       
                                       //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
                                       
                                       //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
                                       associateHandler (user.uid, user, user);
                                       MLLog(@"dd%@",user.rawData);
                                       MLLog(@"dd%@",user.credential);
                                       NSMutableDictionary *para = [NSMutableDictionary new];

                                       if (type == SSDKPlatformTypeQQ) {
                                           mOpenID = user.credential.uid;
                                           mNickName = [user.rawData objectForKey:@"nickname"];
                                           mSex = [user.rawData objectForKey:@"gender"];
                                           mHeaderUrl = [user.rawData objectForKey:@"figureurl_qq_2"];
                                           [para setObject:@"2" forKey:@"loginType"];
                                           if ([mSex isEqualToString:@"男"]) {
                                               mSex = @"1";
                                           }else if ([mSex isEqualToString:@"女"]){
                                               mSex = @"2";
                                           }

                                       }else if (type == SSDKPlatformTypeWechat){
                                           mOpenID = [user.rawData objectForKey:@"openid"];
                                           mNickName = [user.rawData objectForKey:@"nickname"];
                                           mSex = [user.rawData objectForKey:@"sex"];
                                           mHeaderUrl = [user.rawData objectForKey:@"headimgurl"];
                                           [para setObject:@"1" forKey:@"loginType"];

                                       }

                                       
                                       NSString *mUTFStr = [[NSString alloc] initWithString:mNickName];
                                       [mUTFStr enumerateSubstringsInRange:NSMakeRange(0, mUTFStr.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
                                           
                                           
                                           const unichar hs = [substring characterAtIndex:0];
                                           if (0xd800 <= hs && hs <= 0xdbff) {
                                               if (substring.length > 1) {
                                                   const unichar ls = [substring characterAtIndex:1];
                                                   const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                                   if (0x1d000 <= uc && uc <= 0x1f77f) {
                                                       mNickName = [mNickName stringByReplacingOccurrencesOfString:substring withString:@""];                                                   }
                                               }
                                           } else if (substring.length > 1) {
                                               const unichar ls = [substring characterAtIndex:1];
                                               if (ls == 0x20e3) {
                                                   mNickName = [mNickName stringByReplacingOccurrencesOfString:substring withString:@""];                                               }
                                           } else {
                                               if (0x2100 <= hs && hs <= 0x27ff) {
                                                   mNickName = [mNickName stringByReplacingOccurrencesOfString:substring withString:@""];                                               } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                                       mNickName = [mNickName stringByReplacingOccurrencesOfString:substring withString:@""];                                               } else if (0x2934 <= hs && hs <= 0x2935) {
                                                           mNickName = [mNickName stringByReplacingOccurrencesOfString:substring withString:@""];                                               } else if (0x3297 <= hs && hs <= 0x3299) {
                                                               mNickName = [mNickName stringByReplacingOccurrencesOfString:substring withString:@""];                                               } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                                                   mNickName = [mNickName stringByReplacingOccurrencesOfString:substring withString:@""];                                               }
                                           }

                                       }];
                              
                                     
                                       
                                       
                                       MLLog(@"性别是：%@",mSex);
                                       [para setObject:@"ios" forKey:@"device"];

                                       [para setObject:mOpenID forKey:@"openid"];
                                       [para setObject:mNickName forKey:@"nickname"];
                                       [para setObject:mSex forKey:@"sex"];
                                       [para setObject:mHeaderUrl forKey:@"headimgurl"];
                                       [para setObject:NumberWithInt(0) forKey:@"identity"];
                                       
                                       MLLog(@"第三方登录的参数：%@",para);
                                       
                                       [mUserInfo mVerifyOpenId:para block:^(mBaseData *resb, mUserInfo *mUser) {
                                           if (resb.mState == 200011) {
                                               
                                               [LCProgressHUD showSuccess:@"登录成功"];
                                               
                                               [self loginOk];
                                               //
                                           }else if (resb.mSucess){
                                               [LCProgressHUD showSuccess:@"登录成功"];
                                               
                                               [self loginOk];
                                           }
                                           else{
                                               
                                               //                                               [self showAdsView];
                                               
                                               [self showErrorStatus:@"您已取消登录！"];
                                               
                                               
                                           }
                                       }];
                                       
                                       
                                   }onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
                                       
                                       if (state == SSDKResponseStateSuccess){
                                           [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                           
                                           MLLog(@"返回的用户信息：%@",user);
                                           
                                        
                                           
                                       }  else
                                       {
                                           [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                           
                                           MLLog(@"－－－错误信息%@",error);
                                           [self showErrorStatus:@"您已取消登录！"];
                                       }
                                   }];

}



- (void)goWechat{

    otherLoginViewController *ooo = [[otherLoginViewController alloc] initWithNibName:@"otherLoginViewController" bundle:nil];
    ooo.mType = 2;
    ooo.mOpenId = mOpenID;
    [self presentModalViewController:ooo];
}

#pragma mark----忘记密码
- (void)forgetAction:(UIButton *)sender{
    registViewController *rrr = [[registViewController alloc] initWithNibName:@"registViewController" bundle:nil];
    rrr.mType = 2;
    rrr.block = ^(NSString *content,NSString *mPwd){
        
        mLoginV.phoneTx.text = content;
        mLoginV.codeTx.text = mPwd;
    };
    
    [self presentModalViewController:rrr];
}
#pragma mark----注册
- (void)registAction:(UIButton *)sender{
    
    mType = 1;
    
    [self goRegist];
}

- (void)goRegist{
    registViewController *rrr = [[registViewController alloc] initWithNibName:@"registViewController" bundle:nil];
    rrr.mType = mType;
    
    if (mType == 3) {
        rrr.mOpenid = mOpenID;
        rrr.mNickName = mNickName;
        rrr.mSex = mSex;
        rrr.mHeaderUrl = mHeaderUrl;
    }
    
    rrr.block = ^(NSString *content,NSString *mPwd){
        
        mLoginV.phoneTx.text = content;
        mLoginV.codeTx.text = mPwd;
        
        [self initLogin];
        
    };

    [self presentModalViewController:rrr];
}
#pragma mark----获取RSAkey
- (void)getRSAKey{

    [mUserInfo getRSAKey:^(mBaseData *resb) {
       
        if (resb.mSucess) {
            mRSAKey = resb.mData;
        }else{
            mRSAKey = nil;
        }
    }];
    
}
#pragma mark----登录
- (void)mLoginAction:(UIButton *)sender{
    MLLog(@"登录");
    if (mLoginV.phoneTx.text == nil || [mLoginV.phoneTx.text isEqualToString:@""]) {
        [LCProgressHUD showInfoMsg:@"手机号码不能为空"];
        [mLoginV.phoneTx becomeFirstResponder];
        return;
    }
    if (![Util isMobileNumber:mLoginV.phoneTx.text]) {
        [LCProgressHUD showInfoMsg:@"请输入合法的手机号码"];
        [mLoginV.phoneTx becomeFirstResponder];

        return;
    }
    if (mLoginV.codeTx.text == nil || [mLoginV.codeTx.text isEqualToString:@""]) {
        [LCProgressHUD showInfoMsg:@"密码不能为空"];

        [mLoginV.codeTx becomeFirstResponder];
        
        return;
    }
    
    [self initLogin];
   
}

- (void)initLogin{
    
    [LBProgressHUD showHUDto:self.view withTips:@"正在登录中..." animated:YES];
    
    [mUserInfo mUserLogin:mLoginV.phoneTx.text andPassword:[Util RSAEncryptor:mLoginV.codeTx.text] block:^(mBaseData *resb, mUserInfo *mUser) {
        [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (resb.mSucess) {
            [self loginOk];
            
            [LCProgressHUD showSuccess:@"登录成功"];
        }else{
            [LCProgressHUD showFailure:resb.mMessage];
            
        }
        
        
    }];

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
    

//    self.tabBarController.selectedIndex = 1;


//    if( self.quikTagVC )
//    {
//        [self setToViewController_2:self.quikTagVC];
//    }
//    else
//    {
//        [self popViewController_2];
    [self dismissViewController];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"back"object:self];

//    }
    

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
        return @[@"replash-1.png",@"replash.png",@"replash3.png"];
    }
    else
    {
        return @[@"replash-1.png",@"replash.png",@"replash3.png"];
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


#pragma mark----加载弹框
- (void)showAdsView{
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.window.backgroundColor = [UIColor colorWithWhite:20
                                                   alpha:0.3];
    WJAdsView *adsView = [[WJAdsView alloc] initWithWindow:app.window];
    adsView.tag = 10;
    adsView.delegate = self;
    
    NSArray *tt = @[@"已有账号去登录",@"未有账号去注册"];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    
    UIView *vvvv = [UIView new];
    vvvv.frame = CGRectMake(0, 0,adsView.mainContainView.frame.size.width, adsView.mainContainView.frame.size.height);
    
    UIImageView *iii = [UIImageView new];
    iii.frame = vvvv.bounds;
    iii.image = [UIImage imageNamed:@"ren_bgk"];
    [vvvv addSubview:iii];
    
    UIButton *aaa = [UIButton new];
    aaa.frame = CGRectMake(15, vvvv.frame.size.height/2-60, vvvv.frame.size.width-30, 40);
    aaa.backgroundColor = M_CO;
    
    aaa.layer.masksToBounds = YES;
    aaa.layer.cornerRadius = 3;
    
    [aaa setTitle:tt[0] forState:0];
    [aaa addTarget:self action:@selector(aaaAction:) forControlEvents:UIControlEventTouchUpInside];
    [vvvv addSubview:aaa];
    
    UIButton *bbb = [UIButton new];
    bbb.frame = CGRectMake(15, vvvv.frame.size.height/2+30, vvvv.frame.size.width-30, 40);
    bbb.backgroundColor = [UIColor redColor];
    
    bbb.layer.masksToBounds = YES;
    bbb.layer.cornerRadius = 3;
    
    [bbb setTitle:tt[1] forState:0];
    [bbb addTarget:self action:@selector(bbbAction:) forControlEvents:UIControlEventTouchUpInside];
    [vvvv addSubview:bbb];
    
    
    [array addObject:vvvv];
    
    
    
    [self.view addSubview:adsView];
    adsView.containerSubviews = array;
    [adsView showAnimated:YES];
}


- (void)aaaAction:(UIButton *)sender{
    [self goWechat];

}

- (void)bbbAction:(UIButton *)sender{
    mType = 3;
    [self goRegist];
}

- (void)hide{
    WJAdsView *adsView = (WJAdsView *)[self.view viewWithTag:10];
    [adsView hideAnimated:YES];
}
- (void)wjAdsViewDidAppear:(WJAdsView *)view{
    MLLog(@"视图出现");
}
- (void)wjAdsViewDidDisAppear:(WJAdsView *)view{
    MLLog(@"视图消失");
}

- (void)wjAdsViewTapMainContainView:(WJAdsView *)view currentSelectIndex:(long)selectIndex{
    MLLog(@"点击主内容视图:--%ld",selectIndex);
}


@end
