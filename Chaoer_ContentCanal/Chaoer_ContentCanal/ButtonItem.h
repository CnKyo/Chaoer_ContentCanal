//
//  ButtonItem.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/21.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonItem : UIControl
- (id)initWithFrame:(CGRect)frame WithImageName:(NSString *)imageName WithImageWidth:(CGFloat)imgWidth WithImageHeightPercentInItem:(CGFloat)imgPercent WithTitle:(NSString *)title WithFontSize:(CGFloat)fontSize WithFontColor:(UIColor *)color WithGap:(CGFloat)gap;
@end
