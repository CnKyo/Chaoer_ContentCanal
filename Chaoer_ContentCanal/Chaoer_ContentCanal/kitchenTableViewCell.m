//
//  kitchenTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/6.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "kitchenTableViewCell.h"

@implementation kitchenTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{

    self.mBgkImg.layer.masksToBounds = YES;
    self.mBgkImg.layer.cornerRadius = 3;
}

@end
