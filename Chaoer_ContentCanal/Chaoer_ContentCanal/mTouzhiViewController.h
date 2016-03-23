//
//  mTouzhiViewController.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface mTouzhiViewController : BaseVC


/**
 *  主视图
 */
@property (strong, nonatomic) IBOutlet UIView *mMainView;
/**
 *  投资人text
 */
@property (strong, nonatomic) IBOutlet UITextField *mNameTx;
/**
 *  资金text
 */
@property (strong, nonatomic) IBOutlet UITextField *mMoneyTx;
/**
 *  支付方式
 */
@property (strong, nonatomic) IBOutlet UIView *mPayTypeView;
/**
 *  投资按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mDoneBtn;
/**
 *  银行卡
 */
@property (strong, nonatomic) IBOutlet UIButton *mBankBtn;
/**
 *  支付宝
 */
@property (strong, nonatomic) IBOutlet UIButton *mAliBtn;
/**
 *  微信
 */
@property (strong, nonatomic) IBOutlet UIButton *mwechatBtn;




@end
