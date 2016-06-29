//
//  shopCarHeaderAndFooterView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/28.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface shopCarHeaderAndFooterView : UIView

#pragma mark----headerview
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mImg;
/**
 *  内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;
/**
 *  去逛逛按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mGoShopBtn;
/**
 *  我的按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mMyBtn;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (shopCarHeaderAndFooterView *)shareHeaderView;

#pragma mark----footerview
/**
 *  初始化Footer方法
 *
 *  @return 返回view
 */
+ (shopCarHeaderAndFooterView *)shareFooterView;
#pragma mark----footerview子视图
/**
 *  子视图图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mSubImg;
/**
 *  子视图名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mSubName;
/**
 *  子视图价格
 */
@property (weak, nonatomic) IBOutlet UILabel *mSubPrice;
/**
 *  子视图详情按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mSubDetailBtn;
/**
 *  子视图添加购物车
 */
@property (weak, nonatomic) IBOutlet UIButton *mSubAddShopCarBtn;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (shopCarHeaderAndFooterView *)shareFooterSubView;

#pragma mark----结算视图
/**
 *  选中后的图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mSelectedImg;

/**
 *  选择全部
 */
@property (weak, nonatomic) IBOutlet UIButton *mSelectAll;
/**
 *  合计
 */
@property (weak, nonatomic) IBOutlet UILabel *mtotleMoney;
/**
 *  去结算按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mGoPayBtn;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (shopCarHeaderAndFooterView *)shareComfirView;

@end
