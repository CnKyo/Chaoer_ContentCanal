//
//  mRedBagHeader.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mRedBagHeader.h"

@implementation mRedBagHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (mRedBagHeader *)shareView{
    mRedBagHeader *view = [[[NSBundle mainBundle] loadNibNamed:@"mRedBagHeader" owner:self options:nil] objectAtIndex:0];
    
    
    view.mHeaderBtn.layer.masksToBounds = YES;
    view.mHeaderBtn.layer.cornerRadius = view.mHeaderBtn.mwidth/2;
    view.mHeaderBtn.layer.borderColor = M_CO.CGColor;
    view.mHeaderBtn.layer.borderWidth = 10;

    return view;
}


@end
