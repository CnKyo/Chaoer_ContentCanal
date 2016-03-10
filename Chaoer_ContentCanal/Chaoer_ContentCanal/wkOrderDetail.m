//
//  wkOrderDetail.m
//  O2O_JiazhengSeller
//
//  Created by 密码为空！ on 15/8/7.
//  Copyright (c) 2015年 zongyoutec.com. All rights reserved.
//

#import "wkOrderDetail.h"

@implementation wkOrderDetail

+ (wkOrderDetail *)shareOrderDetail{
    wkOrderDetail *view = [[[NSBundle mainBundle]loadNibNamed:@"orderDetailView" owner:self options:nil]objectAtIndex:0];
    
    view.wkView1.layer.masksToBounds = YES;
    view.wkView1.layer.borderColor = [UIColor colorWithRed:0.871 green:0.855 blue:0.851 alpha:1].CGColor;
    view.wkView1.layer.borderWidth = 0.75f;
    
    view.wkView2.layer.masksToBounds = YES;
    view.wkView2.layer.borderColor = [UIColor colorWithRed:0.871 green:0.855 blue:0.851 alpha:1].CGColor;
    view.wkView2.layer.borderWidth = 0.75f;
    
    view.wkImg.layer.masksToBounds = YES;
    view.wkImg.layer.cornerRadius = 4;
    
    return view;
}

+ (wkOrderDetail *)shareMapView{
    wkOrderDetail *view = [[[NSBundle mainBundle]loadNibNamed:@"mBottomMapView" owner:self options:nil]objectAtIndex:0];
    
    
    return view;
}
@end
