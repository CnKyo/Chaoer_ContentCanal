//
//  APIObjectDefine.h
//  EasySearch
//
//  Created by 瞿伦平 on 16/3/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomDefine.h"
#import "MJExtension.h"
#import "HTTPrequest.h"


#pragma mark - NSDictionary
@interface NSDictionary (QUAdditions)
-(id)objectWithKey:(NSString *)key; //返回有效值
@end

@interface NSMutableDictionary (QUAdditions)
- (void)setNeedStr:(NSString *)anObject forKey:(id)aKey;  //设置必须有的值
- (void)setValidStr:(NSString *)anObject forKey:(id)aKey;  //当值不为空时，设置该值
- (void)setInt:(int)anObject forKey:(id)aKey;
@end


@interface NSURL (AFObjectDefine)
+ (NSURL*)imageurl:(NSString*)str;
@end





@interface APIObjectDefine : NSObject

@end





#pragma mark - shareSDK 菜谱

@interface APIShareSdkObject : NSObject
@property (nonatomic,strong) id                 result;         //正文
@property (nonatomic,strong) NSString *         msg;   //错误消息
@property (nonatomic,assign) int                retCode;         //非0表示 错误,调试使用
+(APIShareSdkObject *)infoWithError:(NSError *)error;
+(APIShareSdkObject *)infoWithErrorMessage:(NSString *)errMsg;
@end



@interface CookCategoryInfoObject : NSObject
@property (nonatomic, strong) NSString *            ctgId;              //分类ID
@property (nonatomic, strong) NSString *            name;              //分类描述
@property (nonatomic, strong) NSString *            parentId;              //上层分类ID
@end

@interface CookCategoryObject : NSObject
@property (nonatomic, strong) CookCategoryInfoObject *  categoryInfo;              //分类ID
@property (nonatomic, strong) NSMutableArray *      childs;              //子集合
@end


@interface CookRecipeStepObject : NSObject
@property (nonatomic, strong) NSString *            img;              //图片显示
@property (nonatomic, strong) NSString *            step;               //制作步骤
@end


@interface CookRecipeObject : NSObject
@property (nonatomic, strong) NSString *            img;              //预览图地址
@property (nonatomic, strong) NSString *            ingredients;              //原材料
@property (nonatomic, strong) NSMutableArray *      method;              //具体方法
@property (nonatomic, strong) NSString *            sumary;              //简介
@property (nonatomic, strong) NSString *            title;              //标题
@property (nonatomic, strong) NSMutableArray *      childs;              //子集合
@end


@interface CookObject : NSObject
@property (nonatomic, strong) NSMutableArray *      ctgIds;              //分类ID
@property (nonatomic, strong) NSString *            ctgTitles;              //分类标签
@property (nonatomic, strong) NSString *            menuId;              //菜谱id
@property (nonatomic, strong) NSString *            name;              //菜谱名称
@property (nonatomic, strong) NSString *            thumbnail;              //预览图地址
@property (nonatomic, strong) CookRecipeObject *    recipe;              //制作步骤
@end



#pragma mark - API 

@interface APIObject : NSObject
@property (nonatomic,strong) id                 data;         //正文
@property (nonatomic,strong) NSString *         message;   //错误消息
@property (nonatomic,strong) NSString *         title;   //
@property (nonatomic,assign) int                state;         //
@property (nonatomic,assign) int                alert;         //
+(APIObject *)infoWithError:(NSError *)error;
+(APIObject *)infoWithErrorMessage:(NSString *)errMsg;
@end






//干洗店铺活动信息
@interface DryClearnShopCampaignObject : NSObject
@property (nonatomic, assign) int                   type;              //id
@property (nonatomic, strong) NSString *            condition;              //
@property (nonatomic, strong) NSString *            code;              //电话
@property (nonatomic, strong) NSString *            name;              //
@property (nonatomic, strong) NSString *            content;              //
@end



//干洗店铺信息
@interface DryClearnShopObject : NSObject
@property (nonatomic, assign) int                   iD;              //id
@property (nonatomic, strong) NSString *            shopName;              //
@property (nonatomic, strong) NSString *            shopTel;              //电话
@property (nonatomic, strong) NSString *            shopLogo;              //
@property (nonatomic, strong) NSString *            shopDes;              //
@property (nonatomic, strong) NSString *            address;              //
@property (nonatomic, strong) NSString *            openingTime;              //
@property (nonatomic, strong) NSString *            closingTime;              //
@property (nonatomic, assign) double                lat;              //
@property (nonatomic, assign) double                lng;              //
@property (nonatomic, strong) NSString *            deliverPrice;              //
@property (nonatomic, strong) NSString *            freePrice;              //
@property (nonatomic, strong) NSMutableArray *      campaignList;              //活动
@end


