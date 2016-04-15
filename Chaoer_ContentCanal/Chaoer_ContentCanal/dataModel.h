//
//  dataModel.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dataModel : NSObject <NSURLConnectionDataDelegate>
+(instancetype)shareInstance;

@end

@interface mBaseData : NSObject



@property (nonatomic,strong) NSString   *mTitle;

@property (nonatomic,assign) int        mState;

@property (nonatomic,assign) BOOL        mSucess;

@property (nonatomic,strong) id         mData;


@property (nonatomic,assign) int        mAlert;


@property (nonatomic,strong) NSString   *mMessage;


-(id)initWithObj:(NSDictionary*)obj;

-(void)fetchIt:(NSDictionary*)obj;

+(mBaseData *)infoWithError:(NSString*)error;

@end

@interface Ginfo : NSObject
/**
 *  app版本
 */
@property (nonatomic,strong) NSString   *mAppVersion;
/**
 *  设备型号
 */
@property (nonatomic,strong) NSString   *mDeviceModel;
/**
 *  设备版本
 */
@property (nonatomic,strong) NSString   *mDeviceVersion;
/**
 *  udid
 */
@property (nonatomic,strong) NSString   *mUDID;
/**
 *  系统
 */
@property (nonatomic,strong) NSString   *mSystem;

+ (void)getGinfo:(void(^)(mBaseData *resb))block;

@end

@class SVerifyMsg;
@class GFix;
@class SServicer;
@class GFixOrder;
@class GServiceList;
@class GCanal;
/**
 *  用户信息
 */
@interface mUserInfo : NSObject

/**
 *  登陆id
 */
@property (assign,nonatomic)int mLoginId;

/**
 *  验证码
 */
@property (nonatomic,strong) NSString   *mVerifyCode;


/**
 *  昵称
 */
@property (nonatomic,strong) NSString   *mNickName;
/**
 *  手机（登录名）
 */
@property (nonatomic,strong) NSString   *mPhone;

/**
 *  身份
 */
@property (nonatomic,strong) NSString        *mIdentity;
/**
 *  用户头像
 */
@property (nonatomic,strong) NSString   *mUserImgUrl;
/**
 *  用户积分
 */
@property (nonatomic,assign) int        mCredit;
/**
 *  用户登记
 */
@property (nonatomic,assign) int        mGrade;
/**
 *  用户余额
 */
@property (nonatomic,assign) CGFloat        mMoney;

/**
 *  用户ID
 */
@property (nonatomic,assign) int        mUserId;

/**
 *  个性签名
 */
@property (nonatomic,strong) NSString   *mSignature;
/**
 *  性别
 */
@property (nonatomic,strong) NSString   *mSex;

/**
 *  是否银行实名认证
 */
@property (nonatomic,assign) BOOL        mIsRegist;
/**
 *  是否绑定住户信息
 */
@property (nonatomic,assign) BOOL        mIsBundle;
/**
 *  密码
 */
@property (nonatomic,strong) NSString   *mPwd;

/**
 *  地址
 */
@property (nonatomic,strong) NSString   *mAddress;
/**
 *  国家
 */
@property (nonatomic,strong) NSString   *mCountry;
/**
 *  城市
 */
@property (nonatomic,strong) NSString   *mCity;
/**
 *  添加时间
 */
@property (nonatomic,strong) NSString   *mAddTime;
/**
 *  年龄
 */
@property (nonatomic,strong) NSString   *mAge;
/**
 *  教育
 */
@property (nonatomic,strong) NSString   *mEducation;
/**
 *  邮箱
 */
@property (nonatomic,strong) NSString   *mEmail;
/**
 *  肖像
 */
@property (nonatomic,strong) NSString   *mPortrait;
/**
 *  省份
 */
@property (nonatomic,strong) NSString   *mProvince;
/**
 *  qq
 */
@property (nonatomic,strong) NSString   *mQQ;
/**
 *  状态
 */
@property (nonatomic,strong) NSString   *mStatus;
/**
 *  
 */
@property (nonatomic,strong) SVerifyMsg *mVerifyMsg;

