//
//  QHLTableViewCell.h
//  shoppingCar
//
//  Created by Apple on 16/1/12.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QHLGoods.h"
@class QHLTableViewCell;
@class QHLButton;

@protocol QHLTableViewCellDelegate <NSObject>
/**
 *  选中按钮代理方法
 *
 *  @param cell              选中的cell
 *  @param selBtnSelectState 是否选中
 *  @param indexPath         选择的索引
 */
- (void)cell:(QHLTableViewCell *)cell selBtnDidClickToChangeAllSelBtn:(BOOL)selBtnSelectState andIndexPath:(NSIndexPath *)indexPath;
/**
 *  删除按钮代理方法
 *
 *  @param cell       选中的cell
 *  @param isSelected 是否选中
 *  @param indexPath  选择的索引
 */
- (void)cell:(QHLTableViewCell *)cell deleteBtnDidClicked:(BOOL)isSelected andIndexPath:(NSIndexPath *)indexPath;
@end

@interface QHLTableViewCell : UITableViewCell

@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *mPrice;

/**
 *  商品模型
 */
@property (nonatomic, strong) QHLGoods *goods;
/**
 *  索引
 */
@property (nonatomic, weak) NSIndexPath *indexPath;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**
 *  代理方法
 */
@property (nonatomic, weak) id<QHLTableViewCellDelegate> cellDelegate;
@end
