//
//  mFoodTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  cell的代理方法
 */
@protocol WKFoodCellDelegate <NSObject>

@optional
/**
 *  减按钮的代理方法
 *
 *  @param mIndexPath 索引
 *  @param mTag       标签
 */
- (void)WKFoodCellWithJianBtnClickWithIndexPath:(NSIndexPath *)mIndexPath andTag:(NSInteger)mTag;
/**
 *  加按钮的代理方法
 *
 *  @param mIndexPath 索引
 *  @param mTag       标签
 */
- (void)WKFoodCellWithAddBtnClickWithIndexPath:(NSIndexPath *)mIndexPath andTag:(NSInteger)mTag;

@end

@interface mFoodTableViewCell : UITableViewCell
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mLogo;
/**
 *  买菜
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;
/**
 *  详情
 */
@property (weak, nonatomic) IBOutlet UILabel *mDescrip;
/**
 *  评价
 */
@property (weak, nonatomic) IBOutlet UILabel *mRate;
/**
 *  价格
 */
@property (weak, nonatomic) IBOutlet UILabel *mPrice;
/**
 *  减按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mJianBtn;
/**
 *  数量
 */
@property (weak, nonatomic) IBOutlet UILabel *mNum;
/**
 *  加按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mAddBtn;
/**
 *  索引
 */
@property (strong,nonatomic) NSIndexPath *mIndexPath;
/**
 *  代理
 */
@property (strong,nonatomic) id<WKFoodCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UILabel *mClassName;


@end
