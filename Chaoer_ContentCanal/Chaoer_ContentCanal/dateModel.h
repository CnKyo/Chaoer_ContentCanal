//
//  dateModel.h
//  YiZanService
//
//  Created by zzl on 15/3/19.
//  Copyright (c) 2015年 zywl. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface dateModel : NSObject

@end

@interface SAutoEx : NSObject<NSCopying>

-(id)initWithObj:(NSDictionary*)obj;

-(void)fetchIt:(NSDictionary*)obj;

@end

//返回通用数据,,,
@interface SResBase : NSObject

@property (nonatomic,assign) BOOL       msuccess;//是否成功了
@property (nonatomic,assign) int        mcode;  //错误码
@property (nonatomic,strong) NSString*  mmsg;   //客户端需要显示的提示信息,正确,失败,根据msuccess判断显示错误还是提示,
@property (nonatomic,strong) NSString*  mdebug;
@property (nonatomic,strong) id         mdata;

-(id)initWithObj:(NSDictionary*)obj;

-(void)fetchIt:(NSDictionary*)obj;

+(SResBase*)infoWithError:(NSString*)error;

@end

@interface SUserState : NSObject

@property (nonatomic,assign)    BOOL    mbHaveNewMsg;

@end

typedef enum _userrole
{
    E_R_Seller      = 1,//商家
    E_R_Sender      = 2,//配送人员
    E_R_Servicer    = 4,//服务人员
}UserRole;

@class STimeSet;
@class SMyMoney;
@class SWithDrawInfo;
@class SOrderPack;
@class SShop;
@interface SUser : NSObject

@property (nonatomic,assign) int         mUserId;
@property (nonatomic,assign) int         mAge;
@property (nonatomic,strong) NSString*   mSex;
@property (nonatomic,strong) NSString*   mPhone;
@property (nonatomic,strong) NSString*   mUserName;
@property (nonatomic,strong) NSString*   mHeadImgURL;
@property (nonatomic,strong) NSString*   mToken;
@property (nonatomic,strong) NSString*   mBrief;
@property (nonatomic,assign) float       mTotalMoney; //总余额
@property (nonatomic,assign) float       mWithdrawMoney; //可提现金额
@property (nonatomic,assign) float       mFrozenMoney; //冻结金额
@property (nonatomic,assign) int         mRole;//角色
@property (nonatomic,strong) NSString*   mBg;//头像大背景图片

-(BOOL)isSeller;//是否有商家角色

-(BOOL)isSender;//是否有配送人员角色

-(BOOL)isServicer;//是否有服务人员角色

//返回当前用户
+(SUser*)currentUser;

//判断是否需要登录
+(BOOL)isNeedLogin;

//是否是一个合法的用户对象
-(BOOL)isVaildUser;

//退出登陆
+(void)logout;

//发送短信
+(void)sendSM:(NSString*)phone block:(void(^)(SResBase* resb))block;

///校验手机号码
+(void)checkPhone:(NSString *)mPhone andCode:(NSString *)mCode block:(void(^)(SResBase* resb))block;

///更新手机号码
+(void)changePhone:(NSString *)mNewPhone andOldphone:(NSString *)oldPhone andCode:(NSString *)mCode block:(void(^)(SResBase* resb))block;
//登录,密码或者验证码登录
+(void)loginWithPhone:(NSString*)phone psw:(NSString*)psw vcode:(NSString*)vcode block:(void(^)(SResBase* resb, SUser*user))block;

//密码登录,
+(void)loginWithPhone:(NSString*)phone psw:(NSString*)psw block:(void(^)(SResBase* resb, SUser*user))block;


//重置密码
+(void)reSetPswWithPhone:(NSString*)phone newpsw:(NSString*)newpsw smcode:(NSString*)smcode  block:(void(^)(SResBase* resb, SUser*user))block;

//修改用户信息,修改成功会更新对应属性 HeadImg 360x360
-(void)updateUserInfo:(NSString*)name HeadImg:(UIImage*)Head Brief:(NSString *)brief block:(void(^)(SResBase* resb))block;

//获取消息列表 all => SMessageInfo
-(void)getMyMsg:(int)page block:(void(^)( SResBase* resb , NSArray* all ))block;

//是否有新消息
-(void)getMsgStatus:(void(^)( SResBase* resb ,BOOL bhavenew ))block;


//获取评价列表 all => SRate
-(void)getMyRate:(int)page type:(int)type block:(void(^)( SResBase* resb , NSArray* all ))block;


