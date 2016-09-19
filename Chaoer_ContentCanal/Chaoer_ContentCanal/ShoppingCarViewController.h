//
//  ShoppingCarViewController.h
//  ZDCar
//
//  Created by yangxuran on 16/7/22.
//  Copyright © 2016年 boc. All rights reserved.
//  购物车

#import <UIKit/UIKit.h>

@interface ShoppingCarViewController : UIViewController
/**
 *  1是超市详情进入  2是我的界面进入
 */
@property (assign,nonatomic) int mType;
@property (nonatomic,strong) void(^block)(BOOL mIsBack);
@end
