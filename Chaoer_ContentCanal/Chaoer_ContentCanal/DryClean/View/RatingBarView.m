//
//  RatingBarView.m
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "RatingBarView.h"

@implementation RatingBarView

- (id)initWithHight:(CGFloat)starSize
{
    self = [self initWithFrame:CGRectZero];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
//        CGFloat width1 = size.width *0.7;
//        CGFloat width2 = size.width *0.3;
        
        RateView *bar = [RateView rateViewWithRating:3.7f];
        //bar.rating = 4.0f;
        bar.starNormalColor = [UIColor colorWithRed:0.804 green:0.808 blue:0.812 alpha:1.000];
        bar.starFillColor = [UIColor colorWithRed:0.976 green:0.675 blue:0.165 alpha:1.000];
        bar.starSize = starSize;
        bar.padding = starSize/4;
        [self addSubview:bar];
        
        self.bar = bar;

//        self.bar = [[RatingBar alloc] initWithFrame:CGRectMake(0, 0, width1, size.height)];
//        self.bar.backgroundColor = [UIColor redColor];
//        [self addSubview:_bar];
        
        self.barLable = [self newUILableWithText:@"4.0分" textColor:[UIColor colorWithRed:0.988 green:0.678 blue:0.157 alpha:1.000] font:[UIFont boldSystemFontOfSize:15]];
        self.barLable.frame = CGRectMake(bar.frame.size.width+5, 0, bar.frame.size.width*0.4, starSize);
        
        self.bounds = CGRectMake(0, 0, CGRectGetMaxX(_barLable.frame), starSize);
    }
    return self;
}

@end
