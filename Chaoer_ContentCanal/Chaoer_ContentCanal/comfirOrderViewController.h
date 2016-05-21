//
//  comfirOrderViewController.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/21.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface comfirOrderViewController : BaseVC
/**
 *  主类型
 */
@property (assign,nonatomic) int mID;
/**
 *  子类型
 */
@property (nonatomic,strong) NSString *mSubClass;
/**
 *  保修订单对象
 */
@property (nonatomic,strong) GFix *mFixOrder;

@end
