//
//  cashViewController.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/24.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface cashViewController : BaseVC
/**
 *  余额
 */
@property (strong, nonatomic) IBOutlet UILabel *mBalance;
/**
 *  金额
 */
@property (strong, nonatomic) IBOutlet UITextField *mMoneyTx;
/**
 *  银行卡
 */
@property (strong, nonatomic) IBOutlet UITextField *mBankNumTx;
/**
 *  银行图标
 */
@property (strong, nonatomic) IBOutlet UIImageView *mBankImg;
/**
 *  到账时间
 */
@property (strong, nonatomic) IBOutlet UIButton *mTimeBtn;
/**
 *  确认按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mOkBtn;
/**
 *  银行卡
 */
@property (weak, nonatomic) IBOutlet UILabel *mBankCode;



@end
