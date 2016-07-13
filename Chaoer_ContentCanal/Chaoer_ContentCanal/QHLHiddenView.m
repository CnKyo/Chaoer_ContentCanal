//
//  QHLHiddenView.m
//  shoppingCar
//
//  Created by Apple on 16/1/28.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "QHLHiddenView.h"
#import "QHLButton.h"
#import "UIView+QHLExtension.h"

@interface QHLHiddenView ()

@property (nonatomic, weak) QHLButton *hiddenSelBtn;
@property (nonatomic, weak) UILabel *allSelLbl;

@property (nonatomic, strong) NSMutableArray *btns;
@end

@implementation QHLHiddenView

- (NSMutableArray *)btns {
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightGrayColor];
        
        //添加全选按钮
        [self setUphiddenSelBtn];
        
        //添加全选label
        [self setUpAllSelectedLabel];
        
        //添加3个按钮
        [self setUpBtns];
    }
    return self;
}

#pragma mark - 隐藏view的全选按钮
- (void)setUphiddenSelBtn {
    QHLButton *hiddenSelBtn = [[QHLButton alloc] init];
    
    //圆角
    hiddenSelBtn.layer.cornerRadius = 10;
    hiddenSelBtn.layer.masksToBounds = YES;
    //背景图
    [hiddenSelBtn setBackgroundImage:[UIImage imageNamed:@"normalBtn"] forState:UIControlStateNormal];
    [hiddenSelBtn setBackgroundImage:[UIImage imageNamed:@"selectedBtn"] forState:UIControlStateSelected];
    //点击方法
    [hiddenSelBtn addTarget:self action:@selector(hiddenSelBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    self.hiddenSelBtn = hiddenSelBtn;
    
    [self addSubview:hiddenSelBtn];
}

#pragma mark - hiddenSelBtn点击事件
- (void)hiddenSelBtnDidClick:(QHLButton *)hiddenSelBtn {
    
    if ([self.hiddenViewDelegate respondsToSelector:@selector(hiddenView:didClickAllSelBtn:)]) {
        [self.hiddenViewDelegate hiddenView:self didClickAllSelBtn:hiddenSelBtn.selected];
    }
}

#pragma mark - 添加全选label
- (void)setUpAllSelectedLabel {
    UILabel *allSelLbl = [[UILabel alloc] init];
    
    //字体大小
    allSelLbl.font = [UIFont systemFontOfSize:10];
    //内容
    allSelLbl.text = @"全选";
    //颜色
    allSelLbl.textColor = [UIColor whiteColor];
    
    [self addSubview:allSelLbl];
    self.allSelLbl = allSelLbl;
}

#pragma mark - 添加3个按钮
- (void)setUpBtns {
    for (int i = 0; i < 3; i ++) {
        QHLButton *btn = [[QHLButton alloc] init];
        
        //title
        NSString *title;
        if (i == 2) {
            title = @"删除";
        } else {
            title = [NSString stringWithFormat:@"按钮%d",i + 1];
        }
        [btn setTitle:title forState:UIControlStateNormal];
        //背景色
        [btn setBackgroundColor:[UIColor blackColor]];
        //圆角
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        //tag
        btn.tag = i;
        //点击事件
        [btn addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.btns addObject:btn];
        [self addSubview:btn];
    }
}

#pragma mark - btns的点击事件
- (void)btnDidClick:(QHLButton *)btn {
    
    if ([self.hiddenViewDelegate respondsToSelector:@selector(hiddenView:didClicHiddenViewBtn:)]) {
        [self.hiddenViewDelegate hiddenView:self didClicHiddenViewBtn:btn.tag];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.hiddenSelBtn.x = 10;
    self.hiddenSelBtn.y = 12;
    self.hiddenSelBtn.width = 20;
    self.hiddenSelBtn.height = 20;
    
    self.allSelLbl.x = 40;
    self.allSelLbl.y = 12;
    self.allSelLbl.height = 20;
    self.allSelLbl.width = 20;
    
    for (int i = 0; i < self.btns.count; i ++) {
        
        QHLButton *btn = self.btns[i];
        
        btn.x = 75 + 110 * i;
        btn.y = 7;
        btn.width = 80;
        btn.height = 30;
    }
}

- (void)setAllSelBtnSelected:(BOOL)allSelBtnSelected {
    _allSelBtnSelected = allSelBtnSelected;
    
    self.hiddenSelBtn.selected = allSelBtnSelected;
}
@end
