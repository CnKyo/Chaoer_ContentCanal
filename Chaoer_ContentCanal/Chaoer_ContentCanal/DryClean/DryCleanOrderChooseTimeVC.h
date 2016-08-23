//
//  DryCleanOrderTimeVC.h
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//干洗订单选择时间界面

#import "QUScrollVC.h"
#import "APIClient.h"

@interface DryCleanOrderChooseTimeVC : QUScrollVC
@property(nonatomic,assign) int shopId; //店铺id

@property (nonatomic, copy) void (^chooseCallBack)(NSString* dateStr, NSString* timeStr);

@end
