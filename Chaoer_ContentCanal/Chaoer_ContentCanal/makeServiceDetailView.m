//
//  makeServiceDetailView.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/24.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "makeServiceDetailView.h"

@implementation makeServiceDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(makeServiceDetailView *)shareOrderDetailView{
    makeServiceDetailView *view = [[[NSBundle mainBundle] loadNibNamed:@"makeFixOrderDetailView" owner:self options:nil] objectAtIndex:0];
    
    view.mOkBtn.layer.masksToBounds = YES;
    view.mOkBtn.layer.cornerRadius = 3;
    
    return view;
}
@end
