//
//  pptMyAddressViewController.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/13.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface pptMyAddressViewController : BaseVC

/**
 *  1是发布  2是添加
 */
@property (assign,nonatomic) int mType;

@property (nonatomic,strong) void(^block)(NSString *block ,NSString *mId);

@end
