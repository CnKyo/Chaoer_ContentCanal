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
 *  banerview
 */
@property (weak, nonatomic) IBOutlet UIView *mBanerView;

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
