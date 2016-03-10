//
//  wkOrderDetail.h
//  O2O_JiazhengSeller
//
//  Created by 密码为空！ on 15/8/7.
//  Copyright (c) 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface wkOrderDetail : UIView
/**
*  顶部view
*/
@property (weak, nonatomic) IBOutlet UIView *wkView1;
/**
 *  底部view
 */
@property (weak, nonatomic) IBOutlet UIView *wkView2;
/**
 *  订单状态
 */
@property (weak, nonatomic) IBOutlet UILabel *wkOrderStatus;
/**
 *  订单编号
 */
@property (weak, nonatomic) IBOutlet UILabel *wkOrderid;
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *wkImg;
/**
 *  服务名称
 */
@property (weak, nonatomic) IBOutlet UILabel *wkServiceName;
/**
 *  价格
 */
@property (weak, nonatomic) IBOutlet UILabel *wkPrice;
/**
 *  时长
 */
@property (weak, nonatomic) IBOutlet UILabel *wkShichang;
/**
 *  预约时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mServiceTime;
/**
 *  服务地址
 */
@property (weak, nonatomic) IBOutlet UILabel *wkAddress;
/**
 *  用户名
 */
@property (weak, nonatomic) IBOutlet UILabel *wkUserName;
/**
 *  电话号码
 */
@property (weak, nonatomic) IBOutlet UILabel *wkPhone;
/**
 *  电话按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *wkConnectBtn;

/**
 *  通用view
 *
 *  @return view
 */
+ (wkOrderDetail *)shareOrderDetail;


@property (weak, nonatomic) IBOutlet UIButton *mapNavBtn;

@property (weak, nonatomic) IBOutlet UIView *mQQmapView;
+ (wkOrderDetail *)shareMapView;

@end
