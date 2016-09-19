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

    
    return view;
}

+ (mShopCarHeaderSection *)shareFooterView{
    
    mShopCarHeaderSection *view = [[[NSBundle mainBundle] loadNibNamed:@"mShopCarFooterSection" owner:self options:nil] objectAtIndex:0];
    
    
    return view;
}
- (IBAction)mSelAction:(UIButton *)sender {
    
    if ([self.headerViewDelegate respondsToSelector:@selector(headerView:selBtnDidClickToChangeAllSelBtn:andSection:)]) {
        [self.headerViewDelegate headerView:self selBtnDidClickToChangeAllSelBtn:sender.selected andSection:self.section];

    }
    
    
}
- (void)setShop:(GShopCarList *)shop {
    
    NSDictionary *mStyle1 = @{@"color": [UIColor redColor]};
    
    
    _shop = shop;
    //设置数据
    self.mSelBtn.selected = shop.mSelected;
    self.mSelBtn.tag = shop.mShopId;
    NSString *mAct = @"营业时间";
    NSString *mTime = nil;
    
    if (shop.mIsCanOrder) {
        mTime = @"";
    }else{
        mTime = @"商家休息中";
    }
    self.mName.text = [NSString stringWithFormat:@"%@  %@",shop.mShopName,mTime];
    
    self.mContent.attributedText = [[NSString stringWithFormat:@"%@:<color>%@-%@</color>",mAct,shop.mOpenTime,shop.mCloseTime] attributedStringWithStyleBook:mStyle1];
    
    
    
}

@end
