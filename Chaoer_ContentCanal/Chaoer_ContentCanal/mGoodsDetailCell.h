//
//  mGoodsDetailCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/29.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mGoodsDetailCell : UITableViewCell
#pragma mark----第一种cell类型
/**
 *  店铺详情view
 */
@property (weak, nonatomic) IBOutlet UIView *mShopDetailView;
/**
 *  店铺logo
 */
@property (weak, nonatomic) IBOutlet UIImageView *mShopLogo;
/**
 *  热卖
 */
@property (weak, nonatomic) IBOutlet UIImageView *mHot;
/**
 *  店铺名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mShopName;
/**
 *  所有商品
 */
@property (weak, nonatomic) IBOutlet UILabel *mAllGoodsNum;
/**
 *  关注数
 */
@property (weak, nonatomic) IBOutlet UILabel *mFocusNum;
///**
// *  活动view
// */
//@property (weak, nonatomic) IBOutlet UIView *mActivityView;
/**
 *  店铺名称约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mShopNameLeft;

/**
 *  活动数组
 */
@property (strong,nonatomic) NSArray *mActivityArr;

/**
 *  cell的高
 */
@property (assign,nonatomic) CGFloat mCellH;


@property (strong,nonatomic) SGoodsDetail *mGoodsDetail;

#pragma mark ----第二种cell样式
/**
 *  商品图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mGoodsImg;
/**
 *  商品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsName;
/**
 *  商品内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsContent;
/**
 *  现价
 */
@property (weak, nonatomic) IBOutlet UILabel *mNoewPrice;
/**
 *  原价
 */
@property (weak, nonatomic) IBOutlet UILabel *mOldPrice;
/**
 *  地址
 */
@property (weak, nonatomic) IBOutlet UILabel *mAddress;
/**
 *  销量
 */
@property (weak, nonatomic) IBOutlet UILabel *mSalesNum;
/**
 *  配送费
 */
@property (weak, nonatomic) IBOutlet UILabel *mSendPrice;

@property (assign,nonatomic) CGFloat mGoodsDetailH;

@end
