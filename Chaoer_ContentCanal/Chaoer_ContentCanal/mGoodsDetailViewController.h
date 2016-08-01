//
//  mGoodsDetailViewController.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/29.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface mGoodsDetailViewController : BaseVC

@property (strong,nonatomic)MGoods *mSGoods;

@property (assign,nonatomic) int  mShopId;

@property (assign,nonatomic) BOOL mIsCollecte;
@end
