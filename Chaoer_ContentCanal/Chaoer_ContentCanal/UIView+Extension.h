//
//  UIView (Extension).h
//  HZProject
//
//  Created by KG on 15/8/17.
//  Copyright (c) 2015年 KG. All rights reserved.
//
//  因为控件的frame不能直接修改，必须整体赋值。所以重写方法，可以直接修改size，height，width，x，y

#import <UIKit/UIKit.h>

@interface UIView (Extension)
/**
 *  x坐标
 */
@property (assign, nonatomic) CGFloat kx;

/**
 *  y坐标
 */
@property (assign, nonatomic) CGFloat ky;

/**
 *  width
 */
@property (assign, nonatomic) CGFloat kwidth;

/**
 *  height
 */
@property (assign, nonatomic) CGFloat kheight;

/**
 *  size
 */
@property (assign, nonatomic) CGSize ksize;

/**
 *  origin
 */
@property (assign, nonatomic) CGPoint korigin;

/**
 *  中心x坐标
 */
@property (assign, nonatomic) CGFloat kcenterX;

/**
 *  中心y坐标
 */
@property (assign, nonatomic) CGFloat kcenterY;


/*--------------------上。左。下。右。------------------------*/
/**
 *  上
 */
@property (assign, nonatomic) CGFloat ktop;

/**
 *  左
 */
@property (assign, nonatomic) CGFloat kleft;

/**
 *  下
 */
@property (assign, nonatomic) CGFloat kbottom;

/**
 *  右
 */
@property (assign, nonatomic) CGFloat kright;


/*--------------------点------------------------*/
/**
 *  左下角
 */
@property (readonly) CGPoint kbottomLeft;

/**
 *  右下角
 */
@property (readonly) CGPoint kbottomRight;

/**
 *  右上角
 */
@property (readonly) CGPoint ktopRight;

/**
 *  左上角
 */
@property (readonly) CGPoint ktopLeft;


/**
 *  绘制cell分割线
 *
 *  @param rect      cell_rect
 *  @param lineWidth 线宽
 *  @param lineColor 线色
 */
- (void)drawCellSeparatorLine:(CGRect)rect lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor;

@end
