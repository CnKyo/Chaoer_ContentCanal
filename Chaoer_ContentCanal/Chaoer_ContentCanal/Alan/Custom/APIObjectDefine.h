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


#pragma mark - NSDictionary
@interface NSDictionary (QUAdditions)
-(id)objectWithKey:(NSString *)key; //返回有效值
@end

@interface NSMutableDictionary (QUAdditions)
- (void)setNeedStr:(NSString *)anObject forKey:(id)aKey;  //设置必须有的值
- (void)setValidStr:(NSString *)anObject forKey:(id)aKey;  //当值不为空时，设置该值
- (void)setInt:(int)anObject forKey:(id)aKey;
@end




@interface APIObjectDefine : NSObject

@end


@interface APIObject : NSObject
@property (nonatomic,strong) id                 result;         //正文
@property (nonatomic,strong) NSString *         msg;   //错误消息
@property (nonatomic,assign) int                retCode;         //非0表示 错误,调试使用
+(APIObject *)infoWithError:(NSError *)error;
+(APIObject *)infoWithErrorMessage:(NSString *)errMsg;
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



@interface MobileAddressObject : NSObject
@property (nonatomic, strong) NSString *            city;              //城市
@property (nonatomic, strong) NSString *            cityCode;              //城市区号
@property (nonatomic, strong) NSString *            mobileNumber;              //手机号前7位
@property (nonatomic, strong) NSString *            operatorS;              //运营商信息
@property (nonatomic, strong) NSString *            province;              //省份
@property (nonatomic, strong) NSString *            zipCode;              //邮编
@end



@interface AddressDistrictObject : NSObject
@property (nonatomic, strong) NSString *            iD;              //区县ID
@property (nonatomic, strong) NSString *            district;              //区县
@end

@interface AddressCityObject : NSObject
@property (nonatomic, strong) NSString *            iD;              //城市ID
@property (nonatomic, strong) NSString *            city;              //城市
@property (nonatomic, strong) NSMutableArray *      district;              //区县
@end

@interface AddressProvinceObject : NSObject
@property (nonatomic, strong) NSString *            iD;              //省份ID
@property (nonatomic, strong) NSString *            province;              //省份
@property (nonatomic, strong) NSMutableArray *      city;              //城市
@end


@interface AddressPostCodeObject : NSObject
@property (nonatomic, strong) NSString *            pId;              //省份id
@property (nonatomic, strong) NSString *            province;              //省份
@property (nonatomic, strong) NSString *            cId;              //城市id
@property (nonatomic, strong) NSString *            city;              //城市
@property (nonatomic, strong) NSString *            dId;              //区县id
@property (nonatomic, strong) NSString *            district;              //区县
@property (nonatomic, strong) NSString *            postNumber;              //邮编
@property (nonatomic, assign) int                   size;              //address数组长度
@property (nonatomic, strong) NSMutableArray *      address;              //地址数组
@end






@interface WeatherFutureObject : NSObject
@property (nonatomic, strong) NSString *            date;              //日期
@property (nonatomic, strong) NSString *            dayTime;              //白天天气
@property (nonatomic, strong) NSString *            night;              //晚上天气
@property (nonatomic, strong) NSString *            temperature;              //温度
@property (nonatomic, strong) NSString *            week;              //星期
@property (nonatomic, strong) NSString *            wind;              //风向
@end


@interface WeatherObject : NSObject
@property (nonatomic, strong) NSString *            airCondition;              //空气质量
@property (nonatomic, strong) NSString *            province;              //省份
@property (nonatomic, strong) NSString *            city;              //城市
@property (nonatomic, strong) NSString *            district;              //区县
@property (nonatomic, strong) NSString *            coldIndex;              //感冒指数
@property (nonatomic, strong) NSString *            updateTime;              //更新时间
@property (nonatomic, strong) NSString *            date;              //日期
@property (nonatomic, strong) NSString *            dressingIndex;              //穿衣指数
@property (nonatomic, strong) NSString *            exerciseIndex;              //运动指数
@property (nonatomic, strong) NSString *            humidity;              //湿度
@property (nonatomic, strong) NSString *            sunset;              //日落时间
@property (nonatomic, strong) NSString *            sunrise;              //日出时间
@property (nonatomic, strong) NSString *            temperature;              //温度
@property (nonatomic, strong) NSString *            time;              //时间
@property (nonatomic, strong) NSString *            washIndex;              //洗衣指数
@property (nonatomic, strong) NSString *            weather;              //天气
@property (nonatomic, strong) NSString *            week;              //星期
@property (nonatomic, strong) NSString *            wind;              //风向
@property (nonatomic, strong) NSMutableArray *      future;              //未来天气
@end







@interface EnvironmentFutureObject : NSObject
@property (nonatomic, strong) NSString *            date;              //日期
@property (nonatomic, assign) int                   aqi;              //空气质量指数
@property (nonatomic, strong) NSString *            quality;              //空气质量
@end

@interface EnvironmentHourObject : NSObject
@property (nonatomic, strong) NSString *            dateTime;              //日期
@property (nonatomic, assign) int                   aqi;              //空气质量指数
@end

@interface EnvironmentObject : NSObject
@property (nonatomic, assign) int                   aqi;              //空气质量指数
@property (nonatomic, strong) NSString *            quality;              //空气质量
@property (nonatomic, strong) NSString *            province;              //省份
@property (nonatomic, strong) NSString *            city;              //城市
@property (nonatomic, strong) NSString *            district;              //区县
@property (nonatomic, assign) int                   no2;              //污染物no2
@property (nonatomic, assign) int                   pm25;              //污染物pm2.5
@property (nonatomic, assign) int                   so2;              //污染物so2
@property (nonatomic, strong) NSString *            updateTime;              //更新时间
@property (nonatomic, strong) NSMutableArray *      fetureData;              //未来几天数据
@property (nonatomic, strong) NSMutableArray *      hourData;              //空气质量指数小时数据
@end




