
//
//  mFoodRateHeaderView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mFoodRateHeaderView.h"

@implementation mFoodRateHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (mFoodRateHeaderView *)shareView{
    mFoodRateHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"mFoodRateHeaderView" owner:self options:nil] objectAtIndex:0];
    return view;
    
}

@end
