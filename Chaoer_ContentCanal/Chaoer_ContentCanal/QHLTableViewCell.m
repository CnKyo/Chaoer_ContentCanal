
//
//  QHLTableViewCell.m
//  shoppingCar
//
//  Created by Apple on 16/1/12.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "QHLTableViewCell.h"
#import "QHLButton.h"
#import "UIView+QHLExtension.h"

@interface QHLTableViewCell ()
@property (nonatomic, weak) QHLButton *selBtn;
@property (nonatomic, weak) QHLButton *mDeleteBtn;

@property (nonatomic, weak) UILabel *introduction;
@property (nonatomic, weak) UILabel *price;
@property (nonatomic, weak) UILabel *name;

@end

@implementation QHLTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"shopping_cell";
    
    QHLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[QHLTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置cell可交互
        self.contentView.userInteractionEnabled = YES;
        
        //创建选择按钮
        [self setUpSelectedBtn];
        
        //创建icon
        [self setUpIconImageView];
        
        //创建name
        [self setUpNameLabel];
        
        //创建introduction
        [self setUpIntroLabel];
        
        //创建price
        [self setUpPriceLabel];
    }
    return self;
}
#pragma mark - 创建选择按钮
- (void)setUpSelectedBtn {
    QHLButton *selBtn = [[QHLButton alloc] init];
    
    [self.contentView addSubview:selBtn];
    self.selBtn = selBtn;
    
    selBtn.indexPath = self.indexPath;
    
    //设置圆角
    selBtn.layer.cornerRadius = 10;
    selBtn.layer.masksToBounds = YES;
    //frame
    selBtn.x = 10;
    selBtn.y = 20;
    selBtn.width = 20;
    selBtn.height = 20;
    
    //背景图
    [selBtn setBackgroundImage:[UIImage imageNamed:@"ppt_add_address_normal"] forState:UIControlStateNormal];
    [selBtn setBackgroundImage:[UIImage imageNamed:@"ppt_add_address_selected"] forState:UIControlStateSelected];
    //点击方法
    [selBtn addTarget:self action:@selector(selBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    QHLButton *DeleteBtn = [QHLButton new];
    [self.contentView addSubview:DeleteBtn];
    self.mDeleteBtn = DeleteBtn;
    DeleteBtn.indexPath = self.indexPath;
    [DeleteBtn setBackgroundImage:[UIImage imageNamed:@"shopcar_delete"] forState:0];
    [DeleteBtn setTitleColor:[UIColor whiteColor] forState:0];
    //frame
    DeleteBtn.x = self.contentView.frame.size.width+20;
    DeleteBtn.y = 15;
    DeleteBtn.width = 20;
    DeleteBtn.height = 20;
    //点击方法
    [DeleteBtn addTarget:self action:@selector(deleteBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

#pragma mark - 选择按钮的点击事件
- (void)selBtnDidClick:(QHLButton *)selBtn {
    if ([self.cellDelegate respondsToSelector:@selector(cell:selBtnDidClickToChangeAllSelBtn:andIndexPath:)]) {
        [self.cellDelegate cell:self selBtnDidClickToChangeAllSelBtn:selBtn.selected andIndexPath:self.indexPath];
    }
}
#pragma mark - 删除按钮的点击事件
- (void)deleteBtnDidClick:(QHLButton *)sender{
    if ([self.cellDelegate respondsToSelector:@selector(cell:deleteBtnDidClicked:andIndexPath:)]) {
        [self.cellDelegate cell:self deleteBtnDidClicked:sender.selected andIndexPath:self.indexPath];
    }
}
#pragma mark - 设置icon
- (void)setUpIconImageView {
    UIImageView *imgView = [[UIImageView alloc] init];
    
    [self.contentView addSubview:imgView];
    self.imgView = imgView;
    
    //frame
    imgView.x = CGRectGetMaxX(self.selBtn.frame) + 10;
    imgView.y = 10;
    imgView.width = 50;
    imgView.height = 50;
    imgView.image = [UIImage imageNamed:@"default.jpeg"];
    
}
#pragma mark - 设置introduction
- (void)setUpIntroLabel {
    UILabel *introduction = [[UILabel alloc] init];
    
    [self.contentView addSubview:introduction];
    self.introduction = introduction;
    
    //frame
    introduction.x = CGRectGetMaxX(self.imgView.frame) + 10;
    introduction.y = 40;
    introduction.width = 200;
    introduction.height = 20;
}

#pragma mark - 设置price
- (void)setUpPriceLabel {
    UILabel *price = [[UILabel alloc] init];
    price.textColor = [UIColor redColor];
    [self.contentView addSubview:price];
    self.price = price;
    
    //frame
    price.x = CGRectGetMaxX(self.introduction.frame) + 10;
    price.y = 55;
    price.width = 50;
    price.height = 20;
    
    UIView *line = [UIView new];
    line.x = 10;
    line.y = 84;
    line.width = DEVICE_Width-10;
    line.height = 0.5;
    line.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:0.75];
    [self.contentView addSubview:line];
    
}

- (void)setUpNameLabel {
    UILabel *name = [[UILabel alloc] init];
    
    [self.contentView addSubview:name];
    self.name = name;
    
    //frame
    name.x = CGRectGetMaxX(self.imgView.frame) + 10;
    name.y = 10;
    name.width = 100;
    name.height = 30;
    
    
}


- (void)setGoods:(QHLGoods *)goods {
    _goods = goods;
    
    //设置cell中的子控件数据
    self.selBtn.selected = goods.selected;
    self.selBtn.tag = [goods.tag intValue];
    self.introduction.text = goods.introduction;
    self.price.text = [NSString stringWithFormat:@"￥:%d",[goods.price intValue]];
    self.name.text = goods.name;
    
}

@end
