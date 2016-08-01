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



+ (mGoodsDetailBottomView *)shareBuyView{

    
    mGoodsDetailBottomView *view = [[[NSBundle mainBundle] loadNibNamed:@"mGoodsDetailBottomBuyView" owner:self options:nil] objectAtIndex:0];
    
    view.mAddView.layer.masksToBounds = YES;
    view.mAddView.layer.cornerRadius = 3;
    view.mAddView.layer.borderWidth = 0.5;
    view.mAddView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    view.mJianBtn.layer.masksToBounds = view.mAddBtn.layer.masksToBounds = YES;
    view.mJianBtn.layer.borderColor = view.mAddBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view.mJianBtn.layer.borderWidth = view.mAddBtn.layer.borderWidth = 0.5;
    
    return view;
    
}

/**
 *  关闭按钮
 *
 *  @param sender
 */
- (IBAction)mCloseAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(mGoodsDetailCloseActionView)]) {
        [self.delegate mGoodsDetailCloseActionView];
    }
    
}
/**
 *  减按钮
 *
 *  @param sender
 */
- (IBAction)mJianAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(mGoodsDetailJianActionView)]) {
        [self.delegate mGoodsDetailJianActionView];
    }
    
    
}
/**
 *  加按钮
 *
 *  @param sender 
 */
- (IBAction)mAddAction:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(mGoodsDetailAddActionView)]) {
        [self.delegate mGoodsDetailAddActionView];
    }

    
}

- (IBAction)mOkBtnAction:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(mGoodsDetailOkActionView)]) {
        [self.delegate mGoodsDetailOkActionView];
    }
    
}


@end
