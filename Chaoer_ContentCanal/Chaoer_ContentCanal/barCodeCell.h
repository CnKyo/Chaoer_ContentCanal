//
//  barCodeCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/5.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface barCodeCell : UITableViewCell

/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *mHeader;
/**
 *  名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mNickName;
/**
 *  电话
 */
@property (weak, nonatomic) IBOutlet UILabel *mPhone;
/**
 *  身份
 */
@property (weak, nonatomic) IBOutlet UILabel *mIdentify;
/**
 *  二维码
 */
@property (weak, nonatomic) IBOutlet UIImageView *mBarCode;

@property (weak, nonatomic) IBOutlet UIView *mMainView;

@property (weak, nonatomic) IBOutlet UIView *mSmallView;

@end
