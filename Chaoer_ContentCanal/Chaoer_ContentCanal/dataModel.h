//
//  dataModel.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dataModel : NSObject

@end

@interface mBaseData : NSObject



@property (nonatomic,strong) NSString   *mTitle;

@property (nonatomic,assign) int        mState;

@property (nonatomic,assign) int        mSucess;

@property (nonatomic,strong) id         mData;


@property (nonatomic,assign) int        mAlert;


@property (nonatomic,strong) NSString   *mMessage;


-(id)initWithObj:(NSDictionary*)obj;

-(void)fetchIt:(NSDictionary*)obj;

+(mBaseData *)infoWithError:(NSString*)error;

@end
@class SVerifyMsg;
@class SFix;
/**
 *  用户信息
 */
@interface mUserInfo : NSObject
/**
 *  返回信息
 */
@property (nonatomic,strong) NSString   *mR_msg;

/**
 *  昵称
 */
@property (nonatomic,strong) NSString   *mNickName;
/**
 *  身份
 */
@property (nonatomic,assign) int        mIdentity;
/**
 *  用户头像
 */
@property (nonatomic,strong) NSString   *mUserImgUrl;
/**
 *  用户积分
 */
@property (nonatomic,assign) float        mCredit;
/**
 *  用户登记
 */
@property (nonatomic,assign) float        mGrade;
/**
 *  用户余额
 */
@property (nonatomic,assign) float        mMoney;

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


@property (nonatomic,strong) SVerifyMsg *mVerifyMsg;

-(id)initWithObj:(NSDictionary*)obj;

-(void)fetchIt:(NSDictionary*)obj;

/**
 *  是否是一个合法的用户对象
 *
 *  @return
 */
-(BOOL)isVaildUser;
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
+ (void)editUserMsg:(int)mUserid andLoginName:(NSString *)mLoginName andNickName:(NSString *)nickName andSex:(NSString *)mSex andSignate:(NSString *)mSignate block:(void(^)(mBaseData *resb))block;

/**
 *  修改头像
 *
 *  @param mUserId 用户id
 *  @param mImg    图片
 *  @param block   返回值
 */
+ (void)modifyUserImg:(int)mUserId andImage:(UIImage *)mImg block:(void(^)(mBaseData *resb))block;

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


#pragma mark----实名认证
/**
 * 实名认证 获取城市id
 *
 *  @param mCityId 城市id默认是0
 *  @param block   返回值
 */
+ (void)getCityId:(int)mCityId block:(void(^)(mBaseData *resb))block;
/**
 *  获得对应管理用户
 *
 *  @param mCityId   城市id
 *  @param mProvince 区县
 *  @param block     返回值
 */
+ (void)getArearId:(int)mCityId andProvince:(int)mProvince block:(void(^)(mBaseData *resb))block;

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
+ (void)getBuilNum:(NSString *)mName block:(void(^)(mBaseData *))block;
/**
 *  获取对应住房号
 *
 *  @param mName      楼盘名
 *  @param mBuildName 楼栋号
 *  @param block      返回值
 */
+ (void)getDoorNum:(NSString *)mName andBuildName:(NSString *)mBuildName block:(void(^)(mBaseData *resb))block;

/**
 *  获取绑定住户的信息
 *
 *  @param mUserId 用户id
 *  @param block   返回值
 */
+ (void)getBundleMsg:(int)mUserId block:(void(^)(mBaseData *resb,SVerifyMsg *info))block;

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
+ (void)feedPerson:(int)mUserId andVillageName:(NSString *)mVillageName andBuildName:(NSString *) mBuildName andDoorNum:(NSString *)mDoorNum andReason:(NSString *)mReason block:(void(^)(mBaseData *resb))blovk;

/**
 *  投诉物管
 *
 *  @param mUserId 用户id
 *  @param mName   投诉姓名
 *  @param mReason 原因
 *  @param block   返回值
 */
+ (void)feedCanal:(int)mUserId andName:(NSString *)mName andReason:(NSString *)mReason block:(void(^)(mBaseData *resb))block;


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
+ (void)getFixDetail:(int)mUid block:(void(^)(mBaseData *resb))block;
/**
 *  提交报修
 *
 *  @param mUid            用户id
 *  @param mLevel          一级分类
 *  @param mClassification 二级分类
 *  @param mRemark         备注
 *  @param mTime           预约时间
 *  @param mPhone          预留电话
 *  @param blck            返回值
 */
+ (void)commiteFixOrder:(int)mUid andLevel:(int)mLevel andClassification:(int)mClassification andRemark:(NSString *)mRemark andtime:(int)mTime andPhone:(NSString *)mPhone block:(void(^)(mBaseData *resb))blck;

/**
 *  获取维修订单页面数据
 *
 *  @param mOrderId 订单id
 *  @param mId      商户id
 *  @param block    返回值
 */
+ (void)getFixOrderComfirm:(int)mOrderId andmId:(int)mId block:(void(^)(mBaseData *resb))block;
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



@end
/**
 *  报修分类
 */
@interface SFix : NSObject
/**
 *  分类名
 */
@property (nonatomic,strong)    NSString       *mName;
/**
 *  分类id
 */
@property (nonatomic,assign)    int       mId;
/**
 *  上级分类
 */
@property (nonatomic,assign)    int       mSuperiorId;
/**
 *  级别？
 */
@property (nonatomic,assign)    int       mLevel;
/**
 *  类型
 */
@property (nonatomic,assign)    int       mtype;

-(id)initWithObj:(NSDictionary*)obj;



@end


