//
//  mPayFeeBarCodeView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/22.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mPayFeeBarCodeView.h"

@implementation mPayFeeBarCodeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (mPayFeeBarCodeView *)shareView{

    mPayFeeBarCodeView *view = [[[NSBundle mainBundle] loadNibNamed:@"mPayFeeBarCodeView" owner:self options:nil] objectAtIndex:0];
    return view;

}

@end
