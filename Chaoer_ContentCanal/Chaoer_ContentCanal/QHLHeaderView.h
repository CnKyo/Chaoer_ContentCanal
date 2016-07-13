//
//  QHLHeaderView.h
//  shoppingCar
//
//  Created by Apple on 16/1/12.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QHLShop.h"
@class QHLHeaderView;
@class QHLButton;

@protocol QHLHeaderViewDelegate <NSObject>

- (void)headerView:(QHLHeaderView *)headerView selBtnDidClickToChangeAllSelBtn:(BOOL)selBtnSelectState andSection:(NSInteger)section;

@end

@interface QHLHeaderView : UITableViewHeaderFooterView
@property (nonatomic, strong) QHLShop *shop;

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, assign) NSInteger section;
+ (instancetype)headerWithTableView:(UITableView *)tableView;
@property (nonatomic, weak) id<QHLHeaderViewDelegate> headerViewDelegate;

@end
