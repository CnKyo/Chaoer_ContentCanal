//
//  pptHistoryTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/13.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pptHistoryTableViewCell : UITableViewCell
/**
 *  名称和时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mNameAndTime;
/**
 *  状态
 */
@property (weak, nonatomic) IBOutlet UILabel *mStatus;
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mImg;
/**
 *  内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;
/**
 *  时间和距离
 */
@property (weak, nonatomic) IBOutlet UILabel *mDistanceAndTime;
/**
 *  酬金
 */
@property (weak, nonatomic) IBOutlet UILabel *mMoney;

/**
 *  评价按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mRateBtn;


@end
