//
//  communityStatusTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/13.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "communityStatusTableViewCell.h"

@implementation communityStatusTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews{

    self.mImage.layer.masksToBounds = YES;
    self.mImage.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
