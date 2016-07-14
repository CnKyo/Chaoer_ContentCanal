//
//  mOrderDetailBottomView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mOrderDetailBottomView.h"

@implementation mOrderDetailBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (mOrderDetailBottomView *)shareView{

    mOrderDetailBottomView *view = [[[NSBundle mainBundle] loadNibNamed:@"mOrderDetailBottomView" owner:self options:nil] objectAtIndex:0];
    
    view.mCheckBtn.layer.masksToBounds = YES;
    view.mCheckBtn.layer.cornerRadius = 3;
    
    return view;
}

+ (mOrderDetailBottomView *)shareSectionView{
    mOrderDetailBottomView *view = [[[NSBundle mainBundle] loadNibNamed:@"mOrderDetailHeaderSectionView" owner:self options:nil] objectAtIndex:0];
    
    view.mBgkView.layer.masksToBounds = YES;
    view.mBgkView.layer.cornerRadius = 3;
    
    return view;
}

@end
