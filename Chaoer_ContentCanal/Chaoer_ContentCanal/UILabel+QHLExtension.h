//
//  UILabel+QHLExtension.h
//  shoppingCar
//
//  Created by Apple on 16/1/28.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (QHLExtension)
+ (UILabel *)setUpLabelWithFrame:(CGRect)frame andFont:(UIFont *)font andTtitle:(NSString *)title andTextColor:(UIColor *)textColor andSuperview:(UIView *)superView;
@end
