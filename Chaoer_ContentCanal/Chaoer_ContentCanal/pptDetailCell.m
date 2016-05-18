//
//  pptDetailCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "pptDetailCell.h"

@implementation pptDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)layoutSubviews{

    self.mHeaderImg.layer.masksToBounds = self.mDoBtn.layer.masksToBounds = self.mBgkView.layer.masksToBounds =  YES;
    self.mHeaderImg.layer.cornerRadius = self.mDoBtn.layer.cornerRadius = self.mBgkView.layer.cornerRadius = 3;
    
    self.mBgkImg.layer.masksToBounds = YES;
    self.mBgkImg.layer.cornerRadius = 4;
    self.mBgkImg.layer.borderColor = [UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:0.45].CGColor;
    self.mBgkImg.layer.borderWidth = 0.5;

    
    
}
@end
