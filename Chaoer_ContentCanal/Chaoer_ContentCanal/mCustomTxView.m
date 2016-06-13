//
//  mCustomTxView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/13.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mCustomTxView.h"

@implementation mCustomTxView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (mCustomTxView *)shareView{

    mCustomTxView *view = [[[NSBundle mainBundle] loadNibNamed:@"mCustomTxView" owner:self options:nil] objectAtIndex:0];
    
    
    view.mBgk.layer.masksToBounds = YES;
    view.mBgk.layer.cornerRadius = 4;
    return view;
    
    
}

@end
