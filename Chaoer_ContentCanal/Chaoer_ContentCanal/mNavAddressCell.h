//
//  mNavAddressCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/2.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mNavAddressCell : UITableViewCell
/**
 *  定位图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *mLocationImg;
/**
 *  地址
 */
@property (weak, nonatomic) IBOutlet UILabel *mAddress;
/**
 *  地址左边的约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mAddressLeft;


@end