//获取我的订单,,
// statu 1：新订单；2：进行中；3：已完成；3：已取消  retobj ==> SOrderPack
-(void)getMyOrders:(int)page status:(int)status date:(NSString*)date keywords:(NSString*)keywords block:(void(^)(SResBase* resb,SOrderPack* retobj))block;



-(void)getSchedulesWithDate:(int)mPage nadType:(int)mType block:(void(^)(SResBase* resb ,NSArray* mDateList ))block;
/**
 *  修改用户信息,修改成功会更新对应属性
 *
 *  @param pwdStr 修改的密码
 *  @param mImage 修改的头像
 *  @param block  返回的数据
 */
-(void)editUserInfo:(NSString*)name pwd:(NSString *)pwdStr mHeaderImg:(UIImage*)mImage block:(void(^)(SResBase* resb,BOOL bok ,float process))block;

+(void)relTokenWithPush;

+(void)clearTokenWithPush;

+(NSArray*)loadHistoryWaiter;

+(NSArray*)loadHistory;

+(void)clearHistoryWaiter;

+(void)clearHistory;
///开启和关闭接单 0:开启；1：关闭
+ (void)OpenAndCloseOrder:(int)mStatus block:(void(^)( SResBase* resb))block;
///获取佣金
- (void)getMoney:(int)mPage block:(void(^)( SResBase* resb , SMyMoney* money ))block;

//获取服务时间设置,
-(void)getTimeSet:(void(^)( SResBase* resb , NSArray* all ))block;

//设置时间,
-(void)addTimeSet:(int)maybeid weeks:(NSArray*)weeks hours:(NSArray*)hours block:(void(^)(SResBase* resb ,STimeSet* retobj))block;


//请假
-(void)leaveReq:(int)starttime endtime:(int)endtime text:(NSString*)text block:(void(^)(SResBase* resb))block;

//获取请假列表
-(void)leaveList:(int)page block:(void(^)(NSArray* arr, SResBase*  resb))block;

//获取银行账户信息
-(void)getBankInfo:(void(^)( SResBase*  resb,SWithDrawInfo* retobj ))block;

//体现到银行卡里面
-(void)getWithDraw:(double)amount block:(void(^)( SResBase*  resb ))block;

@end

@interface GInfo : NSObject

@property (nonatomic,strong)    NSString*   mGToken;    //全局token
@property (nonatomic,assign)    int         mivint;      //962694
@property (nonatomic,strong)    NSArray*    mSupCitys;  //开通城市 ==> SCity
@property (nonatomic,strong)    NSArray*    mPayments;  //支付信息 ==> SPayment;


@property (nonatomic,strong)    NSString*   mAppVersion;
@property (nonatomic,assign)    BOOL        mForceUpgrade;
@property (nonatomic,strong)    NSString*   mAppDownUrl;
@property (nonatomic,strong)    NSString*   mUpgradeInfo;
@property (nonatomic,strong)    NSString*   mServiceTel;

@property (nonatomic,strong)    NSString*   mOssid;
@property (nonatomic,strong)    NSString*   mOssKey;
@property (nonatomic,strong)    NSString*   mOssBucket;
@property (nonatomic,strong)    NSString*   mOssHost;

@property (nonatomic,strong)    NSString*   mAboutUrl;          //关于我们Url
@property (nonatomic,strong)    NSString*   mProtocolUrl;       //用户协议Url
@property (nonatomic,strong)    NSString*   mRestaurantTips;    //餐厅订餐说明
@property (nonatomic,strong)    NSString*   mShareQrCodeImage;  //分享二维码图片地址
@property (nonatomic,strong)    NSString*   mHelpUrl;       //用户协议Url



+(GInfo*)shareClient;

+(void)getGInfoForce:(void(^)(SResBase* resb, GInfo* gInfo))block;

+(void)getGInfo:(void(^)(SResBase* resb, GInfo* gInfo))block;

@end


@interface SWxPayInfo : NSObject

@property (nonatomic,strong) NSString*  mpartnerId;//	string	是			商户号
@property (nonatomic,strong) NSString*  mprepayId;//	string	是			预支付交易会话标识
@property (nonatomic,strong) NSString*  mpackage;//	string	是			扩展字段
@property (nonatomic,strong) NSString*  mnonceStr;//	string	是			随机字符串
@property (nonatomic,assign) int        mtimeStamp;//	int	是			时间戳
@property (nonatomic,strong) NSString*  msign;//	string	是			签名
-(id)initWithObj:(NSDictionary*)obj;

@end




@interface SPayment : NSObject

-(id)initWithObj:(NSDictionary*)obj;


@property (nonatomic,strong)    NSString*   mCode;
@property (nonatomic,strong)    NSString*   mName;
@property (nonatomic,strong)    NSString*   mIconName;
@property (nonatomic,assign)    int        mDefault;

