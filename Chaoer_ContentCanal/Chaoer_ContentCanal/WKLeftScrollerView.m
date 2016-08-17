//
//  WKLeftScrollerView.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "WKLeftScrollerView.h"

@implementation WKLeftScrollerView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
    
}

+ (WKLeftScrollerView *)initWithFrame:(CGRect)mFrame andDataArr:(NSArray *)mArr{

    
    WKLeftScrollerView *view = [[self alloc] initWithFrame:mFrame];
    view.backgroundColor = [UIColor whiteColor];
    [view initViewWithData:mArr];
    return view;
    
}

- (void)initViewWithData:(NSArray *)mArr{

    UIScrollView *mView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.mwidth, self.mheight)];
    mView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:mView];
    
    float y = 0;
    
    for (int i = 0; i<mArr.count; i++) {
        UIButton *mBtn = [UIButton new];
        mBtn.frame = CGRectMake(0,y, self.mwidth, 45);
        mBtn.tag = i;
        [mBtn addTarget:self action:@selector(mBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [mView addSubview:mBtn];
        y+=45;
    }
    mView.contentSize = CGSizeMake(self.mwidth, y);
    
}
- (void)mBtnAction:(UIButton *)sender{

    if ([self.delegate respondsToSelector:@selector(WKLeftBtnClickedWithIndex:)]) {
        [self.delegate WKLeftBtnClickedWithIndex:sender.tag];
    }
    
}
@end