//
//  RatingBarView.h
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingBar.h"
#import "UIView+AutoSize.h"

@interface RatingBarView : UIView

@property(nonatomic,strong) RatingBar *bar;
@property(nonatomic,strong) UILabel *barLable;

- (id)initWithSize:(CGSize)size;

@end
