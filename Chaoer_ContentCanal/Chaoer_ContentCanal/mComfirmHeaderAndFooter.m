//
//  mComfirmHeaderAndFooter.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mComfirmHeaderAndFooter.h"

@implementation mComfirmHeaderAndFooter

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (mComfirmHeaderAndFooter *)initHeaderView{

    mComfirmHeaderAndFooter *view = [[[NSBundle mainBundle] loadNibNamed:@"mComfirmHeaderView" owner:self options:nil] objectAtIndex:0];
    return view;
}

+ (mComfirmHeaderAndFooter *)initFooterView{
    
    mComfirmHeaderAndFooter *view = [[[NSBundle mainBundle] loadNibNamed:@"comfirmOrderFooterView" owner:self options:nil] objectAtIndex:0];
    return view;
}
- (IBAction)mUserScore:(UISwitch *)sender {
    
    if (sender.on) {
        if ([self.delegate respondsToSelector:@selector(mFooterSwitchChanged:)]) {
            
            [self.delegate mFooterSwitchChanged:YES];
        }
    }else{
        
        if ([self.delegate respondsToSelector:@selector(mFooterSwitchChanged:)]) {
            [self.delegate mFooterSwitchChanged:NO];
        }
        
    
    }
    
    
    
}
@end
