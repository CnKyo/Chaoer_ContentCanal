//
//  mComfirmHederAndFooterSection.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/22.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mComfirmHederAndFooterSection.h"

@implementation mComfirmHederAndFooterSection

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (mComfirmHederAndFooterSection *)shareHeader{

    mComfirmHederAndFooterSection *view = [[[NSBundle mainBundle] loadNibNamed:@"mComfirmHederSection" owner:self options:nil] objectAtIndex:0];
    
    return view;

}


+ (mComfirmHederAndFooterSection *)shareFooter{

    
    mComfirmHederAndFooterSection *view = [[[NSBundle mainBundle] loadNibNamed:@"mComfirmFooterSection" owner:self options:nil] objectAtIndex:0];

    
    
    return view;
}
- (IBAction)sendType:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(sectionWithSendType:)]) {
        [self.delegate sectionWithSendType:self.mIndexPaths];
    }
}
- (IBAction)coupAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(sectionWithCoup:)]) {
        [self.delegate sectionWithCoup:self.mIndexPaths];
    }
}
- (IBAction)noteAction:(UIButton *)sender {
    if ( [self.delegate respondsToSelector:@selector(sectionWithMessage:)]) {
        [self.delegate sectionWithMessage:self.mIndexPaths];
    }
}

@end
