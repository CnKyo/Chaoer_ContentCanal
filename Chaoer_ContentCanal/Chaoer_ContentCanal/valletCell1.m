//
//  valletCell1.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/3.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "valletCell1.h"
#import "mGeneralSubView.h"
#import "YSProgressView.h"

@implementation valletCell1
{

    /**
     *  子视图
     */
    mGeneralSubView *mView;
    YSProgressView *mProgress;


}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)layoutSubviews{

    [super layoutSubviews];
    
    self.mBgkView1.layer.masksToBounds = YES;
    self.mBgkView1.layer.cornerRadius = 4;

    
    self.mTradeView.layer.masksToBounds = self.mScoreView.layer.masksToBounds = self.mRedBagView.layer.masksToBounds = self.mCollectionView.layer.masksToBounds = YES;
    self.mTradeView.layer.borderColor = self.mScoreView.layer.borderColor =  self.mRedBagView.layer.borderColor =  self.mCollectionView.layer.borderColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1].CGColor;
    
    self.mTradeView.layer.borderWidth = self.mScoreView.layer.borderWidth = self.mRedBagView.layer.borderWidth = self.mCollectionView.layer.borderWidth = 0.25;
    
    
}

- (void)setMTopFourBtnArr:(NSArray *)mTopFourBtnArr{

    
    for (UIView *vvv in self.mSubView.subviews) {
        [vvv removeFromSuperview];
    }
    
    
      NSArray *mII = @[[UIImage imageNamed:@"vallet_topup"],[UIImage imageNamed:@"vallet_tom"],[UIImage imageNamed:@"vallet_cash"],[UIImage imageNamed:@"vallet_2code"]];
    
    CGFloat mmW = self.mSubView.mwidth/4;
    
    for (int i = 0; i<mII.count; i++) {
        
        mView = [mGeneralSubView shareSubView];
        mView.frame = CGRectMake(i*mmW, 0, mmW, self.mSubView.mheight);
        mView.mName.text = mTopFourBtnArr[i];
        mView.mImg.image = mII[i];
        mView.mBtn.tag = i;
        [mView.mBtn addTarget:self action:@selector(mBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.mSubView addSubview:mView];
    
        
    }

    
}
#pragma mark----按钮的点击事件
- (void)mBtnAction:(UIButton *)sender{

    if ([self.delegate respondsToSelector:@selector(cellWithFourBtnSelectedIndex:)]) {
        [self.delegate cellWithFourBtnSelectedIndex:sender.tag];
    }
    
    
}


- (IBAction)mHistoryBtnAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(cellWithHistoryBtnSelectedIndex:)]) {
        [self.delegate cellWithHistoryBtnSelectedIndex:sender.tag];
    }
    
    
}

- (IBAction)mRegistAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(cellWithRegistBtnAction)]) {
            [self.delegate cellWithRegistBtnAction];
    }

    
}


- (IBAction)mRuleAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(cellWithRuleBtnAction)]) {
        [self.delegate cellWithRuleBtnAction];
    }
    
    
}


- (void)setMFDays:(int)mFDays{
    self.mDays.text = [NSString stringWithFormat:@"%d天",mFDays];
    
    for (YSProgressView *vvv in self.mSliderView.subviews) {
        [vvv removeFromSuperview];
    }
    
    mProgress = [[YSProgressView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, self.mSliderView.mheight)];
    mProgress.progressValue = mFDays;
    [self.mSliderView addSubview:mProgress];

    
    NSDictionary *mStyle = @{@"color":[UIColor colorWithRed:0.91 green:0.13 blue:0.13 alpha:0.75]};

    if ([mUserInfo backNowUser].mIsSign) {
        self.mRegistContent.attributedText =[[NSString stringWithFormat:@"今日签到<color>+1</color> "] attributedStringWithStyleBook:mStyle];

    }

    
}

- (void)setMFScore:(int)mFScore{
    self.mScore.text = [NSString stringWithFormat:@"%d",mFScore];

}

- (void)setMFBalance:(float)mFBalance{
    NSDictionary *mStyle = @{@"color":[UIColor colorWithRed:0.91 green:0.13 blue:0.13 alpha:0.75]};
    
    self.mBalance.attributedText =[[NSString stringWithFormat:@"账户余额:<color>¥%.2f</color> ",mFBalance] attributedStringWithStyleBook:mStyle];

    
}

@end
