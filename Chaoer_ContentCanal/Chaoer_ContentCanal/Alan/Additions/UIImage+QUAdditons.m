//
//  UIImage+QUAdditons.m
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "UIImage+QUAdditons.h"

@implementation UIImage(QUAdditons)



+ (UIImage *)imageFromColor:(UIColor *)color {
    return [self imageFromColor:color targetSize:CGSizeMake(600, 600)];
}

+ (UIImage *)imageFromColor:(UIColor *)color targetSize:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
