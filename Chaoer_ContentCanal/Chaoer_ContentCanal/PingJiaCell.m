//
//  PingJiaCell.m
//  XiCheBuyer
//
//  Created by 周大钦 on 15/7/17.
//  Copyright (c) 2015年 zdq. All rights reserved.
//

#import "PingJiaCell.h"

@implementation PingJiaCell

- (void)awakeFromNib {
    // Initialization code
    _mReplyBT.layer.borderColor = M_CO.CGColor;
    _mReplyBT.layer.borderWidth = 1;
    _mReplyBT.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
