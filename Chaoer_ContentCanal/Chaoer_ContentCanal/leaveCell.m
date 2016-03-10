//
//  leaveCell.m
//  O2O_XiCheSeller
//
//  Created by 王钶 on 15/6/24.
//  Copyright (c) 2015年 zongyoutec.com. All rights reserved.
//

#import "leaveCell.h"

@implementation leaveCell

- (void)awakeFromNib {
    // Initialization code
    
    self.mLine.layer.masksToBounds = YES;
    self.mLine.layer.borderColor = M_TextColor2.CGColor;
    self.mLine.layer.borderWidth = 0.2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
