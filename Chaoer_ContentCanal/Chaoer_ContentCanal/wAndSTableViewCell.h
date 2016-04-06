//
//  wAndSTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface wAndSTableViewCell : UITableViewCell
/**
 *  图片
 */
@property (strong, nonatomic) IBOutlet UIImageView *mLogo;
/**
 *  店铺名称
 */
@property (strong, nonatomic) IBOutlet UILabel *mShopName;
/**
 *  距离
 */
@property (strong, nonatomic) IBOutlet UILabel *mDistance;
/**
 *  时间
 */
@property (strong, nonatomic) IBOutlet UILabel *mTime;
/**
 *  选择
 */
@property (strong, nonatomic) IBOutlet UILabel *mChoice;
/**
 *  减按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mDelBtn;
/**
 *  数量
 */
@property (strong, nonatomic) IBOutlet UILabel *mNum;
/**
 *  加按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mAddBtn;
/**
 *  用户
 */
@property (strong, nonatomic) IBOutlet UILabel *mUser;
/**
 *  销量
 */
@property (strong, nonatomic) IBOutlet UILabel *mSalesNum;


@end
