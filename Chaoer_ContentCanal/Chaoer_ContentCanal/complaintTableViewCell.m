//
//  complaintTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "complaintTableViewCell.h"

@implementation complaintTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{

    [self.mContent setPlaceholder:@"请输入您要投诉的内容"];
    [self.mContent setHolderToTop];
}

@end