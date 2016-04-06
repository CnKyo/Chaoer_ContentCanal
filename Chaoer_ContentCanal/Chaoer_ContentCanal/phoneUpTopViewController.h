//
//  phoneUpTopViewController.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface phoneUpTopViewController : BaseVC
/**
 *  背景
 */
@property (strong, nonatomic) IBOutlet UIView *mBgkView;
/**
 *  手机号码
 */
@property (strong, nonatomic) IBOutlet UITextField *mPhoneT;
/**
 *  30
 */
@property (strong, nonatomic) IBOutlet UIButton *mThirty;
/**
 *  50
 */
@property (strong, nonatomic) IBOutlet UIButton *mFifty;
/**
 *  100
 */
@property (strong, nonatomic) IBOutlet UIButton *mHundred;
/**
 *  余额
 */
@property (strong, nonatomic) IBOutlet UILabel *mBalance;
/**
 *  立即支付
 */
@property (strong, nonatomic) IBOutlet UIButton *mGopayBtn;


@end
