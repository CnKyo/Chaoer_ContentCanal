//
//  shopCarTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/28.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface shopCarTableViewCell : UITableViewCell
/**
 *  活动图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mActivityImg;
/**
 *  活动内容
 */
@property (weak, nonatomic) IBOutlet UILabel *mActivityContent;
/**
 *  商品图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mGoodsImg;
/**
 *  商品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsName;
/**
 *  商品详情
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsContent;
/**
 *  删除按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mDeleteBtn;
/**
 *  加减view
 */
@property (weak, nonatomic) IBOutlet UIView *mAddAndSubtract;
/**
 *  减按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mSubtracBtn;
/**
 *  商品数量
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsNum;
/**
 *  加按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mAddBtn;
/**
 *  商品价格
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsPrice;
/**
 *  商品备注
 */
@property (weak, nonatomic) IBOutlet UILabel *mGoodsNote;
/**
 *  活动详情左边的约束 
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mActivitContentLeft;



@end
