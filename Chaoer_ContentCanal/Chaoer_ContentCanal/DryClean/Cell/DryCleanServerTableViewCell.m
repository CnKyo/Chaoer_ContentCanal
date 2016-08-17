//
//  DryCleanServerTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "DryCleanServerTableViewCell.h"

@implementation DryCleanServerTableViewCell


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
        
        self.priceLable = [superView newUILableWithText:@"" textColor:[UIColor redColor] font:font];
        
        self.jianBtn = [superView newUIButtonWithTarget:self mehotd:@selector(jianCountMethod:) bgImgNormal:IMG(@"icon_headerdefault.png")];
        self.countLable = [superView newUILableWithText:@"" textColor:[UIColor blackColor] font:font textAlignment:QU_TextAlignmentCenter];
        self.addBtn = [superView newUIButtonWithTarget:self mehotd:@selector(addCountMethod:) bgImgNormal:IMG(@"icon_headerdefault.png")];
        
        [self.thumbImgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.left).offset(padding);
            make.top.equalTo(superView.top).offset(padding/2);
            make.bottom.equalTo(superView.bottom).offset(-padding/2);
            make.width.equalTo(_thumbImgView.mas_height).multipliedBy(0.8);
        }];
        [self.nameLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_thumbImgView.right).offset(padding/2);
            make.top.equalTo(_thumbImgView.mas_top);
            make.bottom.equalTo(_thumbImgView.mas_centerY);
        }];
        [self.priceLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_nameLable);
            make.top.equalTo(_thumbImgView.mas_centerY);
            make.bottom.equalTo(_thumbImgView.mas_bottom);
        }];
        
        [self.addBtn makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(18);
            make.right.equalTo(superView.right).offset(-padding);
            make.centerY.equalTo(superView.centerY);
        }];
        [self.countLable makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(30);
            make.right.equalTo(_addBtn.left);
            make.top.bottom.equalTo(_addBtn);
        }];
        [self.jianBtn makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.centerY.equalTo(_addBtn);
            make.right.equalTo(_countLable.left);
            make.left.greaterThanOrEqualTo(_nameLable.right).offset(padding/2);
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


-(void)jianCountMethod:(UIButton *)sender
{
    
}


-(void)addCountMethod:(UIButton *)sender
{
    
}

@end
