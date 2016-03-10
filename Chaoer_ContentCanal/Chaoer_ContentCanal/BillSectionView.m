//
//  BillSectionView.m
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/10/30.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "BillSectionView.h"

@implementation BillSectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (BillSectionView *)shareView{
    
    BillSectionView *view = [[[NSBundle mainBundle] loadNibNamed:@"BillSectionView" owner:self options:nil] objectAtIndex:0];
    
    
    return view;
}

@end
