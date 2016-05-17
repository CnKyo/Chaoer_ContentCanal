//
//  applyPPTView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface applyPPTView : UIView
/**
 *  view1
 */
@property (weak, nonatomic) IBOutlet UIView *mView1;
/**
 *  view2
 */
@property (weak, nonatomic) IBOutlet UIView *mView2;
/**
 *  押金
 */
@property (weak, nonatomic) IBOutlet UILabel *mMoney;
/**
 *  姓名
 */
@property (weak, nonatomic) IBOutlet UITextField *mNameTx;
/**
 *  性别
 */
@property (weak, nonatomic) IBOutlet UITextField *mSexTx;
/**
 *  联系方式
 */
@property (weak, nonatomic) IBOutlet UITextField *mConnectTx;
/**
 *  身份证
 */
@property (weak, nonatomic) IBOutlet UITextField *mIdentifyTx;
/**
 *  手持身份证
 */
@property (weak, nonatomic) IBOutlet UIButton *mHandBtn;
/**
 *  正面
 */
@property (weak, nonatomic) IBOutlet UIButton *mFrontBtn;
/**
 *  反面
 */
@property (weak, nonatomic) IBOutlet UIButton *mForwordBtn;
/**
 *  规则
 */
@property (weak, nonatomic) IBOutlet UIImageView *mRuleImg;
/**
 *  规则按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mRuleBtn;
/**
 *  确定按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mOkBtn;

@property (weak, nonatomic) IBOutlet UIButton *mSexBtn;


/**
 *  初始化方法
 *
 *  @return 返回view 
 */
+ (applyPPTView *)shareView;


@end
