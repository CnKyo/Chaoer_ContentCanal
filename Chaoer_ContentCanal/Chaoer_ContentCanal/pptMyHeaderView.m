//
//  pptMyHeaderView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/13.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "pptMyHeaderView.h"

@implementation pptMyHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (pptMyHeaderView *)shareViuew{

    pptMyHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"pptMyHeaderView" owner:self options:nil] objectAtIndex:0];
    
    view.mHeaderImg.layer.masksToBounds = YES;
    view.mHeaderImg.layer.cornerRadius = view.mHeaderImg.mwidth/2;
    view.mHeaderImg.layer.borderColor = [UIColor whiteColor].CGColor;
    view.mHeaderImg.layer.borderWidth = 2;
    
    return view;
}
@end
