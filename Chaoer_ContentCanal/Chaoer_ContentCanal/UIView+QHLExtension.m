//
//  UIView+QHLExtension.m
//  shoppingCar
//
//  Created by Apple on 16/1/28.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UIView+QHLExtension.h"

@implementation UIView (QHLExtension)
- (void)setWx:(CGFloat)wx{

    CGRect frame = self.frame;
    frame.origin.x = wx;
    self.frame = frame;
}
- (void)setWy:(CGFloat)wy{

    CGRect frame = self.frame;
    frame.origin.y = wy;
    self.frame = frame;
}
- (void)setWwidth:(CGFloat)wwidth{
    CGRect frame = self.frame;
    frame.size.width = wwidth;
    self.frame = frame;
}
- (void)setWheight:(CGFloat)wheight {
    CGRect frame = self.frame;
    frame.size.height = wheight;
    self.frame = frame;
}
- (void)setWsize:(CGSize)wsize{
    CGRect frame = self.frame;
    frame.size = wsize;
    self.frame = frame;
}
- (void)setWorigin:(CGPoint)worigin {
    CGRect frame = self.frame;
    frame.origin = worigin;
    self.frame = frame;
}
- (void)setWcenterX:(CGFloat)wcenterX {
    CGPoint center = self.center;
    center.x = wcenterX;
    self.center = center;
}
- (void)setWcenterY:(CGFloat)wcenterY {
    CGPoint center = self.center;
    center.y = wcenterY;
    self.center = center;
}
- (CGFloat)wx{
    return self.frame.origin.x;
}
- (CGFloat)wy{
    return self.frame.origin.y;
}
- (CGFloat)wwidth{
    return self.frame.size.width;
}
- (CGFloat)wheight{
    return self.frame.size.height;
}
- (CGSize)wsize{
    return self.frame.size;
}
- (CGPoint)worigin{
    return self.frame.origin;
}
- (CGFloat)wcenterX {
    return self.center.x;
}
- (CGFloat)wcenterY {
    return self.center.y;
}

+ (UIView *)setUpViewWithFrame:(CGRect)frame andBackgroundColor:(UIColor *)backgroundColor andAlpha:(CGFloat)alpha andSuperview:(UIView *)superView {
    UIView *subView = [[UIView alloc] initWithFrame:frame];
    
    subView.backgroundColor = backgroundColor;
    subView.alpha = alpha;
    
    [superView addSubview:subView];
    return subView;
}
@end
