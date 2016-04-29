//
//  mTopUpBalanceView.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/26.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mTopUpBalanceView.h"

@implementation mTopUpBalanceView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (mTopUpBalanceView *)shareView{

    mTopUpBalanceView *view = [[[NSBundle mainBundle] loadNibNamed:@"mTopUpBalanceView" owner:self options:nil] objectAtIndex:0];
    
    
    view.mHeader.layer.masksToBounds = YES;
    view.mHeader.layer.cornerRadius = 3;
    
    view.mCodeBtn.layer.masksToBounds = view.mPayBtn.layer.masksToBounds = YES;
    view.mCodeBtn.layer.cornerRadius = view.mPayBtn.layer.cornerRadius = 3;
    
    
    
    return view;
}

@end
