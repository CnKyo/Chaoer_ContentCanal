//
//  mComfirmHeaderAndFooter.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol mFooterSwitchDelegate <NSObject>

@optional
/**
 *  代理方法
 *
 *  @param mChange 状态改变
 */
- (void)mFooterSwitchChanged:(BOOL)mChange andSwitch:(UISwitch *)mSender;

@end

@interface mComfirmHeaderAndFooter : UIView
#pragma mark---- 确认订单header
/**
 *  地址
 */
@property (weak, nonatomic) IBOutlet UILabel *mAddress;
/**
 *  地址按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mAddressBtn;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (mComfirmHeaderAndFooter *)initHeaderView;
#pragma mark---- 确认订单footer
/**
 *  积分
 */
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mScore;
/**
 *  积分按钮
 */
@property (weak, nonatomic) IBOutlet UISwitch *mScoreBtn;
/**
 *  商品总额
 */
@property (weak, nonatomic) IBOutlet UILabel *mTotalMoney;
/**
 *  运费总额
 */
@property (weak, nonatomic) IBOutlet UILabel *mSendPrice;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (mComfirmHeaderAndFooter *)initFooterView;

@property (strong,nonatomic) id <mFooterSwitchDelegate> delegate;

@end
