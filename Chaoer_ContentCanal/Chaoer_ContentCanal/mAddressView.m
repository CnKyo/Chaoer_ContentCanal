//
//  mAddressView.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mAddressView.h"


@implementation mAddressView

+ (mAddressView *)shareView{

    mAddressView *view = [[[NSBundle mainBundle] loadNibNamed:@"mAddressView" owner:self options:nil] objectAtIndex:0];
    
    view.mLine.layer.masksToBounds = YES;
    view.mLine.layer.borderColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.91 alpha:1].CGColor;
    view.mLine.layer.borderWidth = 0.5;
    
    return view;
}

+ (mAddressView *)sharePayView{
    
    mAddressView *view = [[[NSBundle mainBundle] loadNibNamed:@"mTopUpView" owner:self options:nil] objectAtIndex:0];
    
    view.mLogo.layer.masksToBounds = view.mPayBtn.layer.masksToBounds = YES;
    view.mLogo.layer.cornerRadius = view.mPayBtn.layer.cornerRadius = 3;
    

    
    
    
    return view;
}
+ (mAddressView *)shareUsrInfo{
    
    mAddressView *view = [[[NSBundle mainBundle] loadNibNamed:@"mUserInfoView" owner:self options:nil] objectAtIndex:0];
    
    view.mUserImg.layer.masksToBounds = YES;
    view.mUserImg.layer.cornerRadius = view.mUserImg.mwidth/2;
    
    return view;
}

+ (mAddressView *)shareShopCar{
    mAddressView *view = [[[NSBundle mainBundle] loadNibNamed:@"mShopCarView" owner:self options:nil] objectAtIndex:0];
    
    view.mBadge.layer.masksToBounds = YES;
    view.mBadge.layer.cornerRadius = view.mBadge.mwidth/2;
    
    return view;
}

+ (mAddressView *)sharepayDetailView{

    mAddressView *view = [[[NSBundle mainBundle] loadNibNamed:@"mOrderComform" owner:self options:nil] objectAtIndex:0];
    return view;
}
+ (mAddressView *)shareGoodsDetailView{
    mAddressView *view = [[[NSBundle mainBundle] loadNibNamed:@"mGoodsDetailView" owner:self options:nil] objectAtIndex:0];
    return view;
}
@end
