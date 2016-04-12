//
//  mFixView.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQTextView.h"
@interface mFixView : UIView

/**
 *  输入看
 */
@property (strong, nonatomic) IBOutlet IQTextView *mTxView;
/**
 *  附件－左边的按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mLeftBtn;
/**
 *  附件－右边的按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mRightBtn;
/**
 *  地址
 */
@property (strong, nonatomic) IBOutlet UILabel *mAddress;
/**
 *  地址按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mAddressBtn;

/**
 *  电话
 */
@property (strong, nonatomic) IBOutlet UILabel *mPhone;
/**
 *  服务时间
 */
@property (strong, nonatomic) IBOutlet UIButton *mTimeBtn;

/**
 *  需要选择的view
 */
@property (strong, nonatomic) IBOutlet UIView *mSelectedView;
/**
 *  家电按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mHomeBtn;
/**
 *  清洁按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mCleanBtn;
/**
 *  管道按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mPipeBtn;
/**
 *  需要隐藏的view
 */
@property (strong, nonatomic) IBOutlet UIView *mHiddenView;
/**
 *  选择的结果
 */
@property (strong, nonatomic) IBOutlet UIButton *mResultBtn;
/**
 *  选择的结果
 */
@property (strong, nonatomic) IBOutlet UILabel *mResultContent;
/**
 *  预约
 */
@property (strong, nonatomic) IBOutlet UIButton *mMakeBtn;



/**
 *  初始化方法
 *
 *  @return view
 */
+ (mFixView *)shareView;


@end
