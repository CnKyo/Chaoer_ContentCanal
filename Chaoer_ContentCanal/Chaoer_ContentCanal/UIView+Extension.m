//
//  UIView (Extension).m
//  HZProject
//
//  Created by KG on 15/8/17.
//  Copyright (c) 2015年 KG. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
- (void)setKx:(CGFloat)kx{
    CGRect frame = self.frame;
    frame.origin.x = kx;
    self.frame = frame;
}

- (CGFloat)kx {
    return self.frame.origin.x;
}

- (void)setKy:(CGFloat)ky {
    CGRect frame = self.frame;
    frame.origin.y = ky;
    self.frame = frame;
}

- (CGFloat)ky {
    return self.frame.origin.y;
}

- (void)setKcenterX:(CGFloat)kcenterX{
    CGPoint center = self.center;
    center.x = kcenterX;
    self.center = center;
}

- (CGFloat)kcenterX {
    return self.center.x;
}

-(void)setKcenterY:(CGFloat)kcenterY{
    CGPoint center = self.center;
    center.y = kcenterY;
    self.center = center;
}

- (CGFloat)kcenterY {
    return self.center.y;
}

-(void)setKwidth:(CGFloat)kwidth{
    CGRect frame = self.frame;
    frame.size.width = kwidth;
    self.frame = frame;
}

- (CGFloat)kwidth {
    return self.frame.size.width;
}

-(void)setKheight:(CGFloat)kheight{
    CGRect frame = self.frame;
    frame.size.height = kheight;
    self.frame = frame;
}

- (CGFloat)kheight {
    return self.frame.size.height;
}

-(void)setKsize:(CGSize)ksize{
    CGRect frame = self.frame;
    frame.size = ksize;
    self.frame = frame;
}

- (CGSize)ksize {
    return self.frame.size;
}

-(void)setKorigin:(CGPoint)korigin{
    CGRect frame = self.frame;
    frame.origin = korigin;
    self.frame = frame;
}

- (CGPoint)korigin {
    return self.frame.origin;
}


/*--------------------华丽分割线------------------------*/

- (CGFloat)ktop {
    return self.frame.origin.y;
}

-(void)setKtop:(CGFloat)ktop{
    CGRect frame = self.frame;
    frame.origin.y = ktop;
    self.frame = frame;
}

- (CGFloat)kleft {
    return self.frame.origin.x;
}

-(void)setKleft:(CGFloat)kleft{
    CGRect frame = self.frame;
    frame.origin.x = kleft;
    self.frame = frame;
}

- (CGFloat)kbottom {
    return self.frame.origin.y + self.frame.size.height;
}

-(void)setKbottom:(CGFloat)kbottom{
    CGRect frame = self.frame;
    frame.origin.y = kbottom - self.frame.origin.y;
    self.frame = frame;
}

- (CGFloat)kright {
    return self.frame.origin.x + self.frame.size.width;
}

-(void)setKright:(CGFloat)kright{
    CGRect frame = self.frame;
    frame.origin.x = kright - self.frame.origin.x;
    self.frame = frame;
}


/*--------------------华丽分割线------------------------*/

-(CGPoint)kbottomLeft{
    CGFloat bottomX = self.frame.origin.x;
    CGFloat bottomY = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(bottomX, bottomY);
}

- (CGPoint)kbottomRight {
    CGFloat bottomX = self.frame.origin.x + self.frame.size.width;
    CGFloat bottomY = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(bottomX, bottomY);
}

- (CGPoint)ktopLeft {
    CGFloat topX = self.frame.origin.x;
    CGFloat topY = self.frame.origin.y;
    return CGPointMake(topX, topY);
}

- (CGPoint)ktopRight {
    CGFloat topX = self.frame.origin.x + self.frame.size.width;
    CGFloat topY = self.frame.origin.y;
    return CGPointMake(topX, topY);
}

- (void)drawCellSeparatorLine:(CGRect)rect lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor {
    // 开启上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 上分割线，
    CGContextSetStrokeColorWithColor(context,lineColor.CGColor);
    CGContextStrokeRect(context, CGRectMake(0, -0.5, rect.size.width, lineWidth));
    
    // 下分割线
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, lineWidth));
}
@end
