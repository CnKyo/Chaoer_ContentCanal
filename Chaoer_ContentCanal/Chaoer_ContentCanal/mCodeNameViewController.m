//
//  mCodeNameViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mCodeNameViewController.h"

#import "mUserInfoViewController.h"
#import "hasCodeViewController.h"
#import "needCodeViewController.h"
#import "verifyBankViewController.h"
@interface mCodeNameViewController ()

@end

@implementation mCodeNameViewController
{
    BOOL isCode;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"实名认证";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    isCode = NO;
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
    
    self.mBgkView.layer.masksToBounds = YES;
    self.mBgkView.layer.borderColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.87 alpha:1].CGColor;
    self.mBgkView.layer.borderWidth = 0.5;
    
    
    if ([mUserInfo backNowUser].mIsHousingAuthentication) {
        
        self.mStatus.text = @"";
    }else{
        self.mStatus.text = @"未实名认证";
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)mCode:(id)sender {

    if ([mUserInfo backNowUser].mIsHousingAuthentication) {
        hasCodeViewController *hhh = [hasCodeViewController new];
        [self pushViewController:hhh];
    }else{
        needCodeViewController *nnn = [[needCodeViewController alloc] initWithNibName:@"needCodeViewController" bundle:nil];
        nnn.Type = 2;
        [self pushViewController:nnn];
    }
}
- (IBAction)mInfo:(id)sender {
    
    mUserInfoViewController *mmm = [[mUserInfoViewController alloc] initWithNibName:@"mUserInfoViewController" bundle:nil];
    [self pushViewController:mmm];

    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
