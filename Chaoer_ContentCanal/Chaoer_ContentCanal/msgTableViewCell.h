//
//  msgTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/6.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface msgTableViewCell : UITableViewCell
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mImg;

/**
 *  内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mcontent;
/**
 *  消息提示点
 */
@property (weak, nonatomic) IBOutlet UIImageView *mMPoint;


/**
 *  消息logo
 */
@property (weak, nonatomic) IBOutlet UIImageView *mLogo;
/**
 *  消息时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mTime;
/**
 *  消息详情
 */
@property (weak, nonatomic) IBOutlet UILabel *mDetail;
/**
 *  消息提示点
 */
@property (weak, nonatomic) IBOutlet UIImageView *mPoint;
/**
 *  消息标题
 */
@property (weak, nonatomic) IBOutlet UILabel *mTitle;







@end
