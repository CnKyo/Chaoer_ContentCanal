//
//  mShopCarHeaderSection.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/13.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mShopCarHeaderSection : UIView
/**
 *  是否选择
 */
@property (weak, nonatomic) IBOutlet UIImageView *mSelectImg;
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mHeaderImg;
/**
 *  名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;
/**
 *  活动
 */
@property (weak, nonatomic) IBOutlet UILabel *mActivity;
/**
 *  内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;
/**
 *  约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mContentLeft;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (mShopCarHeaderSection *)shareHeaderView;
/**
 *  总金额
 */
@property (weak, nonatomic) IBOutlet UILabel *mTotalMoney;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (mShopCarHeaderSection *)shareFooterView;

@end
