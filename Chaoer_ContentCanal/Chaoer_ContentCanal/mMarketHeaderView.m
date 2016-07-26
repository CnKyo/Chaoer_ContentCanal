//
//  mMarketHeaderView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/27.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mMarketHeaderView.h"

@implementation mMarketHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (mMarketHeaderView *)shareView{

    
    mMarketHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"mMarketHeaderView" owner:self options:nil] objectAtIndex:0];

    return view;
}

@end
