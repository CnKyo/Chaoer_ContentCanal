//
//  mFoodRateHeaderView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mFoodRateHeaderView : UIView
/**
 *  服务态度
 */
@property (weak, nonatomic) IBOutlet UIView *mSericeRateView;
/**
 *  服务态度评分
 */
@property (weak, nonatomic) IBOutlet UILabel *mServiceRateLb;
/**
 *  商品评价
 */
@property (weak, nonatomic) IBOutlet UIView *mProductRateView;
/**
 *  商品评分
 */
@property (weak, nonatomic) IBOutlet UILabel *mProductRateLb;
/**
 *  送达时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mSendTime;
/**
 *  综合评分
 */
@property (weak, nonatomic) IBOutlet UILabel *mtotleScore;
/**
 *  总描述
 */
@property (weak, nonatomic) IBOutlet UILabel *mTotleDetail;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (mFoodRateHeaderView *)shareView;

@end