@end

//存储一些APP的全局数据
@interface SAppInfo : NSObject

@property (nonatomic,strong)    NSString*   mSelCity;//用户选择的城市
@property (nonatomic,assign)    int         mCityId;//用户选择的城市id
@property (nonatomic,strong)    NSString*   mAddr;//当前APP的地址
@property (nonatomic,assign)    float       mlng;//当前APP的坐标
@property (nonatomic,assign)    float       mlat;
@property (nonatomic,strong)    NSString*  mCityNow;

//支付需要跳出到APP,这里记录回调
@property (nonatomic,strong)    void(^mPayBlock)(SResBase* resb);


//修改了属性就调用下这个,
-(void)updateAppInfo;

//定位,,会修改 mAddr mlat mlng
//bforce 是否强制定位,否则是缓存了的
-(void)getUserLocation:(BOOL)bforce block:(void(^)(NSString*err))block;


+(void)getPointAddress:(float)lng lat:(float)lat block:(void(^)(NSString* address,NSString*err))block;

+(void)getPointAddressBubyer:(float)lng lat:(float)lat block:(void(^)(NSString* address,NSString* city,NSString*err))block;


+(SAppInfo*)shareClient;
///
+(void)feedback:(NSString*)content block:(void(^)(SResBase* resb))block;

@end


@interface SNorms : SAutoEx

@property (nonatomic,assign)    int         mId;
@property (nonatomic,strong)    NSString*   mName;//	string	规格
@property (nonatomic,assign)    float       mPrice;//	double	价格
@property (nonatomic,assign)    int         mStock;//	int	库存

@property (nonatomic,strong)    NSDictionary*   mdic;

@end

@interface SGoods : SAutoEx

@property (nonatomic,assign)    int         mId;//	int	编号
@property (nonatomic,strong)    NSString*   mName;//	string	名称
@property (nonatomic,assign)    int         mCount;//	int	数量；订单对象使用
@property (nonatomic,assign)    float       mPrice;//	double	价格
@property (nonatomic,strong)    NSArray*    mImgs;//	List<String>	图片,第一张为默认图,,修改或者添加的时候,,这个里面有些UIImage对象
@property (nonatomic,assign)    int         mSaleCount;//	int	销量
@property (nonatomic,assign)    int         mStock;//	int	库存
@property (nonatomic,strong)    NSString*   mDate;//	String	上架、下架日期（2015-10-26）
@property (nonatomic,strong)    NSArray*    mNorms;//	 ==>SNorms 	规格列表
@property (nonatomic,assign)    int         mDuration;//	int	服务时长，以分钟为单位（服务）
@property (nonatomic,strong)    NSArray*    mStaff;// ==> SPeople 服务、配送人员（服务）
@property (nonatomic,assign)    int         mDeductType;//	int	提成类型1固定2按比例（服务）
@property (nonatomic,assign)    float       mDeductVal;//	提成值（服务）

@property (nonatomic,assign)    int         mTradeId;//分类ID
@property (nonatomic,strong)    NSString*   mBrief;//简介
@property (nonatomic,assign)    BOOL        mIsCheck;

//添加这个商品
-(void)addThis:(void(^)(SResBase* resb))block;

//更新这个商品
-(void)updateThis:(void(^)(SResBase* resb))block;

//上架
+(void)getOn:(NSArray*)ids block:(void(^)(SResBase* resb))block;

//下架
+(void)getOff:(NSArray*)ids block:(void(^)(SResBase* resb))block;

//删除
+(void)delSome:(NSArray*)ids block:(void(^)(SResBase* resb))block;

@end



typedef enum _orderStateNew
{
    ///无
    E_OS_Non                = 000,
    ///等待付款
    E_OS_WaitPayIt          = 100,
    ///付款成功
    E_OS_PaySucsess         = 101,
    ///服务机构确认
    E_OS_JigouComfirm       = 102,
    ///服务人员确认
    E_OS_RenyuanComfirm     = 103,
    ///服务人员出发
    E_OS_Renyuango          = 104,
    ///服务人员上门取件(洗衣类型)
    E_OS_Pickup             = 105,
    ///开始服务
    E_OS_StartService       = 106,
    ///平台清洗
    E_OS_CleanFinish        = 107,
    ///上门返件
    E_OS_ReturnFinish       = 108,
    ///服务完成
    E_OS_ServiceFinish      = 109,
    ///会员确认完成
    E_OS_VipComfirmFinish   = 200,
    ///系统自动确认完成
    E_OS_SystemComfirmfinish= 201,
    ///会员取消订单
    E_OS_VipCancelOrder     = 300,
    ///支付超时取消订单
    E_OS_PayTimeOut         = 301,
    ///服务机构拒绝
    E_OS_JigouRefuse        = 302,
    ///服务人员拒绝
    E_OS_RenyuanRefuse      = 303,
    ///退款审核中
    E_OS_AuditRefund        = 400,
    ///退款未通过
    E_OS_RefundNotThrought  = 401,
    ///退款处理中
    E_OS_Refunding          = 402,
    ///退款失败
    E_OS_Refundfailure      = 403,
    ///退款成功
    E_OS_RefundSecsess      = 404,
    ///会员删除订单
    E_OS_VipDelOrder        = 500,
    ///服务机构删除订单
    E_OS_JigouDelOrder      = 501,
    
}OrderStateNew;
@class SPeople;
@interface SOrder : SAutoEx

