//
//  mMarkeyRateCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/12.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQTextView.h"
#import "StarsView.h"
@interface mMarkeyRateCell : UITableViewCell




/**
 *  整体评价
 */
@property (weak, nonatomic) IBOutlet UIView *mTotalRateView;
/**
 *  整体评价
 */
@property (weak, nonatomic) IBOutlet UILabel *mTotalStatus;
/**
 *  配送者评价
 */
@property (weak, nonatomic) IBOutlet UIView *mSenderRate;
/**
 *  配送者评价
 */
@property (weak, nonatomic) IBOutlet UILabel *mSenderStatus;
/**
 *  商品评价
 */
@property (weak, nonatomic) IBOutlet UIView *mProductRateView;
/**
 *  商品评价
 */
@property (weak, nonatomic) IBOutlet UILabel *mProductStatus;
/**
 *  商品图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mProductImg;
/**
 *  商品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;
/**
 *  商品详情
 */
@property (weak, nonatomic) IBOutlet UILabel *mDetail;
/**
 *  查看商品按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mDetailBtn;
/**
 *  评价
 */
@property (weak, nonatomic) IBOutlet IQTextView *mRateTx;









@end
