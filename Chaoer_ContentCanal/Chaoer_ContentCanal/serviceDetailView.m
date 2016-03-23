//
//  serviceDetailView.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/23.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "serviceDetailView.h"

@implementation serviceDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(serviceDetailView *)shareView{
    serviceDetailView *view = [[[NSBundle mainBundle] loadNibNamed:@"serviceDetailView" owner:self options:nil] objectAtIndex:0];
    
    
    view.mHeader.layer.masksToBounds = YES;
    view.mHeader.layer.cornerRadius = view.mHeader.mwidth/2;
    
    return view;
}

+ (serviceDetailView *)shareOrderView{
    
    serviceDetailView *view = [[[NSBundle mainBundle] loadNibNamed:@"makeServiceView" owner:self options:nil] objectAtIndex:0];
    
    return view;
}
@end
