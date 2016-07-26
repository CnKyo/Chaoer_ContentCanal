//
//  communityOrderTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/24.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "communityOrderTableViewCell.h"

@implementation communityOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{

    [super layoutSubviews];
    self.mLogo.layer.masksToBounds = YES;
    self.mLogo.layer.cornerRadius = 3;
    
    [self.mdobtn addTarget:self action:@selector(mBtnAction:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)mBtnAction:(mMarketMyOrderBtn *)sender{

    if ([self.delegate respondsToSelector:@selector(cellWithBtnClickAction:)]) {
        [self.delegate cellWithBtnClickAction:sender.mShop];
    }
    
}
- (void)setMShop:(GMyMarketOrderList *)mShop{

    NSDictionary *mStyle1 = @{@"color": [UIColor redColor]};

    
    self.mTime.text = [NSString stringWithFormat:@"订单编号:%@",mShop.mOrderCode];
    self.mNane.text = mShop.mShopName;
    [self.mLogo sd_setImageWithURL:[NSURL URLWithString:mShop.mShopLogo] placeholderImage:[UIImage imageNamed:@"img_default"]];

    
    
    NSInteger mNum = mShop.mGoodsArr.count;
    
    self.mContent.text = [NSString stringWithFormat:@"共有%ld件商品",(long)mNum];
    
    self.mPrice.attributedText = [[NSString stringWithFormat:@"配送费:<color>¥%.2f元</color>",mShop.mDeliveFee] attributedStringWithStyleBook:mStyle1];
    self.mOrderCode.attributedText = [[NSString stringWithFormat:@"总价:<color>¥%.2f元</color>",mShop.mCommodityPrice] attributedStringWithStyleBook:mStyle1];
    
    NSString *mTT = nil;
    if (mShop.mState == 10) {
        mTT = @"去支付";
        self.mdobtn.enabled = YES;
        [self.mdobtn setTitle:mTT forState:0];
        [self.mdobtn setTitleColor:M_CO forState:0];
        self.mdobtn.layer.masksToBounds = YES;
        self.mdobtn.layer.cornerRadius = 3;
        self.mdobtn.layer.borderColor = M_CO.CGColor;
        self.mdobtn.layer.borderWidth = 0.5;
    }else if (mShop.mState == 11){
        mTT = @"进行中";
        self.mdobtn.enabled = YES;
        [self.mdobtn setTitle:mTT forState:0];
        [self.mdobtn setTitleColor:M_CO forState:0];
        self.mdobtn.layer.masksToBounds = YES;
        self.mdobtn.layer.cornerRadius = 3;
        self.mdobtn.layer.borderColor = M_CO.CGColor;
        self.mdobtn.layer.borderWidth = 0.5;
    }else if (mShop.mState == 12){
        
        
        mTT = @"已完成";
        
        
        self.mdobtn.enabled = NO;
        [self.mdobtn setTitle:mTT forState:0];
        [self.mdobtn setTitleColor:[UIColor lightGrayColor] forState:0];
        self.mdobtn.layer.masksToBounds = YES;
        self.mdobtn.layer.cornerRadius = 3;
        self.mdobtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.mdobtn.layer.borderWidth = 0.5;
        
    }else{
        
        if (mShop.mIsComment == 1) {
            mTT = @"已评价";
            
            self.mdobtn.enabled = NO;
            [self.mdobtn setTitle:mTT forState:0];
            [self.mdobtn setTitleColor:[UIColor lightGrayColor] forState:0];
            self.mdobtn.layer.masksToBounds = YES;
            self.mdobtn.layer.cornerRadius = 3;
            self.mdobtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            self.mdobtn.layer.borderWidth = 0.5;
        }else{
            mTT = @"待评价";

            self.mdobtn.enabled = YES;
            [self.mdobtn setTitle:mTT forState:0];
            [self.mdobtn setTitleColor:[UIColor redColor] forState:0];
            self.mdobtn.layer.masksToBounds = YES;
            self.mdobtn.layer.cornerRadius = 3;
            self.mdobtn.layer.borderColor = [UIColor redColor].CGColor;
            self.mdobtn.layer.borderWidth = 0.5;
        }
        

    }

}
@end
