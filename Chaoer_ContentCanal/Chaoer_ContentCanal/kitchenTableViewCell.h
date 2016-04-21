//
//  kitchenTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/6.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface kitchenTableViewCell : UITableViewCell

/**
 *  背景图
 */
@property (weak, nonatomic) IBOutlet UIImageView *mBgkImg;
/**
 *  文本内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;
/**
 *  左边标签
 */
@property (weak, nonatomic) IBOutlet UILabel *mLeftLb;

@end
