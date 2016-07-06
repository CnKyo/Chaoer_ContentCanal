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
 *  1是社区生活订单 2是报修订单
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

@end
