//
//  mBarCodeView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/5.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mBarCodeView.h"

@implementation mBarCodeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (mBarCodeView *)shareView{

    mBarCodeView *view  = [[[NSBundle mainBundle] loadNibNamed:@"mBarCodeView" owner:self options:nil] objectAtIndex:0];
    
    
    view.mMainView.layer.masksToBounds = view.mSmallView.layer.masksToBounds = YES;
    view.mMainView.layer.cornerRadius = view.mSmallView.layer.cornerRadius = 5;
    
    view.mHeader.layer.masksToBounds = YES;
    view.mHeader.layer.cornerRadius = 3;
    
    
    
    return view;
}

+ (mBarCodeView *)shareBottomView{
    
    mBarCodeView *view  = [[[NSBundle mainBundle] loadNibNamed:@"mSahreView" owner:self options:nil] objectAtIndex:0];
    
    
    return view;
}
@end
