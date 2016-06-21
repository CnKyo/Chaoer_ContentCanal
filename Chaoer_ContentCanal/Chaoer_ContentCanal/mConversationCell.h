//
//  mConversationCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/28.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mConversationCell : UITableViewCell

#pragma mark----第一种聊天cell
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *mHeaderImg;
/**
 *  姓名
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;
/**
 *  距离
 */
@property (weak, nonatomic) IBOutlet UILabel *mDistance;
/**
 *  起泡
 */
@property (weak, nonatomic) IBOutlet UILabel *mBage;



@end