@property (nonatomic,assign)    int         mId;//	int	编号
@property (nonatomic,strong)    NSString*   mSn;//	string	订单号
@property (nonatomic,strong)    NSString*   mProvince;//	string	省
@property (nonatomic,strong)    NSString*   mCity;//	string	市
@property (nonatomic,strong)    NSString*   mArea;//	  string	区
@property (nonatomic,strong)    NSString*   mAddress;//	string	地址
@property (nonatomic,strong)    NSString*   mName;//购买人姓名
@property (nonatomic,strong)    NSString*   mMobile;//	string	电话
@property (nonatomic,strong)    NSDictionary*    mMapPoint;//	List<string>	坐标
@property (nonatomic,strong)    NSString*   mOrderStatusStr;//	String	订单状态，直接显示
@property (nonatomic,assign)    float       mTotalFee;//	double	订单总额
@property (nonatomic,assign)    int         mCount;//	int	商品数量
@property (nonatomic,strong)    NSString*   mAppTime;//	String	预约时间2015-09-15 16:00-19:00
@property (nonatomic,strong)    NSString*   mPayType;//	String	支付方式
@property (nonatomic,assign)    float       mFreight;//	double	配送费
@property (nonatomic,strong)    NSString*   mBuyRemark;//	string	会员备注
@property (nonatomic,strong)    NSString*   mCancelRemark;//	String	拒绝理由
@property (nonatomic,assign)    int         mOrderType;//	String	订单类型 1:商品 2:服务
@property (nonatomic,assign)    int         mStatus;//	int	订单状态
@property (nonatomic,strong)    NSString*   mCreateTime;//	String	下单时间
@property (nonatomic,strong)    NSArray*    mOrderGoods;//	List<Goods>	商品列表
@property (nonatomic,strong)    SPeople*   	mStaff;//	Staff	配送、服务人员对象
@property (nonatomic,assign)    BOOL        mIsCanCancel;//	boolean	是否取消订单（商家端）
@property (nonatomic,assign)    BOOL        mIsCanAccept;//	boolean	是否可以确认订单（商家端）
@property (nonatomic,assign)    BOOL        mIsCanFinish;//	boolean	是否可以服务完成（配送、服务人员端：订单完成）
@property (nonatomic,assign)    BOOL        mIsCanStartService;//是否可以开始 服务 或者 配送
@property (nonatomic,assign)    BOOL        mIsCanChangeStaff;//是否可以更改服务人员

@property (nonatomic,assign)    float       mPrice;//	double	价格
@property (nonatomic,strong)    NSArray*    mImgs;//	List<String>	商品图片列表


@property (nonatomic,assign)    float       mLat;
@property (nonatomic,assign)    float       mLongit;
@property (nonatomic,assign)    int         mDist;//距离
@property (nonatomic,strong)    NSString*   mDistStr;

@property (nonatomic,strong)    NSString*   mPayStatusStr;// = "\U5df2\U4ed8\U6b3e";
@property (nonatomic,strong)    NSString*   mShopName;// = "\U6c47\U751c\U8702\U4e1a";

@property (nonatomic,assign)    int         mIsFinished;
@property (nonatomic,strong)    NSString*   mBuyerFinishTime;

@property (nonatomic,assign)    float       mGoodsFee;//	Double	商品金额
@property (nonatomic,assign)    float       mDiscountFee;//	Double	优惠金额
@property (nonatomic,assign)    float       mPayFee;//	Double	支付金额

@property (nonatomic,strong)    NSString*   mSellerName;

//订单详情
-(void)getDetail:(void(^)(SResBase* resb))block;


//开始服务
-(void)startSrv:(void(^)(SResBase* resb))block;


