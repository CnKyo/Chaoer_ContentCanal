//
//  mGeneryEmptyView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/26.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mGeneryEmptyView : UIView
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mEmptyImg;
/**
 *  提示i 文字
 */
@property (weak, nonatomic) IBOutlet UILabel *mEmptyTitle;
/**
 *  按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mEmptyBtn;
/**
 *  初始化方法
 *
 *  @return view
 */
+ (mGeneryEmptyView *)shareView;

@end
