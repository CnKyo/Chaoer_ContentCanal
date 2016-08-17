//
//  mDetailSectionView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  代理
 */
@protocol WKFoodDetailDelegate <NSObject>

@optional
/**
 *  加入购物车代理方法
 */
- (void)WKFoodDetailAddShopCarAction;
/**
 *  加按钮方法
 */
- (void)WKFoodDetailAddAction;
/**
 *  减按钮方法
 */
- (void)WKFoodDetailJianAction;

@end

@interface mDetailSectionView : UIView
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *mTitle;
/**
 *  内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;

+ (mDetailSectionView *)shareView;

+ (mDetailSectionView *)shareShopCarView;
/**
 *  价格
 */
@property (weak, nonatomic) IBOutlet UILabel *mPrice;
/**
 *  减按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mJianBtn;
/**
 *  数量
 */
@property (weak, nonatomic) IBOutlet UILabel *mNum;
/**
 *  加按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mAddBtn;
/**
 *  加入购物车按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mAddShopCarBtn;


@property (strong,nonatomic) id<WKFoodDetailDelegate>delegate;

@end
