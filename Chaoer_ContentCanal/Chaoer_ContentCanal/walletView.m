//
//  walletView.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/4/5.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "walletView.h"

@implementation walletView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (walletView *)shareView{
    walletView *view = [[[NSBundle mainBundle] loadNibNamed:@"walletView" owner:self options:nil] objectAtIndex:0];
    return view;
}

@end
