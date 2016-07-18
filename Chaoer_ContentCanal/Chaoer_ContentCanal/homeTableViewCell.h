//
//  homeTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/10.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  代理方法
 */
@protocol WKHomeCellDelegate <NSObject>

@optional
/**
 *  baner的点击代理方法
 *
 *  @param mIndex 返回索引
 */
- (void)cellWithBanerClicked:(NSInteger)Index;
/**
 *  子视图的点击代理方法
 *
 *  @param mIndex 返回索引
 */
- (void)cellWithSubViewClicked:(NSInteger)Index;
/**
 *  主视图的点击代理方法
 *
 *  @param mIndex 返回索引
 */
- (void)cellWithMainViewClicked:(NSInteger)Index;

@end

@interface homeTableViewCell : UITableViewCell
/**
 *  baner数据源
 */
@property (strong,nonatomic) NSArray *mDataSourceArr;
/**
 *  子视图数据源
 */
@property (strong,nonatomic) NSArray *mSubArr;
/**
 *  主视图数据源
 */
@property (strong,nonatomic) NSArray *mMainArr;
/**
 *  代理方法
 */
@property (strong,nonatomic) id <WKHomeCellDelegate> delegate;


@end
