//
//  mActivitySubView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/25.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mActivitySubView : UIView
/**
 *  活动名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;
/**
 *  活动内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (mActivitySubView *)shareView;
@end
