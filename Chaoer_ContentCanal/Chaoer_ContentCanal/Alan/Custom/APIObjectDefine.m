//
//  APIObjectDefine.m
//  EasySearch
//
//  Created by 瞿伦平 on 16/3/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "APIObjectDefine.h"


#pragma mark -
#pragma mark NSDictionary
@implementation NSDictionary (QUAdditions)
-(id)objectWithKey:(NSString *)key
{
    id obj = [self objectForKey:key];
    if ([obj isEqual:[NSNull null]]) {
        obj = nil;
    }
    return obj;
}
@end

@implementation NSMutableDictionary (QUAdditions)
- (void)setNeedStr:(NSString *)anObject forKey:(id)aKey
{
    if (anObject.length > 0)
        [self setObject:anObject forKey:aKey];
    else
        [self setObject:@"" forKey:aKey];
}

- (void)setValidStr:(NSString *)anObject forKey:(id)aKey
{
    if (anObject.length > 0)
        [self setObject:anObject forKey:aKey];
}

- (void)setInt:(int)anObject forKey:(id)aKey
{
    [self setObject:StringWithInt(anObject) forKey:aKey];
}
@end




@implementation NSURL (AFObjectDefine)
+ (NSURL*)imageurl:(NSString*)str
{
    NSString *newStr = @"";
    if (str.length > 0) {
        if ([str hasPrefix:@"http://"] || [str hasPrefix:@"https://"])
            newStr =  str;
        else
            newStr = [NSString stringWithFormat:@"%@%@", [HTTPrequest currentResourceUrl], str];
    }
    return [NSURL URLWithString:newStr];
}
@end





@implementation APIObjectDefine

@end

#pragma mark -
#pragma mark APIObject
@implementation APIShareSdkObject

+(APIShareSdkObject *)infoWithError:(NSError *)error
{
    APIShareSdkObject *info = [[APIShareSdkObject alloc] init];
    NSString *des = [error.userInfo objectWithKey:@"NSLocalizedDescription"];
    if (des.length > 0)
        info.msg = des;
    else
        info.msg       = @"网络请示失败，请检查网络";
    info.retCode = 0;
    return info;
}

+(APIShareSdkObject *)infoWithErrorMessage:(NSString *)errMsg
{
    APIShareSdkObject *info = [[APIShareSdkObject alloc] init];
    info.msg       = errMsg;
    info.retCode = 0;
    return info;
}

-(void)loadErrorCode
{
    switch (_retCode) {
        case 200:
            self.msg = @"成功";
            break;
        case 10001:
            self.msg = @"appkey不合法";
            break;
        case 10020:
            self.msg = @"接口维护";
            break;
        case 10021:
            self.msg = @"接口停用";
            break;
            
        case 20101:
            self.msg = @"查询不到相关数据";
            break;
        case 20102:
            self.msg = @"手机号码格式错误";
            break;
            
        case 20301:
            self.msg = @"邮编号码为空";
            break;
        case 20302:
            self.msg = @"邮编号码查询不到对应的地址";
            break;
            
        case 20401:
            self.msg = @"城市参数为空";
            break;
        case 20402:
            self.msg = @"查询不到该城市的天气";
            break;
            
        case 20601:
            self.msg = @"请输入正确的15或18位身份证号码";
            break;
        case 20602:
            self.msg = @"错误的身份证或无结果";
            break;
            
        case 20701:
            self.msg = @"城市参数为空";
            break;
        case 20702:
            self.msg = @"查询不到该城市的空气质量";
            break;
            
        case 21401:
            self.msg = @"卡号有误,或者旧银行卡，暂时没有收录";
            break;
            
        case 21901:
            self.msg = @"查询不到相关数据";
            break;
        case 21902:
            self.msg = @"name为空或不合法";
            break;
            
        case 22001:
            self.msg = @"查询不到相关数据";
            break;
        case 22002:
            self.msg = @"name为空或不合法";
            break;
        default:
            break;
    }
}
@end


@implementation CookCategoryInfoObject
@end

@implementation CookCategoryObject
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"childs" : @"CookCategoryObject"};
}
@end



@implementation CookRecipeStepObject
@end

@implementation CookRecipeObject
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"method" : @"CookRecipeStepObject"};
}
@end

@implementation CookObject
@end







@implementation APIObject

+(APIObject *)infoWithError:(NSError *)error
{
    APIObject *info = [[APIObject alloc] init];
    NSString *des = [error.userInfo objectWithKey:@"NSLocalizedDescription"];
    if (des.length > 0)
        info.message = des;
    else
        info.message       = @"网络请示失败，请检查网络";
    info.state = 0;
    return info;
}

+(APIObject *)infoWithErrorMessage:(NSString *)errMsg
{
    APIObject *info = [[APIObject alloc] init];
    info.message       = errMsg;
    info.state = 0;
    return info;
}
@end



@implementation DryClearnShopCampaignObject
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"iD" : @"id"};
}

//计算折扣后金额
-(double)campaignWithMoney:(double)money
{
    double newMoney = money;
    if ([_code isEqualToString:@"A"]) { //减去规定金额
        newMoney = money - _price;
    } else if ([_code isEqualToString:@"B"]) { //折扣
        newMoney = money * (_price / 10);
    }
    return newMoney;
}

@end



@implementation DryClearnShopObject
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"iD" : @"id"};
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"campaignList" : @"DryClearnShopCampaignObject"};
}
@end


@implementation DryClearnShopClassObject
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"iD" : @"id"};
}
@end


@implementation DryClearnShopServerObject
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"iD" : @"id"};
}
@end



@implementation CouponsObject
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"iD" : @"id",
             @"desc" : @"description"};
}

//计算折扣后金额
-(double)couponWithMoney:(double)money
{
    double newMoney = money;
    if ([_typeCode isEqualToString:@"A"]) { //减去规定金额
        newMoney = money - _facePrice;
    } else if ([_typeCode isEqualToString:@"B"]) { //折扣
        newMoney = money * (_facePrice / 10);
    }
    return newMoney;
}

@end


@implementation AddressObject
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"iD" : @"id"};
}
@end



@implementation DryClearnShopOrderShowObject
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"userScore" : @"user.score",
             @"userRate" : @"user.rate",
             @"userMoney" : @"user.money"};
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"coupons" : @"CouponsObject"};
}


@end



@implementation DryClearnShopOrderPostObject
@end

@implementation DryClearnShopOrderCommentPostObject
@end


@implementation ComplainObject
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"iD" : @"id"};
}
@end



@implementation JPushReceiveAPSObject
@end

@implementation JPushReceiveObject
@end




