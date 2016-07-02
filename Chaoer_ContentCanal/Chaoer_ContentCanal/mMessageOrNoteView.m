//
//  mMessageOrNoteView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/2.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mMessageOrNoteView.h"

@implementation mMessageOrNoteView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (mMessageOrNoteView *)shareView{

    mMessageOrNoteView *view = [[[NSBundle mainBundle] loadNibNamed:@"mMessageOrNoteView" owner:self options:nil] objectAtIndex:0];
    
    view.mBgkView.layer.masksToBounds = YES;
    view.mBgkView.layer.borderColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.00].CGColor;
    view.mBgkView.layer.borderWidth = 0.5;
    
    view.mTextView.layer.masksToBounds = YES;
    view.mTextView.layer.cornerRadius = 3;
    view.mTextView.layer.borderColor =  [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.00].CGColor;
    view.mTextView.layer.borderWidth = 0.5;
    
    view.mSubmitBtn.layer.masksToBounds = YES;
    view.mSubmitBtn.layer.cornerRadius = 3;
    
    [view.mTextView setHolderToTop];
    [view.mTextView setPlaceholder:@"请填写您的留言！"];
    return view;
    
    
}

@end
