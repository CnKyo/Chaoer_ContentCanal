//
//  mCustomHomeView.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/10.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mCustomHomeView.h"

@implementation mCustomHomeView

+ (mCustomHomeView *)shareView{
    mCustomHomeView *view = [[[NSBundle mainBundle] loadNibNamed:@"mCustomHomeView" owner:self options:nil] objectAtIndex:0];
    return view;
}
@end
