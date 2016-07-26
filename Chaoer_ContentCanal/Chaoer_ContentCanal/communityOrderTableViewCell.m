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
    
    
    self.mdobtn.layer.masksToBounds = YES;
    self.mdobtn.layer.cornerRadius = 3;
    self.mdobtn.layer.borderColor = M_CO.CGColor;
    self.mdobtn.layer.borderWidth = 0.5;
    
    [self.mdobtn addTarget:self action:@selector(mBtnAction:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)mBtnAction:(UIButton *)sender{

    if ([self.delegate respondsToSelector:@selector(cellWithBtnClickAction:)]) {
        [self.delegate cellWithBtnClickAction:self.mShop];
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

}
@end
