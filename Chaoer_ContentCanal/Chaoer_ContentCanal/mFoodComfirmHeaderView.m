//
//  mFoodComfirmHeaderView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mFoodComfirmHeaderView.h"

@implementation mFoodComfirmHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (mFoodComfirmHeaderView *)shareHeaderView{

    mFoodComfirmHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"mFoodComfirmHeaderView" owner:self options:nil] objectAtIndex:0];
    return view;
}


+ (mFoodComfirmHeaderView *)shareSectionView{
    
    mFoodComfirmHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"mFoodComfirmSctionView" owner:self options:nil] objectAtIndex:0];
    return view;
}


+ (mFoodComfirmHeaderView *)shareBottomView{
    
    mFoodComfirmHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"mFoodComfirmBottomView" owner:self options:nil] objectAtIndex:0];
    return view;
}

+ (mFoodComfirmHeaderView *)shareFooterView{
    
    mFoodComfirmHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"mFoodComfirmFooterView" owner:self options:nil] objectAtIndex:0];
    
    
    [view.mNotTx setHolderToTop];
    [view.mNotTx setPlaceholder:@"您可以给商家备注说明！"];
    
    return view;
}

- (IBAction)mGoPayAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(WKFoodComfirmViewWithGoPayBtnclick)]) {
        [self.delegate WKFoodComfirmViewWithGoPayBtnclick];
    }
    
}

- (IBAction)mCoupAction:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(WKFoodComfirmViewWithCoupBtnclick)]) {
        [self.delegate WKFoodComfirmViewWithCoupBtnclick];

    }
    
}

- (IBAction)mSendTimeAction:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(WKFoodComfirmViewWithSendTimeBtnclick)]) {
        [self.delegate WKFoodComfirmViewWithSendTimeBtnclick];
    }
    

}

- (IBAction)mAddressAction:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(WKFoodComfirmViewWithAddressBtnclick)]) {
        [self.delegate WKFoodComfirmViewWithAddressBtnclick];
    }
    

}

@end
