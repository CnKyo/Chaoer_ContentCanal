//
//  BillVC.h
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/10/30.
//  Copyright (c) 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillVC : BaseVC

@property (nonatomic,strong) SShop *mShop;

@property (nonatomic,strong) void(^itblock)(BOOL flag);

@end