//选择人员,配送人员或者服务人员 staffid选择的人员ID
-(void)selectPeople:(int)staffid block:(void(^)(SResBase* resb))block;


//取消订单 remark订单备注
-(void)cancleThis:(NSString*)remark block:(void(^)(SResBase* resb))block;

//订单确认
-(void)confirmThis:(void(^)(SResBase* resb))block;

//订单完成
-(void)completeThis:(void(^)(SResBase* resb))block;


//订单完成
-(void)startThis:(void(^)(SResBase* resb))block;


-(void)payIt:(NSString*)paytype block:(void(^)(SResBase* resb))block;
    
@end

@interface SOrderGoods : SAutoEx


@property (nonatomic,assign)    int         mGoodsId;//	int	商品编号
@property (nonatomic,strong)    NSString*   mGoodsName;//	string	商品名称
@property (nonatomic,strong)    NSString*   mGoodsImages;//	string	商品图片
@property (nonatomic,strong)    NSString*   mGoodsNorms;//	string	商品规格名称
@property (nonatomic,assign)    int         mGoodsNormsId;//	int	商品规格编号
@property (nonatomic,assign)    int         mNum;//	int	数量
@property (nonatomic,assign)    float       mPrice;//	double	价格

@end


@interface SOrderRateInfo : SAutoEx

@property (nonatomic,assign)  int       mId;//int 编号
@property (nonatomic,strong)  NSString* mUserName;//String;//评价用户昵称
@property (nonatomic,strong)  NSString* mContent;// string;//评价内容
@property (nonatomic,strong)  NSString* mReply;// string;//商家回复
@property (nonatomic,strong)  NSString* mReplyTime;// String;//"商家评价回复时间2015-07-29"
@property (nonatomic,assign)  int       mStar;//int 评价星级（1-5）
@property (nonatomic,strong)  NSString* mCreateTime;//String;//"创建时间2015-07-29"
@property (nonatomic,strong)  NSString* mGoodName;//String;//菜品名称（若是评价外卖菜品则有此字段）
@property (nonatomic,strong)  NSArray*  mImages;//评价图片
@property (nonatomic,assign)  int       mOrderId;//订单编号

//回复这个
-(void)replayThis:(NSString*)content block:(void(^)(SResBase* resb))block;


@end

@interface SStatisic : NSObject

@property (nonatomic,assign) int        mYear;//2015
@property (nonatomic,assign) int        mMonth;//1 2 3
@property (nonatomic,assign) int        mNum;
@property (nonatomic,assign) float      mTotal;
///订单id
@property (nonatomic,assign) int        mOrderId;

//详情列表的时候,需要下面的
@property (nonatomic,strong) NSString*  mTimeStr;
@property (nonatomic,strong) NSString*  mSrvName;
@property (nonatomic,strong) NSString*  mImgURL;
@property (nonatomic,assign) float      mMoney;
@property (nonatomic,strong) NSString*  mOrderSn;

@property (nonatomic,strong)    SGoods*         mGooods;

//获取统计数据,month = -1 表示 按照月份来统计,0 表示最近统计数据,
+(void)getStatisic:(int)yeaer month:(int)month page:(int)page block:(void(^)(SResBase* resb,NSArray* all))block;

@end

@interface SMessageInfo : SAutoEx
-(id)initWithAPN:(NSDictionary*)objapn;

@property (nonatomic,assign)    int       mId;//int 编号
@property (nonatomic,strong)    NSString *mContent;// string  内容
@property (nonatomic,strong)    NSString *mTitle;// string  标题
@property (nonatomic,strong)    NSString *mCreateTime;//  string  "创建时间2015-08-09"
@property (nonatomic,assign)    int      mStatus;//  int "是否已读1：已读 0：未读"
@property (nonatomic,assign)    int      mType;//  int "消息类型1：普通消息2：html页面，args为url3：订单消息，args为订单id"
@property (nonatomic,strong)    NSString *mArgs;//    参数
@property (nonatomic,assign)    int      mCrateType;// int "消息来源类型0：平台1：商家"

@property (nonatomic,assign) BOOL       mChecked;
//阅读消息
-(void)readThis:(void(^)(SResBase* resb))block;

//删除消息
-(void)delThis:(void(^)(SResBase* resb))block;

///是否有新消息
+ (void)isHaveMessage:(void(^)(SResBase* resb))block;

//全部标记为已读
+(void)readAllMessage:(void(^)(SResBase* retobj))block;

//msgid 所有需要删除的消息ID
+(void)delMessages:(NSArray*)msgid block:(void(^)(SResBase* retobj))block;

//读一些..
+(void)readSomeMsg:(NSArray*)msgid block:(void(^)(SResBase* retobj))block;

