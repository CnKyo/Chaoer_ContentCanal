//
//  makeServiceDetailView.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/24.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"
@interface makeServiceDetailView : UIView

/**
 *  订单名称
 */
@property (strong, nonatomic) IBOutlet UILabel *mOrderName;
/**
 *  维修人员
 */
@property (strong, nonatomic) IBOutlet UILabel *mServiceName;
/**
 *  报修类别
 */
@property (strong, nonatomic) IBOutlet UILabel *mServiceClass;
/**
 *  内容
 */
@property (strong, nonatomic) IBOutlet UIView *mContentView;
/**
 *  地址
 */
@property (strong, nonatomic) IBOutlet UILabel *mAddress;
/**
 *  电话
 */
@property (strong, nonatomic) IBOutlet UILabel *mPhone;
/**
 *  服务时间
 */
@property (strong, nonatomic) IBOutlet UILabel *mServiceTime;
/**
 *  服务价格
 */
@property (strong, nonatomic) IBOutlet UILabel *mServicePrice;
/**
 *  余额支付
 */
@property (strong, nonatomic) IBOutlet UIImageView *mBalance;
/**
 *  积分支付
 */
@property (strong, nonatomic) IBOutlet UIImageView *mScore;
/**
 *  评价
 */
@property (strong, nonatomic) IBOutlet CWStarRateView *mRaitView;
/**
 *  确定按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mOkBtn;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (makeServiceDetailView *)shareOrderDetailView;

@end
