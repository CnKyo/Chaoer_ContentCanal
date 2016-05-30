//
//  mSetupViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mSetupViewController.h"
#import "mBundleViewController.h"

@interface mSetupViewController ()

@end

@implementation mSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"设置";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
    
    self.mBgkView.layer.masksToBounds = YES;
    self.mBgkView.layer.borderColor = [UIColor colorWithRed:0.88 green:0.87 blue:0.89 alpha:1].CGColor;
    self.mBgkView.layer.borderWidth = 1;
    
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
- (IBAction)mBundleAction:(id)sender {
    
//    mBundleViewController *mmm = [[mBundleViewController alloc] initWithNibName:@"mBundleViewController" bundle:nil];
//    [self pushViewController:mmm];
    [LCProgressHUD showInfoMsg:@"即将到来，敬请期待！"];

    
}
- (IBAction)mLogout:(id)sender {
        [self AlertViewShow:@"退出登录" alertViewMsg:@"是否确定退出当前用户" alertViewCancelBtnTiele:@"取消" alertTag:10];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if( buttonIndex == 1)
    {
        [mUserInfo logOut];
        [SVProgressHUD showSuccessWithStatus:@"退出成功"];
        [self gotoLoginVC];
    }
}
- (void)AlertViewShow:(NSString *)alerViewTitle alertViewMsg:(NSString *)msg alertViewCancelBtnTiele:(NSString *)cancelTitle alertTag:(int)tag{
    
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:alerViewTitle message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:@"确定", nil];
    al.delegate = self;
    al.tag = tag;
    [al show];
}

@end
