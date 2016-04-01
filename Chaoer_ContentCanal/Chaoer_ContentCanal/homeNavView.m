//
//  homeNavView.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/4/1.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "homeNavView.h"

@implementation homeNavView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (homeNavView *)shareView{

    homeNavView *view = [[[NSBundle mainBundle] loadNibNamed:@"homeNavView" owner:self options:nil] objectAtIndex:0];
    return view;
}

@end
