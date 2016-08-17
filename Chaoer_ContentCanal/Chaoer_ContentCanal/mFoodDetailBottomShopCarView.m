//
//  mFoodDetailBottomShopCarView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mFoodDetailBottomShopCarView.h"

@implementation mFoodDetailBottomShopCarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (mFoodDetailBottomShopCarView *)shareView{

    mFoodDetailBottomShopCarView *view = [[[NSBundle mainBundle] loadNibNamed:@"mFoodDetailBottomShopCarView" owner:self options:nil] objectAtIndex:0];
    return view;
}

+ (mFoodDetailBottomShopCarView *)shareHeadView{
    
    mFoodDetailBottomShopCarView *view = [[[NSBundle mainBundle] loadNibNamed:@"mFoodDetailHeaderView" owner:self options:nil] objectAtIndex:0];
    return view;
}

@end
