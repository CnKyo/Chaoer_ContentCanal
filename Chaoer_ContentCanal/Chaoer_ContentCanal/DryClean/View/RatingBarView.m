//
//  RatingBarView.m
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "RatingBarView.h"

@implementation RatingBarView

- (id)initWithSize:(CGSize)size
{
    self = [self initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        CGFloat width1 = size.width *0.7;
        CGFloat width2 = size.width *0.3;

        self.bar = [[RatingBar alloc] initWithFrame:CGRectMake(0, 0, width1, size.height)];
        [self addSubview:_bar];
        
        self.barLable = [self newUILableWithText:@"4.0分" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:13]];
        self.barLable.frame = CGRectMake(width1, 0, width2, size.height);
    }
    return self;
}

@end
