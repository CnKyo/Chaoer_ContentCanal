//
//  mTopUpBalanceView.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/26.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mTopUpBalanceView : UIView

/**
 *  头像
 */
@property (strong, nonatomic) IBOutlet UIImageView *mHeader;
/**
 *  帐户
 */
@property (strong, nonatomic) IBOutlet UILabel *mName;
/**
 *  余额
 */
@property (strong, nonatomic) IBOutlet UILabel *mBalance;
/**
 *  银行卡
 */
@property (strong, nonatomic) IBOutlet UITextField *mBankCard;
/**
 *  拍照
 */
@property (strong, nonatomic) IBOutlet UIButton *mPhotoBtn;
/**
 *  有效期
 */
@property (strong, nonatomic) IBOutlet UITextField *mTime;
/**
 *  cvv码
 */
@property (strong, nonatomic) IBOutlet UITextField *mCVV;
/**
 *  姓名tx
 */
@property (strong, nonatomic) IBOutlet UITextField *mNameTx;
/**
 *  身份证
 */
@property (strong, nonatomic) IBOutlet UITextField *mIdentify;
/**
 *  电话
 */
@property (strong, nonatomic) IBOutlet UITextField *mPhone;
/**
 *  验证吗
 */
@property (strong, nonatomic) IBOutlet UITextField *mCode;
/**
 *  验证吗按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mCodeBtn;
/**
 *  确定按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mPayBtn;

/**
 *  初始化方法
 *
 *  @return view
 */
+ (mTopUpBalanceView *)shareView;




@end
