//
//  UILabel+QHLExtension.m
//  shoppingCar
//
//  Created by Apple on 16/1/28.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UILabel+QHLExtension.h"

@implementation UILabel (QHLExtension)
+ (UILabel *)setUpLabelWithFrame:(CGRect)frame andFont:(UIFont *)font andTtitle:(NSString *)title andTextColor:(UIColor *)textColor andSuperview:(UIView *)superView {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    
    label.font = font;
    label.textColor = textColor;
    label.text = title;
    
    [superView addSubview:label];
    
    return label;
}
@end
