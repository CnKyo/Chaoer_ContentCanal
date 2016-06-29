//
//  mOrderStatusCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/29.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mOrderStatusCell : UITableViewCell
/**
 *  顶部线
 */
@property (weak, nonatomic) IBOutlet UIView *mTopLine;
/**
 *  点
 */
@property (weak, nonatomic) IBOutlet UIImageView *mPoint;
/**
 *  底部的线
 */
@property (weak, nonatomic) IBOutlet UIView *mBottomLine;
/**
 *  状态
 */
@property (weak, nonatomic) IBOutlet UILabel *mStatus;
/**
 *  时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mTime;
/**
 *  内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;


@end
