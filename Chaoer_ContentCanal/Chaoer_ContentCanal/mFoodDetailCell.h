//
//  mFoodDetailCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mFoodDetailCell : UITableViewCell
/**
 *  规格
 */
@property (weak, nonatomic) IBOutlet UIView *mSpecView;
/**
 *  评价数量
 */
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mRateNum;
/**
 *  评价率
 */
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mRatePoint;
/**
 *  评价view
 */
@property (weak, nonatomic) IBOutlet UIView *mRateView;


@end
