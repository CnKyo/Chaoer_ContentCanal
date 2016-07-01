//
//  mSearchHeaderSectionView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/30.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mSearchHeaderSectionView.h"

@implementation mSearchHeaderSectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (mSearchHeaderSectionView *)shareView{

    
    mSearchHeaderSectionView *view = [[[NSBundle mainBundle] loadNibNamed:@"mSearchHeaderSectionView" owner:self options:nil] objectAtIndex:0];
    return view;
    
}

@end
