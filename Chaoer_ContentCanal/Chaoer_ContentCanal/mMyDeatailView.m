//
//  mMyDeatailView.m
//  O2O_XiCheSeller
//
//  Created by 密码为空！ on 15/7/13.
//  Copyright (c) 2015年 zongyoutec.com. All rights reserved.
//

#import "mMyDeatailView.h"

@implementation mMyDeatailView

+ (mMyDeatailView *)shareView{
    
    mMyDeatailView *view = [[[NSBundle mainBundle]loadNibNamed:@"myEditView" owner:self options:nil]objectAtIndex:0];

    
    view.mHeaderImg.layer.masksToBounds = YES;
    view.mHeaderImg.layer.cornerRadius = view.mHeaderImg.mwidth/2;
    
    view.bgvc1.layer.masksToBounds = YES;
    view.bgvc1.layer.borderColor = [UIColor colorWithRed:0.890 green:0.882 blue:0.886 alpha:1].CGColor;
    view.bgvc1.layer.borderWidth = 0.25;
    
    view.bgvc2.layer.masksToBounds = YES;
    view.bgvc2.layer.borderColor = [UIColor colorWithRed:0.890 green:0.882 blue:0.886 alpha:1].CGColor;
    view.bgvc2.layer.borderWidth = 0.25;
    
    return view;
}

@end
