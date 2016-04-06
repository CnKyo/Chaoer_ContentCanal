//
//  popMessageView.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/24.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "popMessageView.h"

@implementation popMessageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (popMessageView *)shareView{
    popMessageView *view = [[[NSBundle mainBundle] loadNibNamed:@"popMessageView" owner:self options:nil] objectAtIndex:0];
    return view;
}

@end
