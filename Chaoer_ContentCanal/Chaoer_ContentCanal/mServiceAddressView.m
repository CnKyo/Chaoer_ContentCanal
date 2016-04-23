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
+ (mServiceAddressView *)shareView{
    mServiceAddressView *view = [[[NSBundle mainBundle] loadNibNamed:@"mServiceAddressView" owner:self options:nil] objectAtIndex:0];
//    view.layer.masksToBounds = YES;
//    view.layer.borderColor = [UIColor colorWithRed:0.78 green:0.78 blue:0.8 alpha:1].CGColor;
//    view.layer.borderWidth = 1;
    return view;
}


+ (mServiceAddressView *)shareSmallSubView{
    mServiceAddressView *view = [[[NSBundle mainBundle] loadNibNamed:@"mSmallSubView" owner:self options:nil] objectAtIndex:0];

    return view;
}

@end
