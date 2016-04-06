//
//  choiseServicerTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/23.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"
@interface choiseServicerTableViewCell : UITableViewCell
/**
 *  头像
 */
@property (strong, nonatomic) IBOutlet UIImageView *mHeader;
/**
 *  名称
 */
@property (strong, nonatomic) IBOutlet UILabel *mName;
/**
 *  电话
 */
@property (strong, nonatomic) IBOutlet UILabel *mPhone;
/**
 *  评分
 */
@property (strong, nonatomic) IBOutlet CWStarRateView *mRaitingView;
/**
 *  预约按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mDoneBtn;
/**
 *  距离
 */
@property (strong, nonatomic) IBOutlet UILabel *mDistance;



@end
