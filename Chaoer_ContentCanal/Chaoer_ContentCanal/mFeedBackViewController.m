//
//  mFeedBackViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mFeedBackViewController.h"

#import "mFeedManageViewController.h"
#import "mFeedCompanyViewController.h"

#import "mFeedPersonViewController.h"
@interface mFeedBackViewController ()

@end

@implementation mFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.Title = self.mPageName = @"投诉建议";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark----投诉个人
- (IBAction)mPerson:(id)sender {
    if ([mUserInfo backNowUser].mTemporary) {
        [LCProgressHUD showInfoMsg:@"您还未认证！"];
        return;
    }
    
    mFeedPersonViewController *mmm = [[mFeedPersonViewController alloc] initWithNibName:@"mFeedPersonViewController" bundle:nil];
    [self pushViewController:mmm];
    
}
#pragma mark----投诉物管
- (IBAction)mCanal:(id)sender {
    if ([mUserInfo backNowUser].mTemporary) {
        [LCProgressHUD showInfoMsg:@"您还未认证！"];
        return;
    }
    
    mFeedManageViewController *mmm = [[mFeedManageViewController alloc] initWithNibName:@"mFeedManageViewController" bundle:nil];
    [self pushViewController:mmm];
    
}
#pragma mark----投诉公司
- (IBAction)mCompany:(id)sender {
    
    mFeedCompanyViewController *mmm = [[mFeedCompanyViewController alloc] initWithNibName:@"mFeedCompanyViewController" bundle:nil];
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
