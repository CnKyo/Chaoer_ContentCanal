//
//  communityOrderDetailCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/29.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface communityOrderDetailCell : UITableViewCell

#pragma mark----第一种cell类型
/**
 *  背景1
 */
@property (weak, nonatomic) IBOutlet UIView *mBgkView1;
/**
 *  背景2
 */
@property (weak, nonatomic) IBOutlet UIView *mbgkView2;
/**
 *  订单编号
 */
@property (weak, nonatomic) IBOutlet UILabel *mOrderCode;
/**
 *  创建时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mCreateTime;
/**
 *  订单状态
 */
@property (weak, nonatomic) IBOutlet UILabel *mOrderStatus;
/**
 *  查看按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mCheckBtn;
/**
 *  收货地址
 */
@property (weak, nonatomic) IBOutlet UILabel *mOrderAddress;

#pragma mark----第二种cell类型
/**
 *  背景
 */
@property (weak, nonatomic) IBOutlet UIView *mBgk;
/**
 *  商品信息
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsMsg;
/**
 *  商品图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mGoodsImg;
/**
 *  商品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsName;
/**
 *  商品说明
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsDetail;
/**
 *  商品规格
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsRule;
/**
 *  商品价格
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsPrice;
/**
 *  总金额
 */
@property (weak, nonatomic) IBOutlet UILabel *mTotleMoney;

@end
