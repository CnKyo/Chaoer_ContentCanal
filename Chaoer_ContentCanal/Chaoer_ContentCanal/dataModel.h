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

#pragma mark----聚合基本数据结构
@interface mJHBaseData : NSObject




@property (nonatomic,assign) int        mState;

@property (nonatomic,assign) BOOL        mSucess;

@property (nonatomic,strong) id         mData;


@property (nonatomic,strong) NSString   *mMessage;


-(id)initWithObj:(NSDictionary*)obj;

-(void)fetchIt:(NSDictionary*)obj;

+(mJHBaseData *)infoWithError:(NSString*)error;

@end
#pragma mark----聚合基本数据结构
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
@class JHCity;
@class JHProvince;
@class GCanal;
@class GCanalList;
@class GPPTOrder;

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
 *  身份
 */
@property (nonatomic,assign) int        mId;


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
 *  是否实名认证
 */
@property (nonatomic,assign) BOOL        mIsRegist;
/**
 *  是否绑定住户信息
 */
@property (nonatomic,assign) BOOL        mIsBundle;
/**
 *  是否房屋认证:0:未认证；1：认证
 */
@property (nonatomic,assign) BOOL mIsHousingAuthentication;
/**
 *  密码
 */
@property (nonatomic,strong) NSString   *mPwd;

@property (nonatomic,strong) NSString   *muuid;

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
/**
 *  登录类型1是微信登录 0是手机登录 其它
 */
@property (nonatomic,assign) int mLoginType;
/**
 *  微信openid
 */
@property (nonatomic,strong) NSString   *mOpenId;
/**
 *  社区id
 */
@property (nonatomic,assign) int mCommunityId;



#pragma mark----用户跑跑腿状态
/**
 *  0（未提交资料，需提交资料审核资质），1（押金未支付，请支付），2（审核中，请耐心等待！），3（已被系统禁用），4（您已注销），5（是跑腿者）
 */
@property (nonatomic,assign) int mIs_leg;

/**
 *  跑跑腿id
 */
@property (nonatomic,assign) int mLegworkUserId;

-(id)initWithObj:(NSDictionary*)obj;

-(void)fetchIt:(NSDictionary*)obj;


/**
 *  支付需要跳出到APP,这里记录回调
 */
@property (nonatomic,strong)    void(^mPayBlock)(mBaseData* resb);


/**
 *  是否是一个合法的用户对象
 *
 *  @return
 */
-(BOOL)isVaildUser;

- (BOOL)isNeedLogin;
/**
 *  临时身份
 *
 *  @return <#return value description#>
 */
- (BOOL)mTemporary;

/**
 *  返回当前用户
 *
 *  @return
 */
+ (mUserInfo *)backNowUser;

+ (mUserInfo *)backRCCInfo;

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
#pragma mark----获取rsa加密公钥
/**
 *  获取rsa加密公钥
 *
 *  @param block
 */
+ (void)getRSAKey:(void(^)(mBaseData *resb))block;
#pragma mark----关联融云
/**
 *  关联融云
 */
+ (void)OpenRCConnect;
/**
 *  融云更新定位信息
 *
 *  @param mRCCUserId 融云userid
 *  @param mLat       纬度
 *  @param mLong      经度
 *  @param block      返回值
 */
+ (void)reRCClocation:(NSString *)mRCCUserId andLat:(NSString *)mLat andLong:(NSString *)mLong block:(void(^)(mBaseData *resb))block;

/**
 *  获取当前用户信息
 *
 *  @param block 返回值
 */
- (void)getNowUserInfo:(void(^)(mBaseData *resb,mUserInfo *user))block;

+(void)dealUserSession:(mBaseData*)info andPhone:(NSString *)mPara andOpenId:(NSString *)mOpenid block:(void(^)(mBaseData* resb, mUserInfo*user))block;

+(void)saveUserInfo:(NSDictionary *)dccat;
#pragma mark----更新app
/**
 *  更新app
 *
 *  @param block 返回值
 */
- (void)getUpdateApp:(void(^)(mBaseData *resb))block;

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
 *  微信注册
 *
 *  @param mPara 参数
 *  @param block 返回值
 */
+ (void)mWechatRegist:(NSDictionary *)mPara block:(void(^)(mBaseData *resb))block;
#pragma mark----支付方式（微信，支付宝）
/**
 *  支付
 *
 *  @param paytype 支付方式
 *  @param block   返回值
 */
-(void)payIt:(NSString*)paytype andPrice:(int)mPrice block:(void(^)(mBaseData* resb))block;

/**
 *  报修支付
 *
 *  @param mPayType 支付类型
 *  @param mPrice   价格
 *  @param mCode    编号
 *  @param block    返回值
 */
- (void)payType:(int)mPayType andPrice:(float)mPrice andCode:(NSString *)mCode block:(void(^)(mBaseData* resb))block;

/**
 *  登录
 *
 *  @param mLoginName 用户名
 *  @param mPwd       密码
 *  @param block      返回值
 */
+ (void)mUserLogin:(NSString *)mLoginName andPassword:(NSString *)mPwd block:(void (^)(mBaseData *resb, mUserInfo *mUser))block;

/**
 *  验证是否有微信账号
 *
 *  @param mOpenId openid
 *  @param block   返回值
 */
+ (void)mVerifyOpenId:(NSDictionary *)mOpenId block:(void (^)(mBaseData *resb, mUserInfo *mUser))block;
/**
 *  微信登录
 *
 *  @param mLoginName 用户名
 *  @param mPwd       密码
 *  @param mOpenId    openid
 *  @param block      返回值
 */
+ (void)mLoginWithWechat:(NSString *)mLoginName andPassword:(NSString *)mPwd andOpenId:(NSString *)mOpenId block:(void (^)(mBaseData *resb, mUserInfo *mUser))block;
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
+ (void)editUserMsg:(NSString *)mHeader andUserid:(int)mUserid andLoginName:(NSString *)mLoginName andNickName:(NSString *)nickName andSex:(NSString *)mSex andSignate:(NSString *)mSignate block:(void(^)(mBaseData *resb,mUserInfo *mUser))block;

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

#pragma mark----实名认证（获取省市区）
/**
 *  实名认证（获取省市区）
 *
 *  @param block 返回值
 */
- (void)getCodeAddress:(void(^)(mBaseData *resb,NSArray *mArr))block;

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
+ (void)getArearId:(NSString *)mProvince andArear:(NSString*)mArear andCity:(NSString *)mCity block:(void(^)(mBaseData *resb,NSArray *mArr))block;

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

