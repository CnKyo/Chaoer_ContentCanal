//
//  valletCell1.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/3.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  cell按钮代理方法
 */
@protocol cellWithBtnActionDelegate <NSObject>

@optional

/**
 *  详情规则代理方法
 */
- (void)cellWithRuleBtnAction;
/**
 *  签到代理方法
 */
- (void)cellWithRegistBtnAction;
/**
 *  顶部4个按钮的代理方法
 *
 *  @param mIndex 索引
 */
- (void)cellWithFourBtnSelectedIndex:(NSInteger)mIndex;
/**
 *  历史记录按钮的代理方法
 *
 *  @param mIndex 索引
 */
- (void)cellWithHistoryBtnSelectedIndex:(NSInteger)mIndex;

@end

@interface valletCell1 : UITableViewCell

@property (strong,nonatomic) id <cellWithBtnActionDelegate> delegate;

#pragma mark ----第一种cell样式
/**
 *  背景
 */
@property (weak, nonatomic) IBOutlet UIView *mBgkView1;
/**
 *  积分数量
 */
@property (weak, nonatomic) IBOutlet UILabel *mScore;
/**
 *  规则按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mRuleBtn;
/**
 *  签到view
 */
@property (weak, nonatomic) IBOutlet UIView *mRegistView;
/**
 *  签到按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mRegistBtn;
/**
 *  今日签到＋
 */
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mRegistContent;
/**
 *  滑动view
 */
@property (weak, nonatomic) IBOutlet UIView *mSliderView;
/**
 *  签到多少天
 */
@property (weak, nonatomic) IBOutlet UILabel *mDays;
/**
 *  账户余额
 */
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mBalance;

#pragma mark ----第二种cell样式
/**
 *  添加的子视图
 */
@property (weak, nonatomic) IBOutlet UIView *mSubView;

#pragma mark ----第三种cell样式
/**
 *  交易记录
 */
@property (weak, nonatomic) IBOutlet UIView *mTradeView;
/**
 *  交易记录按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mTradeBtn;
/**
 *  积分记录
 */
@property (weak, nonatomic) IBOutlet UIView *mScoreView;
/**
 *  积分记录按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mScoreBtn;
/**
 *  红包
 */
@property (weak, nonatomic) IBOutlet UIView *mRedBagView;
/**
 *  红包按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mRedbagBtn;
/**
 *  收款
 */
@property (weak, nonatomic) IBOutlet UIView *mCollectionView;
/**
 *  收款按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mCollectionBtn;

/**
 *  顶部4个按钮的数据源
 */
@property (strong,nonatomic) NSArray *mTopFourBtnArr;


/**
 *  积分
 */
@property (assign,nonatomic)int mFScore;
/**
 *  余额
 */
@property (assign,nonatomic)float mFBalance;
/**
 *  累计签到多少天
 */
@property (assign,nonatomic)int mFDays;

@end
