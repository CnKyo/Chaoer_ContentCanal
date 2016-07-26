//
//  mMarketRateViewController.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface mMarketRateViewController : BaseVC
/**
 *  订单编号
 */
@property (strong,nonatomic) NSString *mOrderCode;
/**
 *  店铺id
 */
@property (assign,nonatomic) int mShopId;
/**
 *  店铺名称
 */
@property (strong,nonatomic) NSString *mName;
/**
 *  店铺图片
 */
@property (strong,nonatomic) NSString *mShopImg;
/**
 *  总价
 */
@property (assign,nonatomic) CGFloat mTotlaPrice;

@end
