//
//  mOrderDetailBottomView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GMyMarketOrderInfo;
/**
 *  代理
 */
@protocol orderBottomViewBtnclick <NSObject>

@optional
/**
 *  底部按钮的代理方法
 *
 *  @param mOrderInfo 订单对象
 */
- (void)mBottomViewWithBtnClick:(GMyMarketOrderInfo *)mBottomOrderInfo;

@end

@interface mOrderDetailBottomView : UIView
#pragma mark ---- 订单详情底部view
/**
 *  合计
 */
@property (weak, nonatomic) IBOutlet UILabel *mTotal;
/**
 *  查看物流
 */
@property (weak, nonatomic) IBOutlet UIButton *mCheckBtn;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (mOrderDetailBottomView *)shareView;
#pragma mark ---- 订单详情cellsectionview
/**
 *  背景
 */
@property (weak, nonatomic) IBOutlet UIView *mBgkView;
/**
 *  超市图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mStoreImg;
/**
 *  名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (mOrderDetailBottomView *)shareSectionView;

@property (strong,nonatomic) GMyMarketOrderInfo *mOrderInfo;

@property (strong,nonatomic) id <orderBottomViewBtnclick> delegate;


@end
