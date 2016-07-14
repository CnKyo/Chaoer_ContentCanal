//
//  mComfirmOrderCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mComfirmOrderCell.h"

@implementation mComfirmOrderCell

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
    
    [self.mcheckProduct addTarget:self action:@selector(mCheckAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mSendTypeBtn addTarget:self action:@selector(mSendAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mCoupBtn addTarget:self action:@selector(mCoupAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mNoteBtn addTarget:self action:@selector(mNoteAction:) forControlEvents:UIControlEventTouchUpInside];

    
}
- (void)mCheckAction:(UIButton *)sender{
    if ([self.cellDelegate respondsToSelector:@selector(cellDidCheckImage:andIndex:)]) {
        [self.cellDelegate cellDidCheckImage:self andIndex:self.indexPath];
    }
    
}
- (void)mSendAction:(UIButton *)sender{
    
    if ([self.cellDelegate respondsToSelector:@selector(cellDidChioceSendType:andIndex:)]) {
        [self.cellDelegate cellDidChioceSendType:self andIndex:self.indexPath];
    }
    
    
}
- (void)mCoupAction:(UIButton *)sender{
    if ([self.cellDelegate respondsToSelector:@selector(cellDidSelectedCoup:andIndex:)]) {
        [self.cellDelegate cellDidSelectedCoup:self andIndex:self.indexPath];
    }
    
}
- (void)mNoteAction:(UIButton *)sender{
    if ([self.cellDelegate respondsToSelector:@selector(cellDidMessageNote:andIndex:)]) {
        [self.cellDelegate cellDidMessageNote:self andIndex:self.indexPath];
    }
    
}
@end
