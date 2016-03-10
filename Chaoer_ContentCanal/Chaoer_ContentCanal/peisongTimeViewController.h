//
//  peisongTimeViewController.h
//  O2O_Communication_seller
//
//  Created by 王珂 on 15/11/5.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface peisongTimeViewController : BaseVC

@property (strong,nonatomic) SShop   *mShop;

@property (nonatomic,strong) void(^itblock)(NSDictionary *mBackDic);

@end
