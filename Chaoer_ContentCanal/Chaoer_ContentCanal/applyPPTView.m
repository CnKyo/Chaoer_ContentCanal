//
//  applyPPTView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "applyPPTView.h"

@implementation applyPPTView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (applyPPTView *)shareView{

    applyPPTView *view = [[[NSBundle mainBundle]loadNibNamed:@"applyPPTView" owner:self options:nil] objectAtIndex:0];
    
    
    view.mView1.layer.masksToBounds = view.mView2.layer.masksToBounds = YES;
    view.mView1.layer.borderColor = view.mView2.layer.borderColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00].CGColor;
    view.mView1.layer.borderWidth = view.mView2.layer.borderWidth = 0.5;
    
    view.mOkBtn.layer.masksToBounds = YES;
    view.mOkBtn.layer.cornerRadius = 3;
    
    return view;
    
}

@end
