//
//  homeHotViewController.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/25.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface homeHotViewController : BaseVC
/**
 *  商品id
 */
@property (assign,nonatomic) int mGoodId;
/**
 *  纬度
 */
@property (nonatomic,strong) NSString *mLat;
/**
 *  经度
 */
@property (nonatomic,strong) NSString *mLng;

@end
