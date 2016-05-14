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

    
    
}
@end
