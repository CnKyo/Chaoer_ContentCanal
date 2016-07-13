//
//  QHLButton.m
//  shoppingCar
//
//  Created by Apple on 16/1/12.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "QHLButton.h"

@implementation QHLButton

- (void)setHighlighted:(BOOL)highlighted {
}


#pragma mark - 创建button
+ (QHLButton *)setUpButtonWithFrame:(CGRect)frame andNormaleImg:(NSString *)normalImg andSelectedImg:(NSString *)SelectedImg andNormalTitle:(NSString *)normalTitle andSelectedTitle:(NSString *)selectedTitle andBackgroundColor:(UIColor *)bgColor andRadius:(CGFloat)radius andSuperView:(UIView *)superView {
    
    QHLButton *button = [[QHLButton alloc] initWithFrame:frame];
    
    [button setTitle:normalTitle forState:UIControlStateNormal];
    [button setTitle:selectedTitle forState:UIControlStateSelected];
    
    [button setBackgroundImage:[UIImage imageNamed:normalImg] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:SelectedImg] forState:UIControlStateSelected];
    
    [button setBackgroundColor:bgColor];
    
    //圆角
    button.layer.cornerRadius = radius;
    button.layer.masksToBounds = YES;
    
    [superView addSubview:button];
    
    return button;
}
@end
