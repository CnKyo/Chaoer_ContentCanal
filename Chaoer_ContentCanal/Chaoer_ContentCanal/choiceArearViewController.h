//
//  choiceArearViewController.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/20.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface choiceArearViewController : BaseVC

@property (nonatomic,strong) void(^block)(NSString *block ,NSString *mId);


@end
