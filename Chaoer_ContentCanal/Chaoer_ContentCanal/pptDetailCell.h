//
//  pptDetailCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mOrderButton.h"
@interface pptDetailCell : UITableViewCell
#pragma mark----办事情cell样式

@property (weak, nonatomic) IBOutlet UIImageView *mBgkImg;


/**
 *  订单详情
 */
@property (weak, nonatomic) IBOutlet UILabel *mOrderDetailName;
/**
 *  标签view
 */
@property (weak, nonatomic) IBOutlet UIView *mTagView;
/**
 *  酬劳金额
 */
@property (weak, nonatomic) IBOutlet UILabel *mTHXMoney;
/**
 *  订单号
 */
@property (weak, nonatomic) IBOutlet UILabel *mOrderNum;
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *mHeaderImg;
/**
 *  订单名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mOrderName;
/**
 *  服务人名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mServiceName;
/**
 *  电话
 */
@property (weak, nonatomic) IBOutlet UILabel *mPhone;
/**
 *  服务时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mServiceTime;
/**
 *  到达地址
 */
@property (weak, nonatomic) IBOutlet UILabel *mArriveAddress;
/**
 *  跑腿费
 */
@property (weak, nonatomic) IBOutlet UILabel *mSendMoney;
/**
 *  订单类型
 */
@property (weak, nonatomic) IBOutlet UILabel *mOrderType;
/**
 *  支付类型
 */
@property (weak, nonatomic) IBOutlet UILabel *mPayType;
/**
 *  备注
 */
@property (weak, nonatomic) IBOutlet UILabel *mNote;
/**
 *  操作按钮
 */
@property (weak, nonatomic) IBOutlet mOrderButton *mDoBtn;

#pragma mark----送东西cell样式
/**
 *  物品价格
 */
@property (weak, nonatomic) IBOutlet UILabel *mStaffPrice;

/**
 *  发货地址 
 */
@property (weak, nonatomic) IBOutlet UILabel *mSendAddress;

#pragma mark----跑腿订单详情cell样式
/**
 *  背景
 */
@property (weak, nonatomic) IBOutlet UIView *mBgkView;
/**
 *  订单状态
 */
@property (weak, nonatomic) IBOutlet UILabel *mOrderStatus;
/**
 *  订单状态图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mOrderStatusImg;
/**
 *  等级
 */
@property (weak, nonatomic) IBOutlet UILabel *mLevel;
/**
 *  配送人信息
 */
@property (weak, nonatomic) IBOutlet UILabel *mSenderMg;


@end
