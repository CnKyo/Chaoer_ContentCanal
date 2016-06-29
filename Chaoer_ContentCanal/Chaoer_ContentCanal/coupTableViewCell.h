//
//  coupTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/24.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface coupTableViewCell : UITableViewCell
/**
 *  背景
 */
@property (weak, nonatomic) IBOutlet UIImageView *mBgkImg;
/**
 *  金额
 */
@property (weak, nonatomic) IBOutlet UILabel *mMoney;
/**
 *  优惠内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;
/**
 *  店铺图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mLogo;
/**
 *  店铺名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mStore;
/**
 *  时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mTime;
/**
 *  是否失效还是使用
 */
@property (weak, nonatomic) IBOutlet UIImageView *mIsValid;

@end
