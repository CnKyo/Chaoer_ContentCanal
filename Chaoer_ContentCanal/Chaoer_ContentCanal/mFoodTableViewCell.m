//
//  mFoodTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mFoodTableViewCell.h"

@implementation mFoodTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
//    self.mJianBtn.layer.masksToBounds = self.mAddBtn.layer.masksToBounds = YES;
//    self.mJianBtn.layer.cornerRadius = self.mAddBtn.layer.cornerRadius = self.mAddBtn.mwidth/2;
    
    
    
}

- (IBAction)mJianAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(WKFoodCellWithJianBtnClickWithIndexPath:andTag:)]) {
        [self.delegate WKFoodCellWithJianBtnClickWithIndexPath:self.mIndexPath andTag:sender.tag];

    }
}

- (IBAction)mAddAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(WKFoodCellWithAddBtnClickWithIndexPath:andTag:)]) {
        [self.delegate WKFoodCellWithAddBtnClickWithIndexPath:self.mIndexPath andTag:sender.tag];
    }
    
}


@end
