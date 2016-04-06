//
//  wpgTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface wpgTableViewCell : UITableViewCell
/**
 *  图片
 */
@property (strong, nonatomic) IBOutlet UIImageView *mLogo;
/**
 *  项目
 */
@property (strong, nonatomic) IBOutlet UILabel *mName;


@end
