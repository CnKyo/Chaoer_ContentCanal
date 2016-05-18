//
//  pptTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "pptTableViewCell.h"

@implementation pptTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews{

    self.mHeader.layer.masksToBounds = YES;
    self.mHeader.layer.cornerRadius = 3;
    
    
    self.mDoneBtn.layer.masksToBounds = YES;
    self.mDoneBtn.layer.cornerRadius = 3;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
