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

    self.mLogo.layer.masksToBounds = YES;
    self.mLogo.layer.cornerRadius = self.mLogo.mwidth/2;
    
    self.mPayBtn.layer.masksToBounds = self.mEvolutionBtn.layer.masksToBounds = YES;
    self.mPayBtn.layer.cornerRadius = self.mEvolutionBtn.layer.cornerRadius = 3;
    self.mPayBtn.layer.borderColor = self.mEvolutionBtn.layer.borderColor = [UIColor colorWithRed:0.77 green:0.77 blue:0.77 alpha:1].CGColor;
    self.mPayBtn.layer.borderWidth = self.mEvolutionBtn.layer.borderWidth = 0.5;
    
    
    
    self.mLeftBtn.layer.masksToBounds = self.mRightBtn.layer.masksToBounds = YES;
    self.mLeftBtn.layer.cornerRadius = self.mRightBtn.layer.cornerRadius = 4;
    self.mLeftBtn.layer.borderColor = [UIColor colorWithRed:0.95 green:0.27 blue:0.29 alpha:1.00].CGColor;
    self.mRightBtn.layer.borderColor = [UIColor colorWithRed:0.91 green:0.54 blue:0.22 alpha:1.00].CGColor;

    self.mLeftBtn.layer.borderWidth = self.mRightBtn.layer.borderWidth = 0.5;
    
    
    
    
    
    
}
@end
