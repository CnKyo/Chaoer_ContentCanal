//
//  mPublicWalerViewController.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface mPublicWalerViewController : BaseVC
/**
 *  活动名称
 */
@property (strong, nonatomic) IBOutlet UILabel *mActivityName;
/**
 *  列表
 */
@property (strong, nonatomic) IBOutlet UITableView *mTableView;
/**
 *  时间
 */
@property (strong, nonatomic) IBOutlet UILabel *mTime;
/**
 *  状态
 */
@property (strong, nonatomic) IBOutlet UIImageView *mStatus;
/**
 *  参加按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mJoinBtn;





@end
