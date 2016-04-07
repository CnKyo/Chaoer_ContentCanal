//
//  walletView.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/4/5.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICountingLabel.h"

@interface walletView : UIView

/**
 *  余额
 */
@property (strong, nonatomic) IBOutlet UIView *mBalanceView;
/**
 *  余额lb
 */
@property (strong, nonatomic) IBOutlet UICountingLabel *mBalanceLb;

/**
 *  积分
 */
@property (strong, nonatomic) IBOutlet UICountingLabel *mScore;
/**
 *  提现按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *withdrawalBtn;
/**
 *  充值按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *topupBtn;
/**
 *  订单
 */
@property (strong, nonatomic) IBOutlet UIButton *mOrderBtn;
/**
 *  交易记录
 */
@property (strong, nonatomic) IBOutlet UIButton *mHistoryBtn;
/**
 *  红包
 */
@property (weak, nonatomic) IBOutlet UIButton *mRedBagBtn;

/**
 *  初始化方法
 *
 *  @return view
 */
+ (walletView *)shareView;

@end
