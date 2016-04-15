//
//  utilityView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface utilityView : UIView

/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (utilityView *)shareView;
/**
 *  省份按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mProvinceBtn;
/**
 *  城市按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mCityBtn;
/**
 *  缴费类型按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mPayType;
/**
 *  缴费单位按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mUnitBtn;
/**
 *  缴费金额
 */
@property (weak, nonatomic) IBOutlet UITextField *mPayMoneyTx;
/**
 *  户号
 */
@property (weak, nonatomic) IBOutlet UITextField *mNumTx;
/**
 *  户名
 */
@property (weak, nonatomic) IBOutlet UITextField *mNameTx;
/**
 *  缴费按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mPayBtn;


@end
