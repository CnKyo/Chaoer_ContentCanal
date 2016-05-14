//
//  pptMyRateCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pptMyRateCell : UITableViewCell
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *mHeader;
/**
 *  姓名
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;
/**
 *  时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mTime;
/**
 *  评价view
 */
@property (weak, nonatomic) IBOutlet UIView *mRateView;
/**
 *  分钟数？
 */
@property (weak, nonatomic) IBOutlet UILabel *mPoint;
/**
 *  评价内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;

@end
