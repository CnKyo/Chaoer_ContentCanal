//
//  pptHistoryTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/13.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "pptHistoryTableViewCell.h"

@implementation pptHistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews{

    self.mImg.layer.masksToBounds = YES;
    self.mImg.layer.cornerRadius = 3;
    
    self.mRateBtn.layer.masksToBounds = YES;
    self.mRateBtn.layer.cornerRadius = 3;
    self.mRateBtn.layer.borderColor = M_CO.CGColor;
    self.mRateBtn.layer.borderWidth = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
