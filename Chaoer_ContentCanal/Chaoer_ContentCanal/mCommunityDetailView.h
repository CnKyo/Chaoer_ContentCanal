//
//  mCommunityDetailView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/9.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mCommunityDetailView : UIView
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *mTitle;
/**
 *  时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mTiem;
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mImg;
/**
 *  自内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mSubContent;
/**
 *  内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (mCommunityDetailView *)shareView;

@end
