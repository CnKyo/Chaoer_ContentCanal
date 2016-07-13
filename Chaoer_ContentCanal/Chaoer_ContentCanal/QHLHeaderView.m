//
//  QHLHeaderView.m
//  shoppingCar
//
//  Created by Apple on 16/1/12.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "QHLHeaderView.h"
#import "QHLButton.h"
#import "UIView+QHLExtension.h"

@interface QHLHeaderView ()
@property (nonatomic, weak) QHLButton *selBtn;
@property (nonatomic, weak) UILabel *name;
@property (nonatomic, weak) UILabel *introduction;
@property (nonatomic, weak) UIView *mLine;

@end

@implementation QHLHeaderView

+ (instancetype)headerWithTableView:(UITableView *)tableView {
    static NSString *ID = @"headerView";
    QHLHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    if (!headerView) {
        headerView = [[QHLHeaderView alloc] initWithReuseIdentifier:ID];
    }
    
    headerView.contentView.backgroundColor = [UIColor whiteColor];
    return headerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        //设置cell可交互
        self.contentView.userInteractionEnabled = YES;
        
        //创建选择按钮
        [self setUpSelectedBtn];
        
        //创建icon
        [self setUpIconImageView];
        
        //创建introduction
        [self setUpIntroLabel];
        
        //创建name
        [self setUpNameLabel];
    }
    return self;
}



#pragma mark - 创建选择按钮
- (void)setUpSelectedBtn {
    QHLButton *selBtn = [[QHLButton alloc] init];
    self.selBtn = selBtn;
    
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
    
    [self.contentView addSubview:selBtn];
}

#pragma mark - 选择按钮的点击事件
- (void)selBtnDidClick:(QHLButton *)selBtn {
    if ([self.headerViewDelegate respondsToSelector:@selector(headerView:selBtnDidClickToChangeAllSelBtn:andSection:)]) {
        [self.headerViewDelegate headerView:self selBtnDidClickToChangeAllSelBtn:selBtn.selected andSection:self.section];
    }
    
}

#pragma mark - 设置icon
- (void)setUpIconImageView {
    UIImageView *imgView = [[UIImageView alloc] init];
    self.imgView = imgView;
    //frame
    imgView.x = CGRectGetMaxX(self.selBtn.frame) + 15;
    imgView.y = 15;
    imgView.width = 30;
    imgView.height = 30;
    //image
    imgView.image = [UIImage imageNamed:@"default_portrait"];
    
    [self.contentView addSubview:imgView];
}

#pragma mark - 设置name
- (void)setUpNameLabel {
    UILabel *name = [[UILabel alloc] init];
    self.name = name;
    //frame
    name.x = CGRectGetMaxX(self.imgView.frame) + 10;
    name.y = 10;
    name.width = 80;
    name.height = 25;
    
    [self.contentView addSubview:name];
}



#pragma mark - 设置introduction
- (void)setUpIntroLabel {
    UILabel *introduction = [[UILabel alloc] init];
    self.introduction = introduction;
    //frame
    introduction.x = CGRectGetMaxX(self.imgView.frame) + 10;
    introduction.y = 40;
    introduction.width = 200;
    introduction.height = 15;
    
    [self.contentView addSubview:introduction];
    [self initLine];

    
}
- (void)initLine{
    UIView *line = [UIView new];
    self.mLine = line;
    line.x = 0;
    line.y = 59;
    line.width = DEVICE_Width;
    line.height = 0.5;
    line.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:0.75];
    [self.contentView addSubview:line];
}
- (void)setShop:(QHLShop *)shop {
    _shop = shop;
    
    //设置数据
    self.selBtn.selected = shop.selected;
    self.selBtn.tag = [shop.tag intValue];
    self.name.text = shop.name;
    self.introduction.text = shop.introduction;
}


@end
