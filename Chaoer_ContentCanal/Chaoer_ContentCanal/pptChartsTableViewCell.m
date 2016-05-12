//
//  pptChartsTableViewCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/12.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "pptChartsTableViewCell.h"

@implementation pptChartsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{

    self.mHeader.layer.masksToBounds = YES;
    self.mHeader.layer.cornerRadius = 3;
    
    
    for (UILabel *lll in self.mTagView.subviews) {
        [lll removeFromSuperview];
    }
    
    NSArray *tt = @[@"帅气",@"阳光",@"速度"];
    
    CGFloat LW = self.mTagView.mwidth/3-15;
    
    for ( int i = 0; i<tt.count; i++) {
        
        UILabel *lll = [UILabel new];
        lll.frame = CGRectMake(5+LW*i, 2, LW-10, 25);
        lll.text = tt[i];
        lll.font = [UIFont systemFontOfSize:13];
        lll.textColor = [UIColor whiteColor];
        lll.textAlignment = NSTextAlignmentCenter;
        lll.backgroundColor = [UIColor colorWithRed:0.55 green:0.75 blue:0.94 alpha:1.00];
        lll.layer.masksToBounds = YES;
        lll.layer.cornerRadius = 12;
        [self.mTagView addSubview:lll];
    }
    
    
}
@end
