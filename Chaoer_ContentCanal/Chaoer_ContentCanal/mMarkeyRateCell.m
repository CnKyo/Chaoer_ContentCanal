//
//  mMarkeyRateCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/12.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mMarkeyRateCell.h"

@implementation mMarkeyRateCell

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
    [self.mRateTx setHolderToTop];
    [self.mRateTx setPlaceholder:@"请留下您宝贵的评价!"];
}
@end
