//
//  pptMyInfoCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/13.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pptMyInfoCell : UITableViewCell
/**
 *  姓名
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;
/**
 *  性别
 */
@property (weak, nonatomic) IBOutlet UILabel *mSex;
/**
 *  帐户
 */
@property (weak, nonatomic) IBOutlet UILabel *mAcount;
/**
 *  联系方式
 */
@property (weak, nonatomic) IBOutlet UILabel *mConnect;
/**
 *  身份证
 */
@property (weak, nonatomic) IBOutlet UILabel *mIdentify;
/**
 *  担保金
 */
@property (weak, nonatomic) IBOutlet UILabel *mMoney;

@end
