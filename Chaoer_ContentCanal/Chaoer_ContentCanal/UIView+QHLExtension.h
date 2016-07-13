//
//  UIView+QHLExtension.h
//  shoppingCar
//
//  Created by Apple on 16/1/28.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (QHLExtension)
/**
 * 分类只能扩充方法
 * 下面的代码只会生成方法的声明，并不会生成_x _y _width _height _size _origin
 * 必须自己去实现
 */
@property (nonatomic, assign) CGFloat wx;
@property (nonatomic, assign) CGFloat wy;
@property (nonatomic, assign) CGFloat wwidth;
@property (nonatomic, assign) CGFloat wheight;
@property (nonatomic, assign) CGPoint worigin;
@property (nonatomic, assign) CGSize wsize;
@property (nonatomic, assign) CGFloat wcenterX;
@property (nonatomic, assign) CGFloat wcenterY;

+ (UIView *)setUpViewWithFrame:(CGRect)frame andBackgroundColor:(UIColor *)backgroundColor andAlpha:(CGFloat)alpha andSuperview:(UIView *)superView;
@end
