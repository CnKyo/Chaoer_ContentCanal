//
//  mMyDeatailView.h
//  O2O_XiCheSeller
//
//  Created by 密码为空！ on 15/7/13.
//  Copyright (c) 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQTextView.h"

@interface mMyDeatailView : UIView

///背景1
@property (weak, nonatomic) IBOutlet UIView *bgvc1;
///背景2
@property (weak, nonatomic) IBOutlet UIView *bgvc2;

///姓名按钮
@property (weak, nonatomic) IBOutlet UIButton *mNameBtn;
///头像
@property (weak, nonatomic) IBOutlet UIImageView *mHeaderImg;


///头像按钮
@property (weak, nonatomic) IBOutlet UIButton *mHeaderBtn;
///密码按钮
@property (weak, nonatomic) IBOutlet UIButton *mPwdBtn;
///手机按钮
@property (weak, nonatomic) IBOutlet UIButton *mPhoneBtn;
+ (mMyDeatailView *)shareView;
@end
