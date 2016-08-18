//
//  mFoodRateTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WKRateCellImgClickDelegate <NSObject>

@optional

- (void)cellWithImgBrowserClickedAndTag:(NSInteger)mTag andSubViews:(UIView *)msubViews;

@end

@interface mFoodRateTableViewCell : UITableViewCell

/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mImg;
/**
 *  名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;
/**
 *  时间
 */
@property (weak, nonatomic) IBOutlet UILabel *mTime;
/**
 *  评价view
 */
@property (weak, nonatomic) IBOutlet UIView *mRateVie;
/**
 *  评价图片
 */
@property (weak, nonatomic) IBOutlet UIView *mRateImgsArr;
/**
 *  评价内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mcontent;
/**
 *  高度约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mImgsViewH;
/**
 *  评分
 */
@property(nonatomic,assign) NSInteger mRateNum;
/**
 *  图片数组
 */
@property(nonatomic,strong) NSArray *mImgArr;


@property (strong,nonatomic) id<WKRateCellImgClickDelegate>delegate;
@end
