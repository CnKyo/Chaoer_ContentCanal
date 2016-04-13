//
//  communityStatusTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/13.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface communityStatusTableViewCell : UITableViewCell
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mImage;
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *mTitle;
/**
 *  内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;
/**
 *  时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mTime;


@end
