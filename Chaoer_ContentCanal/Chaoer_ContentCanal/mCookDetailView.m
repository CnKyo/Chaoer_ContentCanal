//
//  mCookDetailView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/21.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mCookDetailView.h"

@implementation mCookDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (mCookDetailView *)shareView{

    mCookDetailView *view = [[[NSBundle mainBundle] loadNibNamed:@"mCookDetailView" owner:self options:nil] objectAtIndex:0];

    return view;
}

@end
