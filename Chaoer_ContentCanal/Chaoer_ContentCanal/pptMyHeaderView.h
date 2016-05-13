//
//  pptMyHeaderView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/13.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pptMyHeaderView : UIView
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *mHeaderImg;
/**
 *  姓名
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;
/**
 *  等级
 */
@property (weak, nonatomic) IBOutlet UILabel *mLevel;
/**
 *  酬劳
 */
@property (weak, nonatomic) IBOutlet UILabel *mMoney;
/**
 *  标签
 */
@property (weak, nonatomic) IBOutlet UIButton *mMyTagBtn;
/**
 *  消息
 */
@property (weak, nonatomic) IBOutlet UIButton *mMyMsgBtn;
/**
 *  评价
 */
@property (weak, nonatomic) IBOutlet UIButton *mMyRateBtn;
/**
 *  初始化方法
 *
 *  @return view
 */
+ (pptMyHeaderView *)shareViuew;

@end
