//
//  mFixOrderDetailTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/6.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mFixOrderDetailTableViewCell : UITableViewCell
/**
 *  订单状态
 */
@property (weak, nonatomic) IBOutlet UIImageView *mOrderStatusImg;
/**
 *  订单状态
 */
@property (weak, nonatomic) IBOutlet UILabel *mStatus;

/**
 *  师傅姓名
 */
@property (weak, nonatomic) IBOutlet UILabel *mServiceName;
/**
 *  师傅电话
 */
@property (weak, nonatomic) IBOutlet UILabel *mServicePhone;
/**
 *  拨打电话
 */
@property (weak, nonatomic) IBOutlet UIButton *mConnectBtn;
/**
 *  订单类型
 */
@property (weak, nonatomic) IBOutlet UILabel *mOrderName;
/**
 *  订单编号
 */
@property (weak, nonatomic) IBOutlet UILabel *mOrderCode;
/**
 *  服务时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mOrderTime;
/**
 *  服务地址
 */
@property (weak, nonatomic) IBOutlet UILabel *mAddress;
/**
 *  支付金额    
 */
@property (weak, nonatomic) IBOutlet UILabel *mMoney;



@end
