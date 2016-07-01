//
//  GoodsDetailNavView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/29.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "GoodsDetailNavView.h"

@implementation GoodsDetailNavView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



+ (GoodsDetailNavView *)shareView{

    GoodsDetailNavView *view = [[[NSBundle mainBundle] loadNibNamed:@"GoodsDetailNavView" owner:self options:nil] objectAtIndex:0];
    
    return view;
    
    
}
+ (GoodsDetailNavView *)shareSearchView{
    
    GoodsDetailNavView *view = [[[NSBundle mainBundle] loadNibNamed:@"GoodsSearchView" owner:self options:nil] objectAtIndex:0];
    
    view.mSearchView.layer.masksToBounds = YES;
    view.mSearchView.layer.cornerRadius = 3;
    
    return view;
    
    
}


+ (GoodsDetailNavView *)shareShopCarView{

    GoodsDetailNavView *view = [[[NSBundle mainBundle] loadNibNamed:@"mGoodsDetailBottomView" owner:self options:nil] objectAtIndex:0];
    
    view.mGoodsNum.layer.masksToBounds = YES;
    view.mGoodsNum.layer.cornerRadius = view.mGoodsNum.mwidth/2;
    
    return view;}


@end
