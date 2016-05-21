//
//  mComfirOrderDetailView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/21.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mComfirOrderDetailView.h"

@implementation mComfirOrderDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (mComfirOrderDetailView *)shareView{

    mComfirOrderDetailView *view = [[[NSBundle mainBundle] loadNibNamed:@"mComfirOrderDetailView" owner:self options:nil] objectAtIndex:0];
    return view;
    
}

@end
