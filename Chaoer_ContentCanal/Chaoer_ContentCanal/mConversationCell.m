//
//  mConversationCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/28.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mConversationCell.h"

@implementation mConversationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)layoutSubviews{

    self.mHeaderImg.layer.masksToBounds = YES;
    self.mHeaderImg.layer.cornerRadius  = 3;
    
    self.mBage.layer.masksToBounds = YES;
    self.mBage.layer.cornerRadius = self.mBage.mwidth/2;
    
}

@end
