//
//  mCampTionTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mCampTionTableViewCell.h"

@implementation mCampTionTableViewCell

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
    self.mCampName.layer.masksToBounds = YES;
    self.mCampName.layer.cornerRadius = 3;
}


@end
