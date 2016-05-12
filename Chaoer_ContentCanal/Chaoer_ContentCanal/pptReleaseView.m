//
//  pptReleaseView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/12.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "pptReleaseView.h"

@implementation pptReleaseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (pptReleaseView *)shareView{

    pptReleaseView *view = [[[NSBundle mainBundle] loadNibNamed:@"pptReleaseView" owner:self options:nil] objectAtIndex:0];
    return view;
    
}
@end
