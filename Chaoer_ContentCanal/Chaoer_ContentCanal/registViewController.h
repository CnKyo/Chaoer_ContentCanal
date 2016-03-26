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
 *  参数类型1是注册2是忘记密码
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




@end
