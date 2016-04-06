//
//  popMessageView.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/24.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface popMessageView : UIView
/**
 *  缴费
 */
@property (strong, nonatomic) IBOutlet UIButton *mStaffBtn;
/**
 *  社区
 */
@property (strong, nonatomic) IBOutlet UIButton *mCommunityBtn;
/**
 *  报修
 */
@property (strong, nonatomic) IBOutlet UIButton *mFixBtn;
/**
 *  初始化方法
 *
 *  @return view
 */
+ (popMessageView *)shareView;


@end
