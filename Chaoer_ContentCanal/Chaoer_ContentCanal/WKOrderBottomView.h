//
//  WKOrderBottomView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WKOrderBottomView;

@protocol WKOrderBottomDelegate <NSObject>

@optional

- (void)allSelectedWithView:(WKOrderBottomView *)mBottomView didSelected:(BOOL)mSelected;

- (void)mGoPayAction;

@end
@interface WKOrderBottomView : UIView

@property (nonatomic,weak) id<WKOrderBottomDelegate> bottomDelegate;

/**
 *  选中商品数量
 */
@property (nonatomic, assign) NSInteger mNum;

/**
 *  选中商品的价格
 */
@property (nonatomic, assign) NSInteger mMoney;
/**
 *  是否全选
 */
@property (nonatomic, assign, getter=isSelected) BOOL btnSelected;
/**
 *  全选按钮
 */
@property (nonatomic, weak) UIButton *mAllSelBtn;
/**
 *  总价
 */
@property (nonatomic, weak) UILabel *mTotalLbl;
/**
 *  去支付
 */
@property (nonatomic, weak) UIButton *mGoPayBtn;
/**
 *  全选label
 */
@property (nonatomic, weak) UILabel *mAllSelectedLb;

@end
