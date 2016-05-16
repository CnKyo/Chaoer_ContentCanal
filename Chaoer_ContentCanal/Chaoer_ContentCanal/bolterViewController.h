//
//  bolterViewController.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/12.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface bolterViewController : BaseVC
/**
 *  类型  1是发布  2是筛选
 */
@property (assign,nonatomic) int mType;
/**
 *  1是买东西 2是办事情 3是跑腿
 */
@property (assign,nonatomic) int mSubType;

@property (nonatomic,strong) void(^block)(NSString *block,NSString *mTagId);

@end
