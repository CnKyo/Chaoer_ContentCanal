//
//  UIImage+QUAdditons.h
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QUAdditons)
+ (UIImage *)imageFromColor:(UIColor *)color;
+ (UIImage *)imageFromColor:(UIColor *)color targetSize:(CGSize)size;

@end