#pragma mark----获取楼栋门牌号
/**
 *  获取楼栋门牌号
 *
 *  @param mCommunityId 小区id
 *  @param block        返回值
 */
- (void)getBanAndUnitAndFloors:(NSString *)mCommunityId block:(void(^)(mBaseData *resb,NSArray *mArr))block;

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
+ (void)realCode:(NSString *)mName andUserId:(int)mUserid andCommunityId:(int)mCommunityId andBannum:(NSString *)mBannum andUnnitnum:(NSString *)mUnitNum andFloor:(NSString *)mFloor andDoornum:(NSString *)mDoorNum andIdentity:(NSString *)mId block:(void(^)(mBaseData *resb))block;

#pragma mark----实名认证
- (void)realyCodeAndCommunityId:(int)mType andName:(NSString *)mName andCommunityId:(NSString *)mCommunityId andBanNum:(NSString *)mBanNum andUnitNum:(NSString *)mUnitNum andFloorNum:(NSString *)mFloor andRoomNum:(NSString *)mroomNum andIdentify:(NSString *)mIdentify andAddcommunity:(BOOL)mIsAddCommunity andcommunityName:(NSString *)mcommunityName andAddress:(NSString *)mAddress andProvinceID:(NSString *)mProvinceId andArearId:(NSString *)mArearId andCityId:(NSString *)mCityID andPhone:(NSString *)mPhone block:(void(^)(mBaseData *resb))block;

- (void)addHouse:(int)mCommunityId andBannum:(NSString *)mBannum andUnnitnum:(NSString *)mUnitNum andFloor:(NSString *)mFloor andDoornum:(NSString *)mDoorNum andIdentity:(NSString *)mId block:(void(^)(mBaseData *resb))block;


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

#pragma mark----获取baner横幅
/**
 *  获取baner横幅
 *
 *  @param block 返回值
 */
+ (void)getBaner:(void(^)(mBaseData *resb,NSArray *mBaner))block;

#pragma mark----获取跑跑腿baner横幅
/**
 *  获取baner横幅
 *
 *  @param block 返回值
 */
- (void)getPPTbaner:(void(^)(mBaseData *resb,NSArray *mBaner))block;


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
- (void)getCanalMsg:(void(^)(mBaseData *resb,GCanalList *mList))block;

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
- (void)FindPublickType:(int)mType andId:(NSString *)mId block:(void(^)(mJHBaseData *resb,NSArray *mArr))block;

- (void)FindPublic:(int )mType andPara:(NSDictionary *)mParas block:(void(^)(mJHBaseData *resb,NSArray *mArr))block;

/**
 *  账户欠费查询
 *
 *  @param mParas 参数
 *  @param block  返回值
 */
- (void)Inquire:(NSDictionary *)mParas block:(void(^)(mJHBaseData *resb))block;

/**
 *  缴费
 *
 *  @param mParas 参数
 *  @param block  返回值
 */
- (void)goPay:(NSDictionary *)mParas block:(void(^)(mJHBaseData *resb))block;

/**
 *  提现
 *
 *  @param mUid           用户id
 *  @param mMoney         提现金额
 *  @param mPresentManner 是否是及时(1:为及时即T+0;为空或者为0：T+1)
 *  @param block          返回值
 */
+(void)getCash:(int)mUid andMoney:(NSString *)mMoney andPresentManner:(NSString *)mPresentManner block:(void(^)(mBaseData *resb))block;

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

#pragma mark---提交保修订单
- (void)commitFixOrder:(NSString *)mSuperId andSubClass:(NSString *)mSubClass andNote:(NSString *)mNote andServiceTime:(NSString *)mServiceTime andAddress:(NSString *)mAddress andCommunityId:(NSString *)mCommunityId andServicerId:(int)mId andImgUrl:(NSString *)mImgUrl andVideoUrl:(NSString *)mVideoUrl block:(void(^)(mBaseData *resb))block;

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
 *  完成保修订单
 *
 *  @param mOrderId 订单id
 *  @param mPayType 支付方式
 *  @param mRate    评价
 *  @param block    返回值
 */
- (void)finishFixOrder:(NSString *)mOrderId andPayType:(NSString *)mPayType andRate:(NSString *)mRate block:(void(^)(mBaseData *resb))block;




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
#pragma mark----订单列表
/**
 *  获取订单列表
 *
 *  @param mType 订单类型
 *  @param block 返回值
 */
- (void)getOrderList:(int)mType block:(void(^)(mBaseData *resb,NSArray *mArr))block;
/**
 *  获取子订单列表
 *
 *  @param mType  订单类型
 *  @param mStart 起始分页
 *  @param mEnd   结束分页
 *  @param block  返回值
 */
- (void)getOrder:(NSString *)mType andStart:(int)mStart andEd:(int)mEnd block:(void(^)(mBaseData *resb,NSArray *mArr))block;

/**
 *  获取保修订单详情
 *
 *  @param mOrderID 订单id
 *  @param block    返回值
 */
- (void)getOrderDetail:(NSString *)mOrderID block:(void(^)(mBaseData *resb,GFixOrder *mFixOrder))block;


/**
 *  获取积分列表
 *
 *  @param mType 接口类型
 *  @param mPage 分页
 *  @param mNum  数量
 *  @param block 返回值
 */
- (void)getScoreList:(int)mType andPage:(int)mPage andNum:(int)mNum block:(void(^)(mBaseData *resb,NSArray *mArr))block;
#pragma mark---菜谱
/**
 *  阿凡达菜谱数据
 *
 *  @param mPage 分页
 *  @param block 返回值
 */
- (void)getCookList:(int)mPage block:(void(^)(mJHBaseData *resb,NSArray *mArr))block;

#pragma mark----获取保修用户信息
/**
 *  获取保修用户信息
 *
 *  @param block 返回值
 */
- (void)getAddress:(void(^)(mBaseData *resb,NSArray *mArr))block;
/**
 *  打开推送
 */
+ (void)openPush;
/**
 *  清除推送
 */
+ (void)closePush;

#pragma mark----社区动态
/**
 *  获取社区动态分类
 *
 *  @param block 返回值
 */
- (void)getCommunityClass:(void(^)(mBaseData *resb,NSArray *mArr))block;
/**
 *  获取社区动态
 *
 *  @param mCommunityId 社区id
 *  @param mPage        分页
 *  @param mType        类型
 *  @param block        返回值
 */
- (void)getCommunityStatus:(int)mCommunityId andPage:(int)mPage andType:(int)mType block:(void(^)(mBaseData *resb,NSArray *mArr))block;

