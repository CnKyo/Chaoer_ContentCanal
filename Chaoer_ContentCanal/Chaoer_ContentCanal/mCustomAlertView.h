//
//  mCustomAlertView.h
//  O2O_XiCheSeller
//
//  Created by 密码为空！ on 15/7/13.
//  Copyright (c) 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mCustomAlertView : UIView

/**
 *  状态图表
 */
@property (strong, nonatomic) IBOutlet UIImageView *mStatusImg;
/**
 *  提示内容
 */
@property (strong, nonatomic) IBOutlet UILabel *mContent;
/**
 *  按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mBtn;
/**
 *  初始化方法
 *
 *  @return view
 */
+ (mCustomAlertView *)shareView;

@end
