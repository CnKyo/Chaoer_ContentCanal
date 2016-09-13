//
//  communityOrderDetailCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/29.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface communityOrderDetailCell : UITableViewCell

#pragma mark----第一种cell类型
/**
 *  背景1
 */
@property (weak, nonatomic) IBOutlet UIView *mBgkView1;
/**
 *  背景2
 */
@property (weak, nonatomic) IBOutlet UIView *mbgkView2;
/**
 *  订单编号
 */
@property (weak, nonatomic) IBOutlet UILabel *mOrderCode;
/**
 *  创建时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mCreateTime;
/**
 *  订单状态
 */
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mOrderStatus;
/**
 *  查看按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mCheckBtn;
/**
 *  收货地址
 */
@property (weak, nonatomic) IBOutlet UILabel *mOrderAddress;
/**
 *  积分抵扣
 */
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mCreditMoney;
/**
 *  优惠卷抵扣
 */
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mCoupMoney;
/**
 *  配送费
 */
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mSendPrice;


#pragma mark----第二种cell类型
/**
 *  背景
 */
@property (weak, nonatomic) IBOutlet UIView *mBgk;

/**
 *  商品图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mGoodsImg;
/**
 *  商品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsName;
/**
 *  商品说明
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsDetail;

/**
 *  总金额
 */
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mTotleMoney;


@property (strong,nonatomic)GMyOrderGoodsA *mGoodInfo;


@property (strong,nonatomic)GMyMarketOrderInfo *mOrderInfo;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mGoodsDetailH;



@end
