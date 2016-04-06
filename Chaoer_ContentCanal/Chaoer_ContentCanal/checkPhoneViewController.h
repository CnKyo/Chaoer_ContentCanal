//
//  checkPhoneViewController.h
//  O2O_Communication_seller
//
//  Created by 密码为空！ on 15/10/14.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface checkPhoneViewController : BaseVC<UITextFieldDelegate,MZTimerLabelDelegate>
///当前手机
@property (weak, nonatomic) IBOutlet UILabel *mNowPhone;
///验证吗view
@property (weak, nonatomic) IBOutlet UIView *mCodeView;
///验证吗按钮
@property (weak, nonatomic) IBOutlet UIButton *mCodeBtn;
///校验按钮
@property (weak, nonatomic) IBOutlet UIButton *mOkBtn;
///验证码tx
@property (weak, nonatomic) IBOutlet UITextField *mCodeTx;
@end
