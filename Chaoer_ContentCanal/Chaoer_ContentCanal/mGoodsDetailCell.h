//
//  mGoodsDetailCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/29.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  设置代理
 */
@protocol mHotGoodsSelectedDelegate <NSObject>

@optional
/**
 *  代理方法
 *
 *  @param index 返回索引
 */
- (void)cellDidSelectedWithIndex:(NSInteger)index;

@end

@interface mGoodsDetailCell : UITableViewCell
#pragma mark----第一种cell类型
/**
 *  商品图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mGoodsImg;
/**
 *  商品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsName;
/**
 *  商品内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsContent;
/**
 *  现价
 */
@property (weak, nonatomic) IBOutlet UILabel *mNoewPrice;
/**
 *  原价
 */
@property (weak, nonatomic) IBOutlet UILabel *mOldPrice;
/**
 *  产地
 */
@property (weak, nonatomic) IBOutlet UILabel *mAddress;
/**
 *  产地
 */
@property (weak, nonatomic) IBOutlet UILabel *mAddresss;
/**
 *  规格
 */
@property (weak, nonatomic) IBOutlet UILabel *mRule;
/**
 *  规格
 */
@property (weak, nonatomic) IBOutlet UILabel *mRules;
/**
 *  是否有货
 */
@property (weak, nonatomic) IBOutlet UILabel *mHave;
/**
 *  是否有货
 */
@property (weak, nonatomic) IBOutlet UILabel *mHaves;

#pragma mark----第二种cell类型
/**
 *  滚动视图
 */
@property (weak, nonatomic) IBOutlet UIScrollView *mScrollerView;
/**
 *  代理方法
 */
@property (strong,nonatomic) id <mHotGoodsSelectedDelegate> delegate;
/**
 *  滚动数据源
 */
@property (strong,nonatomic) NSArray *mDataSource;
@end
