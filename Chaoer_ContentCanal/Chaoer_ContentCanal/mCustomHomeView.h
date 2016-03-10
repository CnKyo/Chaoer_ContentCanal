//
//  mCustomHomeView.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/10.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mCustomHomeView : UIView
/**
 *  图片
 */
@property (strong, nonatomic) IBOutlet UIImageView *mCImg;
/**
 *  按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mBtn;

/**
 *  初始化自定义按钮
 *
 *  @return view
 */
+ (mCustomHomeView *)shareView;

@end
