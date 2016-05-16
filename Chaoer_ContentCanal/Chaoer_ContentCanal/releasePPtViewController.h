//
//  releasePPtViewController.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/12.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface releasePPtViewController : BaseVC

/**
 *  1是商品买送   2是事情办理 3是送东西
 */
@property (assign,nonatomic) int mType;
/**
 *  1是买东西 2是办事情 3是跑腿
 */
@property (assign,nonatomic) int mSubType;

@end
