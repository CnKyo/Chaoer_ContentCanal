//
//  mCommunityMyViewCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/24.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mCommunityMyViewCell.h"

@implementation mCommunityMyViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{

    self.mImg.layer.masksToBounds = YES;
    self.mImg.layer.cornerRadius = 3;
    
//    self.mLeftImg.layer.masksToBounds = self.mRightImg.layer.masksToBounds = YES;
//    self.mLeftImg.layer.cornerRadius = self.mRightImg.layer.cornerRadius = 3;
//    
//    self.mLeftView.layer.masksToBounds = self.mRightView.layer.masksToBounds = YES;
//    self.mLeftView.layer.cornerRadius = self.mLeftView.layer.cornerRadius = 3;
//    self.mLeftView.layer.borderColor = self.mLeftView.layer.borderColor = [UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1.00].CGColor;
//    
//    self.mLeftView.layer.borderWidth = self.mLeftView.layer.borderWidth = 0.75;

    
    
    
    
}


@end