/**
 *  获取新闻详情
 *
 *  @param mNewsId 新闻ID
 *  @param block   返回
 */
- (void)getCommunityDetail:(int)mNewsId block:(void(^)(mBaseData *resb))block;

#pragma mark----跑跑腿数据
/**
 *  查询常用地址
 *
 *  @param block 返回值
 */
- (void)getPPTaddressList:(void(^)(mBaseData *resb,NSArray *mArr))block;


#pragma mark----获取附近跑跑腿我想买订单
/**
 *  查询附近跑跑腿（我想买）订单
 *
 *  @param mType 类型
 *  @param mLat  纬度
 *  @param mLng  经度
 *  @param mPage 分页
 *  @param mNum  分页条数
 *  @param block 返回值
 */
- (void)getPPTNeaerbyOrder:(int)mType andMlat:(NSString *)mLat andLng:(NSString *)mLng andPage:(int)mPage andNum:(int)mNum block:(void(^)(mBaseData *resb,NSArray *mArr))block;
#pragma mark----获取买东西 标签
/**
 *  获取发布跑腿标签
 *
 *  @param mType 类型
 *  @param block 返回值
 */
- (void)getReleaseTags:(int)mType block:(void(^)(mBaseData *resb,NSArray *mArr))block;
#pragma mark----获取地址标签
/**
 *  获取添加地址标签
 *
 *  @param block 返回值
 */
- (void)getPPTaddressTag:(void(^)(mBaseData *resb,NSArray *mArr))block;
#pragma mark----添加地址
/**
 *  添加地址
 *
 *  @param mName          姓名
 *  @param mSex           性别
 *  @param mAddress       地址
 *  @param mPhone         电话
 *  @param mDetailAddress 详细地址
 *  @param mTag           标签
 *  @param block          返回值
 */
- (void)gPPtaddAddress:(NSString *)mName andSex:(NSString *)mSex andAddress:(NSString *)mAddress andPhone:(NSString *)mPhone andDetailAddress:(NSString *)mDetailAddress andTag:(NSString *)mTag block:(void(^)(mBaseData *resb))block;

#pragma mark----发布跑腿
/**
 *  发布订单
 *
 *  @param mLat     纬度
 *  @param mLng     经度
 *  @param mContent 内容
 *  @param mMoney   酬金
 *  @param mAddress 地址
 *  @param mPhone   电话
 *  @param mNote    备注
 *  @param block    返回值
 */
- (void)releasePPTorder:(int)mType andTagId:(NSString *)mTagId andMin:(NSString *)mMin andMAx:(NSString *)mMax andLat:(NSString *)mLat andLng:(NSString *)mLng andContent:(NSString *)mContent andMoney:(NSString *)mMoney andAddress:(NSString *)mAddress andPhone:(NSString *)mPhone andNote:(NSString *)mNote andArriveTime:(NSString *)mTime block:(void(^)(mBaseData *resb))block;

- (void)releasePPTSendorder:(int)mType andTagId:(NSString *)mTagId andMin:(NSString *)mMin andMAx:(NSString *)mMax andLat:(NSString *)mLat andLng:(NSString *)mLng andContent:(NSString *)mContent andMoney:(NSString *)mMoney andAddress:(NSString *)mAddress andPhone:(NSString *)mPhone andNote:(NSString *)mNote andArriveTime:(NSString *)mTime andGoodsName:(NSString *)mGoodsName andGoodsPrice:(NSString *)mGoodsPrice andSendAddress:(NSString *)mSendAddress andArriveAddress:(NSString *)mArriveAddress andTool:(NSString *)mTool block:(void(^)(mBaseData *resb))block;
#pragma mark----获取订单详情
/**
 *  获取订单详情
 *
 *  @param block 返回值
 */
- (void)getOrderDetail:(int)mType andMorderID:(NSString *)mOrderId andOrderCode:(NSString *)mOrderCode block:(void(^)(mBaseData *resb,GPPTOrder *mOrder))block;

#pragma mark----获取跑跑腿个人信息
- (void)getPPTPersonMsg:(void(^)(mBaseData *resb))block;
/**
 *  获取跑腿榜单
 *
 *  @param mPage 分页
 *  @param mNum  数量
 *  @param block 返回值
 */
- (void)getPPTRoll:(int)mPage andNum:(int)mNum block:(void(^)(mBaseData *resb,NSArray *mArr))block;

#pragma matk----获取交通工具
/**
 *  获取交通工具
 *
 *  @param block 返回值
 */
- (void)getTool:(void(^)(mBaseData *resb,NSArray *mArr))block;

#pragma matk----获取历史订单
/**
 *  获取历史订单
 *
 *  @param mLeft  订单状态
 *  @param mRight 订单类型
 *  @param mPage  分页
 *  @param mNum   数量
 *  @param block  返回值
 */
- (void)getPPTOrderHisTory:(int)mLeft andRight:(int)mRight and:(int)mPage andNum:(int)mNum block:(void(^)(mBaseData *resb,NSArray *mArr))block;


#pragma mark----申请跑跑腿
/**
 *  申请跑跑腿
 *
 *  @param mName       姓名
 *  @param mSex        性别
 *  @param mPhone      电话
 *  @param mIdentify   身份证
 *  @param mHandImg    手持照片
 *  @param mFrontImg   正面
 *  @param mForwordImg 反面
 *  @param block       返回值
 */
- (void)applePPT:(NSString *)mName andSex:(NSString *)mSex andPhone:(NSString *)mPhone andIdentify:(NSString *)mIdentify andHandImg:(NSString *)mHandImg andForntImg:(NSString *)mFrontImg andForwordImg:(NSString *)mForwordImg block:(void(^)(mBaseData *resb))block;
#pragma mark----扣除押金
- (void)payPPTAplly:(void(^)(mBaseData *resb))block;

#pragma mark----跑跑腿接单
/**
 *  接单
 *
 *  @param mLegUserId 跑跑腿id
 *  @param mOrderCode 订单编号
 *  @param mOrderType 订单类型
 *  @param mLat       纬度
 *  @param mLng       经度
 *  @param block      返回值
 */
- (void)getPPTOrder:(int)mLegUserId andOrderCode:(NSString *)mOrderCode andOrderType:(NSString *)mOrderType andLat:(NSString *)mLat andLng:(NSString *)mLng block:(void(^)(mBaseData *resb))block;
#pragma mark----用户取消订单操作
/**
 *  用户取消订单
 *
 *  @param mUserId    用户id
 *  @param mOrderCode 订单编号
 *  @param mOrderType 订单类型
 *  @param mLat       纬度
 *  @param mLng       经度
 *  @param block      返回值
 */
