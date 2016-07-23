//
//  mCoupViewController.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/24.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface mCoupViewController : BaseVC

/**
 *  1是优惠券 2是选择优惠券
 */
@property (assign,nonatomic) int mSType;
/**
 *  店铺id
 */
@property (assign,nonatomic) int mShopId;

@property (nonatomic,strong) void(^block)(NSString *mName,NSString *mId,NSString *price);

@end
