//
//  QHLShop.h
//  shoppingCar
//
//  Created by Apple on 16/1/12.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QHLShop : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) NSMutableArray *goods;
@property (nonatomic, copy) NSString *introduction;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)shopWithDict:(NSDictionary *)dict;

+ (NSMutableArray *)shop;

@end
