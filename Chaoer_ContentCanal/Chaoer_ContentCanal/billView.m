//
//  billView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "billView.h"

@implementation billView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (billView *)shareView{

    
    billView *view = [[[NSBundle mainBundle] loadNibNamed:@"billView" owner:self options:nil] objectAtIndex:0];
    
    view.mBillType.layer.masksToBounds = YES;
    view.mBillType.layer.cornerRadius = 3;
    view.mBillType.layer.borderColor = [UIColor redColor].CGColor;
    view.mBillType.layer.borderWidth = 0.5;
    
    return view;
    
    
}


@end
