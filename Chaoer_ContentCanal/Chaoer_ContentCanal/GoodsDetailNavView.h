//
//  GoodsDetailNavView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/29.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsDetailNavView : UIView
/**
 *  返回按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mBackBtn;
/**
 *  名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;
/**
 *  收藏按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mCollectBtn;
/**
 *  分享按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mShareBtn;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (GoodsDetailNavView *)shareView;


@end
