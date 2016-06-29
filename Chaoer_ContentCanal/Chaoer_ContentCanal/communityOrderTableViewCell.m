//
//  communityOrderTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/24.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "communityOrderTableViewCell.h"

@implementation communityOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{


    self.mLogo.layer.masksToBounds = YES;
    self.mLogo.layer.cornerRadius = 3;
    
    
    self.mdobtn.layer.masksToBounds = YES;
    self.mdobtn.layer.cornerRadius = 3;
    self.mdobtn.layer.borderColor = M_CO.CGColor;
    self.mdobtn.layer.borderWidth = 0.5;

}

@end
