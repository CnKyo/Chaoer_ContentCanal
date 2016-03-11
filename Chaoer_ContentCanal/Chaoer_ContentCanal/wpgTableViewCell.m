//
//  wpgTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "wpgTableViewCell.h"

@implementation wpgTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)layoutSubviews{
    _mLogo.layer.masksToBounds = YES;
    _mLogo.layer.cornerRadius = _mLogo.mwidth/2;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