-(id)initWithObj:(NSDictionary*)obj;

-(void)fetchIt:(NSDictionary*)obj;

/**
 *  是否是一个合法的用户对象
 *
 *  @return
 */
-(BOOL)isVaildUser;

- (BOOL)isNeedLogin;

/**
 *  返回当前用户
 *
 *  @return
 */
+ (mUserInfo *)backNowUser;
/**
 *  是否需要登录
 *
 *  @return <#return value description#>
 */
+ (BOOL)isNeedLogin;
/**
 *  退出登录
 */
+ (void)logOut;


/**
 *  获取注册验证吗
 *
 *  @param mPhone 手机号
 *  @param block  返回值
 */
+ (void)getRegistVerifyCode:(NSString *)mPhone block:(void(^)(mBaseData *resb))block;
/**
 *  注册
 *
 *  @param mPhoneNum 手机号码
 *  @param mCode     验证码
 *  @param mPwd      密码
 *  @param mId       ？
 *  @param block     返回值
 */
+ (void)mUserRegist:(NSString *)mPhoneNum andCode:(NSString *)mCode andPwd:(NSString *)mPwd andIdentity:(NSString *)mId block:(void(^)(mBaseData *resb))block;
/**
 *  登录
 *
 *  @param mLoginName 用户名
 *  @param mPwd       密码
 *  @param block      返回值
 */
+ (void)mUserLogin:(NSString *)mLoginName andPassword:(NSString *)mPwd block:(void (^)(mBaseData *resb, mUserInfo *mUser))block;

/**
 *  忘记密码
 *
 *  @param mLoginName 用户名
 *  @param mPwd       设置新密码
 */
+ (void)mForgetPwd:(NSString *)mLoginName andNewPwd:(NSString *)mPwd block:(void(^)(mBaseData *resb))block;

/**
 *  修改个人信息
 *
 *  @param mUserid    用户id
 *  @param mLoginName 登录名称
 *  @param nickName   昵称
 *  @param mSex       性别
 *  @param mSignate   个性签名
 *  @param block      返回值
 */
+ (void)editUserMsg:(int)mUserid andLoginName:(NSString *)mLoginName andNickName:(NSString *)nickName andSex:(NSString *)mSex andSignate:(NSString *)mSignate block:(void(^)(mBaseData *resb,mUserInfo *mUser))block;

/**
 *  修改头像
 *
 *  @param mUserId 用户id
 *  @param mImg    图片
 *  @param block   返回值
 */
+ (void)modifyUserImg:(int)mUserId andImage:(NSData *)mImg andPath:(NSString *)mPath block:(void(^)(mBaseData *resb))block;
/**
 *  获取红包信息
 *
 *  @param mUserId 用户id
 *  @param mType   类型（s为收到的红包，f为发出的红包）
 *  @param block   返回值
 */
+ (void)getRedBag:(int)mUserId andType:(NSString *)mType block:(void(^)(mBaseData *resb,NSArray *marray))block;
/**
 *  验证手机能否充值
 *
 *  @param mPhone 手机号
 *  @param mMoney 充值金额
 *  @param block  返回值
 */
+ (void)verifyUserPhone:(NSString *)mPhone andNum:(float)mMoney block:(void(^)(mBaseData *resb))block;

/**
 *  手机充值
 *
 *  @param mPhone  手机号
 *  @param mMoney  金额
 *  @param mUserId 用户id
 *  @param block   返回值
 */
+ (void)topUpPhone:(NSString *)mPhone andNum:(float)mMoney andUserId:(int)mUserId block:(void(^)(mBaseData *resb))block;


/**
 *  获取易宝验证吗
 *
 *  @param mSellerName 商户名称：默认超尔物管通
 *  @param mLoginName  登录名
 *  @param mMoney      支付金额
 *  @param mPayName    付款人
 *  @param mIdentify   身份证
 *  @param mPhone      电话
 *  @param mBalance    余额
 *  @param mBankCard   银行卡
 *  @param mTime       有效期
 *  @param mCVV        cvv码
 *  @param block       返回值
 */
