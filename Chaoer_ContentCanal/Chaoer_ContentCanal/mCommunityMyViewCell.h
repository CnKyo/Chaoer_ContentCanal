//
//  mCommunityMyViewCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/24.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mCommunityMyViewCell : UITableViewCell

#pragma mark----收藏店铺

/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mImg;
/**
 *  热卖
 */
@property (weak, nonatomic) IBOutlet UIImageView *mHot;
/**
 *  名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;
/**
 *  全部商品
 */
@property (weak, nonatomic) IBOutlet UILabel *mAllNum;
/**
 *  收藏数
 */
@property (weak, nonatomic) IBOutlet UILabel *mCollectNum;
/**
 *  收藏按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mCollectBtn;
/**
 *  约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mNameLeft;

#pragma mark----收藏商品
#pragma mark----左边的视图
/**
 *  左边的试图
 */
@property (weak, nonatomic) IBOutlet UIView *mLeftView;
/**
 *  左边的图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mLeftImg;
/**
 *  左边的名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mLeftName;
/**
 *  左边的价格
 */
@property (weak, nonatomic) IBOutlet UILabel *mLeftPrice;
/**
 *  左边的内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mLeftContent;
/**
 *  左边的销量
 */
@property (weak, nonatomic) IBOutlet UILabel *mLeftNum;
/**
 *  左边的添加按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mLeftAdd;
/**
 *  左边的收藏按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mLeftCollect;
/**
 *  左边的标签
 */
@property (weak, nonatomic) IBOutlet UIImageView *mLeftTagImg;

#pragma mark----右边的试图
/**
 *  右边的view
 */
@property (weak, nonatomic) IBOutlet UIView *mRightView;
/**
 *  右边的图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mRightImg;
/**
 *  右边的名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mRightName;
/**
 *  右边的价格
 */
@property (weak, nonatomic) IBOutlet UILabel *mRightPrice;
/**
 *  右边的内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mRightContent;
/**
 *  右边的销量
 */
@property (weak, nonatomic) IBOutlet UILabel *mRightNum;
/**
 *  右边的添加按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mRightAdd;
/**
 *  右边的收藏按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mRightCollect;
/**
 *  右边的标签
 */
@property (weak, nonatomic) IBOutlet UIImageView *mRightTagImg;


@end
