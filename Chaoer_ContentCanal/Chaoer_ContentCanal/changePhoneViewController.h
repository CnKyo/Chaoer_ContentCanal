//
//  changePhoneViewController.h
//  O2O_Communication_seller
//
//  Created by 密码为空！ on 15/10/14.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface changePhoneViewController : BaseVC<UITextFieldDelegate,MZTimerLabelDelegate>

///手机号码tx
@property (weak, nonatomic) IBOutlet UITextField *mPhoneTx;
///验证吗tx
@property (weak, nonatomic) IBOutlet UITextField *mCodeTx;
///验证吗按钮
@property (weak, nonatomic) IBOutlet UIButton *mCodeBtn;
///确定按钮
@property (weak, nonatomic) IBOutlet UIButton *mOkBtn;
///手机view
@property (weak, nonatomic) IBOutlet UIView *mView1;
///验证吗view
@property (weak, nonatomic) IBOutlet UIView *mView2;


@end