+ (void)getBalanceVerifyCode:(NSString *)mSellerName andLoginName:(NSString *)mLoginName andPayMoney:(int)mMoney andPayName:(NSString *)mPayName andIdentify:(NSString *)mIdentify andPhone:(NSString *)mPhone andBalance:(int)mBalance andBankCard:(NSString *)mBankCard andBankTime:(NSString *)mTime andCVV:(NSString *)mCVV block:(void(^)(mBaseData *resb))block;


/**
 *  核实验证码并首款
 *
 *  @param mOrderCode   本地订单号
 *  @param mYBOrderCode 易宝订单号
 *  @param mCode        手机验证码
 *  @param block        返回值
 */
+ (void)getCodeAndPay:(NSString *)mOrderCode andYBOrderCode:(NSString *)mYBOrderCode andPhoneCode:(NSString *)mCode block:(void(^)(mBaseData *resb))block;
#pragma mark----实名认证
/**
 * 实名认证 获取城市id
 *
 *  @param mCityId 城市id默认是0
 *  @param block   返回值
 */
+ (void)getCityId:(int)mCityId block:(void(^)(mBaseData *resb,NSArray *mArr))block;
/**
 *  获得对应管理用户
 *
 *  @param mCityId   城市id
 *  @param mProvince 区县
 *  @param block     返回值
 */
+ (void)getArearId:(int)mCityId andProvince:(int)mProvince block:(void(^)(mBaseData *resb,NSArray *mArr))block;

/**
 *  获取管理用户的楼盘信息
 *
 *  @param mCId  管理用户id
 *  @param block 返回值
 */
+ (void)getBuildId:(int)mCId block:(void(^)(mBaseData *resb))block;

/**
 *  获取对应楼栋
 *
 *  @param mName 所选择的楼盘名
 *  @param block 返回值
 */
+ (void)getBuilNum:(int)mId block:(void(^)(mBaseData *resb,NSArray *mArr))block;
/**
 *  获取对应住房号
 *
 *  @param mName      楼盘名
 *  @param mBuildName 楼栋号
 *  @param block      返回值
 */
+ (void)getDoorNum:(int )mName andBuildName:(int)mBuildName block:(void(^)(mBaseData *resb,NSArray *mArr))block;

/**
 *  获取绑定住户的信息
 *
 *  @param mUserId 用户id
 *  @param block   返回值
 */
+ (void)getBundleMsg:(int)mUserId block:(void(^)(mBaseData *resb,SVerifyMsg *info))block;


/**
 *  实名认证
 *
 *  @param mUserid      用户id
 *  @param mCommunityId 社区id
 *  @param mBannum      楼栋号
 *  @param mUnitNum     单元号
 *  @param mFloor       楼层号
 *  @param mDoorNum     门牌号
 *  @param block        返回值
 */
+ (void)realCode:(NSString *)mName andUserId:(int)mUserid andCommunityId:(int)mCommunityId andBannum:(int)mBannum andUnnitnum:(int)mUnitNum andFloor:(int)mFloor andDoornum:(int)mDoorNum block:(void(^)(mBaseData *resb))block;

/**
 *  获取银行列表
 *
 *  @param block 返回值
 */
+ (void)getbank:(void(^)(mBaseData *resb,NSArray *marr))block;

/**
 *  获取银行卡城市
 *
 *  @param mCity 城市
 *  @param block 返回值
 */
+ (void)getBankOfCity:(NSString *)mCity andProvince:(NSString *)mProvince andBankName:(NSString *)mName andType:(int)mType block:(void(^)(mBaseData *resb,NSArray *marr))block;



/**
 *  银行卡认证
 *
 *  @param mName     姓名
 *  @param mIdentify 身份证
 *  @param mBankName 开户行
 *  @param mProvince 省份
 *  @param mCity     城市
 *  @param mPoint    网点
 *  @param mCard     银行卡
 *  @param block     返回值
 */
