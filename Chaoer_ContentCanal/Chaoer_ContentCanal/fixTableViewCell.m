//
//  fixTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/21.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "fixTableViewCell.h"

@implementation fixTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{

    self.mImg.layer.masksToBounds = YES;
    self.mImg.layer.cornerRadius = 3;
    
    self.mBgk1.layer.masksToBounds =     self.mBgk2.layer.masksToBounds = YES;
    
    self.mBgk1.layer.cornerRadius =     self.mBgk2.layer.cornerRadius = 3;

}

@end