- (void)cancelOrder:(int)mUserId andOrderCode:(NSString *)mOrderCode andOrderType:(int)mOrderType andLat:(NSString *)mLat andLng:(NSString *)mLng block:(void(^)(mBaseData *resb))block;
#pragma mark----获取系统标签
/**
 *  获取系统标签
 *
 *  @param block 返回值
 */
- (void)getSystemTags:(void(^)(mBaseData *resb,NSArray *mArr))block;

#pragma mark----评价订单
/**
 *  评价订单
 *
 *  @param mUserId    平台用户id
 *  @param mLegId     跑腿用户id
 *  @param mLat       纬度
 *  @param mLng       经度
 *  @param mOrdeCode  订单编号
 *  @param mOrderType 订单类型
 *  @param block      返回值
 */
- (void)rateOrder:(int)mUserId andLegUserId:(int)mLegId andSpeed:(int)mSpeed andMass:(int)mMass andOrderCode:(NSString *)mOrdeCode andOrderType:(int)mOrderType andContent:(NSString *)mContent andTags:(NSString *)mTags block:(void(^)(mBaseData *resb))block;

#pragma mark----获取投诉标签
/**
 *  获取投诉标签
 *
 *  @param block 返回值
 */
- (void)getFeedBackTags:(void(^)(mBaseData *resb,NSArray *mArr))block;

#pragma mark----订单投诉
/**
 *  订单投诉
 *
 *  @param mUserId    平台用户id
 *  @param mLegId     跑腿用户id
 *  @param mContent   投诉内容
 *  @param mTagId     理由id
 *  @param mOrderType 订单类型
 *  @param mOrderCode 订单编号
 *  @param mImages    图片组
 *  @param block      返回值
 */
- (void)feedBackOrder:(int)mUserId andLegUserId:(int)mLegId andContent:(NSString *)mContent andFeedTagId:(int)mTagId andOrderType:(int)mOrderType andOrderCode:(NSString *)mOrderCode andImags:(NSString *)mImages block:(void(^)(mBaseData *resb))block;


#pragma mark----实名认证 获取小区
/**
 *  实名认证 获取小区
 *
 *  @param block 返回值
 */
- (void)getCodeArear:(NSString *)mProvinceId andArearId:(NSString *)mArearId andCityId:(NSString *)mCityId andName:(NSString *)mName andLat:(NSString *)mLat andLng:(NSString *)mLng block:(void(^)(mBaseData *resb,NSArray *mArr))block;




#pragma mark----更新跑跑腿用户状态接口
/**
 *  更新跑跑腿用户状态接口
 *
 *  @param mLat  纬度
 *  @param mLng  经度
 *  @param block 返回值
 */
- (void)ipDataPPTUserStatus:(NSString *)mLat andLng:(NSString *)mLng block:(void(^)(mBaseData *resb))block;


#pragma mark----获取物管费历史纪录
/**
 *  获取物管费历史纪录
 *
 *  @param block 返回值
 */
- (void)getCanelHistory:(int)mPage block:(void(^)(mBaseData *resb,NSArray *mArr))block;



#pragma mark----获取消息列表
/**
 *  获取消息列表
 *
 *  @param mPage 分页
 *  @param block 返回值
 */
- (void)getMsgList:(int)mPage block:(void(^)(mBaseData *resb,NSArray *mArr))block;


#pragma mark----读消息
/**
 *  读消息
 *
 *  @param mId   消息id
 *  @param block 返回值
 */
- (void)readMsg:(int)mId block:(void(^)(mBaseData *resb))block;

#pragma mark----删除消息
/**
 *  删除消息
 *
 *  @param mId   消息id
 *  @param block 返回值
 */
- (void)deleteMsg:(int)mId block:(void(^)(mBaseData *resb))block;

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

@property (nonatomic,strong)    NSString       *mCommunityName;
@property (nonatomic,strong)    NSString       *mAddr;

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

@interface GPPTBaner : NSObject
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

@property (assign,nonatomic) int    mId;

@property (assign,nonatomic) int    mVisite;

@property (assign,nonatomic) int    mStatus;

@property (nonatomic,strong)    NSString       *mUUID;


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

@property (nonatomic,strong)    NSString       *mDescribe;

@property (nonatomic,strong)    NSString       *mEstimatedPrice;
@property (nonatomic,strong)    NSString       *mSmallImage;
@property (nonatomic,strong)    NSString       *mBigImage;
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
/**
 *  订单图片
 */
@property (nonatomic,strong)    NSString       *mOrderImage;
/**
 *  订单状态
 */
@property (nonatomic,strong)    NSString       *mOrderStatus;
/**
 *  服务时间
 */
@property (nonatomic,strong)    NSString       *mOrderServiceTime;
/**
 *  id？
 */
@property (nonatomic,strong)    NSString       *mOrderMerchanid;
/**
 *  订单价格
 */
@property (nonatomic,assign)    CGFloat       mOrderPrice;
/**
 *  社区id
 */
@property (nonatomic,strong)    NSString       *mCommunityId;
/**
 *  地址
 */
@property (nonatomic,strong)    NSString       *mAddress;
/**
 *  二级分累
 */
@property (nonatomic,strong)    NSString       *mClassificationName2;
/**
 *  订单id
 */
@property (nonatomic,strong)    NSString       *mOrderID;
/**
 *  添加时间
 */
@property (nonatomic,strong)    NSString       *addTime;
/**
 *  说明？
 */
@property (nonatomic,strong)    NSString       *mDescription;
/**
 *  服务时间
 */
@property (nonatomic,strong)    NSString       *serviceTime;
/**
 *  电话
 */
@property (nonatomic,strong)    NSString       *tel;


#pragma mark----手机充值对象
@property (nonatomic,strong)    NSString       *mSerialNumber;

@property (nonatomic,strong)    NSString       *mIntegral;

@property (nonatomic,strong)    NSString       *mRechargeTime;

@property (nonatomic,strong)    NSString       *mPaymentMethod;



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
@property (strong,nonatomic) NSString    *mFloor;
/**
 *  门牌号
 */
@property (strong,nonatomic) NSString    *mRoomNumber;
/**
 *  单元
 */
@property (strong,nonatomic) NSString    *mUnit;

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


/**
 物管列表对象
 
 - returns: 返回你
 */
