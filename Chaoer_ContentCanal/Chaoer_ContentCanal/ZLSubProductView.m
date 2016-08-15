//
//  ZLSubProductView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "ZLSubProductView.h"

@implementation ZLSubProductView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
    
}

+ (ZLSubProductView *)initWithFrame:(CGRect)frame andImg:(NSString *)mImg andProductName:(NSString *)mName andOlPrice:(float)mOldPrice andNowPrice:(float)mNowPrice{

    ZLSubProductView *view = [[self alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    [view loadImg:mImg andName:mName andOldPrice:mOldPrice andNowPrice:mNowPrice];
    
    return view;
}
- (void)loadImg:(NSString *)mImg andName:(NSString *)mName andOldPrice:(float)mOldPrice andNowPrice:(float)mNowPrice{
    
    self.mImg = [[UIImageView alloc] init];
    [self.mImg sd_setImageWithURL:[NSURL URLWithString:mImg] placeholderImage:[UIImage imageNamed:@"DefaultImg"]];
    [self addSubview:self.mImg];
    
    self.mName = [[UILabel alloc] init];
    self.mName.textAlignment = NSTextAlignmentCenter;
    self.mName.text = mName;
    self.mName.textColor = [UIColor colorWithRed:0.42 green:0.42 blue:0.42 alpha:1.00];
    self.mName.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.mName];

    self.mNowPrice = [[UILabel alloc] init];
    self.mNowPrice.textAlignment = NSTextAlignmentLeft;
    self.mNowPrice.text = [NSString stringWithFormat:@"%.2f元",mNowPrice];
    self.mNowPrice.textColor = [UIColor colorWithRed:1.00 green:0.11 blue:0.11 alpha:1.00];
    self.mNowPrice.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.mNowPrice];
    
    self.mOldPrice = [[UILabel alloc] init];
    self.mOldPrice.textAlignment = NSTextAlignmentRight;
    self.mOldPrice.text = [NSString stringWithFormat:@"%.2f元",mOldPrice];
    self.mOldPrice.textColor = [UIColor colorWithRed:0.36 green:0.36 blue:0.36 alpha:1.00];
    self.mOldPrice.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.mOldPrice];
    
    self.mBtn = [UIButton new];
    self.mBtn.tintColor = [UIColor clearColor];
    [self.mBtn setTitleColor:[UIColor clearColor] forState:0];
    [self addSubview:self.mBtn];
    
    
    [self.mImg makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(@15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self).offset(@5);
        make.bottom.equalTo(self.mName.top).offset(-5);
    }];
    
    [self.mName makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).offset(@0);
        make.top.equalTo(self.mImg.bottom).offset(@3);
        make.bottom.equalTo(self.mNowPrice.top).offset(-3);

    }];
    
    [self.mNowPrice makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(@2);
        make.right.equalTo(self.mOldPrice.left).offset(-3);
        make.top.equalTo(self.mName.bottom).offset(@3);
        make.bottom.equalTo(self).offset(-1);

    }];
    
    
    [self.mOldPrice makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mNowPrice.right).offset(@3);
        make.right.equalTo(self).offset(-2);
        make.top.equalTo(self.mName.bottom).offset(@3);
        make.bottom.equalTo(self).offset(-1);
    }];
    
    [self.mBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self).offset(@0);
    }];
    
    
    
    
}
@end

