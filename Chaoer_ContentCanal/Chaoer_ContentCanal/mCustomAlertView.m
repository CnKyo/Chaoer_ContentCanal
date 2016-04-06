//
//  mCustomAlertView.m
//  O2O_XiCheSeller
//
//  Created by 密码为空！ on 15/7/13.
//  Copyright (c) 2015年 zongyoutec.com. All rights reserved.
//

#import "mCustomAlertView.h"

@implementation mCustomAlertView


+ (mCustomAlertView *)shareView{
    mCustomAlertView *view = [[[NSBundle mainBundle]loadNibNamed:@"mCustomAlertView" owner:self options:nil]objectAtIndex:0];
    
    return view;
}

@end
