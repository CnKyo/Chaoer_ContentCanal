//
//  WKLeftView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/10.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "WKLeftView.h"
#define SFQRedColor [UIColor colorWithRed:255/255.0 green:92/255.0 blue:79/255.0 alpha:1]
#define MAX_TitleNumInWindow 5

@interface WKLeftView()

@property (nonatomic,strong) NSMutableArray *btns;
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) UIButton *titleBtn;
@property (nonatomic,strong) UIScrollView *bgScrollView;
@property (nonatomic,strong) UIView *selectLine;
@property (nonatomic,assign) CGFloat btn_w;

@end

@implementation WKLeftView

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titleArray clickBlick:(btnClicked)block{
    self = [super initWithFrame:frame];
    if (self) {
        _btn_w=40.0;
   
        _titles=titleArray;
        _defaultIndex=1;
        _titleFont=[UIFont systemFontOfSize:14];
        _btns=[[NSMutableArray alloc] initWithCapacity:0];
        _titleNomalColor=[UIColor blackColor];
        _titleSelectColor=[UIColor whiteColor];
        _bgScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, self.frame.size.height)];
        _bgScrollView.backgroundColor=[UIColor whiteColor];
        _bgScrollView.showsHorizontalScrollIndicator=NO;
        _bgScrollView.contentSize=CGSizeMake(_btn_w*titleArray.count+40, self.frame.size.height);
        [self addSubview:_bgScrollView];
        
        
        for (int i=0; i<titleArray.count; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            
            btn.frame=CGRectMake(0, _btn_w*i, self.frame.size.width, 40);
            btn.tag=i+1;
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1.00] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1.00] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
            
            [btn setBackgroundImage:[UIImage imageNamed:@"11-1(1)-1"] forState:UIControlStateSelected];
            [btn setBackgroundImage:nil forState:UIControlStateNormal];
            
            
            btn.titleLabel.font=_titleFont;
            [_bgScrollView addSubview:btn];
            [_btns addObject:btn];
            if (i==0) {
                _titleBtn=btn;
                btn.selected=YES;
            }
            self.block=block;
            
        }
        
    }
    
    return self;
}

-(void)btnClick:(UIButton *)btn{
    
    if (self.block) {
        self.block(btn.tag);
    }
    
    if (btn.tag==_defaultIndex) {
        return;
    }else{
        _titleBtn.selected=!_titleBtn.selected;
        _titleBtn=btn;
        _titleBtn.selected=YES;
        _defaultIndex=btn.tag;
        
    }
    
    //计算偏移量
    CGFloat offsetX=btn.frame.origin.y - 2*_btn_w;
    if (offsetX<0) {
        offsetX=0;
    }
    CGFloat maxOffsetX= _bgScrollView.contentSize.height-DEVICE_Height;
    if (offsetX>maxOffsetX) {
        offsetX=maxOffsetX;
    }
    
    [UIView animateWithDuration:.2 animations:^{
        
        [_bgScrollView setContentOffset:CGPointMake(0, offsetX) animated:YES];
        
    } completion:^(BOOL finished) {
        
    }];
    
}



-(void)setTitleNomalColor:(UIColor *)titleNomalColor{
    _titleNomalColor=titleNomalColor;
    [self updateView];
}

-(void)setTitleSelectColor:(UIColor *)titleSelectColor{
    _titleSelectColor=titleSelectColor;
    [self updateView];
}

-(void)setTitleFont:(UIFont *)titleFont{
    _titleFont=titleFont;
    [self updateView];
}

-(void)setDefaultIndex:(NSInteger)defaultIndex{
    _defaultIndex=defaultIndex;
    [self updateView];
}

-(void)updateView{
    for (UIButton *btn in _btns) {
        [btn setTitleColor:[UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1.00] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.titleLabel.font=_titleFont;
        _selectLine.backgroundColor=_titleSelectColor;
        
        if (btn.tag-1==_defaultIndex-1) {
            _titleBtn=btn;
            btn.selected=YES;
            
        }else{
            btn.selected=NO;
            
        }
    }
}

@end
