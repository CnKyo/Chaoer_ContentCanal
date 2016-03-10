//
//  PingjiaSectionView.m
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/10/30.
//  Copyright (c) 2015年 zongyoutec.com. All rights reserved.
//

#import "PingjiaSectionView.h"

@implementation PingjiaSectionView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    _BgView.layer.cornerRadius = 5;
}


+ (PingjiaSectionView *)shareView{
    
    PingjiaSectionView *view = [[[NSBundle mainBundle]loadNibNamed:@"PingjiaSectionView" owner:self options:nil]objectAtIndex:0];
    return view;
    
}

@end
