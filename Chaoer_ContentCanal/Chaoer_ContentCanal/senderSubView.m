//
//  senderSubView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/6.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "senderSubView.h"

@implementation senderSubView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (senderSubView *)shareView{

    senderSubView *view = [[[NSBundle mainBundle] loadNibNamed:@"senderSubView" owner:self options:nil] objectAtIndex:0];
    return view;
}
@end