+ (void)geBankCode:(NSString *)mName andUserId:(int)mUserId andIdentify:(NSString *)mIdentify andBankName:(NSString *)mBankName andProvince:(NSString *)mProvince andCity:(NSString *)mCity andPoint:(NSString *)mPoint andBankCard:(NSString *)mCard andBankCode:(NSString *)mBankCode block:(void(^)(mBaseData *resb))block;


/**
 *  获取baner横幅
 *
 *  @param block 返回值
 */
+ (void)getBaner:(void(^)(mBaseData *resb,NSArray *mBaner))block;


/**
 *  对公司的建议
 *
 *  @param mContent 内容
 *  @param block    返回值
 */
+ (void)feedCompany:(int)mUserId andContent:(NSString *)mContent block:(void(^)(mBaseData *resb))block;

/**
 *  投诉居民
 *
 *  @param mUserId      用户id
 *  @param mVillageName 小区名
 *  @param mBuildName   楼栋名
 *  @param mDoorNum     门牌号
 *  @param mReason      原因
 *  @param blovk        返回值
 */
+ (void)feedPerson:(NSString *)mValligeId andBuilId:(NSString *)mBuildId andUnit:(NSString *)mUnitId andFloor:(NSString *)mFloor andDoornum:(NSString *)mdoornum andReason:(NSString *)mReason block:(void(^)(mBaseData *resb))blovk;

/**
 *  投诉物管
 *
 *  @param mUserId 用户id
 *  @param mName   投诉姓名
 *  @param mReason 原因
 *  @param block   返回值
 */
+ (void)feedCanal:(int)mArearId andName:(NSString *)mName andReason:(NSString *)mReason block:(void(^)(mBaseData *resb))block;

#pragma mark----管费回显信息
/**
 *  获取物管回显信息
 */
- (void)getCanalMsg:(void(^)(mBaseData *resb,NSArray *mArr))block;

#pragma mark----交物管费
/**
 *  交物管费
 *
 *  @param mPayMoney 缴费金额
 *  @param mPayCount 缴费账户
 *  @param mPayID    缴费ID
 */
- (void)payCanal:(NSMutableDictionary *)mPara block:(void(^)(mBaseData *resb))block;


#pragma mark----聚合数据：公共事业省份查询
/**
 *  公共事业省份查询
 *
 *  @param block
 */
- (void)FindPublickProvince:(void(^)(mBaseData *resb,NSArray *mArr))block;


/**
 *  提现
 *
 *  @param mUid           用户id
 *  @param mMoney         提现金额
 *  @param mPresentManner 是否是及时(1:为及时即T+0;为空或者为0：T+1)
 *  @param block          返回值
 */
+(void)getCash:(int)mUid andMoney:(float)mMoney andPresentManner:(int)mPresentManner block:(void(^)(mBaseData *resb))block;

/**
 *  获取二级分类
 *
 *  @param mType  类型;1:管道维修；2：清洗服务；3：家电维修
 *  @param block  返回值
 */
+ (void)getClass:(int)mType block:(void(^)(mBaseData *resb,NSArray *array))block;

/**
 *  获取报修用户回显信息返回值
 *
 *  @param block 返回值
 */
+ (void)getFixDetail:(NSString *)mSuperiorId andLevel:(NSString *)mLevel block:(void(^)(mBaseData *resb,NSArray *marr))block;

/**
 *  提交保修
 *
 *  @param mUid            用户id
 *  @param mLevel          1级分类
 *  @param mClassification 2级分类
 *  @param mRemark         备注
 *  @param mTime           时间
 *  @param mPhone          电话
 *  @param mAddress        地址
 *  @param mImg            图片
 *  @param blck            返回值
 */
+ (void)commiteFixOrder:(NSString *)mUid andOneLevel:(NSString *)mLevel andClassification:(NSString *)mClassification andRemark:(NSString *)mRemark andtime:(NSString *)mTime andPhone:(NSString *)mPhone andAddress:(NSString *)mAddress andImg:(NSData *)mImgData block:(void(^)(mBaseData *resb))blck;

/**
 *  获取服务人员列表
 *
 *  @param mAddress 地址
 *  @param mLng     经度
 *  @param mLat     纬度
 *  @param mOne     一级分类
 *  @param mTwo     二级分类
 *  @param block    返回值
 */
