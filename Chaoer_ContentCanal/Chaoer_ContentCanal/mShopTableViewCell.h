//
//  mShopTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mShopTableViewCell : UITableViewCell


#pragma mark----左边的cell

/**
 *  热销
 */
@property (strong, nonatomic) IBOutlet UILabel *mHotSale;


#pragma mark----右边的cell
/**
 *  商品名称
 */
@property (strong, nonatomic) IBOutlet UILabel *mGoodsName;
/**
 *  价格
 */
@property (strong, nonatomic) IBOutlet UILabel *mPrice;
/**
 *  销量
 */
@property (strong, nonatomic) IBOutlet UILabel *mSalesNum;
/**
 *  减按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mDelBtn;
/**
 *  数量
 */
@property (strong, nonatomic) IBOutlet UILabel *mNum;
/**
 *  加按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mAddBtn;



@end
