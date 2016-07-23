//
//  mSelectSenTypeViewController.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface mSelectSenTypeViewController : BaseVC


@property (nonatomic,strong) void(^block)(NSString *mName,NSString *mType);

@end
