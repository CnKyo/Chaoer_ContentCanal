//
//  mZhongchouView.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mZhongchouView.h"

@implementation mZhongchouView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (mZhongchouView *)shareTopView{

    mZhongchouView *view = [[[NSBundle mainBundle] loadNibNamed:@"mZhongchouView"owner:self options:nil] objectAtIndex:0];
    return view;
}

+ (mZhongchouView *)shareBottomView{

    mZhongchouView *view = [[[NSBundle mainBundle] loadNibNamed:@"mZhongchouBottomView"owner:self options:nil] objectAtIndex:0];
    return view;
    
}

+ (mZhongchouView *)shareSubView{
    mZhongchouView *view = [[[NSBundle mainBundle] loadNibNamed:@"mZhongchouSubViewView"owner:self options:nil] objectAtIndex:0];
    return view;
}
@end
