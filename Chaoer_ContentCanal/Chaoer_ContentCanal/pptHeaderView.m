//
//  pptHeaderView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "pptHeaderView.h"

@implementation pptHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (pptHeaderView *)shareView{

    
    pptHeaderView *view =[[[NSBundle mainBundle] loadNibNamed:@"pptHeaderView" owner:self options:nil] objectAtIndex:0];
    
    return view;
    
}

@end
