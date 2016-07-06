//
//  mFixOrderFooter.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/6.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mFixOrderFooter.h"

@implementation mFixOrderFooter

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (mFixOrderFooter *)shareView{

    mFixOrderFooter *view = [[[NSBundle mainBundle] loadNibNamed:@"mFixOrderFooter" owner:self options:nil] objectAtIndex:0];
    
    return view;
}

@end
