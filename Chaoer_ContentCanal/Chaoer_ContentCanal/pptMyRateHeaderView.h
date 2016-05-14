//
//  pptMyRateHeaderView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pptMyRateHeaderView : UIView
/**
 *  总评分
 */
@property (weak, nonatomic) IBOutlet UILabel *mRatePoint;
/**
 *  好评
 */
@property (weak, nonatomic) IBOutlet UIView *mGoodRateView;
/**
 *  中评
 */
@property (weak, nonatomic) IBOutlet UIView *mMidRateView;
/**
 *  差评
 */
@property (weak, nonatomic) IBOutlet UIView *mBadRateView;

/**
 *  初始化方法
 *
 *  @return view
 */
+ (pptMyRateHeaderView *)shareView;

@end
