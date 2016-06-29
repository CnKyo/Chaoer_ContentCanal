//
//  mCommunityHeaderView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/24.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mCommunityHeaderView.h"

@implementation mCommunityHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (mCommunityHeaderView *)shareView{

    mCommunityHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"mCommunityHeaderView" owner:self options:nil] objectAtIndex:0];
    
    view.mSmallHeader.layer.masksToBounds = YES;
    view.mSmallHeader.layer.cornerRadius = 3;
    
    return view;
}

@end
