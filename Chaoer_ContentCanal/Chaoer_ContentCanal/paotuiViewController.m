//
//  paotuiViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/6.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "paotuiViewController.h"

@interface paotuiViewController ()

@end

@implementation paotuiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"我的跑跑腿";
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    self.hiddenTabBar = YES;
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.93 alpha:1.00];
    
    self.mName.text = [mUserInfo backNowUser].mNickName;
    self.mPhone.text = [mUserInfo backNowUser].mPhone;
    
    
    
    if (self.mType == 1) {
        [self.mbtn setTitle:@"确定" forState:0];
    }else{
        [self.mbtn setTitle:@"注销" forState:0];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnAction:(id)sender {
    if (self.mType == 1) {
        NSLog(@"确定");
    }else{
        NSLog(@"注销");
        [self AlertViewShow:@"注销身份" alertViewMsg:@"该操作将注销您的跑跑腿身份！" alertViewCancelBtnTiele:@"取消" alertTag:10];

    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if( buttonIndex == 1)
    {
        NSLog(@"确定注销");
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)AlertViewShow:(NSString *)alerViewTitle alertViewMsg:(NSString *)msg alertViewCancelBtnTiele:(NSString *)cancelTitle alertTag:(int)tag{
    
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:alerViewTitle message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:@"确定", nil];
    al.delegate = self;
    al.tag = tag;
    [al show];
}
@end
