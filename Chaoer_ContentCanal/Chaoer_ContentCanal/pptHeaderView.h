//
//  pptHeaderView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pptHeaderView : UIView
/**
 *  地址
 */
@property (weak, nonatomic) IBOutlet UILabel *mAddress;
/**
 *  banerview
 */
@property (weak, nonatomic) IBOutlet UIView *mBanerView;
/**
 *  跑腿榜
 */
@property (weak, nonatomic) IBOutlet UIButton *mPPTseniorityBtn;
/**
 *  发布
 */
@property (weak, nonatomic) IBOutlet UIButton *mPPTReleaseBtn;
/**
 *  纪录
 */
@property (weak, nonatomic) IBOutlet UIButton *mPPTHistoryBtn;
/**
 *  我的
 */
@property (weak, nonatomic) IBOutlet UIButton *mPPTMy;
/**
 *  子视图
 */
@property (weak, nonatomic) IBOutlet UIView *mSubView;



/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (pptHeaderView *)shareView;

@end
