//
//  ServiceHeadView.m
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/10/29.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "ServiceHeadView.h"

@implementation ServiceHeadView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
//    _mSearchView.layer.borderColor = COLOR(218, 219, 220).CGColor;
//    _mSearchView.layer.borderWidth = 0.5;
//    _mSearchView.layer.cornerRadius = 5;
    _mCheckBT.hidden = YES;
    _mQuanxuan.hidden = YES;
    
//    UISearchBar
    
}

+ (ServiceHeadView *)shareView{

    ServiceHeadView *view = [[[NSBundle mainBundle] loadNibNamed:@"ServiceHeadView" owner:self options:nil] objectAtIndex:0];
    
    
    return view;
}

@end
