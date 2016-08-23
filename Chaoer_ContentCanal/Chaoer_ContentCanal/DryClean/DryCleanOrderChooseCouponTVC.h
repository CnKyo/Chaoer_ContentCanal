//
//  DryCleanOrderChooseCouponTVC.h
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/20.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"
#import "APIClient.h"

@interface DryCleanOrderChooseCouponTVC : BaseVC
@property(nonatomic,strong) NSMutableArray* tableArr;

@property (nonatomic, copy) void (^chooseCallBack)(CouponsObject* item);

@end
