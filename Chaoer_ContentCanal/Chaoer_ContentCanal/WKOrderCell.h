//
//  WKOrderCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QHLGoods.h"
#import "QHLButton.h"
@class WKOrderCell;
@class QHLButton;

@protocol WKOrderCellDelegate <NSObject>

@optional
/**
 *  选中按钮代理方法
 *
 *  @param cell              选中的cell
 *  @param selBtnSelectState 是否选中
 *  @param indexPath         选择的索引
 */
- (void)cell:(WKOrderCell *)cell cellDidSelected:(BOOL)selBtnSelectState andIndexPath:(NSIndexPath *)indexPath;


@end
@interface WKOrderCell : UITableViewCell
/**
 *  选择按钮
 */
@property (nonatomic, weak) QHLButton *mBtn;
/**
 *  图片
 */
@property (nonatomic, weak) UIImageView *mImgView;
/**
 *  名称
 */
@property (nonatomic, weak) UILabel *mName;
/**
 *  内容
 */
@property (nonatomic, weak) UILabel *mContent;
/**
 *  价格
 */
@property (nonatomic, weak) UILabel *mPrice;
/**
 *  线
 */
@property (nonatomic, strong) UIView *mLine;

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
@property (nonatomic, weak) id<WKOrderCellDelegate> WKCellDelegate;

@end
