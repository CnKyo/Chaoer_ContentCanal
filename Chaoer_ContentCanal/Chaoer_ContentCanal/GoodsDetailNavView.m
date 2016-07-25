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
    
    [view.mAttentionBtn addTarget:self action:@selector(mAttentionAction:) forControlEvents:UIControlEventTouchUpInside];
    [view.mShopCarBtn addTarget:self action:@selector(mShopCarAction:) forControlEvents:UIControlEventTouchUpInside];
    [view.mAddShopCarBtn addTarget:self action:@selector(mAddShopCarAction:) forControlEvents:UIControlEventTouchUpInside];
    [view.mBuyNowBtn addTarget:self action:@selector(mBuyNowAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return view;
}


#pragma mark----关注按钮
- (void)mAttentionAction:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(mFocusClick:)]) {
        [self.delegate mFocusClick:sender.selected];
    }
    
    
    
}
#pragma mark----购物车按钮
- (void)mShopCarAction:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(mShopCarClick:)]) {
        [self.delegate mShopCarClick:sender.selected];
    }
    
    
}
#pragma mark----添加购物车按钮
- (void)mAddShopCarAction:(UIButton *)sender{
    
    
    if ([self.delegate respondsToSelector:@selector(mAddShopCarClick:)]) {
        [self.delegate mAddShopCarClick:sender.selected];
    }
    
}
#pragma mark----立即购买按钮
- (void)mBuyNowAction:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(mBuyClick:)]) {
            [self.delegate mBuyClick:sender.selected];
    }
    

}

@end
