//
//  goOrderView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/21.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "goOrderView.h"

@implementation goOrderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (goOrderView *)shareView{

    goOrderView *view = [[[NSBundle mainBundle] loadNibNamed:@"goOrderView" owner:self options:nil] objectAtIndex:0];
    
    view.mImag.layer.masksToBounds = YES;
    view.mImag.layer.cornerRadius = 3;
    
    return view;
    
}

@end
