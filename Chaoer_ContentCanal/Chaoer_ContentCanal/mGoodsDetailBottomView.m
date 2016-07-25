//
//  mGoodsDetailBottomView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/25.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mGoodsDetailBottomView.h"

@implementation mGoodsDetailBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (mGoodsDetailBottomView *)shareShopCarView{
    
    mGoodsDetailBottomView *view = [[[NSBundle mainBundle] loadNibNamed:@"mGoodsDetailBottomView" owner:self options:nil] objectAtIndex:0];
    
    view.mGoodsNum.layer.masksToBounds = YES;
    view.mGoodsNum.layer.cornerRadius = view.mGoodsNum.mwidth/2;
    

    
    
    return view;
}




@end
