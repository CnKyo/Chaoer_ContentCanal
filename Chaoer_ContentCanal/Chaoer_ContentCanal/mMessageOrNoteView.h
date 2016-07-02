//
//  mMessageOrNoteView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/2.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQTextView.h"
@interface mMessageOrNoteView : UIView
/**
 *  背景
 */
@property (weak, nonatomic) IBOutlet UIView *mBgkView;
/**
 *  输入框
 */
@property (weak, nonatomic) IBOutlet IQTextView *mTextView;
/**
 *  提交按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mSubmitBtn;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (mMessageOrNoteView *)shareView;


@end
