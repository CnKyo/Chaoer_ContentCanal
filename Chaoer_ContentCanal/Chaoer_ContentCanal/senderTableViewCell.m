//
//  senderTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/6.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "senderTableViewCell.h"

@implementation senderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)layoutSubviews{

    self.mCancelBtn.layer.masksToBounds = self.mFinishBtn.layer.masksToBounds = YES;
    self.mCancelBtn.layer.cornerRadius = self.mFinishBtn.layer.cornerRadius = 3;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
