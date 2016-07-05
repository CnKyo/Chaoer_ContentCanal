//
//  BaseHeaderRefresh.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseHeaderRefresh.h"

@implementation BaseHeaderRefresh

#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (int i = 0; i<75; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%djiazai", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (int i = 0; i<75; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%djiazai", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

@end
