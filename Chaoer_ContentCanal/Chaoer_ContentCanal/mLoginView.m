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
    view.loginBtn.layer.cornerRadius = 3;
    
    view.phoneTx.tintColor = [UIColor whiteColor];
    view.codeTx.tintColor = [UIColor whiteColor];
    
    return view;
}

@end
