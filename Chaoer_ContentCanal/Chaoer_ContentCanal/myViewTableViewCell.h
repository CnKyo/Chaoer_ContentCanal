//
//  myViewTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/4/1.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myViewTableViewCell : UITableViewCell
/**
 *  图片
 */
@property (strong, nonatomic) IBOutlet UIImageView *mImg;
/**
 *  标题
 */
@property (strong, nonatomic) IBOutlet UILabel *mTitle;
/**
 *  详情
 */
@property (strong, nonatomic) IBOutlet UILabel *mDetail;


@end
