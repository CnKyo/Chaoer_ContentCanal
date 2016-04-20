//
//  myOrderTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myOrderTableViewCell : UITableViewCell
#pragma mark---第一种cell样式
/**
 *  第一种cell样式
 *
 *  @param strong
 *  @param nonatomic
 *
 *  @return
 */
/**
 *  名称
 */
@property (strong, nonatomic) IBOutlet UILabel *mName;
/**
 *  数量
 */
@property (strong, nonatomic) IBOutlet UILabel *mNum;



#pragma mark---第二种cell样式
/**
 *  第二种cell样式
 */
/**
 *  订单名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mOrderName;
/**
 *  订单状态
 */
@property (weak, nonatomic) IBOutlet UILabel *mOrderStatus;
/**
 *  服务时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mServiceTime;
/**
 *  服务地址
 */
@property (weak, nonatomic) IBOutlet UILabel *mServiceAddress;

/**
 *  订单价格
 */
@property (weak, nonatomic) IBOutlet UILabel *mOrderPrice;
/**
 *  左边的按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mLeftBtn;
/**
 *  右边的按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mRightBtn;

@property (weak, nonatomic) IBOutlet UIImageView *mImage1;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mServiceTimeLeft;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mAddressLeft;


#pragma mark----第三种cell样式
/**
 *  手机logo
 */
@property (weak, nonatomic) IBOutlet UIImageView *mPhoneLogo;
/**
 *  手机号码
 */
@property (weak, nonatomic) IBOutlet UILabel *mPhone;
/**
 *  充值金额
 */
@property (weak, nonatomic) IBOutlet UILabel *mPhoneMoney;
/**
 *  交易时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mPhoneTime;
/**
 *  状态
 */
@property (weak, nonatomic) IBOutlet UILabel *mPhoneStatus;

@end
