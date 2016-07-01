//
//  mGoodsDetailCell.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/29.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mGoodsDetailCell.h"
#import "mCommunityNavView.h"

@implementation mGoodsDetailCell
{

    mCommunityNavView *mSubView;

}

- (void)layoutSubviews{

    [super layoutSubviews];
    self.mScrollerView.showsVerticalScrollIndicator = FALSE;
    self.mScrollerView.showsHorizontalScrollIndicator = FALSE;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMDataSource:(NSArray *)mDataSource{

    for (UIView *view in self.mScrollerView.subviews) {
        [view removeFromSuperview];
    }
    
    int x = 5;
    int w = 100;
    int tag = 0;
    
    for (int i =0; i<mDataSource.count; i++) {
        mSubView = [mCommunityNavView shaeScrollerSubView];
//        mSubView.frame = CGRectMake(x, 0, w-10, 130);
        mSubView.mSName.text = mDataSource[i];
        mSubView.mSBtn.tag = tag;
        [mSubView.mSBtn addTarget:self action:@selector(msBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i%2 == 1) {
            mSubView.backgroundColor = [UIColor redColor];
        }
        
        [self.mScrollerView addSubview:mSubView];
        [mSubView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mScrollerView).offset(x);
            make.top.equalTo(self.mScrollerView).offset(@0);
            make.width.offset(w-10);
            make.height.offset(@130);
            
        }];
        
        
        x+=w;
        tag++;

    }

    
    self.mScrollerView.contentSize = CGSizeMake(x, self.mScrollerView.mheight);
}

- (void)msBtnAction:(UIButton *)sender{
    
    [self.delegate cellDidSelectedWithIndex:sender.tag];
}

@end