@end



/**
 日程对象日程安排
 */

@interface SchedulDate : SAutoEx

@property (nonatomic,strong)    NSString*   mDateStr;   //日期 今天,明天,15号,,,,,
@property (nonatomic,strong)    NSArray*    mInfos;     //==>SDateOrder

-(id)initWithObj:(NSDictionary*)obj;


@end


@interface STimeSet : SAutoEx

-(id)initWithObj:(NSDictionary*)obj;

@property (nonatomic,assign) int        mId;

/*
 "0:星期日 1:星期一 2:星期二 3:星期三 4:星期四 5:星期五 6:星期六"
 */
@property (nonatomic,strong) NSString*  mWeek;
//@property (nonatomic,strong) NSString*  mTimes;// "00:00 ~ 10:00"
@property (nonatomic,strong) NSString *mShifts;

@property (nonatomic,strong) NSArray*   mWeekInfo;
@property (nonatomic,strong) NSArray*   mTimesInfo;// 选择的起始时间 "00:00"

-(void)delThis:(void(^)(SResBase* resb))block;

@end

@interface SLeave : SAutoEx

-(id)initWithObj:(NSDictionary*)obj;

@property (nonatomic,assign) CGFloat   mHHH;

@property (nonatomic,assign) BOOL       mSelected;

@property (nonatomic,assign) int        mId;
@property (nonatomic,strong) NSString*  mText;  //请假描述
@property (nonatomic,strong) NSString*  mTimeStr;//请假提交时间

@property (nonatomic,strong) NSString*  mStartTimeStr;
@property (nonatomic,strong) NSString*  mEndTimeStr;

@property (nonatomic,strong) NSString*  mStatusStr;

///删除一组请假记录
+(void)delAll:(NSArray*)allids block:(void(^)(SResBase* resb))block;

@end
@interface SMyMoney : SAutoEx
///总佣金
@property (nonatomic,assign) float      mTotleMoney;

///内容
@property (nonatomic,strong) NSArray*  mContent;

-(id)initWithObj:(NSDictionary*)obj;


@end

@interface SMoney : SAutoEx
///金额
@property (nonatomic,assign) float      mMoney;
///时间
@property (nonatomic,strong) NSString*  mCreateTime;
///内容
@property (nonatomic,strong) NSString*  mContent;
///订单编号
@property (nonatomic,strong) NSString        *mOrderId;

-(id)initWithObj:(NSDictionary*)obj;


@end

//提现对象,银行卡信息
@interface SWithDrawInfo : SAutoEx

@property (nonatomic,assign)    int         mId;
@property (nonatomic,strong)    NSString*   mBank;
@property (nonatomic,strong)    NSString*   mBankName;//	String	开户行;
@property (nonatomic,strong)    NSString*   mName;//name	String	开户姓名
@property (nonatomic,strong)    NSString*   mBankNo;//bankNO	String	开户卡号（***** **** *7893）
@property (nonatomic,strong)    NSString*   mNotice;//HTML

-(void)EditBank:(NSString *)bank bankNo:(NSString *)bankNo mobile:(NSString *)mobile name:(NSString *)name verifyCode:(NSString *)verifyCode block:(void(^)(SResBase* resb,SWithDrawInfo *draw))block;

+(void)AddBank:(NSString *)bank bankNo:(NSString *)bankNo mobile:(NSString *)mobile name:(NSString *)name verifyCode:(NSString *)verifyCode block:(void(^)(SResBase* resb,SWithDrawInfo *draw))block;

+(void)GetBankInfo:(void(^)(SResBase* resb,SWithDrawInfo *draw))block;

-(void)DeleteBankInfo:(void(^)(SResBase* resb))block;

@end




@interface SAvd : SAutoEx


@property (nonatomic,assign)    int         mId;//	int	编号
@property (nonatomic,strong)    NSString*   mName;//	String	名称
@property (nonatomic,strong)    NSString*   mImage;//	String	图片地址
@property (nonatomic,assign)    int         mType;//	int	"点击时处理的类型 1：商户分类类型 2：服务类型（暂时未用） 3：商品详情（暂时未用） 4：商家详情（暂时未用） 5：URL"

//String	"相关参数 根据类型设置 1、商户分类编号 2：服务类型ID（暂时未用） 3：商品、服务ID（暂时未用） 4：商家ID（暂时未用） 5:URL地址"
@property (nonatomic,strong)    NSString*   mArg;

@end

@interface STrade : SAutoEx

@property (nonatomic,assign)    int         mId;
@property (nonatomic,strong)    NSString*   mName;

@end