@interface DictionaryObject : NSObject
@property (nonatomic, strong) NSString *            name;              //汉字
@property (nonatomic, strong) NSString *            wubi;              //五笔
@property (nonatomic, strong) NSString *            bushou;              //部首
@property (nonatomic, assign) int                   bihua;              //笔画数
@property (nonatomic, assign) int                   bihuaWithBushou;              //去部首后笔画数
@property (nonatomic, strong) NSString *            pinyin;              //拼音
@property (nonatomic, strong) NSString *            brief;              //简介
@property (nonatomic, strong) NSString *            detail;              //明细
@end

@interface IdiomObject : NSObject
@property (nonatomic, strong) NSString *            name;              //成语
@property (nonatomic, strong) NSString *            pinyin;              //拼音
@property (nonatomic, strong) NSString *            pretation;              //释义
@property (nonatomic, strong) NSString *            source;              //出自
@property (nonatomic, strong) NSString *            sample;              //示例
@property (nonatomic, strong) NSString *            sampleFrom;              //示例出自
@end


@interface CalendarObject : NSObject
@property (nonatomic, strong) NSString *            date;              //日期
@property (nonatomic, strong) NSString *            holiday;              //节假日(不是节假日的日期数据为空)
@property (nonatomic, strong) NSString *            lunar;              //农历日期
@property (nonatomic, strong) NSString *            lunarYear;              //农历年
@property (nonatomic, strong) NSString *            suit;              //宜
@property (nonatomic, strong) NSString *            avoid;              //不宜/忌
@property (nonatomic, strong) NSString *            weekday;              //星期几
@property (nonatomic, strong) NSString *            zodiac;              //生肖
@end



@interface HistoryDayEventObject : NSObject
@property (nonatomic, strong) NSString *            event;              //事件
@property (nonatomic, strong) NSString *            date;              //日期
@property (nonatomic, assign) int                   day;              //天
@property (nonatomic, assign) int                   month;              //月份
@property (nonatomic, strong) NSString *            title;              //标题
@end




@interface HoroscopeObject : NSObject
@property (nonatomic, assign) int                   event;              //事件
@property (nonatomic, strong) NSString *            horoscope;              //八字信息
@property (nonatomic, strong) NSString *            lunar;              //阴历日期
@property (nonatomic, strong) NSString *            lunarDate;              //农历时间
@property (nonatomic, strong) NSString *            zodiac;              //生肖
@end

@interface DreamObject : NSObject
@property (nonatomic, strong) NSString *            name;              //梦源
@property (nonatomic, strong) NSString *            detail;              //解说
@end



@interface IdcardObject : NSObject
@property (nonatomic, strong) NSString *            area;              //身份证所属地区
@property (nonatomic, strong) NSString *            birthday;              //生日
@property (nonatomic, strong) NSString *            sex;              //性别
@end


@interface BankCardObject : NSObject
@property (nonatomic, strong) NSString *            bank;              //所属银行
@property (nonatomic, strong) NSString *            bin;              //bin码
@property (nonatomic, assign) int                   binNumber;              //bin码长度
@property (nonatomic, strong) NSString *            cardName;              //卡名
@property (nonatomic, strong) NSString *            cardType;              //卡片类型
@property (nonatomic, assign) int                   cardNumber;              //卡号长度
@end



@interface HealthObject : NSObject
@property (nonatomic, assign) int                   iD;              //文章id
@property (nonatomic, strong) NSString *            title;              //文章标题
@property (nonatomic, strong) NSString *            content;              //文章内容
@end




@interface WeixinCategoryObject : NSObject
@property (nonatomic, strong) NSString *            cid;              //分类Id
@property (nonatomic, strong) NSString *            name;              //分类名称
@end

@interface WeixinObject : NSObject
@property (nonatomic, strong) NSString *            iD;              //文章id
@property (nonatomic, strong) NSString *            cid;              //分类Id
@property (nonatomic, strong) NSString *            title;              //文章标题
@property (nonatomic, strong) NSString *            subTitle;              //文章副标题
@property (nonatomic, strong) NSString *            sourceUrl;              //文章来源
@property (nonatomic, strong) NSString *            pubTime;              //文章的发布时间
@property (nonatomic, strong) NSString *            thumbnails;              //导航缩略图，多个图片用$分割
@end





@interface AwardObject : NSObject
@property (nonatomic, assign) int                   awardNumber;              //中奖注数
@property (nonatomic, assign) double                awardPrice;              //中奖金额
@property (nonatomic, strong) NSString *            awards;              //奖项
@property (nonatomic, strong) NSString *            type;              //奖项类型
@end

@interface LotteryObject : NSObject
@property (nonatomic, strong) NSString *            name;              //彩种
@property (nonatomic, assign) double                sales;              //销售金额
@property (nonatomic, assign) double                pool;              //奖池金额
@property (nonatomic, strong) NSString *            period;              //期次
@property (nonatomic, strong) NSString *            awardDateTime;              //时间
@property (nonatomic, strong) NSMutableArray *      lotteryNumber;              //开奖号码
@property (nonatomic, strong) NSMutableArray *      lotteryDetails;              //中奖信息
@end





@interface OilPriceObject : NSObject
@property (nonatomic, strong) NSString *            province;              //省份
@property (nonatomic, strong) NSString *            dieselOil0;              //0号柴油
@property (nonatomic, strong) NSString *            gasoline90;              //90号汽油
@property (nonatomic, strong) NSString *            gasoline93;              //93号汽油
@property (nonatomic, strong) NSString *            gasoline97;              //97号汽油
@end