+ (void)getServiceName:(NSString *)mAddress andLng:(NSString *)mLng andLat:(NSString *)mLat andOneLevel:(NSString *)mOne andTwoLevel:(NSString *)mTwo andPage:(int)mStart andEnd:(int)mEnd block:(void(^)(mBaseData *resb,GServiceList *mList))block;


/**
 *  获取维修订单页面数据
 *
 *  @param mOrderId 订单id
 *  @param mId      商户id
 *  @param block    返回值
 */
+ (void)getFixOrderComfirm:(int)mOrderId andmId:(int)mId block:(void(^)(mBaseData *resb,GFixOrder *mOrder))block;

/**
 *  获取订单付款成功
 *
 *  @param mUserId  用户id
 *  @param mOrderId 订单id
 *  @param block    返回值
 */
+ (void)getOrderPaySuccess:(int)mUserId andOrderId:(int)mOrderId block:(void(^)(mBaseData *resb))block;
/**
 *  设置订单状态
 *
 *  @param mUserId  用户id
 *  @param mOrderId 订单id
 *  @param block    返回值
 */
+ (void)upDateOrderStatus:(int)mUserId andOrderId:(int)mOrderId block:(void(^)(mBaseData *resb,NSArray *array))block;
/**
 *  用户预约商户
 *
 *  @param mOrderid  订单id
 *  @param mSellerId 商户id
 *  @param block     返回值
 */
- (void)getUserAppointment:(int)mOrderid andSellerId:(int)mSellerId block:(void(^)(mBaseData *resb))block;
/**
 *  获取商户信息
 *
 *  @param mOid  订单id
 *  @param mId   商户id
 *  @param block 返回值
 */
- (void)getSellerMsg:(int)mOid andmId:(int)mId block:(void(^)(mBaseData *resb))block;


/**
 *  获取小区信息
 *
 *  @param mUserId 用户id
 *  @param block   返回值
 */
- (void)getArear:(void(^)(mBaseData *resb,NSArray *mArr))block;


/**
 *  获取钱包
 *
 *  @param mUserID 用户id
 *  @param block   返回值
 */
- (void)getWallete:(int)mUserID block:(void(^)(mBaseData *resb))block;

/**
 *  打开推送
 */
+ (void)openPush;
/**
 *  清除推送
 */
+ (void)closePush;

@end

@interface SMessage : NSObject
-(id)initWithAPN:(NSDictionary*)objapn;
/**
 *  <#Description#>
 */
@property (nonatomic,assign)    int       mId;//int 编号
/**
 *  <#Description#>
 */
@property (nonatomic,assign)    int       mUserId;//int 编号
/**
 *  <#Description#>
 */
@property (nonatomic,strong)    NSString *mContent;// string  内容
/**
 *  <#Description#>
 */
@property (nonatomic,strong)    NSString *mTitle;// string  标题
/**
 *  <#Description#>
 */
@property (nonatomic,strong)    NSString *mCreateTime;//  string  "创建时间2015-08-09"
/**
 *  <#Description#>
 */
@property (nonatomic,assign)    int      mStatus;//  int "是否已读1：已读 0：未读"
/**
 *  <#Description#>
 */
@property (nonatomic,assign)    int      mType;//  int "消息类型1：普通消息2：html页面，args为url3：订单消息，args为订单id"
/**
 *  <#Description#>
 */
@property (nonatomic,strong)    NSString *mArgs;//    参数
/**
 *  <#Description#>
 */
@property (nonatomic,assign) BOOL       mIsLook;


+ (void)getMsgNum:(int)mUserId andIsLook:(int)mIsLook andType:(NSString *)mType block:(void(^)(mBaseData *resb))block;

@end
/**
 *  红包对象
 */
@interface SRedBag : NSObject
/**
 *  消息id
 */
@property (nonatomic,assign)    int       mId;
/**
 *  用户id
 */
@property (nonatomic,assign)    int       mUserId;
/**
 *  消息类型
 */
