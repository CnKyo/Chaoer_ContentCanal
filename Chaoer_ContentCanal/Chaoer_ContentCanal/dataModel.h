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
@property (nonatomic,strong) NSString   *mR_msg;


@property (nonatomic,strong) NSString   *mNickName;

@property (nonatomic,assign) int        mIdentity;

@property (nonatomic,strong) NSString   *mUserImgUrl;

@property (nonatomic,assign) float        mCredit;

@property (nonatomic,assign) float        mGrade;

@property (nonatomic,assign) float        mMoney;


@property (nonatomic,assign) int        mUserId;


@property (nonatomic,strong) NSString   *mSignature;

@property (nonatomic,strong) NSString   *mSex;


@property (nonatomic,assign) BOOL        mIsRegist;

@property (nonatomic,assign) BOOL        mIsBundle;

-(id)initWithObj:(NSDictionary*)obj;

-(void)fetchIt:(NSDictionary*)obj;

+ (void)mUserRegist:(NSString *)mPhoneNum andCode:(NSString *)mCode andPwd:(NSString *)mPwd andIdentity:(NSString *)mId block:(void(^)(mBaseData *resb))block;

+ (void)mUserLogin:(NSString *)mLoginName andPassword:(NSString *)mPwd block:(void(^)(mUserInfo *mUser,mBaseData *resb))block;





@end