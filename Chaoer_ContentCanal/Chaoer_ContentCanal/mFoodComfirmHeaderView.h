//
//  mFoodComfirmHeaderView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQTextView.h"
/**
 *  代理方法
 */
@protocol WKFoodComfirmViewDelegate <NSObject>

@optional
/**
 *  地址代理方法
 */
- (void)WKFoodComfirmViewWithAddressBtnclick;
/**
 *  送达时间代理方法
 */
- (void)WKFoodComfirmViewWithSendTimeBtnclick;
/**
 *  优惠卷代理方法
 */
- (void)WKFoodComfirmViewWithCoupBtnclick;

/**
 *  去支付代理方法
 */
- (void)WKFoodComfirmViewWithGoPayBtnclick;

@end

@interface mFoodComfirmHeaderView : UIView
#pragma mark----headerview的样式
/**
 *  地址
 */
@property (weak, nonatomic) IBOutlet UILabel *mAddress;
/**
 *  地址按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mAddressBtn;
/**
 *  送达时间按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mSendTimeBtn;
/**
 *  优惠卷按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mCoupBtn;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (mFoodComfirmHeaderView *)shareHeaderView;

#pragma mark----headerSection的样式
+ (mFoodComfirmHeaderView *)shareSectionView;
/**
 *  店铺logo
 */
@property (weak, nonatomic) IBOutlet UIImageView *mShopLogo;
/**
 *  店铺名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mShopName;

#pragma mark----headerBottomView的样式

+ (mFoodComfirmHeaderView *)shareBottomView;
/**
 *  总价
 */
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mTotlePrice;
/**
 *  去支付按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mGopayBtn;

#pragma mark----headerFooterView的样式

+ (mFoodComfirmHeaderView *)shareFooterView;
/**
 *  餐盒费
 */
@property (weak, nonatomic) IBOutlet UILabel *mMealBoxPrice;
/**
 *  配送费
 */
@property (weak, nonatomic) IBOutlet UILabel *mSendPrice;
/**
 *  优惠金额
 */
@property (weak, nonatomic) IBOutlet UILabel *mCoupPrice;
/**
 *  支付金额
 */
@property (weak, nonatomic) IBOutlet UILabel *mPayPrice;
/**
 *  备注
 */
@property (weak, nonatomic) IBOutlet IQTextView *mNotTx;


@property (strong,nonatomic) id<WKFoodComfirmViewDelegate>delegate;

@end
