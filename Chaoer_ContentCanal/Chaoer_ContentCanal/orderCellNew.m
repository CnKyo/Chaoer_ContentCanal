//
//  orderCellNew.m
//  O2O_Communication_seller
//
//  Created by zzl on 15/11/23.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "orderCellNew.h"

@implementation orderCellNew

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    UIColor* tttc = [UIColor colorWithRed:219/255.0f green:219/255.0f blue:219/255.0f alpha:1];
    
    self.mwarper.layer.cornerRadius = 5;
    self.mwarper.layer.borderColor  = [UIColor lightGrayColor].CGColor;
    self.mwarper.layer.borderWidth  = 1.0f;
    
    self.mNumId.text        = [NSString stringWithFormat:@"#%d",self.model.mId];
    self.mOrderTime.text    = [NSString stringWithFormat:@"下单时间:%@",self.model.mCreateTime];
    self.mShopName.text     = self.model.mShopName;
    self.mOrderStatus.text  = self.model.mOrderStatusStr;
    self.mPayStatus.text    = self.model.mPayStatusStr;
    
    NSString* money = [NSString stringWithFormat:@"%.2f",self.model.mPayFee];
    NSString* ostr = [NSString stringWithFormat:@"实收:￥%@元(含配送费)",money];
                      
    NSMutableAttributedString*  str = [[NSMutableAttributedString alloc]initWithString:ostr];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range: [ostr rangeOfString:money]];
    self.mPayInfo.attributedText=  str;
    
    if( !self.model.mIsFinished  )
    {
        self.mtopbgview.backgroundColor = tttc;
        self.mOrderTime.textColor = self.mNumId.textColor = [UIColor colorWithRed:179/255.0f green:179/255.0f blue:179/255.0f alpha:1];
    }
    else
    {
        self.mtopbgview.backgroundColor = [UIColor redColor];
        self.mNumId.textColor = [UIColor redColor];
        self.mOrderTime.textColor = [UIColor redColor];
    }
    
}

@end
