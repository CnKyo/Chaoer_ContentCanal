//
//  ButtonItem.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/21.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "ButtonItem.h"

@implementation ButtonItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame WithImageName:(NSString *)imageName WithImageWidth:(CGFloat)imgWidth WithImageHeightPercentInItem:(CGFloat)imgPercent WithTitle:(NSString *)title WithFontSize:(CGFloat)fontSize WithFontColor:(UIColor *)color WithGap:(CGFloat)gap{
    self.backgroundColor=[UIColor clearColor];
    self=[super initWithFrame:frame];
    if (self) {
        
        UIButton *bbb = [UIButton new];
        bbb.frame = CGRectMake((frame.size.width-imgWidth)/2, 5, imgWidth, imgPercent*frame.size.height);
        [bbb setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [self addSubview:bbb];
        
        
    }
    return self;
}
@end
