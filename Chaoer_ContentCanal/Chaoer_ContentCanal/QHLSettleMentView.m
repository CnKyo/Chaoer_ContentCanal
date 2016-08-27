
//
//  QHLSettleMentView.m
//  shoppingCar
//
//  Created by Apple on 16/1/28.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "QHLSettleMentView.h"
#import "QHLButton.h"
#import "UIView+QHLExtension.h"

@interface QHLSettleMentView ()

@property (nonatomic, weak) QHLButton *allSelBtn;
@property (nonatomic, weak) UILabel *totalLbl;
@property (nonatomic, weak) QHLButton *checkOutBtn;
@property (nonatomic, weak) UILabel *allSelLbl;


@end

@implementation QHLSettleMentView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        self.alpha = 0.6;
        
        //添加全选按钮
        [self setUpAllSelectedBtnWithView];
        
        //添加全选label
        [self setUpAllSelectedLabelWithView];
        
        //添加合计label
        [self setUpTotalLabelWithView];
        
        //添加结算btn
        [self setUpCheckOutBtnWithView];
    }
    return self;
}

#pragma mark - 添加全选按钮
- (void)setUpAllSelectedBtnWithView {
    QHLButton *allSelBtn = [[QHLButton alloc] init];
    
    //圆角
    allSelBtn.layer.cornerRadius = 10;
    allSelBtn.layer.masksToBounds = YES;
    //背景图
    [allSelBtn setBackgroundImage:[UIImage imageNamed:@"ppt_add_address_normal"] forState:UIControlStateNormal];
    [allSelBtn setBackgroundImage:[UIImage imageNamed:@"ppt_add_address_selected"] forState:UIControlStateSelected];
    //点击方法
    [allSelBtn addTarget:self action:@selector(allSelBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    self.allSelBtn = allSelBtn;
    
    [self addSubview:allSelBtn];
}

#pragma mark - allSelBtn的点击事件
- (void)allSelBtnDidClick:(QHLButton *)allSelBtn {
    
    if ([self.settleMentViewDelegate respondsToSelector:@selector(settleMentView:didClickButton:)]) {
        [self.settleMentViewDelegate settleMentView:self didClickButton:allSelBtn.selected];
    }
    
}

#pragma mark - 添加全选label
- (void)setUpAllSelectedLabelWithView {
    UILabel *allSelLbl = [[UILabel alloc] init];
    
    //字体大小
    allSelLbl.font = [UIFont systemFontOfSize:15];
    //内容
    allSelLbl.text = @"全选";
    //颜色
    allSelLbl.textColor = [UIColor blackColor];
    
    [self addSubview:allSelLbl];
    self.allSelLbl = allSelLbl;
}

#pragma mark - 添加合计label
- (void)setUpTotalLabelWithView {
    UILabel *totalLbl = [[UILabel alloc] init];
    
    //字体大小
    totalLbl.font = [UIFont systemFontOfSize:14];
    //内容
    totalLbl.text = [NSString stringWithFormat:@"结算:￥0"];
    //字体颜色
    totalLbl.textColor = [UIColor redColor];
    [self addSubview:totalLbl];
    self.totalLbl = totalLbl;
}

#pragma mark - 添加结算按钮
- (void)setUpCheckOutBtnWithView {
    QHLButton *checkOutBtn = [[QHLButton alloc] init];
    //背景色
    [checkOutBtn setBackgroundColor:[UIColor redColor]];
    //设置字体
    [checkOutBtn setTitle:[NSString stringWithFormat:@"结算(0)"] forState:UIControlStateNormal];
    
    [self addSubview:checkOutBtn];
    self.checkOutBtn = checkOutBtn;
    //点击事件
    [checkOutBtn addTarget:self action:@selector(checkOutBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - checkOutBtn点击事件
- (void)checkOutBtnDidClick:(QHLButton *)checkOutBtn {
    NSLog(@"%s",__func__);
    
    if ([self.settleMentViewDelegate respondsToSelector:@selector(mGoPayClick)]) {
        [self.settleMentViewDelegate mGoPayClick];

    }
    
    
    if ([self.settleMentViewDelegate respondsToSelector:@selector(bottomViewGoPayDidClick:didClick:)]) {
        [self.settleMentViewDelegate bottomViewGoPayDidClick:self didClick:checkOutBtn.selected];

    }
}

- (void)setMoney:(float)money {
    _money = money;
    
    //给金额label赋值
    self.totalLbl.text = [NSString stringWithFormat:@"结算:￥%.2f",money];
}

- (void)setCount:(NSInteger)count {
    _count = count;
    
    //设置结算按钮文字
    [self.checkOutBtn setTitle:[NSString stringWithFormat:@"结算(%ld)",count] forState:UIControlStateNormal];
}

- (void)setBtnSelected:(BOOL)btnSelected {
    _btnSelected = btnSelected;
    
    self.allSelBtn.selected = btnSelected;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.allSelBtn.wx = 10;
    self.allSelBtn.wy = 18;
    self.allSelBtn.wwidth = 20;
    self.allSelBtn.wheight = 20;
    
    self.checkOutBtn.wheight = self.wheight;
    self.checkOutBtn.wwidth = 150;
    self.checkOutBtn.wy = 0;
    self.checkOutBtn.wx = self.wwidth - self.checkOutBtn.wwidth;
    
    self.allSelLbl.wx = 40;
    self.allSelLbl.wy = 18;
    self.allSelLbl.wheight = 20;
    self.allSelLbl.wwidth = 60;
    
    self.totalLbl.wx = CGRectGetMaxX(self.allSelBtn.frame) + 60;
    self.totalLbl.wy = 13;
    self.totalLbl.wheight = 30;
    self.totalLbl.wwidth = 150;
}
@end
