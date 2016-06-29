//
//  comfirmOrderView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/28.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "comfirmOrderView.h"

@implementation comfirmOrderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (comfirmOrderView *)shareView{

    comfirmOrderView *view = [[[NSBundle mainBundle] loadNibNamed:@"comfirmOrderView" owner:self options:nil] objectAtIndex:0];
    
    return view;
}
+ (comfirmOrderView *)sharePayView{
    
    comfirmOrderView *view = [[[NSBundle mainBundle] loadNibNamed:@"acountView" owner:self options:nil] objectAtIndex:0];
    
    return view;
}
@end
