//
//  setupViewController.m
//  O2O_Communication_seller
//
//  Created by 密码为空！ on 15/9/18.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "setupViewController.h"
#import "moreView.h"
#import "WebVC.h"
#import "feedbackViewController.h"
#import "footView.h"

@interface setupViewController ()

@end

@implementation setupViewController
{
    moreView *mView;
    footView    *mFootView;

}
- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.Title = self.mPageName = @"设置";
    self.view.backgroundColor = M_BGCO;
    
    mView = [moreView shareSetup];
    mView.frame = CGRectMake(0, 64, DEVICE_Width, 165);
    
    [mView.mCache addTarget:self action:@selector(cacheAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mAboiutus addTarget:self action:@selector(aboutUs:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mMsgPush addTarget:self action:@selector(mSwithClick:) forControlEvents:UIControlEventTouchUpInside];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *isopen = [defaults objectForKey:@"msgpush"];
    
    if (isopen == nil) {
        mView.mMsgPush.on= YES;
    }else if ([isopen intValue] == 0){
        
        mView.mMsgPush.on= NO;
    }else if ([isopen intValue] == 1){
        
        mView.mMsgPush.on= YES;
    }

    
    
    [self.view addSubview:mView];

    mFootView = [footView shareView];
    mFootView.frame = CGRectMake(0, mView.mbottom, DEVICE_Width, 75);
    [mFootView.mLoginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
//    if ([SUser isNeedLogin]) {
//        
//        [mFootView.mLoginBtn setTitle:@"登录" forState:UIControlStateNormal];
//    }
//    else{
//        
//        [mFootView.mLoginBtn setTitle:@"退出登录" forState:UIControlStateNormal];
//        
//    }
    [self.view addSubview:mFootView];
    
    // Do any additional setup after loading the view.
}
- (void)mSwithClick:(UISwitch *)sw{
    
    if(sw.isOn){
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:@(1) forKey:@"msgpush"];
        
        [defaults synchronize];
        
//        [SUser relTokenWithPush];
        
    }else{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:@(0) forKey:@"msgpush"];
        
        [defaults synchronize];
        
//        [SUser clearTokenWithPush];
    }
    
}
- (void)loginAction:(UIButton *)sender{
    MLLog(@"登录登出？");
    [self AlertViewShow:@"退出登录" alertViewMsg:@"是否确定退出当前用户" alertViewCancelBtnTiele:@"取消" alertTag:10];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if( buttonIndex == 1)
    {
        [mUserInfo logOut];
        [SVProgressHUD showSuccessWithStatus:@"退出成功"];
        [mFootView.mLoginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [self gotoLoginVC];
    }
}
- (void)AlertViewShow:(NSString *)alerViewTitle alertViewMsg:(NSString *)msg alertViewCancelBtnTiele:(NSString *)cancelTitle alertTag:(int)tag{
    
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:alerViewTitle message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:@"确定", nil];
    al.delegate = self;
    al.tag = tag;
    [al show];
}

#pragma mark----关于我们
- (void)aboutUs:(UIButton *)sender{
    WebVC *w = [WebVC new];
    w.mName = @"关于我们";
//    w.mUrl = [GInfo shareClient].mAboutUrl;
//    MLLog(@"关于我们：%@",[GInfo shareClient].mAboutUrl);
    [self pushViewController:w];
}
#pragma mark----意见反馈
- (void)cacheAction:(UIButton *)sender{
    MLLog(@"意见反馈");
    UIStoryboard *secondStroyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    feedbackViewController *f =[secondStroyBoard instantiateViewControllerWithIdentifier:@"xxx"];
    [self.navigationController pushViewController:f animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
