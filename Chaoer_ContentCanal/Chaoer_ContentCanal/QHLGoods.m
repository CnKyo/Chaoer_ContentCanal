//
//  QHLGoods.m
//  shoppingCar
//
//  Created by Apple on 16/1/12.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "QHLGoods.h"


@interface QHLGoods ()

@end

@implementation QHLGoods
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)goodsWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

+ (NSMutableArray *)goodsWithArray:(NSArray *)array {
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        QHLGoods *goods = [QHLGoods goodsWithDict:dict];
        [arrayM addObject:goods];
    }
    return arrayM;
}

#pragma mark - 归解档
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.tag = [aDecoder decodeObjectForKey:@"tag"];
        self.selected = [aDecoder decodeBoolForKey:@"selected"];
        self.price = [aDecoder decodeObjectForKey:@"price"];
        self.introduction = [aDecoder decodeObjectForKey:@"introduction"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.tag forKey:@"tag"];
    [aCoder encodeBool:self.selected forKey:@"selected"];
    [aCoder encodeObject:self.price forKey:@"price"];
    [aCoder encodeObject:self.introduction forKey:@"introduction"];
}
@end
