//
//  choiseServicerTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/23.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "choiseServicerTableViewCell.h"

@implementation choiseServicerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)layoutSubviews{
    self.mHeader.layer.masksToBounds = YES;
    self.mHeader.layer.cornerRadius = 2.5;
    
    self.mDoneBtn.layer.masksToBounds = YES;
    self.mDoneBtn.layer.cornerRadius = 3;
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
