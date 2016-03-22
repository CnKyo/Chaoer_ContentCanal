//
//  dataModel.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "dataModel.h"
#import "HTTPrequest.h"
#import "NSObject+myobj.h"
@implementation dataModel

@end


@interface mBaseData()

@property (nonatomic,strong)    id mcoredat;


@end

@implementation mBaseData

- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
        self.mcoredat = obj;
    }
    return self;

}
- (void)fetchIt:(NSDictionary *)obj{
    
    _mTitle = [obj objectForKeyMy:@"title"];
    _mState = [[obj objectForKeyMy:@"state"] intValue];
    self.mMessage = [obj objectForKeyMy:@"message"];
    self.mAlert = [[obj objectForKeyMy:@"alert"] intValue];
    self.mData = [obj objectForKeyMy:@"data"];
    
    
    if (self.mState == 200000) {
        self.mSucess = YES;
    }else{
        self.mSucess = NO;
    }
    
}
+ (mBaseData *)infoWithError:(NSString *)error{
    mBaseData *retobj = mBaseData.new;
    retobj.mTitle = @"";
    retobj.mState = 400301;
    retobj.mData = nil;
    retobj.mMessage = @"未知错误!";
    return retobj;
}
@end

@implementation mUserInfo

static mUserInfo *g_user = nil;
bool g_bined = NO;

+ (mUserInfo *)backNowUser{
    if (g_user) {
        return g_user;
    }
    if (g_bined) {
        NSLog(@"警告！递归错误！");
        return nil;
    }
    g_bined = YES;
    @synchronized (self) {
        if (!g_user) {
            g_user = [mUserInfo loadUserInfo];
        }
    }
    g_bined = NO;
    return g_user;
}
+(mUserInfo*)loadUserInfo
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSDictionary* dat = [def objectForKey:@"userInfo"];
    if( dat )
    {
        mUserInfo* tu = [[mUserInfo alloc]initWithObj:dat];
        return tu;
    }
    return nil;
}
- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
    
    
    self.mR_msg = [obj objectForKeyMy:@"r_msg"];
    self.mNickName = [obj objectForKeyMy:@"nickName"];
    self.mIdentity = [[obj objectForKeyMy:@"identity"] intValue];
    self.mUserImgUrl = [obj objectForKeyMy:@"img"];
    self.mCredit = [[obj objectForKeyMy:@"cret"] floatValue];
    self.mGrade = [[obj objectForKeyMy:@"grade"] floatValue];
    self.mMoney = [[obj objectForKeyMy:@"money"] floatValue];
    self.mUserId = [[obj objectForKeyMy:@"userId"] intValue];
    self.mSignature = [obj objectForKeyMy:@"signature"];
    self.mSex = [obj objectForKeyMy:@"sex"];
    self.mIsRegist = [obj objectForKeyMy:@"isRegist"];
    self.mIsBundle = [obj objectForKeyMy:@"isBindHourse"];
    
}

+ (BOOL)isNeedLogin{
    return [mUserInfo backNowUser] == nil;
}
- (BOOL)isVaildUser{
    return self.mUserId != 0;
}

+ (void)mUserRegist:(NSString *)mPhoneNum andCode:(NSString *)mCode andPwd:(NSString *)mPwd andIdentity:(NSString *)mId block:(void (^)(mBaseData *))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mPhoneNum forKey:@"loginName"];
    [para setObject:mCode forKey:@"verfyCode"];
    [para setObject:mPwd forKey:@"password"];
    [para setObject:mId forKey:@"identity"];
    [[HTTPrequest sharedClient] postUrl:@"front/personal/regist.do" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
        }else{

        }
    }];
}
+ (void)mUserLogin:(NSString *)mLoginName andPassword:(NSString *)mPwd block:(void (^)(mBaseData *resb, mUserInfo *mUser))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mLoginName forKey:@"loginName"];
    [para setObject:mPwd forKey:@"password"];
    
    [[HTTPrequest sharedClient] postUrl:@"login/flogin.do" parameters:para call:^(mBaseData *info) {
        [self dealUserSession:info block:block];
    }];
}
+(void)mForgetPwd:(NSString *)mLoginName andNewPwd:(NSString *)mPwd block:(void (^)(mBaseData *))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mLoginName forKey:@"loginName"];
    [para setObject:mPwd forKey:@"newPassword"];
    [[HTTPrequest sharedClient] postUrl:@"login/resetpwd.do" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
        }else{
        
        }
    }];


}
+(void)saveUserInfo:(NSDictionary *)dccat
{
    dccat = [Util delNUll:dccat];
    
    NSMutableDictionary *dcc = [[NSMutableDictionary alloc] initWithDictionary:dccat];
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    
    [def setObject:dcc forKey:@"userInfo"];
    
    
    
    [def synchronize];
}
+(void)dealUserSession:(mBaseData*)info block:(void(^)(mBaseData* resb, mUserInfo*user))block
{
    if (info.mSucess && info.mData) {
        NSDictionary* tmpdic = info.mData;
        
        NSMutableDictionary* tdic = [[NSMutableDictionary alloc]initWithDictionary:info.mData];
        NSString* fucktoken = [info.mcoredat objectForKeyMy:@"token"];
        if( fucktoken.length )
            [tdic setObject:fucktoken forKey:@"token"];
        else
        {//如果没有token,那弄原来的
//            [tdic setObject:[SUser currentUser].mToken forKey:@"token"];
        }
        mUserInfo* tu = [[mUserInfo alloc]initWithObj:tdic];
        tmpdic = tdic;
        if ([tu isVaildUser]) {
            [mUserInfo saveUserInfo:tmpdic];
            g_user = nil;
            
        }

    }
    block( info , [mUserInfo backNowUser] );
    
}
@end