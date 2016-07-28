//
//  communityOrderDetailCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/29.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "communityOrderDetailCell.h"

@implementation communityOrderDetailCell

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
    
    self.mbgkView2.layer.masksToBounds = self.mBgk.layer.masksToBounds = self.mBgkView1.layer.masksToBounds = self.mCheckBtn.layer.masksToBounds = YES;
    self.mbgkView2.layer.cornerRadius = self.mBgk.layer.cornerRadius = self.mBgkView1.layer.cornerRadius = self.mCheckBtn.layer.cornerRadius = 3;
    
}


- (void)setMGoodInfo:(GMyOrderGoodsA *)mGoodInfo{

    NSDictionary *mStyle1 = @{@"color": [UIColor redColor]};

    [self.mGoodsImg sd_setImageWithURL:[NSURL URLWithString:mGoodInfo.mGoodsImg] placeholderImage:[UIImage imageNamed:@"img_default"]];
    self.mGoodsName.text = mGoodInfo.mGoodsName;
    self.mTotleMoney.attributedText = [[NSString stringWithFormat:@"商品金额:<color>¥%.2f</color>  数量:<color> X %d</color>",mGoodInfo.mUnitPrice,mGoodInfo.mNum] attributedStringWithStyleBook:mStyle1];
    self.mGoodsDetail.text = mGoodInfo.mGoodsComment;
    
    self.mGoodsDetailH.constant = [Util labelText:mGoodInfo.mGoodsComment fontSize:13 labelWidth:self.mGoodsDetail.mwidth];
    
}

- (void)setMOrderInfo:(GMyMarketOrderInfo *)mOrderInfo{
    NSDictionary *mStyle1 = @{@"color": [UIColor redColor],@"font":[UIFont systemFontOfSize:18]};

    self.mOrderAddress.text = mOrderInfo.mAddress;
    
    NSString *mS = nil;
    
    if (mOrderInfo.mState == 10) {
        mS = @"待支付";
        self.mCheckBtn.hidden = YES;
    }else if(mOrderInfo.mState == 11){
        mS = @"进行中";
        self.mCheckBtn.hidden = YES;
    }else if (mOrderInfo.mState == 12){
        mS = @"已完成";
        self.mCheckBtn.hidden = YES;
    }else{
        
        if (mOrderInfo.mIsComment == 1) {
            mS = @"已评价";
        }else{
            mS = @"待评价";
        }
        
        
        self.mCheckBtn.hidden = YES;
    }
    
    self.mOrderStatus.attributedText = [[NSString stringWithFormat:@"订单状态:  <color><font>%@</font></color>",mS] attributedStringWithStyleBook:mStyle1];
    
    self.mOrderCode.text = [NSString stringWithFormat:@"订单编号:%@",mOrderInfo.mOrderCode];
    
    self.mCreateTime.text = [NSString stringWithFormat:@"下单时间:%@",mOrderInfo.mAddTime];
    
    
}

@end
