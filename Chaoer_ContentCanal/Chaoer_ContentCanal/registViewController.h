//
//  registViewController.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface registViewController : BaseVC


/**
 *  参数类型 1是注册 2是忘记密码 3是微信注册
 */
@property (nonatomic,assign) int    mType;

/**
 *  背景
 */
@property (strong, nonatomic) IBOutlet UIView *mBgkView;
/**
 *  手机
 */
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *mPhone;
/**
 *  验证码
 */
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *mCode;
/**
 *  验证码按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mCodeBtn;
/**
 *  密码
 */
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *mPwd;
/**
 *  确认密码
 */
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *mComfirPwd;
/**
 *  房主按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mMasterBtn;
/**
 *  客人按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mVisiterBtn;
/**
 *  注册按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mRegistBtn;


@property (strong, nonatomic) IBOutlet UIView *mLastLine;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mBgkH;


@property (nonatomic,strong) void(^block)(NSString *block,NSString *mPwd);


/**
 *  openid
 */
@property (nonatomic,strong) NSString *mOpenid;
/**
 *  昵称
 */
@property (nonatomic,strong) NSString *mNickName;
/**
 *  性别
 */
@property (nonatomic,strong) NSString *mSex;
/**
 *  头像
 */
@property (nonatomic,strong) NSString *mHeaderUrl;

@end
