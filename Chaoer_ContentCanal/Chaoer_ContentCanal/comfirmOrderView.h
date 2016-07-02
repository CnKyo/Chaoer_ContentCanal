//
//  comfirmOrderView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/28.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface comfirmOrderView : UIView
/**
 *  地址
 */
@property (weak, nonatomic) IBOutlet UILabel *mAddress;
/**
 *  选择地址
 */
@property (weak, nonatomic) IBOutlet UIButton *mAddressBtn;
/**
 *  商品图片1
 */
@property (weak, nonatomic) IBOutlet UIImageView *mGoods1;
/**
 *  商品图片2
 */
@property (weak, nonatomic) IBOutlet UIImageView *mGoods2;
/**
 *  商品图片3
 */
@property (weak, nonatomic) IBOutlet UIImageView *mGoods3;
/**
 *  总共多少件商品
 */
@property (weak, nonatomic) IBOutlet UILabel *mTotleNum;
/**
 *  查看商品图片
 */
@property (weak, nonatomic) IBOutlet UIButton *mChekGoods;
/**
 *  需要发票？
 */
@property (weak, nonatomic) IBOutlet UILabel *mNeedRecipt;
/**
 *  选择发票
 */
@property (weak, nonatomic) IBOutlet UIButton *mReciptBtn;
/**
 *  需要优惠券
 */
@property (weak, nonatomic) IBOutlet UILabel *mNeedCoup;
/**
 *  选择优惠卷
 */
@property (weak, nonatomic) IBOutlet UIButton *mCoupBtn;
/**
 *  积分
 */
@property (weak, nonatomic) IBOutlet UILabel *mScore;
/**
 *  选择积分
 */
@property (weak, nonatomic) IBOutlet UIButton *mScroreBtn;
/**
 *  备注
 */
@property (weak, nonatomic) IBOutlet UITextField *mNoteTx;
/**
 *  总价
 */
@property (weak, nonatomic) IBOutlet UILabel *mTotleMoney;
/**
 *  运费
 */
@property (weak, nonatomic) IBOutlet UILabel *mTransPrice;
/**
 *  选择标签 
 */
@property (weak, nonatomic) IBOutlet UIButton *mSelecteLabel;


/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (comfirmOrderView *)shareView;
/**
 *  支付金额
 */
@property (weak, nonatomic) IBOutlet UILabel *mPayMoney;
/**
 *  去支付按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mGoPayBtn;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (comfirmOrderView *)sharePayView;

@end
