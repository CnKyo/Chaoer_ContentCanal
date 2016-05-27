//
//  pptTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mOrderButton.h"

@interface pptTableViewCell : UITableViewCell
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *mHeader;
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *mTitle;
/**
 *  距离
 */
@property (weak, nonatomic) IBOutlet UILabel *mDistance;
/**
 *  酬金
 */
@property (weak, nonatomic) IBOutlet UILabel *mMoney;
/**
 *  接手按钮
 */
@property (weak, nonatomic) IBOutlet mOrderButton *mDoneBtn;




@end
