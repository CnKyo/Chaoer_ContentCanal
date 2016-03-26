//
//  editMessageViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "editMessageViewController.h"

@interface editMessageViewController ()

@end

@implementation editMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.Title = self.mPageName = self.mTitel;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.rightBtnTitle = @"保存";
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];

    
    self.mBgkView.layer.masksToBounds  = YES;
    self.mBgkView.layer.borderColor  = [UIColor colorWithRed:0.84 green:0.84 blue:0.86 alpha:1].CGColor;
    self.mBgkView.layer.borderWidth  = 0.5;
    
    self.mTx.placeholder = self.mPlaceholder;
    self.mStatus.text = self.mtext;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)rightBtnTouched:(id)sender{
    [SVProgressHUD showWithStatus:@"正在保存..." maskType:SVProgressHUDMaskTypeClear];
    if (self.mtype == 1) {
        [mUserInfo editUserMsg:[mUserInfo backNowUser].mUserId andLoginName:[mUserInfo backNowUser].mPhone andNickName:self.mTx.text andSex:nil andSignate:nil block:^(mBaseData *resb) {
            if (resb.mData) {
                int sucess = [[resb.mData objectForKey:@"r_msg"] intValue];
                
                if (sucess == 1) {
                    [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
                    self.block(self.mTx.text);
                    [self leftBtnTouched:nil];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"网络请求错误!"];
                    [self leftBtnTouched:nil];

                }

            }else{
                [SVProgressHUD showErrorWithStatus:@"网络请求错误!"];
                [self leftBtnTouched:nil];
            }
        }];
        

    }else{
        [mUserInfo editUserMsg:[mUserInfo backNowUser].mUserId andLoginName:[mUserInfo backNowUser].mPhone andNickName:nil andSex:nil andSignate:self.mTx.text block:^(mBaseData *resb) {
            if (resb.mData) {
                int sucess = [[resb.mData objectForKey:@"r_msg"] intValue];
                
                if (sucess == 1) {
                    [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
                    self.block(self.mTx.text);
                    [self leftBtnTouched:nil];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"网络请求错误!"];
                    [self leftBtnTouched:nil];
                    
                }
                
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络请求错误!"];
                [self leftBtnTouched:nil];
            }
        }];

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

@end
