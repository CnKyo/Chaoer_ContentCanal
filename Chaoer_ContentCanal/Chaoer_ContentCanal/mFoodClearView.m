//
//  mFoodClearView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mFoodClearView.h"

@implementation mFoodClearView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (mFoodClearView *)shareView{

    mFoodClearView *view = [[[NSBundle mainBundle] loadNibNamed:@"mFoodClearView" owner:self options:nil] objectAtIndex:0];
    
    return view;
}

@end
