//
//  editDianpuViewController.m
//  O2O_Communication_seller
//
//  Created by 王珂 on 15/11/4.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "editDianpuViewController.h"

@interface editDianpuViewController ()<UITextFieldDelegate>

@end

@implementation editDianpuViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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

    self.mPageName = self.Title = self.TitleStr;
    self.hiddenRightBtn = NO;
    self.rightBtnTitle = @"保存";
    self.mBgkVC.layer.masksToBounds = YES;
    self.mBgkVC.layer.borderColor = [UIColor colorWithRed:0.878 green:0.875 blue:0.875 alpha:1].CGColor;
    self.mBgkVC.layer.borderWidth = 0.5;
    self.mName2.text = self.mName.text = self.nameStr;

    self.mContent.placeholder = [NSString stringWithFormat:@"请输入%@",_TitleStr];
    self.mTxView.placeholder = [NSString stringWithFormat:@"请输入%@",_TitleStr];
    self.mContent.text = _mContentStr;
    self.mTxView.text = _mContentStr;
    if (_mType == 3) {
        self.mContent.delegate = self;
        self.mContent.keyboardType = UIKeyboardTypeNumberPad;
        self.mContent.tag = 11;
    }
    if (_mType == 2 || _mType == 4) {
        self.mBgkVC2.hidden = NO;
    }else{
        self.mBgkVC2.hidden = YES;

    }
    [self.mTxView setHolderToTop];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)rightBtnTouched:(id)sender{
    if (_mType == 1) {
//        [_mShop updateDianpuName:self.mContent.text block:^(SResBase *info) {
//            if (info.msuccess) {
//                if (_itblock) {
//                    _itblock(self.mContent.text);
//                }
//                
//                [self popViewController];
//            }else{
//                [SVProgressHUD showErrorWithStatus:info.mmsg];
//            }
//        }];

    }if (_mType == 2) {
//        [_mShop updateArticle:self.mTxView.text block:^(SResBase *info) {
//            if (info.msuccess) {
//                if (_itblock) {
//                    _itblock(self.mTxView.text);
//                }
//                
//                [self popViewController];
//            }else{
//                [SVProgressHUD showErrorWithStatus:info.mmsg];
//            }
//        }];
    }if (_mType == 3){
//        if (![Util isMobileNumber:self.mContent.text]) {
//            [self showErrorStatus:@"请输入合法的手机号码"];
//            [self.mContent becomeFirstResponder];
//            return;
//        }
//        [_mShop updateTel:self.mContent.text block:^(SResBase *info) {
//            if (info.msuccess) {
//                if (_itblock) {
//                    _itblock(self.mContent.text);
//                }
//                
//                [self popViewController];
//            }else{
//                [SVProgressHUD showErrorWithStatus:info.mmsg];
//            }
//        }];
    }if (_mType == 4) {
//        [_mShop updateBrief:self.mTxView.text block:^(SResBase *info) {
//            if (info.msuccess) {
//                if (_itblock) {
//                    _itblock(self.mTxView.text);
//                }
//                
//                [self popViewController];
//            }else{
//                [SVProgressHUD showErrorWithStatus:info.mmsg];
//            }
//        }];
    }
    
    if (_mType == 8) {
        
//        if (![Util checkNum:self.mContent.text]) {
//            [self showErrorStatus:@"请输入正确的起送价"];
//            [self.mContent becomeFirstResponder];
//            return;
//        }
//        [_mShop updateQs:self.mContent.text block:^(SResBase *info) {
//            if (info.msuccess) {
//                if (_itblock) {
//                    _itblock(self.mContent.text);
//                }
//                
//                [self popViewController];
//            }else{
//                [SVProgressHUD showErrorWithStatus:info.mmsg];
//            }
//        }];
    }
    
    if (_mType == 9) {
        
//        if (![Util checkNum:self.mContent.text]) {
//            [self showErrorStatus:@"请输入正确的配送费"];
//            [self.mContent becomeFirstResponder];
//            return;
//        }
//        [_mShop updatePs:self.mContent.text block:^(SResBase *info) {
//            if (info.msuccess) {
//                if (_itblock) {
//                    _itblock(self.mContent.text);
//                }
//                
//                [self popViewController];
//            }else{
//                [SVProgressHUD showErrorWithStatus:info.mmsg];
//            }
//        }];
    }
  
}


///限制电话号码输入长度
#define TEXT_MAXLENGTH 11
#pragma mark **----键盘代理方法
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *new = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSInteger res;
    if (textField.tag==11)
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

@end
