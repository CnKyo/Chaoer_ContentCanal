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


@end