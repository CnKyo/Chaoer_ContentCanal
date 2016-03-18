//
//  mPersonView.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/10.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mPersonView.h"

@implementation mPersonView

+ (mPersonView *)shareView{

    mPersonView *view = [[[NSBundle mainBundle] loadNibNamed:@"mPersonView" owner:self options:nil] objectAtIndex:0];
    
    view.mHeaderBtn.layer.masksToBounds = YES;
    view.mHeaderBtn.layer.cornerRadius = view.mHeaderBtn.mwidth/2;
    view.mHeaderBtn.layer.borderColor = M_CO.CGColor;
    view.mHeaderBtn.layer.borderWidth = 10;
    
    return view;
    
}

+ (mPersonView *)shareRightView{
    
    mPersonView *view = [[[NSBundle mainBundle] loadNibNamed:@"mPersonRightView" owner:self options:nil] objectAtIndex:0];
    
    view.mBadg.layer.masksToBounds = YES;
    view.mBadg.layer.cornerRadius = view.mBadg.mwidth/2;    
    
    return view;
}
@end
