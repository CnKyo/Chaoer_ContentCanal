//
//  pptTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mOrderButton.h"

@protocol WKCellWithBanerAndBtnClickDelegate <NSObject>

@optional

- (void)WKCellWithBanerClicked:(NSInteger)mIndex;

- (void)WKCellWithMainBtnClicked:(NSInteger)mIndex;

- (void)WKCellWithDoneBtnAction:(NSIndexPath *)mIndexPath;

@end

@interface pptTableViewCell : UITableViewCell
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *mHeader;
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *mTitle;
/**
 *  距离
 */
@property (weak, nonatomic) IBOutlet UILabel *mDistance;
/**
 *  酬金
 */
@property (weak, nonatomic) IBOutlet UILabel *mMoney;
/**
 *  接手按钮
 */
@property (weak, nonatomic) IBOutlet mOrderButton *mDoneBtn;

@property (weak, nonatomic) IBOutlet UIView *mBanerView;

@property (weak, nonatomic) IBOutlet UIView *mMainBtnView;
/**
 *  滚动数组
 */
@property (strong,nonatomic) NSArray *mBanerArr;
/**
 *  主按钮数组
 */
@property (strong,nonatomic) NSArray *mMainBtnArr;

@property (assign,nonatomic) NSIndexPath *mIndexPath;

@property (strong,nonatomic) id<WKCellWithBanerAndBtnClickDelegate>delegate;

@property (strong,nonatomic) GPPTOrder *mOrder;
@end
