//
//  mFoodShopCarCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mFoodShopCarCell.h"

@implementation mFoodShopCarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)mJianAction:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(WKFoodShopCarCellWithJianAction:)]) {
        [self.delegate WKFoodShopCarCellWithJianAction:sender.tag];
    }
    
}


- (IBAction)mAddAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(WKFoodShopCarCellWithAddAction:)]) {
        [self.delegate WKFoodShopCarCellWithAddAction:sender.tag];
    }
    
    
}

@end