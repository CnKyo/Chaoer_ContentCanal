//
//  mGoodsBtn.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/20.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MGoods;
@class GMarketList;
@interface mGoodsBtn : UIButton

@property (strong,nonatomic) MGoods *mGood;

@property (strong,nonatomic) GMarketList *mShop;

@end
