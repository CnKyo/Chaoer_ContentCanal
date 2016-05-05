//
//  mBarCodeView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/5.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mBarCodeView : UIView
#pragma  mark----二维码view

/**
 *  大的view
 */
@property (weak, nonatomic) IBOutlet UIView *mMainView;
/**
 *  小的view
 */
@property (weak, nonatomic) IBOutlet UIView *mSmallView;
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *mHeader;
/**
 *  名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mNickName;
/**
 *  电话
 */
@property (weak, nonatomic) IBOutlet UILabel *mPhone;
/**
 *  身份
 */
@property (weak, nonatomic) IBOutlet UILabel *mIdentify;
/**
 *  二维码
 */
@property (weak, nonatomic) IBOutlet UIImageView *mBarCode;

/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (mBarCodeView *)shareView;


#pragma  mark----分享view
/**
 *  分享微信
 */
@property (weak, nonatomic) IBOutlet UIButton *mShareWechat;
/**
 *  分享qq
 */
@property (weak, nonatomic) IBOutlet UIButton *mShareTencent;
/**
 *  分享微博
 */
@property (weak, nonatomic) IBOutlet UIButton *mShareWebo;

/**
 *  初始化分享view方法
 *
 *  @return 返回view
 */
+ (mBarCodeView *)shareBottomView;






@end
