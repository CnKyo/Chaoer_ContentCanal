//
//  wkOrderCell.h
//  O2O_JiazhengSeller
//
//  Created by 密码为空！ on 15/8/6.
//  Copyright (c) 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface wkOrderCell : UITableViewCell
/**
 *  顶部view
 */
@property (weak, nonatomic) IBOutlet UIView *wkTopView;
/**
 *  订单名称
 */
@property (weak, nonatomic) IBOutlet UILabel *wkOrderName;
/**
 *  订单状态
 */
@property (weak, nonatomic) IBOutlet UILabel *wkOrderStatus;
/**
 *  电话
 */
@property (weak, nonatomic) IBOutlet UIButton *wkPhone;
/**
 *  地址
 */
@property (weak, nonatomic) IBOutlet UILabel *wkAddress;
/**
 *  预约时间
 */
@property (weak, nonatomic) IBOutlet UILabel *wkServiceTime;

/**
 *  价格
 */
@property (weak, nonatomic) IBOutlet UILabel *wkPrice;

/**
 *  时长
 */
@property (weak, nonatomic) IBOutlet UILabel *wkShichang;
/**
 *  客户名称
 */
@property (weak, nonatomic) IBOutlet UILabel *wkUserName;
/**
 *  电话号码
 */
@property (weak, nonatomic) IBOutlet UIButton *wkMobile;
/**
 *  导航按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *wkNavBtn;

/**
 *  服务按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *wkServiceBtn;
/**
 *  订单对象
 */
@property (strong,nonatomic) SOrder *model;

@property (assign,nonatomic) CGFloat    cellHeight;



///商品数量
@property (weak, nonatomic) IBOutlet UILabel *wkGoodsNum;

///订单号
@property (weak, nonatomic) IBOutlet UILabel *wkOrderId;

///图片view
@property (weak, nonatomic) IBOutlet UIView *wkServiceImgView;


@end