@property (nonatomic,strong)    NSString       *mType;
/**
 *  金额
 */
@property (nonatomic,assign)    float       mMoney;
/**
 *    string  "创建时间2015-08-09"
 */
@property (nonatomic,strong)    NSString *mCreateTime;
/**
 *  名称
 */
@property (nonatomic,strong)    NSString *mName;

-(id)initWithObj:(NSDictionary*)obj;

@end
/**
 *  认证回显信息
 */
@interface SVerifyMsg : NSObject

-(id)initWithObj:(NSDictionary*)obj;
/**
 *  物管公司
 */
@property (nonatomic,strong)    NSString       *mCompanyName;
/**
 *  楼盘名
 */
@property (nonatomic,strong)    NSString       *mVillageName;
/**
 *  楼栋名
 */
@property (nonatomic,strong)    NSString       *mBuildName;
/**
 *  门牌号
 */
@property (nonatomic,strong)    NSString       *mDoorNumber;
/**
 *  省份
 */
@property (nonatomic,strong)    NSString       *mProvince;
/**
 *  城市
 */
@property (nonatomic,strong)    NSString       *mCity;
/**
 *  cid
 */
@property (nonatomic,assign)    int     cId;

@property (nonatomic,strong)    NSString       *mBankCard;
@property (nonatomic,strong)    NSString       *mBankCity;

@property (nonatomic,strong)    NSString       *mBankName;

@property (nonatomic,strong)    NSString       *mBankProvince;
@property (nonatomic,strong)    NSString       *mCard;
@property (nonatomic,strong)    NSString       *mWebsite;
@property (nonatomic,strong)    NSString       *mReal_name;


@end

#pragma mark----商户列表
@interface SSellerList : NSObject
/**
 *  商户id
 */
@property (nonatomic,assign)    int       mId;
/**
 *  商户名
 */
@property (nonatomic,strong)    NSString       *mSellerName;
/**
 *  商户电话
 */
@property (nonatomic,strong)    NSString       *mSellerPhone;
/**
 *  商户图片
 */
@property (nonatomic,strong)    NSString       *mSellerImg;
/**
 *  好评
 */
@property (nonatomic,assign)    float       mEvolution;
/**
 *  距离
 */
@property (nonatomic,assign)    float       mDistance;

-(id)initWithObj:(NSDictionary*)obj;
@end

@interface MBaner : NSObject
/**
 *  图片地址
 */
@property (nonatomic,strong)    NSString       *mImgUrl;
/**
 *  内容
 */
@property (nonatomic,strong)    NSString       *mContentUrl;
/**
 *  title名称
 */
@property (nonatomic,strong)    NSString       *mName;
/**
 *  排序
 */
@property (assign,nonatomic) int    mB_index;


-(id)initWithObj:(NSDictionary*)obj;

@end
/**
 *  保修类
 */
@interface GFix : NSObject
/**
 *  分类名称
 */
@property (nonatomic,strong)    NSString       *mClassName;
/**
 *  分类id
 */
@property (assign,nonatomic) int    mId;
/**
 *  级别
 */
@property (assign,nonatomic) int    mLevel;
/**
 *  父类id
 */
@property (assign,nonatomic) int    mSuperID;
/**
 *  类型
 */
@property (assign,nonatomic) int    mType;


-(id)initWithObj:(NSDictionary*)obj;


@end
/**
 *  服务人员对象
 */
@interface SServicer : NSObject

/**
 *   地址
 */
@property (nonatomic,strong)    NSString       *mAddress;
/**
 *  距离
 */
@property (nonatomic,strong)    NSString       *mDistance;
/**
 *  头像
 */
@property (nonatomic,strong)    NSString       *mMerchantImage;
/**
 *  姓名
 */
@property (nonatomic,strong)    NSString       *mMerchantName;
/**
 *  电话
 */
@property (nonatomic,strong)    NSString       *mMerchantPhone;
/**
 *  id
 */
@property (assign,nonatomic) int    mId;
/**
 *  评价
 */
@property (assign,nonatomic) int    mPraiseRate;

-(id)initWithObj:(NSDictionary*)obj;



