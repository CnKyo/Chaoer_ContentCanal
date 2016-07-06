//
//  mFixOrderDetailTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/6.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mFixOrderDetailTableViewCell.h"

@implementation mFixOrderDetailTableViewCell

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
    self.mConnectBtn.layer.masksToBounds = YES;
    self.mConnectBtn.layer.cornerRadius = 3;
    self.mConnectBtn.layer.borderColor = M_CO.CGColor;
    self.mConnectBtn.layer.borderWidth = 0.5;
}
@end
