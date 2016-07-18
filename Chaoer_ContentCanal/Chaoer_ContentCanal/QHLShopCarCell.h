//
//  QHLShopCarCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/18.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QHLGoods.h"
#import "QHLButton.h"

@class QHLShopCarCell;
@class QHLButton;

@protocol WKTableViewCellDelegate <NSObject>
/**
 *  选中按钮代理方法
 *
 *  @param cell              选中的cell
 *  @param selBtnSelectState 是否选中
 *  @param indexPath         选择的索引
 */
- (void)cell:(QHLShopCarCell *)cell selBtnDidClickToChangeAllSelBtn:(BOOL)selBtnSelectState andIndexPath:(NSIndexPath *)indexPath;

/**
 *  商品减按钮代理方法
 *
 *  @param cell       选中的cell
 *  @param isSelected 是否选中
 *  @param indexPath  选择的索引
 */
- (void)cell:(QHLShopCarCell *)cell JianBtnDidClicked:(BOOL)isSelected andIndexPath:(NSIndexPath *)indexPath;

/**
 *  商品加按钮代理方法
 *
 *  @param cell       选中的cell
 *  @param isSelected 是否选中
 *  @param indexPath  选择的索引
 */
- (void)cell:(QHLShopCarCell *)cell AddBtnDidClicked:(BOOL)isSelected andIndexPath:(NSIndexPath *)indexPath;
@end
@interface QHLShopCarCell : UITableViewCell
/**
 *  索引
 */
@property (nonatomic, weak) NSIndexPath *indexPath;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**
 *  代理方法
 */
@property (nonatomic, weak) id<WKTableViewCellDelegate> cellDelegate;
/**
 *  商品模型
 */
@property (nonatomic, strong) QHLGoods *mGoods;

@property (weak, nonatomic) IBOutlet QHLButton *mSelectedBtn;

@property (weak, nonatomic) IBOutlet UIImageView *mProLogo;

@property (weak, nonatomic) IBOutlet UILabel *mName;

@property (weak, nonatomic) IBOutlet UILabel *mPrice;

@property (weak, nonatomic) IBOutlet UILabel *mContent;

@property (weak, nonatomic) IBOutlet UIView *mOpratorView;

@property (weak, nonatomic) IBOutlet QHLButton *mJianBtn;

@property (weak, nonatomic) IBOutlet UILabel *mNum;

@property (weak, nonatomic) IBOutlet QHLButton *mAddBtn;


@end
