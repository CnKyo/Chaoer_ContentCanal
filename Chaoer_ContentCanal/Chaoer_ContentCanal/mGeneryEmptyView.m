
//
//  mGeneryEmptyView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/26.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mGeneryEmptyView.h"

@implementation mGeneryEmptyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (mGeneryEmptyView *)shareView{


    mGeneryEmptyView *view = [[[NSBundle mainBundle] loadNibNamed:@"mGeneryEmptyView" owner:self options:nil] objectAtIndex:0];
    
    
    view.mEmptyBtn.layer.masksToBounds = YES;
    view.mEmptyBtn.layer.cornerRadius = 3;
    
    view.mEmptyBtn.layer.borderColor = M_CO.CGColor;
    view.mEmptyBtn.layer.borderWidth = 0.5;
    
    return view;

}

@end
