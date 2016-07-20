//
//  mCommunityMyViewCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/24.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mCommunityMyViewCell.h"

@implementation mCommunityMyViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{

    self.mImg.layer.masksToBounds = YES;
    self.mImg.layer.cornerRadius = 3;
    
//    self.mLeftImg.layer.masksToBounds = self.mRightImg.layer.masksToBounds = YES;
//    self.mLeftImg.layer.cornerRadius = self.mRightImg.layer.cornerRadius = 3;
//    
//    self.mLeftView.layer.masksToBounds = self.mRightView.layer.masksToBounds = YES;
//    self.mLeftView.layer.cornerRadius = self.mLeftView.layer.cornerRadius = 3;
//    self.mLeftView.layer.borderColor = self.mLeftView.layer.borderColor = [UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1.00].CGColor;
//    
//    self.mLeftView.layer.borderWidth = self.mLeftView.layer.borderWidth = 0.75;

    
    [self.mLeftCollect addTarget:self action:@selector(mLeftAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mRightCollect addTarget:self action:@selector(mRightAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.mLeftAdd addTarget:self action:@selector(mLeftAddAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mRightAdd addTarget:self action:@selector(mRightAddAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)mLeftAction:(UIButton *)sender{

    if ([self.delegate respondsToSelector:@selector(cellWithLeftBtnClick:)]) {
        [self.delegate cellWithLeftBtnClick:sender.tag];
    }
    
    if ([self.delegate respondsToSelector:@selector(cellWithLeftBtnClick:andId:)]) {
        [self.delegate cellWithLeftBtnClick:sender.tag andId:self.mLeftShopId];
    }
    
    
}

- (void)mRightAction:(UIButton *)sender{
 
    if ([self.delegate respondsToSelector:@selector(cellWithRightBtnClick:)]) {
        [self.delegate cellWithRightBtnClick:sender.tag];
    }
    
    if ([self.delegate respondsToSelector:@selector(cellWithRightBtnClick:andId:)]) {
        [self.delegate cellWithRightBtnClick:sender.tag andId:self.mRightShopId];
    }
    
    
}


- (void)mLeftAddAction:(mGoodsBtn *)sender{
    
    if ([self.delegate respondsToSelector:@selector(cellWithLeftAddShopCar:andGoods:)]) {
        [self.delegate cellWithLeftAddShopCar:sender.tag andGoods:sender.mGood];
    }
    
    
}

- (void)mRightAddAction:(mGoodsBtn *)sender{

    if ([self.delegate respondsToSelector:@selector(cellWithRightAddShopCar:andGoods:)]) {
        [self.delegate cellWithRightAddShopCar:sender.tag andGoods:sender.mGood];
    }
    
    

}

- (IBAction)mLeftDetailAction:(mGoodsBtn *)sender {
    
    if ([self.delegate respondsToSelector:@selector(cellWithLeftDetailClick:andGoods:)]) {
        [self.delegate cellWithLeftDetailClick:sender.tag andGoods:sender.mGood];
    }
    
    
    
}

- (IBAction)mRightDetailAction:(mGoodsBtn *)sender {
    
    if ([self.delegate respondsToSelector:@selector(cellWithRightDetailClick:andGoods:)]) {
        [self.delegate cellWithRightDetailClick:sender.tag andGoods:sender.mGood];
    }
    
}


@end
