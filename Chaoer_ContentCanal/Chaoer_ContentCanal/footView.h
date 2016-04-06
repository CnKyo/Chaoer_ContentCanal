//
//  footView.h
//  O2O_Communication_seller
//
//  Created by 密码为空！ on 15/9/18.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface footView : UIView
@property (weak, nonatomic) IBOutlet UIButton *mLoginBtn;

+ (footView *)shareView;




///大背景图
@property (weak, nonatomic) IBOutlet UIImageView *mBigBgkImg;
///头像
@property (weak, nonatomic) IBOutlet UIImageView *mHeaderImg;
///用户名
@property (weak, nonatomic) IBOutlet UILabel *mUserName;
///线
@property (weak, nonatomic) IBOutlet UIView *mLine;
///编辑按钮
@property (weak, nonatomic) IBOutlet UIButton *mEditBtn;

+ (footView *)shareHeaderView;



#pragma mark----我的佣金

///我的佣金
@property (weak, nonatomic) IBOutlet UILabel *mMyMoney;
///佣金底部view
@property (weak, nonatomic) IBOutlet UIView *mBottomView;


///我的佣金
+ (footView *)shareMyMoney;
@end
