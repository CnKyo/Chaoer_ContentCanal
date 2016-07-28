//
//  mGoodsDetailBottomView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/25.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  代理方法
 */
@protocol mGoodsDetailBuyDelegate <NSObject>

@optional
/**
 *  关闭方法
 */
- (void)mGoodsDetailCloseActionView;
/**
 *  减方法
 */
- (void)mGoodsDetailJianActionView;
/**
 *  加方法
 */
- (void)mGoodsDetailAddActionView;
/**
 *  确定按钮
 */
- (void)mGoodsDetailOkActionView;

@end

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


#pragma mark----底部购买弹出view

/**
 *  商品图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mGoodsImg;
/**
 *  商品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsName;
/**
 *  商品价格
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsPrice;
/**
 *  关闭按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mCloseBtn;
/**
 *  添加view
 */
@property (weak, nonatomic) IBOutlet UIView *mAddView;
/**
 *  减按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mJianBtn;
/**
 *  数量
 */
@property (weak, nonatomic) IBOutlet UILabel *mNum;
/**
 *  加按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mAddBtn;
/**
 *  确定按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mOkBtn;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (mGoodsDetailBottomView *)shareBuyView;


@property (strong,nonatomic) id <mGoodsDetailBuyDelegate> delegate;

@end