@interface SEvaPack : SAutoEx

@property (nonatomic,assign)    float   mScore;//	float	评分
@property (nonatomic,assign)    int     mUnReply;//	int	未回复数量
@property (nonatomic,assign)    int     mReply;//	int	已回复数量
@property (nonatomic,strong)    NSArray*mEva;//==>SOrderRateInfo 评价列表


@end

@interface SSeller : SAutoEx

@property (nonatomic,assign)    int         mId;
@property (nonatomic,strong)    NSString*   mName;//String;//名称
@property (nonatomic,strong)    NSString*   mLogo;//string;//图标
@property (nonatomic,assign)    int         mIsCollect;//int;//是否收藏0：未收藏；1：收藏
@property (nonatomic,strong)    NSArray*    mBanner;//==> SAvd //广告列表
@property (nonatomic,strong)    NSString*   mBusinessHours;//String;//"营业时间8:00 – 23:00"
@property (nonatomic,strong)    NSString*   mFreight;//String;//配送费，格式化好后返回
@property (nonatomic,strong)    NSString*   mTel;//String;//电话
@property (nonatomic,assign)    float       mDeliveryFee;//double;//起送费
@property (nonatomic,assign)    float       mServiceFee;//double;//配送费
@property (nonatomic,strong)    NSString*   mAddress;//String;//地址
@property (nonatomic,strong)    NSString*   mDetail;//String;//商家介绍
@property (nonatomic,strong)    NSString*   mMapPoint;//String;//坐标
@property (nonatomic,strong)    NSString*   mImage;//string;//商家背景图片


//获取经营类型列表 all => STrade
+(void)getTradeList:(void(^)(SResBase* resb,NSArray* all))block;

//获取评价 page 页码, type 1:未回复；2：已回复 all
+(void)getEvaList:(int)page type:(int)type block:(void(^)(SResBase* info,SEvaPack* evapack))block;

@end

//店铺账单对象
@interface SShopBill : SAutoEx

@property (nonatomic,strong)    NSString*   mCreateTime;//时间
@property (nonatomic,strong)    NSString*   mMoney;//double;//金额
@property (nonatomic,assign)    int         mStatus;//状态（0待审核，1成功，2拒绝）
@property (nonatomic,strong)    NSString*   mRemark;//	string备注（入余额，提现）

@end

@interface SProvince : SAutoEx

@property (nonatomic,assign) int mI;
@property (nonatomic,strong) NSString* mN;
@property (nonatomic,strong) NSArray*  mChild;

+ (void)GetProvice:(void(^)(NSArray* all))block;

@end


//店铺信息
@interface SShop : SAutoEx


@property (nonatomic,assign)    float       mTurnover;//double;//营业额
@property (nonatomic,assign)    int         mOrderNum;//int;//订单数量
@property (nonatomic,assign)    float       mBalance;//double;//账户余额
@property (nonatomic,strong)    NSString*   mName;//String;//店铺名称
@property (nonatomic,strong)    NSString*   mImg;//String;//LOGO
@property (nonatomic,strong)    NSString*   mArticle;//String;//公告
@property (nonatomic,assign)    int         mStatus;//int;//营业状态（1：营业；2：暂停）
@property (nonatomic,strong)    NSDictionary*    mBusinessHour;//List<String>;//营业时间
@property (nonatomic,strong)    NSDictionary*    mDeliveryTime;//List<String>;//配送时间
@property (nonatomic,strong)    NSString*   mTel;//String;//联系电话
@property (nonatomic,strong)    NSString*   mServiceRange;//String;//服务范围
@property (nonatomic,strong)    NSString*   mBrief;//String;//简介
@property (nonatomic,assign)    float       mServiceFee;//double;//起送价
@property (nonatomic,assign)    float       mDeliveryFee;//double;//配送费

@property (nonatomic,strong)   NSString*    mRegion;//	string	所在地区 如:重庆市-渝中区
@property (nonatomic,assign)    int         mProvinceId;//	int	省编号
@property (nonatomic,assign)   int          mCityId;//	int	市编号
@property (nonatomic,assign)    int         mAreaId;//	int	区编号
@property (nonatomic,strong)   NSString*    mAddress;//	string	店铺地址
@property (nonatomic,strong)    NSString*   mAddressDetail;//	string	店铺详细地址 (如门牌号)
@property (nonatomic,strong)    NSString*   mMapPointStr;//	string	地图经纬度字符串
@property (nonatomic,strong)    NSString*   mContacts;//负者人

@property (nonatomic,assign)    int         mDeduct;//	int	服务平台抽佣比例 0 - 100
@property (nonatomic,assign)    int         mIsCashOnDelivery;//	int	是否支持货到付款 0：不支持 1：支持


