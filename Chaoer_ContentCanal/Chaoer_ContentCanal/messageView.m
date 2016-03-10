//
//  messageView.m
//  O2O_Communication_seller
//
//  Created by 王珂 on 15/11/9.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "messageView.h"

@implementation messageView

+ (messageView *)shareView{
    messageView *view = [[[NSBundle mainBundle]loadNibNamed:@"messageView" owner:self options:nil]objectAtIndex:0];
    
    return view;
}
@end
