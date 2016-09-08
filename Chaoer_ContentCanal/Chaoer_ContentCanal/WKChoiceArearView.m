//
//  WKChoiceArearView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/9/8.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "WKChoiceArearView.h"

@implementation WKChoiceArearView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (WKChoiceArearView *)shareView{

    WKChoiceArearView *view = [[[NSBundle mainBundle] loadNibNamed:@"WKChoiceArearView" owner:self options:nil] objectAtIndex:0];
    return view;
}

- (IBAction)mCancelAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(WKCancelAction)]) {
        [self.delegate WKCancelAction];
    }
    
    
}

- (IBAction)mOKAction:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(WKOKAction)]) {
        [self.delegate WKOKAction];
    }
    
}


@end
