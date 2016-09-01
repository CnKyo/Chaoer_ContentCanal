//
//  homeViewController.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/10.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface homeViewController : BaseVC

@property(nonatomic,assign) BOOL  withOutLogin; //去掉登陆

-(void)jPushToSenderVCWithType:(NSString *)orderType;

@end
