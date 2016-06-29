//
//  communityTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/12.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol WKBanerSelectedDelegate <NSObject>

@optional
/**
 *  banaer的选择
 *
 *  @param mIndex 标签
 */
- (void)cellDidSelectedBanerIndex:(NSInteger)mIndex;
/**
 *  热卖商品的选择
 *
 *  @param mIndex 标签
 */
- (void)cellWithScrollerViewSelectedIndex:(NSInteger)mIndex;



@end

@interface communityTableViewCell : UITableViewCell
#pragma mark----cell1
/**
 *  banerview
 */
@property (weak, nonatomic) IBOutlet UIView *mBanerView;

@property (strong,nonatomic) id <WKBanerSelectedDelegate> delegate;

#pragma mark----cell2
/**
 *  滚动view
 */
@property (weak, nonatomic) IBOutlet UIScrollView *mScrollerView;

#pragma mark----通用cell3
/**
 *  图片
 */
@property (strong, nonatomic) IBOutlet UIImageView *mLogo;
/**
 *  名称
 */
@property (strong, nonatomic) IBOutlet UILabel *mName;
/**
 *  距离
 */
@property (strong, nonatomic) IBOutlet UILabel *mDistance;
/**
 *  活动
 */
@property (strong, nonatomic) IBOutlet UILabel *mActivity;
/**
 *  内容
 */
@property (strong, nonatomic) IBOutlet UILabel *mContent;
/**
 *  数量
 */
@property (weak, nonatomic) IBOutlet UILabel *mNum;
/**
 *  主视图
 */
@property (weak, nonatomic) IBOutlet UIView *mMainView;
/**
 *  baner数据源
 */
@property (strong,nonatomic) NSArray *mDataSourceArr;
/**
 *  滚动数据源
 */
@property (strong,nonatomic) NSArray *mScrollerSourceArr;

@end
