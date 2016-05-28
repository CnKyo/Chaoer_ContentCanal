//
//  mPriceView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mPriceView.h"

@implementation mPriceView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (mPriceView *)shareView{

    mPriceView *view = [[[NSBundle mainBundle] loadNibNamed:@"mPriceView" owner:self options:nil] objectAtIndex:0];
    
    view.mBgkView.layer.masksToBounds = YES;
    view.mBgkView.layer.cornerRadius = 3;
    
    view.mCancelBtn.layer.masksToBounds = view.mOkBtn.layer.masksToBounds = YES;
    view.mCancelBtn.layer.cornerRadius = view.mOkBtn.layer.cornerRadius = 3;
    view.mCancelBtn.layer.borderColor = view.mOkBtn.layer.borderColor = [UIColor colorWithRed:0.43 green:0.43 blue:0.43 alpha:1.00].CGColor;
    view.mCancelBtn.layer.borderWidth = view.mOkBtn.layer.borderWidth = 0.5;

    
//    view.mView1.layer.masksToBounds  = view.mView2.layer.masksToBounds = YES;
//    view.mView1.layer.cornerRadius = view.mView2.layer.cornerRadius = 3;
//    view.mView1.layer.borderColor = view.mView2.layer.borderColor = M_CO.CGColor;
//    view.mView1.layer.borderWidth = view.mView2.layer.borderWidth = 0.5;
    
    
    return view;
    
}
@end
