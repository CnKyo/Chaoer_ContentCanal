//
//  QHLGoods.h
//  shoppingCar
//
//  Created by Apple on 16/1/12.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QHLGoods : NSObject
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *introduction;

- (instancetype)initWithDict:(NSDictionary *)dcit;
+ (instancetype)goodsWithDict:(NSDictionary *)dict;
+ (NSMutableArray *)goodsWithArray:(NSArray *)array;
@end
