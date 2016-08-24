//
//  goPayViewController.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/28.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface goPayViewController : BaseVC

/**
 *  1是社区生活订单 2是报修订单 3是我的界面 4 是干洗订单
 */
@property (assign,nonatomic) int mType;
/**
 *  充值金额
 */
@property (assign,nonatomic) float mMoney;
/**
 *  订单编号
 */
@property (strong,nonatomic) NSString *mOrderCode;
/**
 *  支付金额
 */
@property (assign,nonatomic) float mPayFee;


@property (assign,nonatomic) BOOL mIsPushFromOrderVC; //是否为订单跳转进入该界面，否则为购物车逻辑进入
@end
