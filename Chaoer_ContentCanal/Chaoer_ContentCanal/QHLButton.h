//
//  QHLButton.h
//  shoppingCar
//
//  Created by Apple on 16/1/12.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QHLButton : UIButton
@property (nonatomic, weak) NSIndexPath *indexPath;

+ (QHLButton *)setUpButtonWithFrame:(CGRect)frame andNormaleImg:(NSString *)normalImg andSelectedImg:(NSString *)SelectedImg andNormalTitle:(NSString *)normalTitle andSelectedTitle:(NSString *)selectedTitle andBackgroundColor:(UIColor *)bgColor andRadius:(CGFloat)radius andSuperView:(UIView *)superView;


@end