@interface GCanalList : NSObject
-(id)initWithObj:(NSDictionary*)obj;


@property (strong,nonatomic) NSArray *mList;

@property (assign,nonatomic) CGFloat mMoney;

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
/**
 *  缴费id
 */
@property (strong,nonatomic) NSString    *mId;





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

@property (strong,nonatomic) NSString    *mPayProjectId;

@property (strong,nonatomic) NSString    *mPayProjectName;



@end
#pragma mark----聚合数据->城市对象
@interface JHCity : NSObject

-(id)initWithObj:(NSDictionary*)obj;
/**
 *  城市ID
 */
@property (strong,nonatomic) NSString    *mCityId;
/**
 *  城市名称
 */
@property (strong,nonatomic) NSString    *mCityName;
/**
 *  省份ID
 */
@property (strong,nonatomic) NSString    *mProvinceId;


@end

#pragma mark----聚合缴费数据对象
@interface JHPayData : NSObject

-(id)initWithObj:(NSDictionary*)obj;
/**
 *  省份ID
 */
@property (strong,nonatomic) NSString    *mProvinceId;
/**
 *  省份名称
 */
@property (strong,nonatomic) NSString    *mProvinceName;
/**
 *  城市ID
 */
@property (strong,nonatomic) NSString    *mCityId;
/**
 *  城市名称
 */
@property (strong,nonatomic) NSString    *mCityName;
/**
 *  缴费类型id
 */
@property (strong,nonatomic) NSString    *mPayProjectId;
/**
 *  缴费类型名称
 */
@property (strong,nonatomic) NSString    *mPayProjectName;
/**
 *  缴费单位id
 */
@property (strong,nonatomic) NSString    *mPayUnitId;
/**
 *  缴费单位名称
 */
@property (strong,nonatomic) NSString    *mPayUnitName;
/**
 *  商品id
 */
@property (strong,nonatomic) NSString    *mProductId;
/**
 *  商品名称
 */
@property (strong,nonatomic) NSString    *mProductName;
/**
 *  价格？
 */
@property (strong,nonatomic) NSString    *mInprice;

@end

/**
 订单统计对象
 
 - returns:
 */
@interface GOrderCount : NSObject

-(id)initWithObj:(NSDictionary*)obj;
/**
 *  订单类型
 */
@property (strong,nonatomic) NSString    *mOrderType;
/**
 *  订单数量
 */
@property (strong,nonatomic) NSString    *mOrderNum;
/**
 *  订单名称
 */
@property (strong,nonatomic) NSString    *mOrderName;


@end
@interface GScroe : NSObject

-(id)initWithObj:(NSDictionary*)obj;

/**
 *  添加时间
 */
@property (strong,nonatomic) NSString    *mAddTime;
/**
 *  操作者
 */
@property (strong,nonatomic) NSString    *mConsumerId;
/**
 *  描述
 */
@property (strong,nonatomic) NSString    *mDescribe;
/**
 *  金额
 */
@property (assign,nonatomic) CGFloat    mMoney;
/**
 *  纪录id
 */
@property (assign,nonatomic) int    mId;
/**
 *  支付类型
 */
@property (assign,nonatomic) int    mPaymentType;
/**
 *  积分使用量
 */
@property (assign,nonatomic) int    mScore;
/**
 *  类型 0充值 1支付
 */
@property (assign,nonatomic) int    mType;
/**
 *  钱包id
 */
@property (assign,nonatomic) int    mWid;
/**
 *  使用的红包金额
 */
@property (assign,nonatomic) int    mRed;

@end



@interface GCook : NSObject


-(id)initWithObj:(NSDictionary*)obj;

/**
 *  图片
 */
@property (strong,nonatomic) NSString    *mImg;
/**
 *  说明
 */
@property (strong,nonatomic) NSString    *mDescription;
/**
 *  材料
 */
@property (strong,nonatomic) NSString    *mFood;
/**
 *  文字
 */
@property (strong,nonatomic) NSString    *mKeywords;
/**
 *  名称
 */
@property (strong,nonatomic) NSString    *mName;
/**
 *  数量
 */
@property (assign,nonatomic) int    mCount;
/**
 *  id
 */
@property (assign,nonatomic) int    mId;

@end



@interface GAddress : NSObject


-(id)initWithObj:(NSDictionary*)obj;


@property (strong,nonatomic) NSString    *mAddressName;

@property (strong,nonatomic) NSString    *mAddressId;


@end


#pragma mark----融云信息对象
@interface RCCInfo : NSObject

-(id)initWithObj:(NSDictionary*)obj;


+ (RCCInfo *)backRCCInfo;

@property (nonatomic,strong) NSString   *mRCCUserName;

@property (nonatomic,strong) NSString   *mRCCUserId;

@property (nonatomic,strong) NSString   *mRCCToken;
/**
 *  获取融云token
 *
 *  @param mType     用户类型
 *  @param mValue    登录类型
 *  @param mUserName 用户昵称
 *  @param mHeader   头像
 *  @param block     返回值
 */
+ (void)getToken:(NSString *)mType andValue:(NSString *)mValue andUserName:(NSString *)mUserName andPrtraitUri:(NSString *)mHeader block:(void(^)(mBaseData *resb,RCCInfo *mrcc))block;

/**
 *  获取我的小区用户列表
 *
 *  @param mPage 页数
 *  @param mNum  条数
 *  @param block 返回值
 */
+ (void)getArearWithRcc:(int)mPage andNum:(int)mNum block:(void(^)(mBaseData *resb,NSArray *mArr))block;

/**
 *  获取附近的人
 *
 *  @param mPage 页数
 *  @param mNum  条数
 *  @param mLat  纬度
 *  @param mLng  经度
 *  @param block 返回值
 */
+ (void)getDistanceWith:(int)mPage andNum:(int)mNum andLat:(NSString *)mLat andLng:(NSString *)mLng block:(void(^)(mBaseData *resb,NSArray *mArr))block;

#pragma mark----获取融云用户信息
/**
 *  获取融云用户信息
 *
 *  @param mUserId userid
 *  @param block   返回值
 */
+ (void)getUserInfo:(NSString *)mUserId block:(void (^)(mBaseData *resb))block;
@end

@interface  RCCUserInfo : NSObject

-(id)initWithObj:(NSDictionary*)obj;

@property (nonatomic,strong) NSString   *totalRow;

@property (nonatomic,strong) NSString   *pageNumber;

@property (nonatomic,strong) NSString   *totalPage;

@property (nonatomic,strong) NSString   *pageSize;

