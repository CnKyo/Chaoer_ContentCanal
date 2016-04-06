//
//  mLoginView.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/10.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mLoginView.h"

@implementation mLoginView

+ (mLoginView *)shareView{
    mLoginView  *view = [[[NSBundle mainBundle] loadNibNamed:@"mLoginView" owner:self options:nil] objectAtIndex:0];
    
//    view.mLogoImg.layer.masksToBounds = YES;
//    view.mLogoImg.layer.cornerRadius = view.mLogoImg.mwidth/2;
    
    
    [view.loginBtn setBackgroundImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateSelected];
    [view.loginBtn setBackgroundImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
    return view;
}

@end
