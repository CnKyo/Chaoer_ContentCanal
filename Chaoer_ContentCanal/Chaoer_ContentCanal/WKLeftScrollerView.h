//
//  WKLeftScrollerView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  view 的代理方法
 */
@protocol WKLeftScrollerViewBtnDidSelectedDelegate <NSObject>

@optional
/**
 *  点击代理方法
 *
 *  @param mIndex 返回索引
 */
- (void)WKLeftBtnClickedWithIndex:(NSInteger)mIndex;

@end

@interface WKLeftScrollerView : UIView

@property (strong,nonatomic) id <WKLeftScrollerViewBtnDidSelectedDelegate> delegate;

/**
 *  初始化方法
 *
 *  @param mFrame 坐标
 *  @param mArr   数据源
 *
 *  @return 返回view
 */
+ (WKLeftScrollerView *)initWithFrame:(CGRect)mFrame andDataArr:(NSArray *)mArr;

@end
