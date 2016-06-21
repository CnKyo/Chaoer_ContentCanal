//
//  mGeneralSubView.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/18.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mGeneralSubView.h"

@implementation mGeneralSubView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (mGeneralSubView *)shareView{
    mGeneralSubView *view = [[[NSBundle mainBundle] loadNibNamed:@"mGeneralSubView" owner:self options:nil] objectAtIndex:0];
    view.mBage.layer.masksToBounds = YES;
    view.mBage.layer.cornerRadius = view.mBage.mwidth/2;
    return view;
}


+ (mGeneralSubView *)shareSubView{

    mGeneralSubView *view = [[[NSBundle mainBundle] loadNibNamed:@"mGeneratSmallView" owner:self options:nil] objectAtIndex:0];
    return view;
    
 
}

@end
