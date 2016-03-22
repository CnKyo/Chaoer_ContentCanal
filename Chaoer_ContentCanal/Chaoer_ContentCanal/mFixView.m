//
//  mFixView.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mFixView.h"

@implementation mFixView

+ (mFixView *)shareView{

    mFixView *view = [[[NSBundle mainBundle] loadNibNamed:@"mFixView" owner:self options:nil] objectAtIndex:0];
    
    view.mTxView.placeholder = @"请输入你的描述！";
    [view.mTxView setHolderToTop];

    
    view.mHomeBtn.layer.masksToBounds = view.mCleanBtn.layer.masksToBounds = view.mPipeBtn.layer.masksToBounds= view.mResultBtn.layer.masksToBounds = YES;
    view.mHomeBtn.layer.cornerRadius = view.mCleanBtn.layer.cornerRadius = view.mPipeBtn.layer.cornerRadius = view.mResultBtn.layer.cornerRadius = 5;
    
    
    return view;
}

@end
