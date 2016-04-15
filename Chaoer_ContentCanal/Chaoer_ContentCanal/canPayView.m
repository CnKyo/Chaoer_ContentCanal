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
    view.mTopup.layer.cornerRadius = 3;
    view.mTopup.layer.borderColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1].CGColor;
    view.mTopup.layer.borderWidth = 0.5;
    view.mBalanceBtn.layer.masksToBounds = YES;
    view.mBalanceBtn.layer.cornerRadius = 3;
    
    return view;
    
}

+ (canPayView *)shareHeaderView{
    canPayView *view = [[[NSBundle mainBundle] loadNibNamed:@"mBalanceView" owner:self options:nil] objectAtIndex:0];

    view.mChongzhi.layer.masksToBounds = YES;
    view.mChongzhi.layer.cornerRadius = 5;
    view.mChongzhi.layer.borderColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1].CGColor;
    view.mChongzhi.layer.borderWidth = 0.5;
    
    return view;
    
}

@end
