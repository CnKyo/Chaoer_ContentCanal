//
//  QHLSettleMentView.h
//  shoppingCar
//
//  Created by Apple on 16/1/28.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>



/**
 *  正常状态下的底部bar
 */
@class QHLSettleMentView, QHLButton;
@protocol QHLSettleMentViewDelegate <NSObject>

- (void)settleMentView:(QHLSettleMentView *)settleMentView didClickButton:(BOOL)allSelBtnSelectState;

- (void)mGoPayClick;

@end

@interface QHLSettleMentView : UIView

@property (nonatomic, weak) id<QHLSettleMentViewDelegate> settleMentViewDelegate;



/**
 *  选中商品数量
 */
@property (nonatomic, assign) NSInteger count;

/**
 *  选中商品数量
 */
@property (nonatomic, assign) NSInteger money;

@property (nonatomic, assign, getter=isSelected) BOOL btnSelected;
@end
