//
//  mFoodDetailBottomShopCarView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  代理方法
 */
@protocol WKFoodBottomDelegate <NSObject>

@optional
/**
 *  去结算代理方法
 */
- (void)WKFoodBottomGoPayAction;


@end

@interface mFoodDetailBottomShopCarView : UIView
/**
 *  购物车按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mshopCarBtn;
/**
 *  去结算按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mGopayBtn;

+ (mFoodDetailBottomShopCarView *)shareView;

+ (mFoodDetailBottomShopCarView *)shareHeadView;
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mImg;
/**
 *  名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;
/**
 *  内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;


@end
