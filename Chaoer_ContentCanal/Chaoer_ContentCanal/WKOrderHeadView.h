//
//  WKOrderHeadView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WKOrderHeadView;
/**
 *  设置代理
 */
@protocol WKHeaderViewDelegate <NSObject>

@optional
/**
 *  代理方法
 *
 *  @param mHeaderView 选择的view
 *  @param mSelected   是否选中
 *  @param mSection    选中的section
 */
- (void)headerWithView:(WKOrderHeadView *)mHeaderView andBtnSelected:(BOOL)mSelected andSection:(NSInteger)mSection;

@end

@interface WKOrderHeadView : UITableViewHeaderFooterView
/**
 *  店铺对象
 */
@property (nonatomic, strong) GMyMarketOrderList *shop;
/**
 *  分组
 */
@property (nonatomic, assign) NSInteger section;
/**
 *  代理
 */
@property (nonatomic, weak) id<WKHeaderViewDelegate> WKHeaderViewDelegate;
/**
 *  选中按钮
 */
@property (strong, nonatomic)  UIButton *mSelectBtn;
/**
 *  店铺图片
 */
@property (strong, nonatomic)  UIImageView *mStoreImg;
/**
 *  名称
 */
@property (strong, nonatomic)  UILabel *mName;
/**
 *  状态
 */
@property (strong, nonatomic)  UILabel *mStatus;
/**
 *  <#Description#>
 */
@property (strong, nonatomic)  UIView *mLine1;
/**
 *  <#Description#>
 */
@property (strong, nonatomic)  UIView *mLine2;

/**
 *  初始化方法
 *
 *  @param tableView 加载列表
 *
 *  @return 返回初始化方法
 */
+ (instancetype)headerWithTableView:(UITableView *)tableView;

@end
