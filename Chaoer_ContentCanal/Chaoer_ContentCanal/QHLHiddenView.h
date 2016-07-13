//
//  QHLHiddenView.h
//  shoppingCar
//
//  Created by Apple on 16/1/28.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, QHLHiddenViewButtonState) {
    QHLHiddenViewButtonStateShared = 0,
    QHLHiddenViewButtonStateAttention,
    QHLHiddenViewButtonStateDelete
};


/**
 *  编辑状态下的底部bar
 */
@class QHLHiddenView, QHLButton;
@protocol QHLHiddenViewDelegate <NSObject>

- (void)hiddenView:(QHLHiddenView *)hiddenView didClickAllSelBtn:(BOOL)allSelBtnSelectState;

- (void)hiddenView:(QHLHiddenView *)hiddenView didClicHiddenViewBtn:(QHLHiddenViewButtonState)buttonType;

@end

@interface QHLHiddenView : UIView
@property (nonatomic, weak) id<QHLHiddenViewDelegate> hiddenViewDelegate;

@property (nonatomic, assign) BOOL allSelBtnSelected;
@end
