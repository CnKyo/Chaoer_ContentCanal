//
//  feedbackViewController.h
//  O2O_Communication_seller
//
//  Created by 密码为空！ on 15/10/30.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"
#import "IQTextView.h"
@interface feedbackViewController : BaseVC
///背景view
@property (weak, nonatomic) IBOutlet UIView *bgkView;
///输入框
@property (weak, nonatomic) IBOutlet IQTextView *txView;
///提交按钮
@property (weak, nonatomic) IBOutlet UIButton *okBtn;
@end
