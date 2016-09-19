//
//  CustomHeaderView.m
//  ShopCarDemo
//
//  Created by 周智勇 on 16/7/25.
//  Copyright © 2016年 Tuse. All rights reserved.
//

#import "CustomHeaderView.h"
#define RGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
@interface CustomHeaderView ()
@property (nonatomic, strong)UIButton * mSelectBtn;
@property (nonatomic, strong)UILabel * mShopName;
@property (nonatomic,strong) UIImageView *mShopImg;
@property (nonatomic, strong)WPHotspotLabel * mTime;

@end

@implementation CustomHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBAColor(249, 249, 249, 1.0);
        [self addSubview:self.mSelectBtn];
        [self addSubview:self.mShopName];
        [self addSubview:self.mShopImg];
        [self addSubview:self.mTime];
    }
    return self;
}

#pragma mark -- Lazy Loading
-(UIButton *)mSelectBtn{
    if (_mSelectBtn == nil) {
        self.mSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mSelectBtn.frame = CGRectMake(5, 25, 20, 20);
        [_mSelectBtn setImage:[UIImage imageNamed:@"shoppingCar_unselect"] forState:UIControlStateNormal];
        [_mSelectBtn addTarget:self action:@selector(mBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mSelectBtn;
}
- (UIImageView *)mShopImg{


    if (_mShopImg == nil) {
        _mShopImg = [[UIImageView alloc] initWithFrame:CGRectMake(35, 20, 40, 40)];
    }
    return _mShopImg;
    
}
-(UILabel *)mShopName{
    if (_mShopName == nil) {
        _mShopName = [[UILabel alloc] initWithFrame:CGRectMake(80, 20, self.frame.size.width-90, 20)];
        _mShopName.text = @"店铺名称";
        _mShopName.font = [UIFont systemFontOfSize:16];
    }
    return _mShopName;
}
-(UILabel *)mTime{
    if (_mTime == nil) {
        _mTime = [[WPHotspotLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_mShopImg.frame)+5, CGRectGetMaxY(_mShopName.frame)+5, self.frame.size.width-90, 20)];
        _mTime.text = @"店铺名称";
        _mTime.font = [UIFont systemFontOfSize:16];
    }
    return _mTime;
    
}
#pragma mark --- Clicked event
- (void)mBtnClicked{
    NSLog(@"店铺按钮被点击");
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickedWhichHeaderView:)]) {
        [self.delegate clickedWhichHeaderView:self.tag];
    }
}


-(void)setModel:(GShopCarList *)model{
    
    NSDictionary *mStyle1 = @{@"color": [UIColor redColor]};

    _model = model;
    
    NSString *mAct = @"营业时间";

    self.mShopName.text = _model.mShopName;
    
    self.mTime.attributedText = [[NSString stringWithFormat:@"%@:<color>%@-%@</color>",mAct,model.mOpenTime,model.mCloseTime] attributedStringWithStyleBook:mStyle1];
    
    [self.mShopImg sd_setImageWithURL:[NSURL URLWithString:model.mShopLogo] placeholderImage:[UIImage imageNamed:@"img_default"]];

    
    if (_model.mSelected) {
        [self.mSelectBtn setImage:[UIImage imageNamed:@"ppt_add_address_selected"] forState:UIControlStateNormal];
    }else{
        [self.mSelectBtn setImage:[UIImage imageNamed:@"ppt_add_address_normal"] forState:UIControlStateNormal];
    }
}

@end
