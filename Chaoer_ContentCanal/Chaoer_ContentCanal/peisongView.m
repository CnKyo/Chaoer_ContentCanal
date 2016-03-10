//
//  peisongView.m
//  O2O_Communication_seller
//
//  Created by 王珂 on 15/11/5.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "peisongView.h"

@implementation peisongView

+ (peisongView *)shareView{
    peisongView *view = [[[NSBundle mainBundle]loadNibNamed:@"peisongView" owner:self options:nil]objectAtIndex:0];
    
    view.mAddBtn.layer.masksToBounds = YES;
    view.mAddBtn.layer.cornerRadius = view.mAddBtn.mwidth/2;
    
    return view;
}

+ (peisongView *)shareJianView{
    peisongView *view = [[[NSBundle mainBundle]loadNibNamed:@"peisongAddView" owner:self options:nil]objectAtIndex:0];
    
    view.mJianBtn.layer.masksToBounds = YES;
    view.mJianBtn.layer.cornerRadius = view.mJianBtn.mwidth/2;
    
    return view;
}

@end
