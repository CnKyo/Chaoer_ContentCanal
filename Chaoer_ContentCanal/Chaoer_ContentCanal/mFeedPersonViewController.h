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
 *  省份
 */
@property (weak, nonatomic) IBOutlet UIButton *mProvinceBtn;
/**
 *  小区按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mValiigeBtn;
/**
 *  单元
 */
@property (weak, nonatomic) IBOutlet UIButton *mUnitBtn;

/**
 *  原因
 */
@property (strong, nonatomic) IBOutlet IQTextView *mReason;

/**
 *  提交按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mSubmit;



@end
