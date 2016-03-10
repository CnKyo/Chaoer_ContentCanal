//
//  SellerVC.h
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/11/3.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellerVC : BaseVC

@property (nonatomic,strong) void(^block)(NSArray* people);

@end
