//
//  WKOrderCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "WKOrderCell.h"


@implementation WKOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{

    static NSString *mID  = @"WKCell";
    
    WKOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:mID];
    
    if (!cell) {
        cell = [[WKOrderCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.userInteractionEnabled = YES;
        [self initView];
    }
    return self;
}

- (void)initView{

    /**
     *  按钮
     */
    QHLButton *mSelBtn = [QHLButton new];
    self.mBtn = mSelBtn;
    
    //背景图
    [mSelBtn setBackgroundImage:[UIImage imageNamed:@"ppt_add_address_normal"] forState:UIControlStateNormal];
    [mSelBtn setBackgroundImage:[UIImage imageNamed:@"ppt_add_address_selected"] forState:UIControlStateSelected];
    //点击方法
    [mSelBtn addTarget:self action:@selector(mSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:mSelBtn];
    
    /**
     *  图片
     */
    UIImageView *mImage = [UIImageView new];
    self.mImgView = mImage;
    [self.contentView addSubview:mImage];
    
    UILabel *mName = [UILabel new];
    mName.font = [UIFont systemFontOfSize:15];
    self.mName = mName;
    [self.contentView addSubview:mName];
    
    UILabel *mContent = [UILabel new];
    mContent.font = [UIFont systemFontOfSize:14];
    self.mContent = mContent;
    [self.contentView addSubview:mContent];
    
    UILabel *mPrice = [UILabel new];
    mPrice.font = [UIFont systemFontOfSize:13];

    self.mPrice = mPrice;
    [self.contentView addSubview:mPrice];
    
    UIView *mLine = [UIView new];
    mLine.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:0.75];
    self.mLine = mLine;
    
    [self.contentView addSubview:mLine];

//    mName.backgroundColor =   [UIColor redColor];
//    mContent.backgroundColor =[UIColor redColor];
//    mPrice.backgroundColor =[UIColor redColor];
    [mSelBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(@10);
        make.top.equalTo(self.contentView).offset(@30);
        make.width.height.offset(@20);
    }];
    
    [mImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mSelBtn.right).offset(@10);
        make.top.equalTo(self.contentView).offset(@10);
        make.width.height.offset(@60);

    }];
    
    [mName makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mImage.right).offset(@10);
        make.top.equalTo(self.contentView).offset(@5);
        make.bottom.equalTo(mContent.top).offset(@-5);

        make.right.equalTo(self.contentView.right).offset(-5);
        make.height.offset(25);
    }];
    
    [mContent makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mImage.right).offset(@10);
        make.top.equalTo(mName.bottom).offset(@5);
        make.bottom.equalTo(mPrice.top).offset(@-5);

        make.right.equalTo(self.contentView.right).offset(-5);
        make.height.offset(20);
    }];

    [mPrice makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mImage.right).offset(@10);
        make.top.equalTo(mContent.bottom).offset(@5);

        make.right.equalTo(self.contentView.right).offset(-5);
        make.height.offset(20);

        
    }];
    
    [mLine makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).offset(@0);
        make.bottom.equalTo(self.contentView.bottom).offset(-0.5);
        make.height.offset(0.5);
        
    }];
    
}
- (void)mSelectAction:(QHLButton *)sender{

    if ([self.WKCellDelegate respondsToSelector:@selector(cell:cellDidSelected:andIndexPath:)]) {
        [self.WKCellDelegate cell:self cellDidSelected:sender.selected andIndexPath:self.indexPath];

    }
}
- (void)setGoods:(QHLGoods *)goods{

    _goods = goods;
    
    //设置cell中的子控件数据
    self.mBtn.selected = goods.selected;
    self.mBtn.tag = [goods.tag intValue];
    self.mContent.text = goods.introduction;
    self.mPrice.text = [NSString stringWithFormat:@"￥:%d",[goods.price intValue]];
    self.mName.text = goods.name;
    
}

@end
