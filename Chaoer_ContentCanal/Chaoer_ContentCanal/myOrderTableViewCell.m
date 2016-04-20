//
//  myOrderTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "myOrderTableViewCell.h"

@implementation myOrderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)layoutSubviews{
    
    
    self.mLeftBtn.layer.masksToBounds = self.mRightBtn.layer.masksToBounds = YES;
    self.mLeftBtn.layer.cornerRadius = self.mRightBtn.layer.cornerRadius = 4;
    self.mLeftBtn.layer.borderColor = [UIColor colorWithRed:0.95 green:0.27 blue:0.29 alpha:1.00].CGColor;
    self.mRightBtn.layer.borderColor = [UIColor colorWithRed:0.91 green:0.54 blue:0.22 alpha:1.00].CGColor;

    self.mLeftBtn.layer.borderWidth = self.mRightBtn.layer.borderWidth = 0.5;
    
    
    self.mImage1.layer.masksToBounds = YES;
    self.mImage1.layer.cornerRadius = 3;
    
    
    
    
    
}
@end
