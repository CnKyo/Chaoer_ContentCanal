//
//  QHLShop.m
//  shoppingCar
//
//  Created by Apple on 16/1/12.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "QHLShop.h"
#import "QHLGoods.h"

@interface QHLShop ()<NSCoding>

@end

@implementation QHLShop
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
        //把goods转成模型
        self.goods = [QHLGoods goodsWithArray:self.goods];

    }
    return self;
}

+ (instancetype)shopWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

+ (NSMutableArray *)shop {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shoppingCar.plist" ofType:nil];
    NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:path];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        QHLShop *shop = [QHLShop shopWithDict:dict];
        [arrayM addObject:shop];
    }
    return arrayM;
}

#pragma mark - 归解档
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.tag = [aDecoder decodeObjectForKey:@"tag"];
        self.selected = [aDecoder decodeBoolForKey:@"selected"];
        self.goods = [aDecoder decodeObjectForKey:@"goods"];
        self.introduction = [aDecoder decodeObjectForKey:@"introduction"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.tag forKey:@"tag"];
    [aCoder encodeBool:self.selected forKey:@"selected"];
    [aCoder encodeObject:self.goods forKey:@"goods"];
    [aCoder encodeObject:self.introduction forKey:@"introduction"];
}





@end
