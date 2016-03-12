//
//  mFixTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/12.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mFixTableViewCell : UITableViewCell

/**
 *  图片
 */
@property (strong, nonatomic) IBOutlet UIImageView *mLogo;
/**
 *  姓名
 */
@property (strong, nonatomic) IBOutlet UILabel *mName;

/**
 *  电话
 */
@property (strong, nonatomic) IBOutlet UILabel *mPhone;

@end
