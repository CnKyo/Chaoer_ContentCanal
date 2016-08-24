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
@property (nonatomic, assign) int                   iD;              //id
@property (nonatomic, assign) int                   type;              //
@property (nonatomic, strong) NSString *            condition;              //
@property (nonatomic, strong) NSString *            code;              //
@property (nonatomic, strong) NSString *            name;              //
@property (nonatomic, strong) NSString *            content;              //
@property (nonatomic, assign) double                price;              //
-(double)campaignWithMoney:(double)money;
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
@property (nonatomic, assign) double                deliverPrice;              //配送费
@property (nonatomic, assign) double                freePrice;              //免配送金额
@property (nonatomic, strong) NSMutableArray *      campaignList;              //活动
@end


//干洗店铺商品分类信息
@interface DryClearnShopClassObject : NSObject
@property (nonatomic, assign) int                   iD;              //id
@property (nonatomic, strong) NSString *            name;              //
@property (nonatomic, strong) NSString *            image;              //
@end


//干洗店铺商品服务信息
@interface DryClearnShopServerObject : NSObject
@property (nonatomic, assign) int                   iD;              //id
@property (nonatomic, assign) double                price;              //
@property (nonatomic, strong) NSString *            type;              //
@property (nonatomic, strong) NSString *            image;              //
@property (nonatomic, strong) NSString *            standard;              //
@property (nonatomic, strong) NSString *            describe;              //

@property (nonatomic, assign) int                   count;              //本地定义购物数量
@end



//优惠券
@interface CouponsObject : NSObject
@property (nonatomic, assign) int                   iD;              //id
@property (nonatomic, strong) NSString *            type;              //
@property (nonatomic, strong) NSString *            code;              //
@property (nonatomic, strong) NSString *            typeCode;              //
@property (nonatomic, strong) NSString *            pass;              //
@property (nonatomic, strong) NSString *            name;              //
@property (nonatomic, strong) NSString *            shopName;              //
@property (nonatomic, strong) NSString *            desc;              //
@property (nonatomic, assign) double                effective;              //
@property (nonatomic, assign) double                enoughMoney;              //
@property (nonatomic, assign) double                facePrice;              //
-(double)couponWithMoney:(double)money;
@end


//地址信息
@interface AddressObject : NSObject
@property (nonatomic, assign) int                   iD;              //id
@property (nonatomic, strong) NSString *            address;              //
@property (nonatomic, strong) NSString *            phone;              //
@property (nonatomic, strong) NSString *            sex;              //
@property (nonatomic, strong) NSString *            userName;              //
@end


//干洗店铺订单界面显示数据
@interface DryClearnShopOrderShowObject : NSObject
@property (nonatomic, strong) DryClearnShopObject * shop;              //
@property (nonatomic, assign) double                money;              //商品总价
@property (nonatomic, strong) NSMutableArray *      coupons;              //可选的优惠券
@property (nonatomic, strong) AddressObject *       addr;              //
@property (nonatomic, assign) int                   userScore;              //用户积分
@property (nonatomic, assign) double                userMoney;              //用户余额
@property (nonatomic, assign) double                userRate;              //用户积分抵扣金额比例
@end


//干洗店铺订单界面生成订单上传数据
@interface DryClearnShopOrderPostObject : NSObject
@property (nonatomic, assign) int                   shopId;              //id
@property (nonatomic, assign) int                   userId;              //id
@property (nonatomic, strong) NSString *            name;              //收货人姓名
@property (nonatomic, strong) NSString *            mobile;              //收货人手机号
@property (nonatomic, strong) NSString *            address;              //收货人地址
@property (nonatomic, strong) NSString *            times;              //收货时间，如：20160809 09:00~10:00
@property (nonatomic, assign) int                   coupon;              //优惠券id，默认为0
@property (nonatomic, assign) int                   campaing;              //活动id，默认为0
@property (nonatomic, assign) BOOL                  score;              //是否使用积分抵现
@property (nonatomic, strong) NSString *            device;              //值：ios
@property (nonatomic, strong) NSString *            cartJson;              //购物信息，如：[{"classify":1,"quantity":2}]
@end


//干洗店铺订单评价界面上传数据
@interface DryClearnShopOrderCommentPostObject : NSObject
@property (nonatomic, assign) int                   shopId;              //超市ID
@property (nonatomic, strong) NSString *            userId;              //id
@property (nonatomic, strong) NSString *            orderCode;              //订单编号
@property (nonatomic, strong) NSString *            context;              //评价类容
@property (nonatomic, strong) NSString *            satisfaction;              //满意度（最高5）
@property (nonatomic, strong) NSString *            images;              //评论图片
@property (nonatomic, strong) NSString *            device;              //值：ios
@end

