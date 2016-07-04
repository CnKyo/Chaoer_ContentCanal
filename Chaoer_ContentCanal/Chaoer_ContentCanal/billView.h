//
//  billView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface billView : UIView
/**
 *  发票类型
 */
@property (weak, nonatomic) IBOutlet UILabel *mBillType;
/**
 *  个人
 */
@property (weak, nonatomic) IBOutlet UIButton *mBillPersonBtn;
/**
 *  单位
 */
@property (weak, nonatomic) IBOutlet UIButton *mBillUninBtn;
/**
 *  发票抬头
 */
@property (weak, nonatomic) IBOutlet UITextField *mBillTx;
/**
 *  发票明细
 */
@property (weak, nonatomic) IBOutlet UIButton *mBillDetailBTn;
/**
 *  发票耗材
 */
@property (weak, nonatomic) IBOutlet UIButton *mBillConsumableBtn;
/**
 *  发票办公用品
 */
@property (weak, nonatomic) IBOutlet UIButton *mBillOfficeBtn;
/**
 *  发票电脑配件
 */
@property (weak, nonatomic) IBOutlet UIButton *mBillPcBtn;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (billView *)shareView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mTxViewH;


@end
