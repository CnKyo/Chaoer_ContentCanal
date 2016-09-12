//
//  feedbackViewController.m
//  O2O_Communication_seller
//
//  Created by 密码为空！ on 15/10/30.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "feedbackViewController.h"

@interface feedbackViewController ()<UITextViewDelegate>

@end

@implementation feedbackViewController
@synthesize mType;
- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    self.isStoryBoard = YES;
    return [super initWithCoder:aDecoder];
}

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
    
    NSString *tt = nil;
    NSString *pp = nil;
    if (mType == 2) {
        tt = @"请输入订单备注";
        pp = @"请输入您的备注";
    }else{
        tt = @"对公司的建议";
        pp = @"在此写上您宝贵的建议:";
    }
    
    self.Title = self.mPageName = tt;
    
    self.txView.placeholder = pp;

    self.hiddenlll = YES;
    self.bgkView.backgroundColor = [UIColor clearColor];
    self.txView.layer.masksToBounds = YES;
    self.txView.layer.borderColor = [UIColor colorWithRed:0.855 green:0.851 blue:0.843 alpha:1].CGColor;
    self.txView.layer.borderWidth = 0.75f;
    self.txView.layer.cornerRadius = 3;
    self.okBtn.layer.masksToBounds = YES;
    self.okBtn.layer.cornerRadius = 3;
    [self.txView setHolderToTop];
    [self.okBtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor = M_BGCO;
    
    
    
}
- (void)okAction:(UIButton *)sender{
    if (mType == 2) {
        
        self.block(self.txView.text);
        
        [self leftBtnTouched:nil];
        
    }else{
        ///提交按钮
        if (self.txView.text == nil || [self.txView.text isEqualToString:@""]) {
            [self showAlertVC:@"提示" alertMsg:@"您未输入任何信息!"];
            return;
        }
        if (self.txView.text.length >= 100) {
            [self showAlertVC:@"提示" alertMsg:@"内容长度不能超过100个字符"];
            return;
        }
        else{
            [self showWithStatus:@"正在提交..."];
            
            [mUserInfo feedCompany:[mUserInfo backNowUser].mUserId andContent:self.txView.text block:^(mBaseData *resb) {
                if (resb.mSucess) {
                    [SVProgressHUD showSuccessWithStatus:resb.mMessage];
                    [self popViewController];
                }else{
                    [SVProgressHUD showErrorWithStatus:resb.mMessage];
                }
            }];
            
        }

    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftBtnTouched:(id)sender{
    [self popViewController];
}
- (void)showAlertVC:(NSString *)title alertMsg:(NSString *)message{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alert show];
}

@end
