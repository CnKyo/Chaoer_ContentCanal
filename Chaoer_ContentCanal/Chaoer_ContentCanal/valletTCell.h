//
//  valletTCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/6.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface valletTCell : UITableViewCell
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mImf;
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *mtitle;
/**
 *  时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mTime;
/**
 *  积分
 */
@property (weak, nonatomic) IBOutlet UILabel *mScore;
/**
 *  状态
 */
@property (weak, nonatomic) IBOutlet UILabel *mStatus;

@end
