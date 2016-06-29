//
//  exchangeCoupView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/24.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface exchangeCoupView : UIView
/**
 *  背景
 */
@property (weak, nonatomic) IBOutlet UIView *mBgk;
/**
 *  输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *mTx;
/**
 *  取消按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mCancelBtn;
/**
 *  兑换按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mOkBtn;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (exchangeCoupView *)shareView;

@end
