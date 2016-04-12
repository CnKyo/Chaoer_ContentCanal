//
//  addressViewController.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/12.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface addressViewController : BaseVC
/**
 *  省份
 */
@property (weak, nonatomic) IBOutlet UIButton *mProvinceBtn;
/**
 *  城市
 */
@property (weak, nonatomic) IBOutlet UIButton *mCityBtn;
/**
 *  小区
 */
@property (weak, nonatomic) IBOutlet UIButton *mArearBtn;
/**
 *  楼栋
 */
@property (weak, nonatomic) IBOutlet UIButton *mBuildBtn;
/**
 *  单元
 */
@property (weak, nonatomic) IBOutlet UIButton *mUnitBtn;
/**
 *  楼层
 */
@property (weak, nonatomic) IBOutlet UIButton *mFloorBtn;
/**
 *  门牌号
 */
@property (weak, nonatomic) IBOutlet UIButton *mDoorumBtn;
/**
 *  保存按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mSaveBtn;


@end
