//
//  mSuperMarketTableViewCell.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/12.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mSuperMarketTableViewCell : UITableViewCell

#pragma mark----左边的
/**
 *  左边的按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mLeftBtn;

/**
 *  左边的图片
 */
@property (strong, nonatomic) IBOutlet UIImageView *mLeftLogo;
/**
 *  左边的添加按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mLaddBtn;
/**
 *  左边的商品名称
 */
@property (strong, nonatomic) IBOutlet UILabel *mLname;
/**
 *  左边的价格
 */
@property (strong, nonatomic) IBOutlet UILabel *mLprice;
/**
 *  左边的已售
 */
@property (strong, nonatomic) IBOutlet UILabel *mLsale;


#pragma mark---右边的
/**
 *  右边的按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mRightBtn;

/**
 *  右边的图片
 */
@property (strong, nonatomic) IBOutlet UIImageView *mRightLogo;
/**
 *  右边的添加按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *mRaddbtn;
/**
 *  右边的商品名称
 */
@property (strong, nonatomic) IBOutlet UILabel *mRname;
/**
 *  右边的价格
 */
@property (strong, nonatomic) IBOutlet UILabel *mRprice;
/**
 *  右边的已售
 */
@property (strong, nonatomic) IBOutlet UILabel *mRsale;



#pragma mark----购物车

/**
 *  商品名称
 */
@property (strong, nonatomic) IBOutlet UILabel *mName;
/**
 *  价格
 */
@property (strong, nonatomic) IBOutlet UILabel *mPrice;
/**
 *  减
 */
@property (strong, nonatomic) IBOutlet UIButton *mDelBtn;
/**
 *  数量
 */
@property (strong, nonatomic) IBOutlet UILabel *mNum;
/**
 *  加
 */
@property (strong, nonatomic) IBOutlet UIButton *mAddBtn;

/**
 *  删除
 */
@property (strong, nonatomic) IBOutlet UIButton *mDELbtn;



@end
