//
//  pptOrderDetailViewController.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface pptOrderDetailViewController : BaseVC
/**
 *  订单类型 1是大厅接单详情 2是订单详情
 */
@property (nonatomic,assign) int mOrderType;

/**
 *  跑腿类型 1是商品买送 2是事情办理 3是送东西
 */
@property (nonatomic,assign) int mType;

/**
 *  订单对象
 */
@property (strong,nonatomic) GPPTOrder *mOrder;

@property (strong,nonatomic)NSString *mLng;

@property (strong,nonatomic)NSString *mLat;

@end
