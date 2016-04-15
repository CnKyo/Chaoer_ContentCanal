//
//  canPayView.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface canPayView : UIView
/**
 *  帐户余额
 */
@property (strong, nonatomic) IBOutlet UILabel *mBalance;
/**
 *  充值
 */
@property (strong, nonatomic) IBOutlet UIButton *mTopup;
/**
 *  图片
 */
@property (strong, nonatomic) IBOutlet UIImageView *mLogoImg;
/**
 *  应交
 */
@property (strong, nonatomic) IBOutlet UILabel *mWillBalance;
/**
 *  时间
 */
@property (strong, nonatomic) IBOutlet UILabel *mTime;
/**
 *  金额tx
 */
@property (strong, nonatomic) IBOutlet UITextField *mMoneyTx;
/**
 *  户号
 */
@property (strong, nonatomic) IBOutlet UITextField *mNumTx;
/**
 *  户名
 */
@property (strong, nonatomic) IBOutlet UITextField *mNameTx;
/**
 *  缴费
 */
@property (strong, nonatomic) IBOutlet UIButton *mBalanceBtn;
/**
 *  选择小区按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mChioceCanalBtn;

@property (weak, nonatomic) IBOutlet UIImageView *mJaintou;


+ (canPayView *)shareView;

@property (strong, nonatomic) IBOutlet UILabel *mYue;

@property (strong, nonatomic) IBOutlet UIButton *mChongzhi;

+ (canPayView *)shareHeaderView;

@end
