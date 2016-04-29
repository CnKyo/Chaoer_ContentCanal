//
//  mFeedManageViewController.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"
#import "IQTextView.h"
@interface mFeedManageViewController : BaseVC
/**
 *  背景
 */
@property (strong, nonatomic) IBOutlet UIView *mBgtkView;
/**
 *  投诉人
 */
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *mName;
/**
 *  投诉原因
 */
@property (strong, nonatomic) IBOutlet IQTextView *mReason;

@property (weak, nonatomic) IBOutlet UIButton *mSubmitBtn;

@property (weak, nonatomic) IBOutlet UIButton *mValligeBtn;

@property (weak, nonatomic) IBOutlet UILabel *mArearLb;
@end
