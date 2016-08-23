//
//  DryCleanShopServerDetailVC.h
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//干洗店铺服务详情界面

#import "QUScrollVC.h"
#import "APIClient.h"

@interface DryCleanShopServerDetailVC : QUScrollVC

@property(nonatomic, strong) DryClearnShopServerObject* item;

@property (nonatomic, copy) void (^addCallBack)(int count);

@end
