//
//  mNavAddressViewController.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/2.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface mNavAddressViewController : BaseVC
/**
 *  回调方法  返回经纬度，id
 */
@property (nonatomic,strong) void(^block)(NSString *mLat,NSString *mLng ,NSString *mId);

@end
