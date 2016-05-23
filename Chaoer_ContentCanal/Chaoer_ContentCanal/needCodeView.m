//
//  needCodeView.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/22.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "needCodeView.h"

@implementation needCodeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (needCodeView *)shareView{
    needCodeView *view = [[[NSBundle mainBundle] loadNibNamed:@"needCodeView" owner:self options:nil] objectAtIndex:0];
    view.mBgkView.layer.masksToBounds = YES;
    view.mBgkView.layer.borderColor = [UIColor colorWithRed:0.82 green:0.82 blue:0.83 alpha:1.00].CGColor;
    view.mBgkView.layer.borderWidth = 1;
    
    
    view.mOkBtn.layer.masksToBounds = YES;
    view.mOkBtn.layer.cornerRadius = 3;
    
    return view;
}

+ (needCodeView *)shareVerifyBankView{

    needCodeView *view = [[[NSBundle mainBundle] loadNibNamed:@"verifyBankCardView" owner:self options:nil] objectAtIndex:0];
    
    
    view.mVerifyBtn.layer.masksToBounds = YES;
    view.mVerifyBtn.layer.cornerRadius = 3;
    
    return view;
    
}

+ (needCodeView *)initWithView{
    
    needCodeView *view = [[[NSBundle mainBundle] loadNibNamed:@"addHouseAndCodeView" owner:self options:nil] objectAtIndex:0];
    
    
    view.mTijiaoBtn.layer.masksToBounds = YES;
    view.mTijiaoBtn.layer.cornerRadius = 3;
    
    return view;
    
    
}

@end
