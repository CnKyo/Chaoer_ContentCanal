//
//  ZWSideIconBt.m
//  O2O_Communication_seller
//
//  Created by zzl on 15/12/17.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "ZWSideIconBt.h"
#import "UILabel+myLabel.h"

@implementation ZWSideIconBt

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//在设置 text之后调用
-(void)setSideIcon:(UIImage*)image atLeft:(BOOL)atLeft//图标显示在坐标,否则右边
{
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    UILabel* tt = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, self.frame.size.height)];
    tt.font = self.titleLabel.font;
    tt.text = [self titleForState:UIControlStateNormal];
    [tt autoReSizeWidthForContent:self.superview.frame.size.width];
    UIImageView* ttt = [[UIImageView alloc]initWithImage:image];
    
    CGRect f = self.frame;
    f.size.width = tt.frame.size.width + 10 + image.size.width + self.titleEdgeInsets.left + self.titleEdgeInsets.right;
    self.frame = f;
    [self addSubview:ttt];
    ttt.center = CGPointMake(0, self.frame.size.height/2);
    
    if ( atLeft )
    {
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [Util relPosUI:self dif:5 tag:ttt tagatdic:E_dic_l];
    }
    else
    {
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [Util relPosUI:self dif:5 tag:ttt tagatdic:E_dic_r];
    }
}

@end
