//
//  wAndSTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "wAndSTableViewCell.h"

@implementation wAndSTableViewCell

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
    
    
    self.mDelBtn.layer.masksToBounds = self.mAddBtn.layer.masksToBounds = YES;
    self.mDelBtn.layer.cornerRadius = self.mAddBtn.layer.cornerRadius = self.mAddBtn.mwidth/2;
}
@end
