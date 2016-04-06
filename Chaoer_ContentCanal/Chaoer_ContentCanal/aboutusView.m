//
//  aboutusView.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/18.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "aboutusView.h"

@implementation aboutusView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (aboutusView *)shareView{
    
    aboutusView *view= [[[NSBundle mainBundle] loadNibNamed:@"aboutusView" owner:self options:nil] objectAtIndex:0];
    
    
    view.mLeftView.layer.masksToBounds = view.mRightView.layer.masksToBounds = YES;
    view.mLeftView.layer.cornerRadius = view.mRightView.layer.cornerRadius = 4;
    view.mLeftView.layer.borderColor = view.mRightView.layer.borderColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.85 alpha:1].CGColor;
    view.mLeftView.layer.borderWidth = view.mRightView.layer.borderWidth = 1;
    
    return view;
}


@end
