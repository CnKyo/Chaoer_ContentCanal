//
//  mShopCarHeaderSection.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/13.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mShopCarHeaderSection.h"

@implementation mShopCarHeaderSection

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (mShopCarHeaderSection *)shareHeaderView{

    mShopCarHeaderSection *view = [[[NSBundle mainBundle] loadNibNamed:@"mShopCarHeaderSection" owner:self options:nil] objectAtIndex:0];
    
    view.mActivity.layer.masksToBounds = YES;
    view.mActivity.layer.cornerRadius = 3;
    
    return view;
}

+ (mShopCarHeaderSection *)shareFooterView{
    
    mShopCarHeaderSection *view = [[[NSBundle mainBundle] loadNibNamed:@"mShopCarFooterSection" owner:self options:nil] objectAtIndex:0];
    
    
    return view;
}

@end
