//
//  utilityView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "utilityView.h"

@implementation utilityView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (utilityView *)shareView{

    utilityView *view = [[[NSBundle mainBundle]loadNibNamed:@"utilityView" owner:self options:nil] objectAtIndex:0];
    
    
       
    view.mGoPayBtn.layer.masksToBounds = view.mInquireBtn.layer.masksToBounds = YES;
    view.mGoPayBtn.layer.cornerRadius = view.mInquireBtn.layer.cornerRadius = 3;
    return view;
}

+ (utilityView *)shareInquireView{
    utilityView *view = [[[NSBundle mainBundle]loadNibNamed:@"inquireView" owner:self options:nil] objectAtIndex:0];
    view.mGoPayBtn.layer.masksToBounds = view.mInquireBtn.layer.masksToBounds = YES;
    view.mGoPayBtn.layer.cornerRadius = view.mInquireBtn.layer.cornerRadius = 3;
    return view;

}

+ (utilityView *)shareEmpty{
    utilityView *view = [[[NSBundle mainBundle]loadNibNamed:@"emptyView" owner:self options:nil] objectAtIndex:0];
    return view;
}

@end
