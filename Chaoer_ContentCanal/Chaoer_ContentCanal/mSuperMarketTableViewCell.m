//
//  mSuperMarketTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/12.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mSuperMarketTableViewCell.h"

@implementation mSuperMarketTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)layoutSubviews{


    _mLeftLogo.layer.masksToBounds = _mRightLogo.layer.masksToBounds = YES;
    _mLeftLogo.layer.cornerRadius = _mRightLogo.layer.cornerRadius = 3;
    
    
    _mLaddBtn.layer.masksToBounds = _mRaddbtn.layer.masksToBounds = YES;
    _mLaddBtn.layer.cornerRadius = _mRaddbtn.layer.cornerRadius = _mRaddbtn.mwidth/2;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
