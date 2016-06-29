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

@end
