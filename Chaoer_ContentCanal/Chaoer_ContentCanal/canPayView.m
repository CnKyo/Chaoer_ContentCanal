//
//  canPayView.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "canPayView.h"

@implementation canPayView

+ (canPayView *)shareView{
    canPayView *view = [[[NSBundle mainBundle] loadNibNamed:@"canPayView" owner:self options:nil] objectAtIndex:0];

    view.mTopup.layer.masksToBounds = YES;
    view.mTopup.layer.cornerRadius = 5;
    view.mTopup.layer.borderColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1].CGColor;
    view.mTopup.layer.borderWidth = 1;
    view.mBalanceBtn.layer.masksToBounds = YES;
    view.mBalanceBtn.layer.cornerRadius = 6;
    
    return view;
    
}

+ (canPayView *)shareHeaderView{
    canPayView *view = [[[NSBundle mainBundle] loadNibNamed:@"mBalanceView" owner:self options:nil] objectAtIndex:0];

    view.mTopup.layer.masksToBounds = YES;
    view.mTopup.layer.cornerRadius = 5;
    view.mTopup.layer.borderColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1].CGColor;
    view.mTopup.layer.borderWidth = 1;
    
    return view;
    
}

@end
