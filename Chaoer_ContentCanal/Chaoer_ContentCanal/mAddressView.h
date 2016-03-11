//
//  mAddressView.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mAddressView : UIView

/**
 *  地址
 */
@property (strong, nonatomic) IBOutlet UILabel *mAddress;


+ (mAddressView *)shareView;

/**
 *  图片
 */
@property (strong, nonatomic) IBOutlet UIImageView *mLogo;

/**
 *  帐号
 */
@property (strong, nonatomic) IBOutlet UILabel *mName;

/**
 *  余额
 */
@property (strong, nonatomic) IBOutlet UILabel *mBalance;

/**
 *  充值金额
 */
@property (strong, nonatomic) IBOutlet UITextField *mMoneyTx;

/**
 *  支付方式
 */
@property (strong, nonatomic) IBOutlet UITextField *mPayType;

/**
 *  支付方式view
 */
@property (strong, nonatomic) IBOutlet UIView *mPayTypeView;

/**
 *  支付按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mPayBtn;

/**
 *  初始化方法
 *
 *  @return view
 */
+ (mAddressView *)sharePayView;


/**
 *  医护头像
 */
@property (strong, nonatomic) IBOutlet UIImageView *mUserImg;
/**
 *  用户名
 */
@property (strong, nonatomic) IBOutlet UILabel *mUserName;
/**
 *  余额
 */
@property (strong, nonatomic) IBOutlet UILabel *mUserMoney;
/**
 *  初始化方法
 *
 *  @return view
 */
+ (mAddressView *)shareUsrInfo;

















@end
