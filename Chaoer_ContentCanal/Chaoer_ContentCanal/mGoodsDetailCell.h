//
//  mGoodsDetailCell.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/29.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mGoodsDetailCell : UITableViewCell
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
 *  产地
 */
@property (weak, nonatomic) IBOutlet UILabel *mAddress;
/**
 *  产地
 */
@property (weak, nonatomic) IBOutlet UILabel *mAddresss;
/**
 *  规格
 */
@property (weak, nonatomic) IBOutlet UILabel *mRule;
/**
 *  规格
 */
@property (weak, nonatomic) IBOutlet UILabel *mRules;
/**
 *  是否有货
 */
@property (weak, nonatomic) IBOutlet UILabel *mHave;
/**
 *  是否有货
 */
@property (weak, nonatomic) IBOutlet UILabel *mHaves;

@end
