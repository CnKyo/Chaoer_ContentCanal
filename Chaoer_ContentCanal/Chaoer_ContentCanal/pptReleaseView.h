//
//  pptReleaseView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/12.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlockButton.h"
@interface pptReleaseView : UIView
/**
 *  背景view
 */
@property (weak, nonatomic) IBOutlet UIView *mBgkView;
/**
 *  买东西按钮
 */
@property (weak, nonatomic) IBOutlet BlockButton *mBuyBtn;
/**
 *  做事情按钮
 */
@property (weak, nonatomic) IBOutlet BlockButton *mDoBtn;
/**
 *  送东西按钮
 */
@property (weak, nonatomic) IBOutlet BlockButton *mSendBtn;
/**
 *  关闭按钮
 */
@property (weak, nonatomic) IBOutlet BlockButton *mCloseBtn;

/**
 *  初始化方法
 *
 *  @return view
 */
+ (pptReleaseView *)shareView;

@end
