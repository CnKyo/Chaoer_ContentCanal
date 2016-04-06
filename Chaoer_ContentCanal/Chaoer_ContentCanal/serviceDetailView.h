//
//  serviceDetailView.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/23.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"

@interface serviceDetailView : UIView
#pragma mark----维修人员详情
/**
 *  头像
 */
@property (strong, nonatomic) IBOutlet UIImageView *mHeader;
/**
 *  姓名
 */
@property (strong, nonatomic) IBOutlet UILabel *mName;
/**
 *  电话
 */
@property (strong, nonatomic) IBOutlet UILabel *mPhpone;
/**
 *  公司
 */
@property (strong, nonatomic) IBOutlet UILabel *mCompany;
/**
 *  费用
 */
@property (strong, nonatomic) IBOutlet UILabel *mPrice;
/**
 *  评价
 */
@property (strong, nonatomic) IBOutlet CWStarRateView *mRaitView;


/**
 *  初始化方法
 *
 *  @return view
 */
+ (serviceDetailView *)shareView;

#pragma mark----报修订单详情
/**
 *  订单标签
 */
@property (strong, nonatomic) IBOutlet UILabel *mOrderTitle;
/**
 *  服务人员名称
 */
@property (strong, nonatomic) IBOutlet UILabel *mServiceName;
/**
 *  类别
 */
@property (strong, nonatomic) IBOutlet UILabel *mClass;
/**
 *  内容view
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
 *  保证金
 */
@property (strong, nonatomic) IBOutlet UILabel *mMoney;
/**
 *  确定按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mOkBtn;
/**
 *  初始化方法
 *
 *  @return view
 */
+ (serviceDetailView *)shareOrderView;

@end
