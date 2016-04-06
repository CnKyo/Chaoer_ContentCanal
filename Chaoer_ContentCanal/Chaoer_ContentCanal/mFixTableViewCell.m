//
//  mFixTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/12.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mFixTableViewCell.h"
#import "ButtonItem.h"
@implementation mFixTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.mHeader = [UIImageView new];
        self.mHeader.layer.masksToBounds = YES;
        self.mHeader.layer.cornerRadius = self.mHeader.mwidth/2;
        [self addSubview:self.mHeader];
        
        self.mNameLb = [UILabel new];
        self.mNameLb.font = [UIFont systemFontOfSize:14];
        self.mNameLb.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.mNameLb];
        
        
        self.mPhoneLb = [UILabel new];
        self.mPhoneLb.font = [UIFont systemFontOfSize:12];
        self.mPhoneLb.textAlignment = NSTextAlignmentLeft;
        self.mPhoneLb.textColor = [UIColor colorWithRed:0.39 green:0.39 blue:0.39 alpha:1];
        [self addSubview:self.mPhoneLb];
        
        
        [self.mHeader makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(@15);
            make.right.equalTo(self.mPhoneLb.left).offset(@-15);
            make.right.equalTo(self.mNameLb.left).offset(@-15);
        
            make.top.equalTo(self).offset(@12);
            make.height.width.offset(@35);
        }];
        
        [self.mNameLb makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mHeader.right).offset(@-15);
            make.right.equalTo(self).offset(@15);
            make.top.equalTo(self).offset(@12);
            make.height.offset(@21);
        }];
        
        [self.mPhoneLb makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mHeader.right).offset(@-15);
            make.right.equalTo(self).offset(@15);
            make.top.equalTo(self.mNameLb).offset(@12);
            make.height.offset(@21);
        }];
        
    UIView *deleteView=[[UIView alloc]initWithFrame:CGRectMake(DEVICE_Width, 0, DEVICE_Width, 60)];
        deleteView.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:deleteView];
        ButtonItem *deleteBtn=[[ButtonItem alloc]initWithFrame:CGRectMake(5, 5, 50, 60) WithImageName:@"aboutus" WithImageWidth:50 WithImageHeightPercentInItem:.7 WithTitle:NSLocalizedString(@"DeleteOrder", nil) WithFontSize:14 WithFontColor:[UIColor blackColor] WithGap:-5];
        
        [deleteView addSubview:deleteBtn];
        
    }
    return self;
}  - (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
