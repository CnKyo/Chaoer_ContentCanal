//
//  mLoginView.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/10.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mLoginView : UIView
/**
 *  logo
 */
@property (strong, nonatomic) IBOutlet UIImageView *mLogoImg;


///登录按钮
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

///手机号码输入框
@property (weak, nonatomic) IBOutlet UITextField *phoneTx;
///验证码输入框
@property (weak, nonatomic) IBOutlet UITextField *codeTx;

/**
 *  腾讯登陆
 */
@property (strong, nonatomic) IBOutlet UIButton *mTencentLogin;
/**
 *  微信登陆
 */
@property (strong, nonatomic) IBOutlet UIButton *mWechatLogin;
/**
 *  新浪登陆
 */
@property (strong, nonatomic) IBOutlet UIButton *mSinaLogin;
/**
 *  忘记密码
 */
@property (strong, nonatomic) IBOutlet UIButton *mForgetBtn;
/**
 *  注册
 */
@property (strong, nonatomic) IBOutlet UIButton *mRegistBtn;


+(mLoginView *)shareView;

@end
