//
//  mActivitySubView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/25.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mActivitySubView.h"

@implementation mActivitySubView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (mActivitySubView *)shareView{

    
    mActivitySubView *view = [[[NSBundle mainBundle] loadNibNamed:@"mActivitySubView" owner:self options:nil] objectAtIndex:0];
    
    
    view.mName.layer.masksToBounds = YES;
    view.mName.layer.cornerRadius = 10;
    
    return view;

    
}

@end
