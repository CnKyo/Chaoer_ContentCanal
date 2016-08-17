//
//  mFoodHeaderView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPHotspotLabel.h"

@class mFoodHeaderView;
/**
 *  代理方法
 */
@protocol WKFoodHeaderViewDelegate <NSObject>

@optional
#pragma mark----headerView样式代理方法

/**
 *  查看更多代理方法
 */
- (void)WKFoodViewCheckMoreBtnClicked;
/**
 *  购物车按钮
 */
- (void)WKFoodViewBottomShopCarCilicked;
/**
 *  去结算
 */
- (void)WKFoodViewBottomGoPayCilicked;

- (void)WKFoodBackAction;

@end

@interface mFoodHeaderView : UIView
#pragma mark----headerView样式
/**
 *  店铺logo
 */
@property (weak, nonatomic) IBOutlet UIImageView *mShopLogo;
/**
 *  店铺名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mShopName;
/**
 *  店铺详情
 */
@property (weak, nonatomic) IBOutlet UILabel *mShopDetail;
/**
 *  活动view
 */
@property (weak, nonatomic) IBOutlet UIView *mCampView;
/**
 *  查看更多
 */
@property (weak, nonatomic) IBOutlet UIButton *mCheckMoreBtn;
/**
 *  公告view
 */
@property (weak, nonatomic) IBOutlet UIView *mNoteView;
/**
 *  公告标题
 */
@property (weak, nonatomic) IBOutlet UILabel *mNote;
/**
 *  公告内容
 */
@property (weak, nonatomic) IBOutlet UIButton *mNoteBtn;
/**
 *  代理
 */
@property (strong,nonatomic) id<WKFoodHeaderViewDelegate>delegate;

+ (mFoodHeaderView *)shareView;

#pragma mark----bottomView样式
/**
 *  购物车按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mShopCarBtn;
/**
 *  数量
 */
@property (weak, nonatomic) IBOutlet UILabel *mNum;
/**
 *  价格
 */
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mTTPrice;
/**
 *  去结算
 */
@property (weak, nonatomic) IBOutlet UIButton *mGoPayBrn;

+ (mFoodHeaderView *)shareBottomView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCampH;


@end
