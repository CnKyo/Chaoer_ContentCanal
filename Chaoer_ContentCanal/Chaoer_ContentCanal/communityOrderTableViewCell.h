//
//  communityOrderTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/24.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPHotspotLabel.h"
@class GMyMarketOrderList;
@protocol cellWithBtnClickDelegate <NSObject>

@optional

- (void)cellWithBtnClickAction:(GMyMarketOrderList *)mShop;

@end

@interface communityOrderTableViewCell : UITableViewCell
/**
 *  下单时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mTime;
/**
 *  订单编号
 */
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mOrderCode;
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mLogo;
/**
 *  名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mNane;
/**
 *  内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;
/**
 *  价格
 */
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mPrice;
/**
 *  按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mdobtn;

@property (strong,nonatomic) GMyMarketOrderList *mShop;

@property (strong,nonatomic) id <cellWithBtnClickDelegate> delegate;

@end
