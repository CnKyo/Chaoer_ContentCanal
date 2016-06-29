//
//  shopCarHeaderAndFooterView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/28.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "shopCarHeaderAndFooterView.h"

@implementation shopCarHeaderAndFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (shopCarHeaderAndFooterView *)shareHeaderView{

    shopCarHeaderAndFooterView *view = [[[NSBundle mainBundle] loadNibNamed:@"shopCarHeaderView" owner:self options:nil] objectAtIndex:0];
    
    view.mGoShopBtn.layer.masksToBounds = view.mMyBtn.layer.masksToBounds = YES;
    view.mGoShopBtn.layer.cornerRadius = view.mMyBtn.layer.cornerRadius = 4;
    view.mGoShopBtn.layer.borderColor = view.mMyBtn.layer.borderColor = M_CO.CGColor;
    view.mGoShopBtn.layer.borderWidth = view.mMyBtn.layer.borderWidth = 0.5;
    
    return view;
    
}

+ (shopCarHeaderAndFooterView *)shareFooterView{
    shopCarHeaderAndFooterView *view = [[[NSBundle mainBundle] loadNibNamed:@"shopCarFooterView" owner:self options:nil] objectAtIndex:0];
    
    return view;
}

+ (shopCarHeaderAndFooterView *)shareFooterSubView{
    shopCarHeaderAndFooterView *view = [[[NSBundle mainBundle] loadNibNamed:@"shopCarFooterSubView" owner:self options:nil] objectAtIndex:0];
    
    return view;
    
}

+ (shopCarHeaderAndFooterView *)shareComfirView{
    shopCarHeaderAndFooterView *view = [[[NSBundle mainBundle] loadNibNamed:@"shopCarcomfirmView" owner:self options:nil] objectAtIndex:0];
    
    return view;
    
    
}
@end
