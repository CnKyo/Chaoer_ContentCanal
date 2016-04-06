//
//  communityTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/12.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface communityTableViewCell : UITableViewCell

/**
 *  图片
 */
@property (strong, nonatomic) IBOutlet UIImageView *mLogo;
/**
 *  名称
 */
@property (strong, nonatomic) IBOutlet UILabel *mName;
/**
 *  距离
 */
@property (strong, nonatomic) IBOutlet UILabel *mDistance;
/**
 *  时间
 */
@property (strong, nonatomic) IBOutlet UILabel *mTime;
/**
 *  内容
 */
@property (strong, nonatomic) IBOutlet UILabel *mContent;







@end
