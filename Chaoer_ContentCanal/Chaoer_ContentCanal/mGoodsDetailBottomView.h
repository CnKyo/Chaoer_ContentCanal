//
//  mGoodsDetailBottomView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/25.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mGoodsDetailBottomView : UIView
#pragma mark----底部购物车bar
/**
 *  关注按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mAttentionBtn;
/**
 *  购物车按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mShopCarBtn;
/**
 *  商品数量
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsNum;
/**
 *  添加购物车
 */
@property (weak, nonatomic) IBOutlet UIButton *mAddShopCarBtn;
/**
 *  立即购买
 */
@property (weak, nonatomic) IBOutlet UIButton *mBuyNowBtn;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (mGoodsDetailBottomView *)shareShopCarView;


@end
