//
//  ZLSubProductView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLSubProductView : UIView
/**
 *  图片
 */
@property (strong,nonatomic) UIImageView *mImg;
/**
 *  按钮
 */
@property (strong,nonatomic) UIButton *mBtn;
/**
 *  商品名称
 */
@property (strong,nonatomic) UILabel *mName;
/**
 *  原价
 */
@property (strong,nonatomic) UILabel *mOldPrice;
/**
 *  现价
 */
@property (strong,nonatomic) UILabel *mNowPrice;
/**
 *  初始化方法
 *
 *  @param frame     设置frame
 *  @param mImg      图片
 *  @param mOldPrice 原价
 *  @param mNowPrice 现价
 *
 *  @return 返回view
 */
+ (ZLSubProductView *)initWithFrame:(CGRect)frame andImg:(NSString *)mImg andProductName:(NSString *)mName andOlPrice:(float)mOldPrice andNowPrice:(float)mNowPrice;


@end
