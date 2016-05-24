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

#import "feedbackViewController.h"
#import "needCodeViewController.h"
#import "verifyBankViewController.h"
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
    if (![mUserInfo backNowUser].mIsRegist) {
        [self AlertViewShow:@"未实名认证！" alertViewMsg:@"通过认证即可使用更多功能？" alertViewCancelBtnTiele:@"取消" alertTag:10];
        return;
    }

    
    mFeedPersonViewController *mmm = [[mFeedPersonViewController alloc] initWithNibName:@"mFeedPersonViewController" bundle:nil];
    [self pushViewController:mmm];
    
}
#pragma mark----投诉物管
- (IBAction)mCanal:(id)sender {
    if (![mUserInfo backNowUser].mIsRegist) {
        [self AlertViewShow:@"未实名认证！" alertViewMsg:@"通过认证即可使用更多功能？" alertViewCancelBtnTiele:@"取消" alertTag:10];
        return;
    }
    mFeedManageViewController *mmm = [[mFeedManageViewController alloc] initWithNibName:@"mFeedManageViewController" bundle:nil];
    [self pushViewController:mmm];
    
}
#pragma mark----投诉公司
- (IBAction)mCompany:(id)sender {
    
    UIStoryboard *secondStroyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    feedbackViewController *f =[secondStroyBoard instantiateViewControllerWithIdentifier:@"xxx"];
    [self.navigationController pushViewController:f animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if( buttonIndex == 1)
    {
        
        if([mUserInfo backNowUser].mIsHousingAuthentication){
            
            verifyBankViewController *vvv = [[verifyBankViewController alloc] initWithNibName:@"verifyBankViewController" bundle:nil];
            [self pushViewController:vvv];
            
            
        }else{
            needCodeViewController *nnn = [[needCodeViewController alloc] initWithNibName:@"needCodeViewController" bundle:nil];
            nnn.Type = 1;
            
            [self pushViewController:nnn];
        }
        
        
    }
}

- (void)AlertViewShow:(NSString *)alerViewTitle alertViewMsg:(NSString *)msg alertViewCancelBtnTiele:(NSString *)cancelTitle alertTag:(int)tag{
    
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:alerViewTitle message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:@"去认证", nil];
    al.delegate = self;
    al.tag = tag;
    [al show];
}

@end
