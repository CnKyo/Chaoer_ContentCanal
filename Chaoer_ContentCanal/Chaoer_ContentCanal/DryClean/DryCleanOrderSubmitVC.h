//
//  DryCleanOrderSubmitVC.h
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//干洗订单提交界面

#import "BaseVC.h"
#import "APIClient.h"

@interface DryCleanOrderSubmitVC : BaseVC

@property(nonatomic,assign) int shopId;
@property(nonatomic,strong) NSMutableArray* goodsArr;
@property(nonatomic,strong) DryClearnShopOrderShowObject *showInfoItem;

@end
