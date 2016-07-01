//
//  mGoodsSearchCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/30.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol cellDidSelectedDelegate <NSObject>

@optional

- (void)cellDidSelectedWithIndex:(NSInteger)index;

@end

@interface mGoodsSearchCell : UITableViewCell

/**
 *  数据源
 */
@property (strong,nonatomic) NSArray *mDataSource;

/**
 *  高度
 */
@property (nonatomic,assign) CGFloat mHight;


@property (strong,nonatomic) id <cellDidSelectedDelegate> delegate;

@end
