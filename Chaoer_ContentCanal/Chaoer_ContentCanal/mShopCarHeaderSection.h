//
//  mShopCarHeaderSection.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/13.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QHLButton.h"
@class QHLButton;
@class mShopCarHeaderSection;


@protocol WKHeaderViewDelegate <NSObject>

@optional
- (void)headerView:(mShopCarHeaderSection *)headerView selBtnDidClickToChangeAllSelBtn:(BOOL)selBtnSelectState andSection:(NSInteger)section;

@end

@interface mShopCarHeaderSection : UIView
@property (weak, nonatomic) IBOutlet QHLButton *mSelBtn;

/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mHeaderImg;
/**
 *  名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;

/**
 *  内容
 */
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mContent;

/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (mShopCarHeaderSection *)shareHeaderView;
/**
 *  总金额
 */
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mTotalMoney;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (mShopCarHeaderSection *)shareFooterView;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, strong) GShopCarList *shop;
@property (nonatomic, weak) id<WKHeaderViewDelegate> headerViewDelegate;

@end
