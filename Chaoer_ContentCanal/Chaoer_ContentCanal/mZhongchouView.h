//
//  mZhongchouView.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mZhongchouView : UIView
/**
 *  活动名称
 */
@property (strong, nonatomic) IBOutlet UILabel *mActivityName;
/**
 *  背景图片
 */
@property (strong, nonatomic) IBOutlet UIImageView *mBgkImg;
/**
 *  活动价格
 */
@property (strong, nonatomic) IBOutlet UILabel *mActivityPrice;
/**
 *  主视图
 */
@property (strong, nonatomic) IBOutlet UIView *mMainView;
/**
 *  初始化顶部view
 *
 *  @return
 */
+ (mZhongchouView *)shareTopView;

/**
 *  活动规则
 */
@property (strong, nonatomic) IBOutlet UILabel *mSctivityRule;
/**
 *  活动概述
 */
@property (strong, nonatomic) IBOutlet UILabel *mActivityBrief;
/**
 *  活动说明
 */
@property (strong, nonatomic) IBOutlet UILabel *mActivityContent;
/**
 *  活动按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mActivityBtn;
/**
 *  初始化bottomview
 *
 *  @return 
 */
+ (mZhongchouView *)shareBottomView;

/**
 *  子视图名称
 */
@property (strong, nonatomic) IBOutlet UILabel *mSubName;
/**
 *  子视图状态
 */
@property (strong, nonatomic) IBOutlet UILabel *mSubStatus;
/**
 *  子视图资金
 */
@property (strong, nonatomic) IBOutlet UILabel *mSubMoney;
/**
 *  子视图按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mSubBtn;
/**
 *  初始化子视图方法
 *
 *  @return view
 */
+ (mZhongchouView *)shareSubView;

@end
