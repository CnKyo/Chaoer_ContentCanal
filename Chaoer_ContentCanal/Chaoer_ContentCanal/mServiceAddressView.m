//
//  mServiceAddressView.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mServiceAddressView.h"

@implementation mServiceAddressView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (mServiceAddressView *)shareSmallSubView{
    mServiceAddressView *view = [[[NSBundle mainBundle] loadNibNamed:@"mSmallSubView" owner:self options:nil] objectAtIndex:0];

    return view;
}

@end
