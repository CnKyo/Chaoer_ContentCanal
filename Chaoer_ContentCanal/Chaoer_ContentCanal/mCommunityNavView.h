//
//  mCommunityNavView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/23.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mCommunityNavView : UIView
#pragma mark----导航条
/**
 *  返回按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mBackBtn;
/**
 *  我的按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mMyBtn;
/**
 *  地址按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mAddressBtn;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (mCommunityNavView *)shareView;
#pragma mark----cell子view
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mImg;
/**
 *  内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mContent;
/**
 *  选择按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mSelectBtn;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (mCommunityNavView *)shareSubView;


#pragma mark----scroller子view
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mSImg;
/**
 *  名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mSName;
/**
 *  现价
 */
@property (weak, nonatomic) IBOutlet UILabel *mSNowPrice;
/**
 *  原价
 */
@property (weak, nonatomic) IBOutlet UILabel *mSOldPrice;
/**
 *  按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mSBtn;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (mCommunityNavView *)shaeScrollerSubView;

@end
