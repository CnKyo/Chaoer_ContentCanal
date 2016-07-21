//
//  mCommunityMyViewCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/24.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mGoodsBtn.h"
/**
 *  cell的点击代理方法
 */
@protocol WKGoodsCellDelegate <NSObject>

@optional
/**
 *  左边按钮的代理方法
 *
 *  @param mTag tag
 */
- (void)cellWithLeftBtnClick:(NSInteger)mTag;
/**
 *  左边收藏按钮的代理方法
 *
 *  @param mTag tag
 */
- (void)cellWithLeftBtnClick:(NSInteger)mTag andId:(int)mShopId;
/**
 *  左边添加到购物车按钮的代理方法
 *
 *  @param mTag tag
 */
- (void)cellWithLeftAddShopCar:(NSInteger)mTag andGoods:(MGoods *)mGoods;
/**
 *  左边查看商品详情按钮的代理方法
 *
 *  @param mTag tag
 */
- (void)cellWithLeftDetailClick:(NSInteger)mTag andGoods:(MGoods *)mGoods;
/**
 *  右边按钮的代理方法
 *
 *  @param mTag tag
 */
- (void)cellWithRightBtnClick:(NSInteger)mTag;
/**
 *  右边收藏按钮的代理方法
 *
 *  @param mTag tag
 */
- (void)cellWithRightBtnClick:(NSInteger)mTag andId:(int)mShopId;
/**
 *  右边添加购物车按钮的代理方法
 *
 *  @param mTag tag
 */
- (void)cellWithRightAddShopCar:(NSInteger)mTag andGoods:(MGoods *)mGoods;
/**
 *  右边查看详情按钮的代理方法
 *
 *  @param mTag tag
 */
- (void)cellWithRightDetailClick:(NSInteger)mTag andGoods:(MGoods *)mGoods;

- (void)cellWithFocusShopClick:(NSIndexPath *)mIndexPath andShop:(GMarketList *)mShop;

#pragma mark ---- 收藏cell购物车点击事件
/**
 *  收藏cell
 *
 *  @param mgoodsId 商品id
 *  @param mShopId  店铺ID
 */
- (void)collectLeftAddshopCar:(NSInteger)mgoodsId andShopId:(int)mShopId;
/**
 *  收藏cell
 *
 *  @param mgoodsId 商品id
 *  @param mShopId  店铺ID
 */
- (void)collectRightAddshopCar:(NSInteger)mgoodsId andShopId:(int)mShopId;
#pragma mark ---- 收藏cell详情点击事件
/**
 *  收藏cell
 *
 *  @param mgoodsId 商品id
 *  @param mShopId  店铺ID
 */
- (void)collectLeftDetail:(NSInteger)mgoodsId andShopId:(int)mShopId;
/**
 *  收藏cell
 *
 *  @param mgoodsId 商品id
 *  @param mShopId  店铺ID
 */
- (void)collectRightDetail:(NSInteger)mgoodsId andShopId:(int)mShopId;
@end

@interface mCommunityMyViewCell : UITableViewCell

#pragma mark----收藏店铺

/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mImg;
/**
 *  热卖
 */
@property (weak, nonatomic) IBOutlet UIImageView *mHot;
/**
 *  名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;

/**
 *  收藏数
 */
@property (weak, nonatomic) IBOutlet UILabel *mCollectNum;
/**
 *  收藏按钮
 */
@property (weak, nonatomic) IBOutlet mGoodsBtn *mCollectBtn;
/**
 *  约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mNameLeft;

@property (strong,nonatomic) NSIndexPath *mIndexPaths;

#pragma mark----收藏商品
#pragma mark----左边的视图
/**
 *  左边的试图
 */
@property (weak, nonatomic) IBOutlet UIView *mLeftView;
/**
 *  左边的图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mLeftImg;
/**
 *  左边的名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mLeftName;
/**
 *  左边的价格
 */
@property (weak, nonatomic) IBOutlet UILabel *mLeftPrice;
/**
 *  左边的内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mLeftContent;
/**
 *  左边的销量
 */
@property (weak, nonatomic) IBOutlet UILabel *mLeftNum;
/**
 *  左边的添加按钮
 */
@property (weak, nonatomic) IBOutlet mGoodsBtn *mLeftAdd;
/**
 *  左边的收藏按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mLeftCollect;
/**
 *  左边的标签
 */
@property (weak, nonatomic) IBOutlet UIImageView *mLeftTagImg;
/**
 *  左边的详情
 */
@property (weak, nonatomic) IBOutlet mGoodsBtn *mLeftDetailBtn;

#pragma mark----右边的试图
/**
 *  右边的view
 */
@property (weak, nonatomic) IBOutlet UIView *mRightView;
/**
 *  右边的图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mRightImg;
/**
 *  右边的名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mRightName;
/**
 *  右边的价格
 */
@property (weak, nonatomic) IBOutlet UILabel *mRightPrice;
/**
 *  右边的内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mRightContent;
/**
 *  右边的销量
 */
@property (weak, nonatomic) IBOutlet UILabel *mRightNum;
/**
 *  右边的添加按钮
 */
@property (weak, nonatomic) IBOutlet mGoodsBtn *mRightAdd;
/**
 *  右边的收藏按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mRightCollect;
/**
 *  右边的标签
 */
@property (weak, nonatomic) IBOutlet UIImageView *mRightTagImg;
/**
 *  右边的详情
 */
@property (weak, nonatomic) IBOutlet mGoodsBtn *mRightDetailBtn;

@property (strong,nonatomic) id <WKGoodsCellDelegate> delegate;

@property (nonatomic,assign) int mLeftShopId;

@property (nonatomic,assign) int mRightShopId;


@end
