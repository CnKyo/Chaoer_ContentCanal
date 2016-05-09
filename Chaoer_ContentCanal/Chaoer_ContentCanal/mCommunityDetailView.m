//
//  mCommunityDetailView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/9.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mCommunityDetailView.h"

@implementation mCommunityDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (mCommunityDetailView *)shareView{

    
    mCommunityDetailView *view = [[[NSBundle mainBundle] loadNibNamed:@"mCommunityDetailView" owner:self options:nil] objectAtIndex:0];
    return view;
    
}

@end
