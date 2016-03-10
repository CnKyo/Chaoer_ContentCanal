//
//  footView.m
//  O2O_Communication_seller
//
//  Created by 密码为空！ on 15/9/18.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "footView.h"

@implementation footView

+ (footView *)shareView{
    footView *view = [[[NSBundle mainBundle]loadNibNamed:@"footView" owner:self options:nil]objectAtIndex:0];
    view.mLoginBtn.layer.masksToBounds = YES;
    view.mLoginBtn.layer.cornerRadius = 4;
    return view;
}
+ (footView *)shareHeaderView{
    footView *view = [[[NSBundle mainBundle]loadNibNamed:@"headerView" owner:self options:nil]objectAtIndex:0];
    
    view.mHeaderImg.layer.masksToBounds = YES;
    view.mHeaderImg.layer.borderColor = [UIColor colorWithRed:0.580 green:0.506 blue:0.478 alpha:1].CGColor;
    view.mHeaderImg.layer.cornerRadius = view.mHeaderImg.mwidth/2;
    view.mHeaderImg.layer.borderWidth = 5;
    
    view.mLine.layer.masksToBounds = YES;
    view.mLine.layer.borderColor = [UIColor colorWithRed:0.847 green:0.843 blue:0.835 alpha:1].CGColor;
    view.mLine.layer.borderWidth = 0.75;
    
    
    return view;
}

+ (footView *)shareMyMoney{
    footView *view = [[[NSBundle mainBundle]loadNibNamed:@"myMoneyHeader" owner:self options:nil]objectAtIndex:0];
    
    view.mBottomView.layer.masksToBounds = YES;
    view.mBottomView.layer.borderColor = [UIColor colorWithRed:0.847 green:0.843 blue:0.835 alpha:1].CGColor;
    view.mBottomView.layer.borderWidth = 0.75;
    
    return view;

}
@end
