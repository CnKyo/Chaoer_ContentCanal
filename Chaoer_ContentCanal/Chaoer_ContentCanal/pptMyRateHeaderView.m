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
    
    
    view.mSectionBtnView.layer.masksToBounds = YES;
    view.mSectionBtnView.layer.borderColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1.00].CGColor;
    
    view.mSectionBtnView.layer.borderWidth = 0.5;
    
    
    return view;
}
@end