@property (nonatomic,strong) NSString   *userId;

@property (nonatomic,strong) NSString   *userName;

@property (nonatomic,strong) NSString   *portraitUri;

@property (nonatomic,strong) NSString   *distance;

@property (nonatomic,strong) NSArray   *mList;


@end

@interface SWxPayInfo : NSObject
/**
 *  支付方式
 */
@property (nonatomic,strong) NSString*  mPayType;
/**
 *  随机字符串
 */
@property (nonatomic,strong) NSString*  noncestr;
/**
 *  商户号
 */
@property (nonatomic,strong) NSString*  partnerid;

/**
 *  商户订单号
 */
@property (nonatomic,strong) NSString*  out_trade_no;
/**
 *  预支付交易会话ID
 */
@property (nonatomic,strong) NSString*  prepayid;
/**
 *  签名
 */
@property (nonatomic,strong) NSString*  sign;
/**
 *  时间戳
 */
@property (nonatomic,assign) int        mtimeStamp;

@property (nonatomic,strong) NSString*  appid;
@property (nonatomic,strong) NSString*  package;


-(id)initWithObj:(NSDictionary*)obj;

@end


@interface GCommunityClass : NSObject

@property (nonatomic,assign) int        mId;

@property (nonatomic,strong) NSString*  mName;

-(id)initWithObj:(NSDictionary*)obj;


@end


@interface GCommunityNews: NSObject
/**
 *  新闻内容ID
 */
@property (nonatomic,assign) int        mId;
/**
 *  主标题
 */
@property (nonatomic,strong) NSString*  mTitel;
/**
 *  类型名字
 */
@property (nonatomic,strong) NSString*  mTypeName;
/**
 *  发布者
 */
@property (nonatomic,strong) NSString*  mWriter;
/**
 *  主内容
 */
@property (nonatomic,strong) NSString*  mContent;
/**
 *  发布时间
 */
@property (nonatomic,strong) NSString*  mDateTime;
/**
 *  新闻图片
 */
@property (nonatomic,strong) NSString*  mNewsImage;
/**
 *  状态
 */
@property (nonatomic,assign) int        mStatus;
/**
 *  类型ID
 */
@property (nonatomic,assign) int        mNewTypeId;
/**
 *  新闻来源
 */
@property (nonatomic,strong) NSString*  mSource;
/**
 *  次内容
 */
@property (nonatomic,strong) NSString*  mSubContent;
/**
 *  次标题
 */
@property (nonatomic,strong) NSString*  mSubTitel;

-(id)initWithObj:(NSDictionary*)obj;


@end


@interface GPPTaddress : NSObject
/**
 *  地址id
 */
@property (nonatomic,assign) int        mId;
/**
 *  地址名称
 */
@property (nonatomic,strong) NSString*  mAddressName;
/**
 *  地址
 */
@property (nonatomic,strong) NSString*  mAddress;
/**
 *  电话
 */
@property (nonatomic,strong) NSString*  mAlternativePhone;
/**
 *  详细地址
 */
@property (nonatomic,strong) NSString*  mDetailsAddr;
/**
 *  电话
 */
@property (nonatomic,strong) NSString*  mPhone;
/**
 *  性别
 */
@property (nonatomic,strong) NSString*  mUserSex;
/**
 *  姓名
 */
@property (nonatomic,strong) NSString*  mUserName;
/**
 *  用户id
 */
@property (nonatomic,strong) NSString*  mUserId;

-(id)initWithObj:(NSDictionary*)obj;

@end

#pragma mark----标签对象
@interface GPPTaddressTag : NSObject

/**
 *  地址id
 */
@property (nonatomic,assign) int        mId;
/**
 *  标签名称
 */
@property (nonatomic,strong) NSString*  mTagName;

-(id)initWithObj:(NSDictionary*)obj;

@end

@interface GReleaseTag : NSObject

/**
 *  标签id
 */
@property (nonatomic,assign) int        mId;
/**
 *  标签名称
 */
@property (nonatomic,strong) NSString*  mTagName;

@property (nonatomic,strong) NSString*  mTypeName;
-(id)initWithObj:(NSDictionary*)obj;

@end

@interface GPPTOrder : NSObject
/**
 *  订单id
 */
@property (nonatomic,assign) int        mId;
/**
 *  到达时间
 */
@property (nonatomic,strong) NSString*  mArrivedTime;
/**
 *  内容
 */
@property (nonatomic,strong) NSString*  mContext;
/**
 *  距离
 */
@property (nonatomic,strong) NSString*  mDistance;
/**
 *  时间？
 */
@property (nonatomic,strong) NSString*  mGenTime;
/**
 *  酬金
 */
@property (nonatomic,strong) NSString*  mLegworkMoney;
/**
 *  最高价
 */
@property (nonatomic,strong) NSString*  mMaxPrice;
/**
 *  订单号
 */
@property (nonatomic,strong) NSString*  mOrderCode;
/**
 *  最低价
 */
@property (nonatomic,strong) NSString*  mStartPrice;
/**
 *  用户id
 */
@property (nonatomic,strong) NSString*  mUserId;
/**
 *  地址
 */
@property (nonatomic,strong) NSString*  mAdress;
/**
 *  商品价格
 */
@property (nonatomic,strong) NSString*  mGoodsPrice;
/**
 *  商品名称
 */
@property (nonatomic,strong) NSString*  mComments;

@property (nonatomic,strong) NSString*  mStatusName;

@property (nonatomic,strong) NSString*  mGoodsName;

@property (nonatomic,strong) NSString*  mAddrName;

@property (nonatomic,strong) NSString*  mStatusCommet;

@property (nonatomic,strong) NSString*  mUserSex;

@property (nonatomic,strong) NSString*  mUserName;

@property (nonatomic,assign) int        mProcessStatus;

@property (nonatomic,assign) int        mSId;

@property (nonatomic,strong) NSString*  mPortrait;

@property (nonatomic,assign) int        mIsTake;

@property (nonatomic,strong) NSString*  mPhone;

@property (nonatomic,strong) NSString*  mTypeName;


@property (nonatomic,strong) NSString*  mSendAddress;

@property (nonatomic,strong) NSString*  mArrivedAddress;

@property (nonatomic,strong) NSString*  mTrafficName;

@property (nonatomic,strong) NSString*  mGoodsTypeName;

@property (nonatomic,assign) int        mPayType;

-(id)initWithObj:(NSDictionary*)obj;

@end


@class GPPTUserInfo;
#pragma mark----跑跑腿对象
@interface GPPTer : NSObject
/**
 *  平台用户id
 */
