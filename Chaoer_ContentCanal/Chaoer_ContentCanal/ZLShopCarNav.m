//
//  ZLShopCarNav.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/9/19.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "ZLShopCarNav.h"

@implementation ZLShopCarNav

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (ZLShopCarNav *)shareView{

//    ZLShopCarNav *view =[[[NSBundle mainBundle] loadNibNamed:@"ZLShopCarNav" owner:self options:nil] objectAtIndex:0];
//    return view;
    
    ZLShopCarNav *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLShopCarNav" owner:self options:nil] objectAtIndex:0];
    return view;
    
}
@end
