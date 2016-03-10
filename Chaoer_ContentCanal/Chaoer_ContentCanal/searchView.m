//
//  searchView.m
//  O2O_Communication_seller
//
//  Created by 密码为空！ on 15/10/30.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "searchView.h"

@implementation searchView

+ (searchView *)shareView{
    searchView *view = [[[NSBundle mainBundle]loadNibNamed:@"searchView" owner:self options:nil]objectAtIndex:0];
    
//    view.bgkVC.layer.masksToBounds = YES;
//    view.bgkVC.layer.cornerRadius = 3;
//    view.bgkVC.layer.borderColor = [UIColor colorWithRed:0.890 green:0.882 blue:0.886 alpha:1].CGColor;
//    view.bgkVC.layer.borderWidth = 0.75;
    
    return view;
}



@end
