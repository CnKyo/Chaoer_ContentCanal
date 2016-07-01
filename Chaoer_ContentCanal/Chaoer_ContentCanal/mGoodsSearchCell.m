//
//  mGoodsSearchCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/30.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mGoodsSearchCell.h"

@implementation mGoodsSearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setMDataSource:(NSArray *)mDataSource{

    for (UIButton *btn in self.contentView.subviews) {
        [btn removeFromSuperview];
    }
    
    int x = 5;
    CGFloat w = 0;
    CGFloat y = 10;
    int tag = 0;
    for (NSString *str in mDataSource) {
        
        
        CGSize size = [Util boundingRectWithSize:CGSizeMake(0, 30) andStr:str];
        
        w = size.width+20;
        UIButton *bbb = [UIButton new];
        
        bbb.frame = CGRectMake(x, y, w-5, 30);

        [bbb setTitle:str forState:0];
        bbb.titleLabel.font = [UIFont systemFontOfSize:14];
        [bbb setTitleColor:[UIColor lightGrayColor] forState:0];
        bbb.layer.masksToBounds = YES;
        bbb.layer.cornerRadius = 4;
        bbb.layer.borderColor = [UIColor lightGrayColor].CGColor;
        bbb.layer.borderWidth = 0.5;
        bbb.tag = tag;
        [bbb addTarget:self action:@selector(msBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:bbb];
        
        x+=w;
        tag++;
        
        if (x>=self.contentView.mwidth) {
            x = 5;
            y += 40;
        }
    }
    
    self.mHight = y+40;
    
    
}
- (void)msBtnAction:(UIButton *)sender{
    
    [self.delegate cellDidSelectedWithIndex:sender.tag];
}
@end