//获取店铺信息
+(void)getShopInfo:(void(^)(SResBase* info,SShop* retobj))block;

//是否支持货到付款
-(void)updateAvrH:(int)benable block:(void(^)(SResBase* info))block;

///修改店铺名称
- (void)updateDianpuName:(NSString *)mName block:(void(^)(SResBase* info))block;
///修改店铺logo
- (void)upDateDianpuLogo:(UIImage *)mLogo block:(void(^)(SResBase* info))block;

//修改公告
-(void)updateArticle:(NSString*)content block:(void(^)(SResBase* info))block;
///营业状态
- (void)upDateYingyeStatus:(int)mStatus block:(void(^)(SResBase* info))block;
//修改简介
-(void)updateBrief:(NSString*)content block:(void(^)(SResBase* info))block;

//修改电话
-(void)updateTel:(NSString*)content block:(void(^)(SResBase* info))block;

//修改配送费
-(void)updatePs:(NSString*)content block:(void(^)(SResBase* info))block;

//修改起送价
-(void)updateQs:(NSString*)content block:(void(^)(SResBase* info))block;

//修改配送时间
-(void)updateDeliveryTimes:(NSDictionary*)allnew block:(void(^)(SResBase* info))block;

//修改营业时间
-(void)updateBusinessTime:(NSArray*)allnew andHourArr:(NSArray *)hourArr block:(void(^)(SResBase* info))block;

//更新区域
-(void)updatePCA:(int)pid cid:(int)cid aid:(int)aid block:(void(^)(SResBase* info))block;

//更新区域
-(void)updateAddressInfo:(NSString*)addr lat:(float)lat lng:(float)lng block:(void(^)(SResBase* info))block;

//更新详细地址
-(void)updateAddressDetailInfo:(NSString*)addr block:(void(^)(SResBase* info))block;

//账单查询
-(void)searchBill:(int)page type:(int)type status:(int)status block:(void(^)(SResBase* info,NSArray *bill))block;
///服务范围
- (void)setArear:(void(^)(SResBase* info))block;


@end


@interface SOrderPack : SAutoEx


@property (nonatomic,assign)    int     mCount;//	int	订单总数
@property (nonatomic,assign)    float   mAmount;//	double	订单总金额
@property (nonatomic,assign)    int     mIngCount;//	int	进行中的订单数
@property (nonatomic,assign)    int     mFinishCount;//	int	已完成的订单数
@property (nonatomic,assign)    int     mCancelCount;//	int	已取消的订单数
@property (nonatomic,strong)    NSArray*mOrders;//==> SOrder	 订单列表


@end



//（服务、配送人员）
@interface SPeople : SAutoEx

@property (nonatomic,assign)    int         mId;
@property (nonatomic,strong)    NSString*   mMobile;
@property (nonatomic,strong)    NSString*   mName;
@property (nonatomic,strong)    NSString*   mAvatar;
@property (nonatomic,assign)    BOOL        mIsCheck;

//获取配送人员和服务人员 type ==>1:服务人员；2：配送人员    all=>>SPeople
+(void)getPeoples:(int)type block:(void(^)(SResBase* resb,NSArray*all))block;


@end

//分类
@interface SGoodsCate : SAutoEx

@property (nonatomic,assign)    int         mId;//	int	是			编号
@property (nonatomic,strong)    NSString*   mName;//	string	是			商品分类名称
@property (nonatomic,assign)    int         mGoodsNum;//	int	是			商品数量
@property (nonatomic,strong)    NSString*   mIcon;//	string	是			图标
@property (nonatomic,assign)    int         mTradeId;       //行业分类Id
@property (nonatomic,strong)    STrade*     mTrade;



//获取商品分类
+(void)getGoodCates:(int)type block:(void(^)(SResBase* resb,NSArray*all))block;


//更新排序 newsort新的顺序的ID数组,
+(void)updateSort:(NSArray*)newsort block:(void(^)(SResBase* resb))block;

//删除
-(void)delThis:(void(^)(SResBase* resb))block;

//修改名字
-(void)changeName:(NSString*)name tradeId:(int)tradeId type:(int)type block:(void(^)(SResBase* resb))block;

//添加一个分类
+(void)addOne:(NSString*)name tradeid:(int)tradeid type:(int)type block:(void(^)(SResBase* resb))block;


//获取这个分类的商品 status 1：上架；2：下架
-(void)getGoodsList:(int)status keywords:(NSString*)keywords page:(int)page block:(void(^)(SResBase* resb,NSArray* all))block;


@end











