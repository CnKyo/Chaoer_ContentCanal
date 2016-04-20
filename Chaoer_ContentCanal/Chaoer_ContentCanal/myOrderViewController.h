//
//  myOrderViewController.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface myOrderViewController : BaseVC
/**
 *  订单类型 1是保修订单 2是充值订单
 */
@property (assign,nonatomic) NSString *mType;

@end
