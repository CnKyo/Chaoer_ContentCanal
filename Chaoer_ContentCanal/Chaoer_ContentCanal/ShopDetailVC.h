//
//  ShopDetailVC.h
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/10/29.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopDetailVC : BaseVC
///店铺名称
@property (weak, nonatomic) IBOutlet UILabel *mShopName;
///店铺logo
@property (weak, nonatomic) IBOutlet UIImageView *mShopLogo;
///店铺公告
@property (weak, nonatomic) IBOutlet UILabel *mShopNote;
///营业状态
@property (weak, nonatomic) IBOutlet UILabel *mShopStatus;
///营业时间
@property (weak, nonatomic) IBOutlet UILabel *mShopWorkTime;
///配送时间
@property (weak, nonatomic) IBOutlet UILabel *mShopPeisongTime;
///电话
@property (weak, nonatomic) IBOutlet UILabel *mShopPhone;
///服务范围
@property (weak, nonatomic) IBOutlet UILabel *mShopArear;
///介绍
@property (weak, nonatomic) IBOutlet UILabel *mShopContent;
//起送价
@property (weak, nonatomic) IBOutlet UILabel *mQsPrice;
//起送价button
@property (weak, nonatomic) IBOutlet UIButton *mQsBT;
@property (weak, nonatomic) IBOutlet UILabel *mPsPrice;
@property (weak, nonatomic) IBOutlet UIButton *mPsBT;

//所在地区
@property (weak, nonatomic) IBOutlet UILabel *mArea;

//店铺地址
@property (weak, nonatomic) IBOutlet UITextField *mAddress;
//详细地址
@property (weak, nonatomic) IBOutlet UITextField *mAddressDetail;

///店铺名称按钮
@property (weak, nonatomic) IBOutlet UIButton *mShopNameBtn;
///店铺logo按钮
@property (weak, nonatomic) IBOutlet UIButton *mShopLogoBtn;
///店铺公告按钮
@property (weak, nonatomic) IBOutlet UIButton *mShopNoteBtn;
///营业状态按钮
@property (weak, nonatomic) IBOutlet UISwitch *mShopWorkSwitch;
///营业时间按钮
@property (weak, nonatomic) IBOutlet UIButton *mShopWorkTimeBtn;
///配送时间按钮
@property (weak, nonatomic) IBOutlet UIButton *mShopPeisongBtn;
///电话按钮
@property (weak, nonatomic) IBOutlet UIButton *mShopPhoneBtn;
///服务范围按钮
@property (weak, nonatomic) IBOutlet UIButton *mShopArearBtn;
///店铺介绍按钮
@property (weak, nonatomic) IBOutlet UIButton *mShopContentBtn;

@property (weak, nonatomic) IBOutlet UILabel *myjper;

@property (weak, nonatomic) IBOutlet UISwitch *mswitchh;






- (IBAction)GoAreaClick:(id)sender;
- (IBAction)mGoAddressClick:(id)sender;
- (IBAction)GoBankManagerClick:(id)sender;

@end
