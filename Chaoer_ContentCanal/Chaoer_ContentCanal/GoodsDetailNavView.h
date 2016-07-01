//
//  GoodsDetailNavView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/29.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsDetailNavView : UIView
#pragma mark----商品详情导航条
/**
 *  返回按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mBackBtn;
/**
 *  名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;
/**
 *  收藏按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mCollectBtn;
/**
 *  分享按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mShareBtn;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (GoodsDetailNavView *)shareView;

#pragma mark----商品详情导航条
/**
 *  搜索框
 */
@property (weak, nonatomic) IBOutlet UITextField *mSearchTx;
/**
 *  搜索按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mSearchBtn;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (GoodsDetailNavView *)shareSearchView;
@property (weak, nonatomic) IBOutlet UIView *mSearchView;



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
+ (GoodsDetailNavView *)shareShopCarView;



@end
