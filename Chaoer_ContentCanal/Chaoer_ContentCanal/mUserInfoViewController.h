//
//  mUserInfoViewController.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface mUserInfoViewController : BaseVC

/**
 *  背景1
 */
@property (strong, nonatomic) IBOutlet UIView *mbgkView1;
/**
 *  背景2
 */
@property (strong, nonatomic) IBOutlet UIView *mBgkView2;
/**
 *  头像
 */
@property (strong, nonatomic) IBOutlet UIButton *mHeaderBtn;
/**
 *  头像图片
 */
@property (strong, nonatomic) IBOutlet UIImageView *mHeaderImg;
/**
 *  昵称
 */
@property (strong, nonatomic) IBOutlet UIButton *mNameBtn;
/**
 *  昵称
 */
@property (strong, nonatomic) IBOutlet UILabel *mName;
/**
 *  住户信息
 */
@property (strong, nonatomic) IBOutlet UIButton *mIfoBtn;
/**
 *  住户信息
 */
@property (strong, nonatomic) IBOutlet UILabel *mUserInfo;

/**
 *  手机号码
 */
@property (strong, nonatomic) IBOutlet UIButton *mPhoneBtn;
/**
 *  手机
 */
@property (strong, nonatomic) IBOutlet UILabel *mPhone;
/**
 *  性别
 */
@property (strong, nonatomic) IBOutlet UIButton *mSexBtn;
/**
 *  性别
 */
@property (strong, nonatomic) IBOutlet UILabel *mSex;
/**
 *  个性签名
 */
@property (strong, nonatomic) IBOutlet UIButton *mDetailBtn;
/**
 *  个性签名    
 */
@property (strong, nonatomic) IBOutlet UILabel *mDetail;

@end
