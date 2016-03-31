//
//  needCodeView.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/22.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface needCodeView : UIView

/**
 *  背景
 */
@property (strong, nonatomic) IBOutlet UIView *mBgkView;
/**
 *  名称tx
 */
@property (strong, nonatomic) IBOutlet UITextField *mNameTx;
/**
 *  城市lb
 */
@property (strong, nonatomic) IBOutlet UILabel *mCityLb;
/**
 *  城市按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mCityBtn;
/**
 *  市区lb
 */
@property (strong, nonatomic) IBOutlet UILabel *mArearLb;
/**
 *  市区按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mArearBtn;
/**
 *  物管lb
 */
@property (strong, nonatomic) IBOutlet UILabel *mCanalLb;
/**
 *  物管按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mCanalBtn;
/**
 *  小区lb
 */
@property (strong, nonatomic) IBOutlet UILabel *mCommunityLb;
/**
 *  小区按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mCommunityBtn;
/**
 *  楼栋lb
 */
@property (strong, nonatomic) IBOutlet UILabel *mBuildLb;
/**
 *  楼栋按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mBuildBtn;
/**
 *  门牌号lb
 */
@property (strong, nonatomic) IBOutlet UILabel *mDoorNumLb;
/**
 *  门牌号按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mDoorNuimBtn;
/**
 *  房主
 */
@property (strong, nonatomic) IBOutlet UIButton *mMasterBtn;
/**
 *  租客
 */
@property (strong, nonatomic) IBOutlet UIButton *mVisitorBtn;
/**
 *  确定按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mOkBtn;


/**
 *  初始化方法
 *
 *  @return 返回的当前的view
 */
+ (needCodeView *)shareView;



#pragma mark----银行卡认证
/**
 *  真实姓名
 */
@property (strong, nonatomic) IBOutlet UITextField *mBankName;
/**
 *  身份证
 */
@property (strong, nonatomic) IBOutlet UITextField *mBankIdentify;
/**
 *  开户行
 */
@property (strong, nonatomic) IBOutlet UILabel *mBankLb;
/**
 *  开户行按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mBankBtn;
/**
 *  开户省份
 */
@property (strong, nonatomic) IBOutlet UILabel *mProvinceLb;
/**
 *  开户省份按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mProvinceBtn;
/**
 *  开户城市
 */
@property (strong, nonatomic) IBOutlet UILabel *mChoiseCity;
/**
 *  开户城市按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mChoiseCityBtn;
/**
 *  开户网点
 */
@property (strong, nonatomic) IBOutlet UILabel *mBankPointLb;
/**
 *  开户网点按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mBankPointBtn;
/**
 *  银行卡
 */
@property (strong, nonatomic) IBOutlet UITextField *mBanCardTx;
/**
 *  认证按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mVerifyBtn;


/**
 *  初始化方法
 *
 *  @return view
 */
+ (needCodeView *)shareVerifyBankView;


@end