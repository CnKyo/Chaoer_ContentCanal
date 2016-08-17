//
//  mDetailSectionView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mDetailSectionView.h"

@implementation mDetailSectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (mDetailSectionView *)shareView{

    mDetailSectionView *view = [[[NSBundle mainBundle] loadNibNamed:@"mDetailSectionView" owner:self options:nil] objectAtIndex:0];
    
    return view;
}

+ (mDetailSectionView *)shareShopCarView{
    mDetailSectionView *view = [[[NSBundle mainBundle] loadNibNamed:@"mFoodDetailSectionView" owner:self options:nil] objectAtIndex:0];
    
    view.mAddShopCarBtn.layer.masksToBounds = YES;
    view.mAddShopCarBtn.layer.cornerRadius = 3;
    
    return view;
}


- (IBAction)mAddShopCarAction:(UIButton *)sender {


    if ([self.delegate respondsToSelector:@selector(WKFoodDetailAddShopCarAction)]) {
        [self.delegate WKFoodDetailAddShopCarAction];
    }
    
}

- (IBAction)mAddAction:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(WKFoodDetailAddAction)]) {
        [self.delegate WKFoodDetailAddAction];
    }
    
}

- (IBAction)mJianAction:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(WKFoodDetailJianAction)]) {
        [self.delegate WKFoodDetailJianAction];
    }
    

}


@end
