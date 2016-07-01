//
//  mSearchHeaderSectionView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/30.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mSearchHeaderSectionView : UIView
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *mTitle;
/**
 *  清除按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mCleanBtn;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (mSearchHeaderSectionView *)shareView;

@end
