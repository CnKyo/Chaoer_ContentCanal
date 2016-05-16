//
//  mPriceView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mPriceView : UIView
/**
 *  背景
 */
@property (weak, nonatomic) IBOutlet UIView *mBgkView;
/**
 *  最小值
 */
@property (weak, nonatomic) IBOutlet UITextField *mMin;
/**
 *  最大值
 */
@property (weak, nonatomic) IBOutlet UITextField *mMax;
/**
 *  取消按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mCancelBtn;
/**
 *  确定按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mOkBtn;

@property (weak, nonatomic) IBOutlet UIView *mView1;

@property (weak, nonatomic) IBOutlet UIView *mView2;


/**
 *  初始化方法
 *
 *  @return view
 */
+ (mPriceView *)shareView;

@end
