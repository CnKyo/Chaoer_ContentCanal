//
//  DryCleanOrderSubmitTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "DryCleanOrderSubmitTableViewCell.h"

@implementation DryCleanOrderSubmitTableViewCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self.contentView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        self.backgroundColor = [UIColor colorWithRed:0.996 green:1.000 blue:1.000 alpha:1.000];
        
        float padding = 10;
        UIFont *font = [UIFont systemFontOfSize:15];
        UIView *superView = self.contentView;
        
        self.thumbImgView = [superView newUIImageViewWithImg:IMG(@"DefaultImg.png")];
        self.nameLable = [superView newUILableWithText:@"" textColor:[UIColor blackColor] font:font];
        self.countLable = [superView newUILableWithText:@"" textColor:[UIColor blackColor] font:font];
        self.priceLable = [superView newUILableWithText:@"" textColor:[UIColor redColor] font:font textAlignment:QU_TextAlignmentRight];
        
        [self.thumbImgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(padding);
            make.top.equalTo(superView.top).offset(padding/2);
            make.bottom.equalTo(superView.bottom).offset(-padding/2);
            make.width.equalTo(_thumbImgView.mas_height);
        }];
        [self.nameLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_thumbImgView.right).offset(padding/2);
            make.top.equalTo(_thumbImgView.mas_top);
            make.bottom.equalTo(_thumbImgView.mas_centerY);
        }];
        [self.countLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_nameLable);
            make.top.equalTo(_thumbImgView.mas_centerY);
            make.bottom.equalTo(_thumbImgView.mas_bottom);
        }];
        [self.priceLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.greaterThanOrEqualTo(_nameLable.right).offset(padding/2);
            make.right.equalTo(superView.right).offset(-padding);
            make.top.bottom.equalTo(superView);
        }];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
