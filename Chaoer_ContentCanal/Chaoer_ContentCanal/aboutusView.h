//
//  aboutusView.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/18.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface aboutusView : UIView


@property (strong, nonatomic) IBOutlet UIView *mLeftView;


@property (strong, nonatomic) IBOutlet UIView *mRightView;


/**
 *  分享微信
 */
@property (strong, nonatomic) IBOutlet UIButton *mWechatBtn;
/**
 *  分享qq
 */
@property (strong, nonatomic) IBOutlet UIButton *mtencentBtn;
/**
 *  初始化方法
 *
 *  @return view
 */
+ (aboutusView *)shareView;

@end
