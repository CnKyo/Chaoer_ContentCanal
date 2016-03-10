//
//  wkOrderCell.m
//  O2O_JiazhengSeller
//
//  Created by 密码为空！ on 15/8/6.
//  Copyright (c) 2015年 zongyoutec.com. All rights reserved.
//

#import "wkOrderCell.h"
#import <MapKit/MapKit.h>
@implementation wkOrderCell
@synthesize cellHeight;
- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    [_wkServiceTime setText:[NSString stringWithFormat:@"下单时间：%@",_model.mCreateTime]];
    NSString *pricestr = [NSString stringWithFormat:@"%.2f",_model.mPrice];
    [_wkPrice hyb_setAttributedText:[NSString stringWithFormat:@"金额：¥<style color=#FF2D4B>%@</style><style color=#585858>元</style>",pricestr]];
    [_wkOrderStatus setText:_model.mOrderStatusStr];
    [_wkOrderId setText:[NSString stringWithFormat:@"订单号：%@",_model.mSn]];
    [_wkGoodsNum hyb_setAttributedText:[NSString stringWithFormat:@"共：<style color=#FF2D4B>%d</style><style color=#585858>件</style>", _model.mCount]];
    
    for( int j  = 0 ;j < 4 ; j++)
    {
        UIImageView* one = (UIImageView*)[_wkServiceImgView viewWithTag:j+1];
        
        if( j < _model.mImgs.count )
        {
            one.hidden = NO;
            [one sd_setImageWithURL:[NSURL URLWithString:_model.mImgs[j]] placeholderImage:[UIImage imageNamed:@"img_def"]];
        }
        else one.hidden = YES;
        
    }
    
    
}
@end
