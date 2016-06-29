//
//  mCommunityHeaderView.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/24.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mCommunityHeaderView : UIView
/**
 *  大头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *mBigHeader;
/**
 *  小头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *mSmallHeader;
/**
 *  姓名
 */
@property (weak, nonatomic) IBOutlet UILabel *mName;
/**
 *  购物车
 */
@property (weak, nonatomic) IBOutlet UIButton *mShopCar;
/**
 *  订单
 */
@property (weak, nonatomic) IBOutlet UIButton *mOrder;
/**
 *  优惠卷
 */
@property (weak, nonatomic) IBOutlet UIButton *mCoup;
/**
 *  初始化方法
 *
 *  @return 返回view
 */
+ (mCommunityHeaderView *)shareView;

@end
