//
//  editDianpuViewController.h
//  O2O_Communication_seller
//
//  Created by 王珂 on 15/11/4.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"
#import "IQTextView.h"
@interface editDianpuViewController : BaseVC
///背景
@property (weak, nonatomic) IBOutlet UIView *mBgkVC;

@property (weak, nonatomic) IBOutlet UIView *mBgkVC2;

@property (weak, nonatomic) IBOutlet UILabel *mName2;
@property (weak, nonatomic) IBOutlet IQTextView *mTxView;
///标签
@property (weak, nonatomic) IBOutlet UILabel *mName;
///输入文本内容
@property (weak, nonatomic) IBOutlet UITextField *mContent;

@property (strong,nonatomic) NSString   *TitleStr;

@property (strong,nonatomic) NSString   *nameStr;

@property (nonatomic,strong) void(^itblock)(NSString *mBackStr);


@property (strong,nonatomic) NSString   *mContentStr;

//@property (strong,nonatomic) SShop   *mShop;
///1为店铺名称 2为店铺公告 3为联系电话 4为店铺介绍
@property (assign,nonatomic) int   mType;


@end
