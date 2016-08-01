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
    
    view.loginBtn.layer.masksToBounds = YES;
    view.loginBtn.layer.cornerRadius = 22;
    
    view.phoneTx.tintColor = [UIColor blackColor];
    view.codeTx.tintColor = [UIColor blackColor];
    
    return view;
}

+ (mLoginView *)shareBottomView{

    mLoginView  *view = [[[NSBundle mainBundle] loadNibNamed:@"mLoginBottomView" owner:self options:nil] objectAtIndex:0];
    
    view.mView1.layer.masksToBounds = YES;
    view.mView2.layer.masksToBounds =YES;
    view.mView3.layer.masksToBounds =YES;
    
    view.mView1.layer.cornerRadius = 20;
    view.mView2.layer.cornerRadius = 20;
    view.mView3.layer.cornerRadius = 20;
    
    view.mView1.layer.borderColor =  [UIColor lightGrayColor].CGColor;
    view.mView2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view.mView3.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    view.mView1.layer.borderWidth =0.5;
    view.mView2.layer.borderWidth =0.5;
    view.mView3.layer.borderWidth =0.5;
    
    return view;
}
@end
