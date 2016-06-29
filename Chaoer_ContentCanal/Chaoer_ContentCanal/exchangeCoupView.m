//
//  exchangeCoupView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/24.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "exchangeCoupView.h"

@implementation exchangeCoupView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (exchangeCoupView *)shareView{

    exchangeCoupView *view = [[[NSBundle mainBundle] loadNibNamed:@"exchangeCoupView" owner:self options:nil] objectAtIndex:0];
    
    
    view.mBgk.layer.masksToBounds = YES;
    view.mBgk.layer.cornerRadius = 5;
    
    return view;
    
    
}

@end
