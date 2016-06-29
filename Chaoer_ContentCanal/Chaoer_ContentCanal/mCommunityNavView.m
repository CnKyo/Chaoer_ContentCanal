//
//  mCommunityNavView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/23.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mCommunityNavView.h"

@implementation mCommunityNavView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (mCommunityNavView *)shareView{

    mCommunityNavView *view = [[[NSBundle mainBundle] loadNibNamed:@"mCommunityNavView" owner:self options:nil] objectAtIndex:0];
    
    return view;
    

}

+ (mCommunityNavView *)shareSubView{
    mCommunityNavView *view = [[[NSBundle mainBundle] loadNibNamed:@"mCommunitySubView" owner:self options:nil] objectAtIndex:0];
    
    view.mImg.layer.masksToBounds = YES;
    view.mImg.layer.cornerRadius = 3;
    
    return view;
}

+ (mCommunityNavView *)shaeScrollerSubView{

    mCommunityNavView *view = [[[NSBundle mainBundle] loadNibNamed:@"mCommunityHotView" owner:self options:nil] objectAtIndex:0];
    
    view.mSImg.layer.masksToBounds = YES;
    view.mSImg.layer.cornerRadius = 3;
    
    return view;
}

@end
