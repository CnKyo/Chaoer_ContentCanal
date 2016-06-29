//
//  mMarketHeaderView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/27.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mMarketHeaderView : UIView
/**
 *  超市logo
 */
@property (weak, nonatomic) IBOutlet UIImageView *mLogo;
/**
 *  热卖
 */
@property (weak, nonatomic) IBOutlet UIImageView *mHot;
/**
 *  超市名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;
/**
 *  商品数量
 */
@property (weak, nonatomic) IBOutlet UILabel *mNum;
/**
 *  收藏数量
 */
@property (weak, nonatomic) IBOutlet UILabel *mCollectNum;
/**
 *  收藏按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mCollectBtn;
/**
 *  超市名称约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mNameLeft;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (mMarketHeaderView *)shareView;


@end