@property (nonatomic,assign) int        mUserId;
/**
 *  跑跑腿用户id
 */
@property (nonatomic,assign) int        mPPTerId;
/**
 *  是否已注销身份
 */
@property (nonatomic,assign) BOOL        mIscancel;
/**
 *  是否关闭？
 */
@property (nonatomic,assign) BOOL        mIsOff;
/**
 *  姓名
 */
@property (nonatomic,strong) NSString*  mName;

/**
 *  累计收益
 */
@property (nonatomic,strong) NSString*  mTotleMoney;
/**
 *  押金
 */
@property (nonatomic,strong) NSString*  mDepositMoney;
/**
 *  赞扬次数
 */
@property (nonatomic,strong) NSString*  mRateNum;
/**
 *  投诉次数
 */
@property (nonatomic,strong) NSString*  mFeedNum;
/**
 *  提交的资料信息
 */
@property (nonatomic,strong) NSString*  mInfoId;
/**
 *  创建时间
 */
@property (nonatomic,strong) NSString*  mCreateTime;
/**
 *  用户等级
 */
@property (nonatomic,strong) NSString*  mLevel;
/**
 *  用户头像
 */
@property (nonatomic,strong) NSString*  mHeaderImg;
/**
 *  接单次数
 */
@property (nonatomic,strong) NSString*  mGetOrderNum;
/**
 *  常见问题url
 */
@property (nonatomic,strong) NSString*  mFAQUrl;
/**
 *  电话 
 */
@property (nonatomic,strong) NSString*  mPhone;


/**
 *  总体评价
 */
@property (nonatomic,assign) int        mTotleRateCount;
/**
 *  好评
 */
@property (nonatomic,assign) int        mGoodRateCount;
/**
 *  中评
 */
@property (nonatomic,assign) int        mMidRateCount;
/**
 *  差评
 */
@property (nonatomic,assign) int        mBadRatecount;

-(id)initWithObj:(NSDictionary*)obj;

-(void)fetchIt:(NSDictionary*)obj;

/**
 *  是否是一个合法的用户对象
 *
 *  @return
 */
-(BOOL)isVaildpptUser;


/**
 *  返回当前用户
 *
 *  @return
 */
+ (GPPTer *)backPPTUser;

+ (void)getPPTerInfo:(int)mUserId block:(void (^)(mBaseData *resb, GPPTer *mUser))block;

+(void)dealpptUserSession:(mBaseData*)info block:(void(^)(mBaseData* resb, GPPTer*user))block;
+(void)savepptUserInfo:(NSDictionary *)dccat;
/**
 *  获取跑跑腿用户基本信息
 *
 *  @param block 返回值
 */
- (void)getPPTBaseUserInfo:(void(^)(mBaseData* resb, GPPTUserInfo*user))block;

/**
 *  获取跑跑腿消息列表
 *
 *  @param mPage 分页
 *  @param mNum  数量
 *  @param block 返回值
 */
- (void)getPPTMsgList:(int)mPage andNum:(int)mNum block:(void(^)(mBaseData* resb, NSArray*mArr))block;

/**
 *  获取收益
 *
 *  @param mPage 分页
 *  @param mNum  数量
 *  @param block 返回值
 */
- (void)getPPTTotleMoney:(int)mPage andNum:(int)mNum block:(void(^)(mBaseData* resb, NSArray*mArr))block;

/**
 *  获取跑跑腿评价列表
 *  @param mtype 评价类型  
 *  @param mPage 分页
 *  @param mNum  数量
 *  @param block 返回值
 */
- (void)getPPTRateList:(int)mType andPage:(int)mPage andNum:(int)mNum block:(void(^)(mBaseData* resb, NSArray*mArr))block;
/**
 *  获取标签
 *
 *  @param block 返回值
 */
- (void)getMyTags:(void(^)(mBaseData* resb, NSArray*mArr))block;
#pragma mark----注销身份
/**
 *  注销身份
 *
 *  @param block 返回值
 */
- (void)cancelPPTIdentify:(void(^)(mBaseData* resb))block;
#pragma mark----删除消息
/**
 *  删除消息
 *
 *  @param mMessageIds 消息id
 *  @param block       返回值
 */
- (void)pptDeleteMessages:(NSString *)mMessageIds block:(void(^)(mBaseData *resb))block;

#pragma mark----确认完成订单
/**
 *  确认完成订单
 *
 *  @param mOrderCode 订单编号
 *  @param mOrderType 订单类型
 *  @param mLat       纬度
 *  @param mLng       经度
 *  @param block      返回值
 */
- (void)finishPPTOrder:(int)mUserId andOrderCode:(NSString *)mOrderCode andOrderType:(int)mOrderType andLat:(NSString *)mLat andLng:(NSString *)mLng block:(void(^)(mBaseData *resb))block;



#pragma mark----跑腿者确认订单
/**
 *  确认完成订单
 *
 *  @param mOrderCode 订单编号
 *  @param mOrderType 订单类型
 *  @param mLat       纬度
 *  @param mLng       经度
 *  @param block      返回值
 */
- (void)mServicefinishPPTOrder:(int)mUserId andMoney:(int)mMoney andOrderCode:(NSString *)mOrderCode andOrderType:(int)mOrderType andLat:(NSString *)mLat andLng:(NSString *)mLng block:(void(^)(mBaseData *resb))block;
@end

@interface GPPTUserInfo : NSObject

@property (nonatomic,assign) int        mLevel;

@property (nonatomic,assign) int        mPile;

@property (nonatomic,strong) NSString*        mCardID;

@property (nonatomic,assign) int        mComplaints;

@property (nonatomic,strong) NSString*  mSex;

@property (nonatomic,strong) NSString*  mName;

@property (nonatomic,assign) int  mDeposit;

@property (nonatomic,strong) NSString*  mOrders;

@property (nonatomic,strong) NSString*  mTel;

@property (nonatomic,strong) NSString*  mGen_time;

@property (nonatomic,strong) NSString*  mPraise;

-(id)initWithObj:(NSDictionary*)obj;

@end
#pragma mark----跑跑腿排行榜
@interface GPPTRankList : NSObject

@property (nonatomic,assign) int        mLevel;

@property (nonatomic,assign) int        mOrderNum;

@property (nonatomic,assign) int        mId;

@property (nonatomic,strong) NSString*  mSex;

@property (nonatomic,strong) NSString*  mName;

@property (nonatomic,strong) NSString*  mHeaderImg;

@property (nonatomic,strong) NSString*  mTel;

