//
//  UILabel+StringWithFrame.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/30.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "UILabel+StringWithFrame.h"

@implementation UILabel (stringFrame)
- (CGSize)boundingRectWithSize:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName: self.font};
    
    CGSize retSize = [self.text boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}


@end
