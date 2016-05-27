//
//  mFeedPersonViewController.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"
#import "IQTextView.h"
@interface mFeedPersonViewController : BaseVC/**
 *  背景
 */
@property (strong, nonatomic) IBOutlet UIView *mBgkView;

/**
 *  小区列表
 */
@property (strong, nonatomic) IBOutlet UITableView *mValiigeTableView;

/**
 *  楼栋列表
 */
@property (strong, nonatomic) IBOutlet UITableView *mBuildTableView;


/**
 *  省份
 */
@property (weak, nonatomic) IBOutlet UIButton *mProvinceBtn;
/**
 *  小区按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mValiigeBtn;
/**
 *  楼栋按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mBuildBtn;
/**
 *  单元
 */
@property (weak, nonatomic) IBOutlet UIButton *mUnitBtn;
/**
 *  楼层  
 */
@property (weak, nonatomic) IBOutlet UIButton *mFloorBtn;
/**
 *  门牌号按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mDoorNumBtn;


/**
 *  门牌号列表
 */
@property (strong, nonatomic) IBOutlet UITableView *mDoorNumTableView;
/**
 *  原因
 */
@property (strong, nonatomic) IBOutlet IQTextView *mReason;

/**
 *  小区列表高度
 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mValiigeH;
/**
 *  楼栋列表高端
 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mBuildH;
/**
 *  门牌号列表高度
 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mDoorNumH;

/**
 *  提交按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mSubmit;



@end