@property (nonatomic,strong) NSArray* mTags;
-(id)initWithObj:(NSDictionary*)obj;


@end



@interface GPPTMyTag : NSObject

@property (nonatomic,assign) int        mTagNum;

@property (nonatomic,strong) NSString*  mTagName;

-(id)initWithObj:(NSDictionary*)obj;

@end
/**
 *  酬劳
 */
@interface GPPTReward : NSObject

@property (nonatomic,assign) int        mOrderType;

@property (nonatomic,assign) int        mPileMoney;

@property (nonatomic,strong) NSString*  mGenTime;

@property (nonatomic,strong) NSString*  mPileTitle;

@property (nonatomic,strong) NSString*  mOrderCode;


-(id)initWithObj:(NSDictionary*)obj;

@end
#pragma mark----跑跑腿消息列表
/**
 *  跑跑腿消息列表
 */
@interface GPPTMsgInfo : NSObject

@property (nonatomic,assign) int        mMsgType;

@property (nonatomic,assign) int        mId;

@property (nonatomic,strong) NSString*  mGenTime;

@property (nonatomic,strong) NSString*  mContent;

@property (nonatomic,strong) NSString*  mTitle;


-(id)initWithObj:(NSDictionary*)obj;

@end

@interface GPPTools : NSObject

@property (nonatomic,assign) int        mId;

@property (nonatomic,strong) NSString*  mToolName;
-(id)initWithObj:(NSDictionary*)obj;


@end


@interface GPPTRateList : NSObject


@property (nonatomic,assign) int        mService_efficiency;

@property (nonatomic,assign) int        mService_satisfaction;

@property (nonatomic,strong) NSString*  mGenTime;

@property (nonatomic,strong) NSString*  mNickName;

@property (nonatomic,strong) NSString*  mContent;


-(id)initWithObj:(NSDictionary*)obj;

@end

#pragma mark----*  系统标签对象
/**
 *  系统标签对象
 */
@interface GSystemTags : NSObject
/**
 *  标签id
 */
@property (nonatomic,assign) int        mTagId;
/**
 *  标签名称
 */
@property (nonatomic,strong) NSString*  mTagName;


-(id)initWithObj:(NSDictionary*)obj;


@end



@interface GFeedTags : NSObject
/**
 *  标签id
 */
@property (nonatomic,assign) int        mTagId;
/**
 *  标签名称
 */
@property (nonatomic,strong) NSString*  mTagName;


-(id)initWithObj:(NSDictionary*)obj;
@end



#pragma mark----省对象
@class GCodeArear;
@interface GCodeProvince : NSObject
/**
 *   省市id
 */
@property (nonatomic,assign) int        mProvinceId;
/**
 *  省市名称
 */
@property (nonatomic,strong) NSString*  mProvinceName;
/**
 *  城市数组
 */
@property (nonatomic,strong) NSArray *mProvinceArr;

@property (nonatomic,strong) GCodeArear *mArear;

-(id)initWithObj:(NSDictionary*)obj;
@end
@class GCodeCity;
#pragma mark----区县对象
@interface GCodeArear : NSObject
/**
 *   省市id
 */
@property (nonatomic,assign) int        mArearId;
/**
 *  省市名称
 */
@property (nonatomic,strong) NSString*  mArearName;
/**
 *  城市数组
 */
@property (nonatomic,strong) NSArray *mArearArr;

@property (nonatomic,strong) GCodeCity *mCity;

-(id)initWithObj:(NSDictionary*)obj;
@end
#pragma mark----城市对象
@interface GCodeCity : NSObject
/**
 *   省市id
 */
@property (nonatomic,assign) int        mCityId;
/**
 *  省市名称
 */
@property (nonatomic,strong) NSString*  mCityName;
/**
 *  城市数组
 */
@property (nonatomic,strong) NSString *mCityCode;

-(id)initWithObj:(NSDictionary*)obj;
@end




@interface GGetArear : NSObject

/**
 *   id
 */
@property (nonatomic,assign) int        mId;
/**
 *  地区名称
 */
@property (nonatomic,strong) NSString*  mArearName;
/**
 *  小区名称
 */
@property (nonatomic,strong) NSString*  mName;
/**
 *  距离
 */
@property (nonatomic,strong) NSString *mDistance;

-(id)initWithObj:(NSDictionary*)obj;

@end


@class GExtra;
@interface GMsgObj : NSObject

/**
 *   id
 */
@property (nonatomic,assign) int        mId;
/**
 *  消息类型
 */
@property (nonatomic,assign) int        mType;
/**
 *  是否已读
 */
@property (nonatomic,assign) BOOL        mIsRead;
/**
 *  消息标题
 */
@property (nonatomic,strong) NSString*  mMsg_title;
/**
 *  消息内容
 */
@property (nonatomic,strong) NSString*  mMsg_content;
/**
 *  时间
 */
@property (nonatomic,strong) NSString *mGen_time;
/**
 *  扩展字段
 */
@property (nonatomic,strong) GExtra *mExtras;




-(id)initWithObj:(NSDictionary*)obj;


@end

#pragma mark----*  消息扩展字段
/**
 *  消息扩展字段
 */
@interface GExtra : NSObject
/**
 *  平台类型
 */
@property (nonatomic,strong) NSString *mModel;
/**
 *  平台类型
 */
@property (nonatomic,assign) int        mPlaformtType;

/**
 *  订单类型
 */
@property (nonatomic,strong) NSString *mOrderType;
/**
 *  订单编号
 */
@property (nonatomic,strong) NSString *mOrderCode;
/**
 *  链接
 */
@property (nonatomic,strong) NSString *mUrl;


-(id)initWithObj:(NSDictionary*)obj;

@end
#pragma mark----认证地址对象
/**
 *  认证地址对象
 */
@interface GAddArearObj : NSObject
/**
 *  楼栋
 */
@property (nonatomic,assign) int mBan;
/**
 *  单元信息
 */
@property (nonatomic,strong) NSArray *mUnitList;

-(id)initWithObj:(NSDictionary *)obj;

@end
#pragma mark----认证房屋楼号对象
/**
 *  认证房屋楼号对象
 */
@interface GArearUnitAndFloorObj : NSObject
/**
 *  单元
 */
@property (nonatomic,assign) int mUnit;
/**
 *  楼层
 */
@property (nonatomic,assign) int mFloor;
/**
 *  门牌号
 */
@property (nonatomic,assign) int mRoomNum;


-(id)initWithObj:(NSDictionary *)obj;

@end



