//
//  pptMyRateHeaderView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "pptMyRateHeaderView.h"

@implementation pptMyRateHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (pptMyRateHeaderView *)shareView{

    pptMyRateHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"pptMyRateHeaderView" owner:self options:nil] objectAtIndex:0];

    return view;
}
@end