@end

@interface GFixOrder : NSObject

-(id)initWithObj:(NSDictionary*)obj;

/**
 *  订单创建时间
 */
@property (nonatomic,strong)    NSString       *mAppointmentTime;
/**
 *  地址
 */
@property (nonatomic,strong)    NSString       *mBuyerAddress;
/**
 *  分类
 */
@property (nonatomic,strong)    NSString       *mClassificationName;
/**
 *  姓名
 */
@property (nonatomic,strong)    NSString       *mMerchantName;
/**
 *  备注
 */
@property (nonatomic,strong)    NSString       *mNote;
/**
 *  电话
 */
@property (nonatomic,strong)    NSString       *mPhone;
/**
 *  订单编号
 */
@property (nonatomic,strong)    NSString       *mOrderCode;
/**
 *  订单状态
 */
@property (assign,nonatomic) int    mStatus;
/**
 *  订单id
 */
@property (assign,nonatomic) int    mOrderId;


@end


@interface GArear : NSObject

-(id)initWithObj:(NSDictionary*)obj;
/**
 *  小区名称
 */
@property (nonatomic,strong)    NSString       *mAddress;
/**
 *  小区id
 */
@property (assign,nonatomic) int    mId;

@end


@interface GCity : NSObject

-(id)initWithObj:(NSDictionary*)obj;
/**
 *  城市,区县名称
 */
@property (nonatomic,strong)    NSString       *mAreaName;
/**
 *  城市id
 */
@property (assign,nonatomic) NSString    *mAreaId;
/**
 *  城市，区县父级ID(查询用得到)
 */
@property (assign,nonatomic) NSString    *mParentId;


@end



@interface GCommunity : NSObject

-(id)initWithObj:(NSDictionary*)obj;
/**
 *  社区名称
 */
@property (nonatomic,strong)    NSString       *mCommunityName;
/**
 *  社区id
 */
@property (assign,nonatomic) int    mPropertyId;

@property (strong,nonatomic) NSString    *mAreaName;

@end

@interface GdoorNum : NSObject

-(id)initWithObj:(NSDictionary*)obj;
/**
 *  楼层
 */
@property (assign,nonatomic) int    mFloor;
/**
 *  门牌号
 */
@property (assign,nonatomic) int    mRoomNumber;
/**
 *  单元
 */
@property (assign,nonatomic) int    mUnit;

@end


@interface GServiceList : NSObject

-(id)initWithObj:(NSDictionary*)obj;
/**
 *  分页
 */
@property (assign,nonatomic) int    pageNumber;
/**
 *  结束页
 */
@property (assign,nonatomic) int    pageSize;
/**
 *  数据
 */
@property (strong,nonatomic) NSArray    *mArray;

@end



@interface GCanal : NSObject

-(id)initWithObj:(NSDictionary*)obj;

/**
 *  已交费用
 */
@property (assign,nonatomic) float    mActualPayment;
/**
 *  余额
 */
@property (assign,nonatomic) float    mMoney;
/**
 *  缴费单位
 */
@property (strong,nonatomic) NSString    *mPaymentUnit;
/**
 *  社区ID
 */
@property (assign,nonatomic) int    mCommunityId;
/**
 *  最后期限
 */
@property (strong,nonatomic) NSString    *mDeadline;
/**
 *  用户名
 */
@property (strong,nonatomic) NSString    *mUserName;
/**
 *  应交的物管费
 */
@property (assign,nonatomic) float    mPayableMoney;
/**
 *  缴费账户
 */
@property (strong,nonatomic) NSString    *mPaymentAccount;
/**
 *  缴费状态
 */
@property (assign,nonatomic) int    mStatus;

@property (strong,nonatomic) NSString    *mStatustr;

@end

#pragma mark----聚合数据->省份对象
@interface JHProvince : NSObject

-(id)initWithObj:(NSDictionary*)obj;
/**
 *  省份ID
 */
@property (strong,nonatomic) NSString    *mProvinceId;
/**
 *  省份名称
 */
@property (strong,nonatomic) NSString    *mProvinceName;


@end


