//
//  mFoodHeaderView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mFoodHeaderView.h"

@implementation mFoodHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (mFoodHeaderView *)shareView{

    mFoodHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"mFoodHeaderView" owner:self options:nil] objectAtIndex:0];
    view.mNote.layer.masksToBounds = YES;
    view.mNote.layer.cornerRadius = 3;
    
    view.mShopLogo.layer.masksToBounds = YES;
    view.mShopLogo.layer.cornerRadius = 3;
    
    view.mNoteView.layer.masksToBounds = YES;
    view.mNoteView.layer.cornerRadius = 2;
    
    return view;
}

+ (mFoodHeaderView *)shareBottomView{
    mFoodHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"mFoodBottomView" owner:self options:nil] objectAtIndex:0];
    
    view.mNum.layer.masksToBounds = YES;
    view.mNum.layer.cornerRadius = view.mNum.mwidth/2;
    
   
    
    return view;
}

- (IBAction)mCheckAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(WKFoodViewCheckMoreBtnClicked)]) {
        [self.delegate WKFoodViewCheckMoreBtnClicked];
        
    }
    
    
}

- (IBAction)mShopCarAction:(UIButton *)sender {


    if ([self.delegate respondsToSelector:@selector(WKFoodViewBottomShopCarCilicked)]) {
        [self.delegate WKFoodViewBottomShopCarCilicked];
    }
    
}

- (IBAction)mGoPayActoin:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(WKFoodViewBottomGoPayCilicked)]) {
        [self.delegate WKFoodViewBottomGoPayCilicked];
    }
    
    
}

- (IBAction)mBackAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(WKFoodBackAction)]) {
        [self.delegate WKFoodBackAction];
    }
    
}


@end
