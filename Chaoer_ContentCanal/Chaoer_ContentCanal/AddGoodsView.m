//
//  AddGoodsView.m
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/11/4.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "AddGoodsView.h"

@implementation AddGoodsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (AddGoodsView *)shareView{
    
    AddGoodsView *view = [[[NSBundle mainBundle] loadNibNamed:@"AddGoodsView" owner:self options:nil] objectAtIndex:0];
    
    
    return view;
}


@end
