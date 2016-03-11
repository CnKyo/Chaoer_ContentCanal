//
//  mFixView.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mFixView.h"

@implementation mFixView

+ (mFixView *)shareView{

    mFixView *view = [[[NSBundle mainBundle] loadNibNamed:@"mFixView" owner:self options:nil] objectAtIndex:0];
    
    
    
    view.mYuyueBtn.layer.masksToBounds = view.mPayBtn.layer.masksToBounds = YES;
    view.mYuyueBtn.layer.cornerRadius = view.mPayBtn.layer.cornerRadius = 5;
    view.mYuyueBtn.layer.borderColor = view.mPayBtn.layer.borderColor = [UIColor colorWithRed:0.82 green:0.82 blue:0.84 alpha:1].CGColor;
    view.mYuyueBtn.layer.borderWidth = view.mPayBtn.layer.borderWidth = 1;
    
    
    return view;
}

@end
