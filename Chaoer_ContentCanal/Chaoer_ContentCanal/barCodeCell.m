//
//  barCodeCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/5.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "barCodeCell.h"

@implementation barCodeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews{

    self.mMainView.layer.masksToBounds = self.mSmallView.layer.masksToBounds = YES;
    self.mMainView.layer.cornerRadius = self.mSmallView.layer.cornerRadius = 5;
    
    self.mHeader.layer.masksToBounds = YES;
    self.mHeader.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
