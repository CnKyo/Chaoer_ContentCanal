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
#import "APService.h"
#import <MobileCoreServices/UTType.h>
#import <RongIMLib/RongIMLib.h>
#import <RongIMKit/RongIMKit.h>

#import "WXApi.h"
#import "WXApiObject.h"

#import <AlipaySDK/AlipaySDK.h>
#import <objc/message.h>

@implementation dataModel{
    NSMutableURLRequest *request;
    NSOperationQueue *queue;
    NSURLConnection *_connection;
    NSMutableData *_reveivedData;
}
+(instancetype)shareInstance{
    static dataModel *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[dataModel alloc]init];
    });
    
    return manager;
}

@end


@interface mBaseData()

@property (nonatomic,strong)    id mcoredat;


@end

@implementation mBaseData

- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        self.mData = [obj objectForKeyMy:@"data"];
        [self fetchIt:obj];
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
    retobj.mMessage = @"服务器君开小差啦!";
    return retobj;
}
@end

#pragma mark----聚合基本数据

@implementation mJHBaseData

- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        self.mData = [obj objectForKeyMy:@"result"];
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
    
    _mState = [[obj objectForKeyMy:@"error_code"] intValue];
    self.mMessage = [obj objectForKeyMy:@"reason"];
    self.mData = [obj objectForKeyMy:@"result"];
    
    
    if (self.mState == 0) {
        self.mSucess = YES;
    }else{
        self.mSucess = NO;
    }
    
}
+ (mJHBaseData *)infoWithError:(NSString *)error{
    mJHBaseData *retobj = mJHBaseData.new;
    retobj.mState = 400301;
    retobj.mData = nil;
    retobj.mMessage = @"数据查询错误!";
    return retobj;
}

@end
#pragma mark----聚合基本数据
@implementation Ginfo

+ (void)getGinfo:(void (^)(mBaseData *))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt([mUserInfo backNowUser].mLoginId) forKey:@"loginId"];
    [para setObject:[Util getAppVersion] forKey:@"appVersion"];
    [para setObject:[Util getDeviceModel] forKey:@"mobileVersion"];
    [para setObject:[Util getDeviceVersion] forKey:@"mobileSystem"];
    [para setObject:[Util getDeviceUUID] forKey:@"imei"];
    [para setObject:@"ios" forKey:@"type"];
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/login/loginlog" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
        }
        
        block (info);
    }];
    
}

@end

@implementation mUserInfo
{

    NSOperationQueue *queue;
    NSURLConnection *_connection;
    NSMutableData *_reveivedData;
}
static mUserInfo *g_user = nil;
bool g_bined = NO;

+ (mUserInfo *)backNowUser{
    if (g_user) {
        return g_user;
    }
    if (g_bined) {
        MLLog(@"警告！递归错误！");
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
    
    
    self.mLoginId = [[obj objectForKeyMy:@"loginId"] intValue];
    
    self.mNickName = [obj objectForKeyMy:@"nickName"];
    
    int mIdd =  [[obj objectForKeyMy:@"identity"] intValue];
    
    if (mIdd == 1) {
        self.mIdentity = @"房主";
    }else{
        self.mIdentity = @"租客";
    }
    
    self.mUserImgUrl = [obj objectForKeyMy:@"img"];
    self.mCredit = [[obj objectForKeyMy:@"credit"] intValue];
    self.mGrade = [[obj objectForKeyMy:@"grade"] intValue];
    self.mMoney = [[obj objectForKeyMy:@"money"] floatValue];
    self.mUserId = [[obj objectForKeyMy:@"userId"] intValue];
    self.mSignature = [obj objectForKeyMy:@"signature"];
    
    int    sss = [[obj objectForKeyMy:@"sex"] intValue];
    if (sss == 1) {
        self.mSex = @"男";
    }else{
        self.mSex = @"女";
    }
    
    
    int isregist = [[obj objectForKeyMy:@"isRegist"] boolValue];
    
    int isbind = [[obj objectForKeyMy:@"isBindHourse"] boolValue];
    
    int isAut = [[obj objectForKeyMy:@"isHousingAuthentication"] boolValue];
    
    self.mIsRegist = isregist?1:0;
    
    self.mIsBundle = isbind?1:0;
    
    self.mIsHousingAuthentication = isAut?1:0;

    
    self.mPhone = [obj objectForKeyMy:@"moblie"];
    self.mPwd = [obj objectForKeyMy:@"mPwd"];
    self.muuid = @"";
    
    self.mLoginType = [[obj objectForKeyMy:@"loginType"] intValue];
    self.mOpenId = [obj objectForKeyMy:@"mOpenId"];
    self.mId = [[obj objectForKeyMy:@"identity"] intValue];
    self.mIs_leg = [[obj objectForKeyMy:@"is_leg"] intValue];
    self.mLegworkUserId = [[obj objectForKeyMy:@"legworkUserId"] intValue];
    
    self.mCommunityId = [[obj objectForKeyMy:@"community_id"] intValue];
}

+ (BOOL)isNeedLogin{
    return [mUserInfo backNowUser] == nil;
}
//退出登陆
+(void)logOut
{
    [mUserInfo closePush];
    g_user = nil;

    
}
- (BOOL)isVaildUser{
    return self.muuid != 0;
}
- (BOOL)isNeedLogin{
    return self.muuid.length == 0;
}

- (BOOL)mTemporary{
    return self.mId == 0;
}
#pragma mark----获取rsa加密公钥
/**
 *  获取rsa加密公钥
 *
 *  @param block
 */
+ (void)getRSAKey:(void(^)(mBaseData *resb))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/login/getPublicKey" parameters:para call:^(mBaseData * _Nonnull info) {
        block (info);
    }];
    
}

+ (void)OpenRCConnect{

    
    RCCInfo *mRcc = [RCCInfo backRCCInfo];
    if (!mRcc) {
        return;
    }
    
    RCUserInfo *mUser =  [[RCUserInfo alloc] initWithUserId:mRcc.mRCCUserId name:mRcc.mRCCUserName portrait:[NSString stringWithFormat:@"%@%@",[HTTPrequest currentResourceUrl],[mUserInfo backNowUser].mUserImgUrl]];
    [RCIMClient sharedRCIMClient].currentUserInfo = mUser;
    
    //初始化融云SDK
    [[RCIMClient sharedRCIMClient] initWithAppKey:RCCAPP_KEY];
    
    
        [[RCIM sharedRCIM] connectWithToken:mRcc.mRCCToken success:^(NSString *userId) {
            MLLog(@"rc ok:%@",userId);

        } error:^(RCConnectErrorCode status) {
            MLLog(@"rcerrcccrr:%ld",(long)status);

        } tokenIncorrect:^{
            MLLog(@"rcerrrr:");

        }];
    
    
//    //连接服务器
//    [[RCIMClient sharedRCIMClient] connectWithToken:mRcc.mRCCToken success:^(NSString *userId) {
//        
//        NSLog(@"rc ok:%@",userId);
//        
//    } error:^(RCConnectErrorCode status) {
//        NSLog(@"rcerrcccrr:%ld",(long)status);
//        
//    } tokenIncorrect:^{
//        
//        NSLog(@"rcerrrr:");
//        
//    }];
    NSString *url = [NSString stringWithFormat:@"%@%@",[HTTPrequest currentResourceUrl],[mUserInfo backNowUser].mUserImgUrl];

    [RCIMClient sharedRCIMClient].currentUserInfo = [[RCUserInfo alloc]initWithUserId:mRcc.mRCCUserId  name:mRcc.mRCCUserName portrait:url];

    
    
    
    
}

+ (void)reRCClocation:(NSString *)mRCCUserId andLat:(NSString *)mLat andLong:(NSString *)mLong block:(void(^)(mBaseData *resb))block{
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mLat forKey:@"lat"];
    [para setObject:mLong forKey:@"lon"];
    
    if ([RCCInfo backRCCInfo].mRCCUserId ) {
        [para setObject:[RCCInfo backRCCInfo].mRCCUserId forKey:@"userId"];

    }
    
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/rongCloud/appUpLocation" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            block (info);
        }else
            block(info);
    }];
}


#pragma mark----微信支付
//=======================微信支付===================================
-(void)wxPay:(int)Price block:(void(^)(mBaseData* retobj))block
{
    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:NumberWithInt(Price) forKey:@"price"];
    [param setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];
    [param setObject:@"wx" forKey:@"channel"];
    [param setObject:NumberWithInt([mUserInfo backNowUser].mCommunityId) forKey:@"community_id"];

    [[HTTPrequest sharedHDNetworking] postUrl:@"app/pay/recharge" parameters:param call:^(mBaseData *info) {
        
        if( info.mSucess )
        {
            // self.mPayedSn = [info.mdata objectForKeyMy:@"sn"];
            // self.mPayMoney = [[info.mdata objectForKeyMy:@"money"] floatValue];
            
            NSString* typestr = [info.mData objectForKeyMy:@"channel"];
            if( [typestr isEqualToString:@"wx"] )
            {
                
    
                
                [SVProgressHUD dismiss];
                SWxPayInfo* wxpayinfo = [[SWxPayInfo alloc]initWithObj:info.mData];
                [mUserInfo backNowUser].mPayBlock = ^(mBaseData *retobj) {
                    
                    if( retobj.mSucess )
                    {//如果成功了,就更新下
                        block(retobj);//再回调获取

                    }else
                        block(retobj);//再回调获取
                    [mUserInfo backNowUser].mPayBlock = nil;
                    
                };
                [self gotoWXPayWithSRV:wxpayinfo];
            }
            else
            {
                mBaseData* itretobj = [mBaseData infoWithError:@"支付出现异常,请稍后再试"];
                block(itretobj);//再回调获取
            }
        }
        else
            block( info );
    }];
}

-(void)gotoWXPayWithSRV:(SWxPayInfo*)payinfo
{
    
    PayReq * payobj = [[PayReq alloc]init];
    
    payobj.partnerId = @"1336953201";
    payobj.prepayId = payinfo.prepayid;
    payobj.nonceStr = payinfo.noncestr;
    payobj.timeStamp = payinfo.mtimeStamp;
    payobj.package = @"Sign=WXPay";
    payobj.sign = payinfo.sign;
    [WXApi sendReq:payobj];
    
}
#pragma mark----支付宝支付
//=======================支付宝支付===================================
-(void)aliPay:(int)Price block:(void(^)(mBaseData* retobj))block
{

    
    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:NumberWithInt(Price) forKey:@"price"];
    [param setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];
    [param setObject:@"alipay" forKey:@"channel"];
    [param setObject:NumberWithInt([mUserInfo backNowUser].mCommunityId) forKey:@"community_id"];

    [[HTTPrequest sharedHDNetworking] postUrl:@"app/pay/recharge" parameters:param call:^(mBaseData *info) {
        
        if( info.mSucess )
        {
            // self.mPayedSn = [info.mdata objectForKeyMy:@"sn"];
            // self.mPayMoney = [[info.mdata objectForKeyMy:@"money"] floatValue];
            
            NSString *mPayInfo = [info.mData objectForKey:@"packages"];
            
            
            
            [SVProgressHUD dismiss];
            
            
            
            [mUserInfo backNowUser].mPayBlock = ^(mBaseData *retobj) {
                
                if( retobj.mSucess )
                {//如果成功了,就更新下
                    block(retobj);//再回调获取
                    
                }else
                    block(retobj);//再回调获取
                [mUserInfo backNowUser].mPayBlock = nil;
                
            };
            
            
            [[AlipaySDK defaultService] payOrder:mPayInfo fromScheme:@"zerolife" callback:^(NSDictionary *resultDic) {
                
                MLLog(@"xxx:%@",resultDic);
                
                mBaseData* retobj = nil;
                
                if (resultDic)
                {
                    if ( [[resultDic objectForKey:@"resultStatus"] intValue] == 9000 )
                    {
                        retobj = [[mBaseData alloc]init];
                        retobj.mSucess = YES;
                        retobj.mMessage = @"支付成功";
                        retobj.mState = 200000;
                    }
                    else
                    {
                        retobj = [mBaseData infoWithError: [resultDic objectForKey:@"memo" ]];
                    }
                }
                else
                {
                    retobj = [mBaseData infoWithError: @"支付出现异常"];
                }
                
                if(  [mUserInfo backNowUser].mPayBlock )
                {
                    [mUserInfo backNowUser].mPayBlock( retobj );
                }
                else
                {
                    MLLog(@"alipay block nil?");
                }
                
            }];
            
            
            
          
        }
        else
        {
            mBaseData* itretobj = [mBaseData infoWithError:@"支付出现异常,请稍后再试"];
            block(itretobj);//再回调获取
        }
    }];

    
    
}
+ (void)getRegistVerifyCode:(NSString *)mPhone block:(void(^)(mBaseData *resb))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mPhone forKey:@"moblie"];
    [para setObject:@"1" forKey:@"from"];
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/verfyCode/appVerfyCode" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            block (info);
        }else
            block(info);
    }];
}

+ (void)mUserRegist:(NSString *)mPhoneNum andCode:(NSString *)mCode andPwd:(NSString *)mPwd andIdentity:(NSString *)mId block:(void (^)(mBaseData *))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mPhoneNum forKey:@"loginName"];
    [para setObject:mCode forKey:@"verfyCode"];
    [para setObject:mPwd forKey:@"passWord"];
    if (mId) {
    [para setObject:mId forKey:@"identity"];    
    }
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/auth/register" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
        
            block (info);
        }else{
            block (info);
        }
    }];
}

+ (void)mWechatRegist:(NSDictionary *)mPara block:(void(^)(mBaseData *resb))block{

    [[HTTPrequest sharedHDNetworking] postUrl:@"app/wxBind/register" parameters:mPara call:^(mBaseData *info) {
        if (info.mSucess) {
            
            block (info);
        }else{
            block (info);
        }
    }];
    
}
#pragma mark----支付方式（微信，支付宝）
-(void)payIt:(NSString*)paytype andPrice:(int)mPrice block:(void(^)(mBaseData* resb))block{

    if( [paytype isEqualToString:@"wx"] )
    {
        [self wxPay:mPrice block:block];
    }
    else if ([paytype isEqualToString:@"alipay"]){
    
        [self aliPay:mPrice block:block];
    }
    else{
        block( [mBaseData infoWithError:@"不支持的支付方式!"] );

    }

}
/**
 *  报修支付
 *
 *  @param mPayType 支付类型
 *  @param mPrice   价格
 *  @param mCode    编号
 *  @param block    返回值
 */
- (void)payType:(int)mPayType andPrice:(float)mPrice andCode:(NSString *)mCode block:(void(^)(mBaseData* resb))block{
    
    int mType;
    
    if (mPayType == 1) {
        /**
         *  微信支付
         */
        mType = 3;
        
        [self Pay:mPrice andType:mType andCode:mCode block:block];
        
    }else if (mPayType == 2){
        /**
         *  支付宝支付
         */
        mType = 4;
        [self Pay:mPrice andType:mType andCode:mCode block:block];

    }else if (mPayType == 3){
        /**
         *  银行卡支付
         */
        mType = 1;
        block( [mBaseData infoWithError:@"不支持的支付方式!"] );


    }else{
        /**
         *  余额支付
         */
        mType = 6;
        [self Pay:mPrice andType:mType andCode:mCode block:block];


    }
    
//    if( [mPayType isEqualToString:@"wx"] )
//    {
//        [self wxPay:mPrice block:block];
//    }
//    else if ([mPayType isEqualToString:@"alipay"]){
//        
//        [self aliPay:mPrice block:block];
//    }
//    else{
//        block( [mBaseData infoWithError:@"不支持的支付方式!"] );
//        
//    }
    
}
-(void)Pay:(float)Price andType:(int)mType andCode:(NSString *)mCode block:(void(^)(mBaseData* retobj))block{
    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:[Util RSAEncryptor:[NSString stringWithFormat:@"%.2f",Price]] forKey:@"price"];
    [param setObject:[Util RSAEncryptor:[NSString stringWithFormat:@"%d",[mUserInfo backNowUser].mUserId]] forKey:@"userId"];
    [param setObject:[Util RSAEncryptor:[NSString stringWithFormat:@"%d",mType]] forKey:@"channel"];
    [param setObject:@"ios" forKey:@"device"];
    [param setObject:[Util RSAEncryptor:mCode] forKey:@"code"];
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/payment/payment_repair" parameters:param call:^(mBaseData *info) {
        
        if( info.mSucess )
        {
            if (mType == 3) {
                NSString* typestr = [info.mData objectForKeyMy:@"channel"];
                if( [typestr isEqualToString:@"wx"] )
                {
                    
                    
                    [SVProgressHUD dismiss];
                    SWxPayInfo* wxpayinfo = [[SWxPayInfo alloc]initWithObj:info.mData];
                    [mUserInfo backNowUser].mPayBlock = ^(mBaseData *retobj) {
                        
                        if( retobj.mSucess )
                        {//如果成功了,就更新下
                            block(retobj);//再回调获取
                            
                        }else
                            block(retobj);//再回调获取
                        [mUserInfo backNowUser].mPayBlock = nil;
                        
                    };
                    [self gotoWXPayWithSRV:wxpayinfo];
                }
                else
                {
                    mBaseData* itretobj = [mBaseData infoWithError:@"支付出现异常,请稍后再试"];
                    block(itretobj);//再回调获取
                }
            }else if (mType == 4){
                NSString *mPayInfo = [info.mData objectForKey:@"packages"];
                
                
                
                [SVProgressHUD dismiss];
                
                
                
                [mUserInfo backNowUser].mPayBlock = ^(mBaseData *retobj) {
                    
                    if( retobj.mSucess )
                    {//如果成功了,就更新下
                        block(retobj);//再回调获取
                        
                    }else
                        block(retobj);//再回调获取
                    [mUserInfo backNowUser].mPayBlock = nil;
                    
                };
                
                
                [[AlipaySDK defaultService] payOrder:mPayInfo fromScheme:@"zerolife" callback:^(NSDictionary *resultDic) {
                    
                    MLLog(@"xxx:%@",resultDic);
                    
                    mBaseData* retobj = nil;
                    
                    if (resultDic)
                    {
                        if ( [[resultDic objectForKey:@"resultStatus"] intValue] == 9000 )
                        {
                            retobj = [[mBaseData alloc]init];
                            retobj.mSucess = YES;
                            retobj.mMessage = @"支付成功";
                            retobj.mState = 200000;
                        }
                        else
                        {
                            retobj = [mBaseData infoWithError: [resultDic objectForKey:@"memo" ]];
                        }
                    }
                    else
                    {
                        retobj = [mBaseData infoWithError: @"支付出现异常"];
                    }
                    
                    if(  [mUserInfo backNowUser].mPayBlock )
                    {
                        [mUserInfo backNowUser].mPayBlock( retobj );
                    }
                    else
                    {
                        MLLog(@"alipay block nil?");
                    }
                    
                }];
            }else if (mType == 1){
            
            }else{
            
                block (info);
            }
            
         
        }
        else
            block( info );
    }];
    
    
}
+ (void)mUserLogin:(NSString *)mLoginName andPassword:(NSString *)mPwd block:(void (^)(mBaseData *resb, mUserInfo *mUser))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mLoginName forKey:@"loginName"];
    [para setObject:mPwd forKey:@"passWord"];
    [para setObject:@"ios" forKey:@"device"];
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/login/applogin" parameters:para call:^(mBaseData *info) {
        [self dealUserSession:info andPhone:mPwd andOpenId:nil block:block];
    }];
    
//    [[HTTPrequest sharedHDNetworking] POST:@"app/login/applogin" parameters:para success:^(id  _Nonnull responseObject) {
//        MLLog(@"%@",responseObject);
//    } failure:^(NSError * _Nonnull error) {
//        MLLog(@"%@",error);
//    }];
    
}
+ (void)mVerifyOpenId:(NSDictionary *)mOpenId block:(void (^)(mBaseData *resb, mUserInfo *mUser))block{
 
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/wxBind/login" parameters:mOpenId call:^(mBaseData *info) {
        
        [self dealUserSession:info andPhone:nil andOpenId:[mOpenId objectForKey:@"openid"] block:block];
    }];
    
    
    
}

+ (void)mLoginWithWechat:(NSString *)mLoginName andPassword:(NSString *)mPwd andOpenId:(NSString *)mOpenId block:(void (^)(mBaseData *resb, mUserInfo *mUser))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mLoginName forKey:@"loginName"];
    [para setObject:mPwd forKey:@"passWord"];
    [para setObject:mOpenId forKey:@"openid"];

    [[HTTPrequest sharedHDNetworking] postUrl:@"app/wxBind/wxPhoneBind" parameters:para call:^(mBaseData *info) {
        [self dealUserSession:info andPhone:mPwd  andOpenId:mOpenId block:block];
    }];
    
}


+(void)mForgetPwd:(NSString *)mLoginName andNewPwd:(NSString *)mPwd block:(void (^)(mBaseData *))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mLoginName forKey:@"userName"];
    [para setObject:mPwd forKey:@"newPassword"];
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/auth/updatePassowrd" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            block (info);

        }else{
            block (info);

        }
    }];


}

- (void)getNowUserInfo:(void(^)(mBaseData *resb,mUserInfo *user))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    
    if (![mUserInfo backNowUser].mUserId) {
        
        [para setObject:@"0" forKey:@"identity"];

    }else{
        [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];
    }
    if([mUserInfo backNowUser].mLoginType){
        [para setObject:NumberWithInt([mUserInfo backNowUser].mLoginType) forKey:@"loginType"];
    }
    
    if ([mUserInfo backNowUser].mOpenId) {
        [para setObject:[mUserInfo backNowUser].mOpenId forKey:@"openid"];

    }
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/updUser/appFindUser" parameters:para call:^(mBaseData *info) {
        
        if (info.mSucess) {
            [mUserInfo dealUserSession:info andPhone:nil andOpenId:[mUserInfo backNowUser].mOpenId block:block];
        }else{
            block (info,[mUserInfo backNowUser]);
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


+(void)dealUserSession:(mBaseData*)info andPhone:(NSString *)mPara andOpenId:(NSString *)mOpenid block:(void(^)(mBaseData* resb, mUserInfo*user))block
{
    
#warning 返回的数据是整个用户信息对象
    if ( info.mSucess || info.mState == 200011) {
        NSDictionary* tmpdic = info.mData;
        
        NSMutableDictionary* tdic = [[NSMutableDictionary alloc]initWithDictionary:info.mData];
//        NSString* fucktoken = [info.mcoredat objectForKeyMy:@"token"];
//        if( fucktoken.length )
//            [tdic setObject:fucktoken forKey:@"token"];
//        else
//        {//如果没有token,那弄原来的
////            [tdic setObject:[SUser currentUser].mToken forKey:@"token"];
//        }
        
        if (mPara) {
            [tdic setObject:mPara forKey:@"mPwd"];
        }
        if (mOpenid) {
            [tdic setObject:mOpenid forKey:@"mOpenId"];

        }
        
        mUserInfo* tu = [[mUserInfo alloc]initWithObj:tdic];
        tmpdic = tdic;
        if ([tu isVaildUser]) {
            [mUserInfo saveUserInfo:tmpdic];
            g_user = nil;
            
        }
        
        [mUserInfo openPush];


    }
    
    
    block( info , [mUserInfo backNowUser] );
    
}


#pragma mark----更新app
/**
 *  更新app
 *
 *  @param block 返回值
 */
- (void)getUpdateApp:(void(^)(mBaseData *resb))block{

    [[HTTPrequest sharedHDNetworking] postUrl:@"app/versions/getVersionNumber" parameters:nil call:^(mBaseData *info) {
        
        block (info);
    }];
    
    
}

+ (void)editUserMsg:(NSString *)mHeader andUserid:(int)mUserid andLoginName:(NSString *)mLoginName andNickName:(NSString *)nickName andSex:(NSString *)mSex andSignate:(NSString *)mSignate block:(void(^)(mBaseData *resb,mUserInfo *mUser))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mUserid) forKey:@"userId"];
    if (mLoginName) {
        [para setObject:mLoginName forKey:@"loginName"];
    }
    
    if (nickName) {
        [para setObject:nickName forKey:@"nickName"];
    }
    if (mSex) {
        [para setObject:mSex forKey:@"sex"];
        
    }
    if (mSignate) {
        [para setObject:mSignate forKey:@"signature"];
        
    }
    if (mHeader) {
        [para setObject:mHeader forKey:@"portrait"];
        
    }
    
    if ([mUserInfo backNowUser].mPhone.length != 0) {
        [para setObject:[mUserInfo backNowUser].mPhone forKey:@"moblie"];

    }
    
    

    [[HTTPrequest sharedHDNetworking] postUrl:@"app/updUser/appModfiyUser" parameters:para call:^(mBaseData *info) {
        
        [self dealUserSession:info andPhone:nil andOpenId:nil block:block];

    }];
    
}
+ (void)modifyUserImg:(int)mUserId andImage:(NSData *)mImg andPath:(NSString *)mPath block:(void(^)(mBaseData *resb))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:[NSString stringWithFormat:@"%d",[mUserInfo backNowUser].mUserId] forKey:@"userId"];
    [para setObject:mImg forKey:@"file"];
    
    
    NSString    *mUrlStr = [NSString stringWithFormat:@"%@app/updUser/appModfiyHead",[HTTPrequest returnNowURL]];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:mUrlStr] cachePolicy:(NSURLRequestUseProtocolCachePolicy) timeoutInterval:30];
    NSString *boundary = @"wfWiEWrgEFA9A78512weF7106A";


    
    request.HTTPMethod = @"POST";
    request.allHTTPHeaderFields = @{
                                    @"Content-Type":[NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary]
                                    };
    
    //multipart/form-data格式按照构建上传数据
    NSMutableData *postData = [[NSMutableData alloc]init];
    for (NSString *key in para) {
        NSString *pair = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n",boundary,key];
        [postData appendData:[pair dataUsingEncoding:NSUTF8StringEncoding]];
        
        id value = [para objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            [postData appendData:[value dataUsingEncoding:NSUTF8StringEncoding]];
        }else if ([value isKindOfClass:[NSData class]]){
            [postData appendData:value];
        }
        [postData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    //文件部分
    NSString *filename = [mPath lastPathComponent];
    NSString *contentType = AFContentTypeForPathExtension([mPath pathExtension]);
    
    NSString *filePair = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"; filename=\"%@\";Content-Type=%@\r\n\r\n",boundary,@"file",filename,contentType];
    [postData appendData:[filePair dataUsingEncoding:NSUTF8StringEncoding]];
    
    //[postData appendData:[@"测试文件数据" dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:mImg]; //加入文件的数据
    
    [postData appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    request.HTTPBody = postData;
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)postData.length] forHTTPHeaderField:@"Content-Length"];
    
  NSURLConnection * _connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [_connection start];

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    NSURLRequest *request = [[HTTPrequest sharedClient].requestSerializer multipartFormRequestWithMethod:@"POST" URLString:mUrlStr parameters:para constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        
//        
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        formatter.dateFormat = @"yyyyMMddHHmmss";
//        NSString *nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
//        
//        NSString *fileName = [NSString stringWithFormat:@"%@.png",nowTimeStr];
//        [formData appendPartWithFileData:mImg name:@"file" fileName:fileName mimeType:@"image/png"];
//        
//    } error:nil];
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    AFHTTPRequestOperation *operator = [[HTTPrequest sharedClient] HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//
//        NSLog(@"%@ˆ",responseObject);
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        NSLog(@"%@",error);
//        block( [mBaseData infoWithError:[NSString stringWithFormat:@"%@",error]] );
//
//    }];
//    [operator start];
    
    
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    
//    [manager POST:mUrlStr parameters:para constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        
//        
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        formatter.dateFormat = @"yyyyMMddHHmmss";
//        NSString *nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
//        
//        NSString *fileName = [NSString stringWithFormat:@"%@.png",nowTimeStr];
//        [formData appendPartWithFileData:mImg name:@"file" fileName:fileName mimeType:@"application/octet-stream"];
//
//        
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@ˆ",responseObject);
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error);
//        block( [mBaseData infoWithError:[NSString stringWithFormat:@"%@",error]] );
//
//    }];
    
  

}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    MLLog(@"reveive Response:\n%@",response);
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    if (!_reveivedData) {
        _reveivedData = [[NSMutableData alloc]init];
    }
    
    [_reveivedData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    MLLog(@"received Data:\n%@",[[NSString alloc] initWithData:_reveivedData encoding:NSUTF8StringEncoding]);
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    MLLog(@"fail connect:\n%@",error);
}


static inline NSString * AFContentTypeForPathExtension(NSString *extension) {
#ifdef __UTTYPE__
    NSString *UTI = (__bridge_transfer NSString *)UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)extension, NULL);
    NSString *contentType = (__bridge_transfer NSString *)UTTypeCopyPreferredTagWithClass((__bridge CFStringRef)UTI, kUTTagClassMIMEType);
    if (!contentType) {
        return @"application/octet-stream";
    } else {
        return contentType;
    }
#else
#pragma unused (extension)
    return @"application/octet-stream";
#endif
}

#pragma mark----获取红包信息
+ (void)getRedBag:(int)mUserId andType:(NSString *)mType block:(void(^)(mBaseData *resb,NSArray *marray))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mUserId) forKey:@"userId"];
    [para setObject:mType forKey:@"type"];
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/redpackage/appRedPackage" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
            NSMutableArray *temparr = [NSMutableArray new];
            for (NSDictionary *dic in info.mData) {
                [temparr addObject:[[SRedBag alloc] initWithObj:dic]];
            }
            
            block( info,temparr);
        }else{
            block( info,nil);

        }
    }];
}


+ (void)verifyUserPhone:(NSString *)mPhone andNum:(float)mMoney block:(void (^)(mBaseData *))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mPhone forKey:@"phone"];
    [para setObject:NumberWithFloat(mMoney) forKey:@"money"];
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/convenience/appIsRecharge" parameters:para call:^(mBaseData *info) {
        
        if (info.mSucess) {
            
            block ( info );
            
        }else{
            block ( info );
        }
    }];
}
+ (void)topUpPhone:(NSString *)mPhone andNum:(float)mMoney andUserId:(int)mUserId block:(void (^)(mBaseData *))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mPhone forKey:@"phone"];
    [para setObject:NumberWithFloat(mMoney) forKey:@"money"];
    [para setObject:NumberWithInt(mUserId) forKey:@"userId"];
    [para setObject:NumberWithInt([mUserInfo backNowUser].mCommunityId) forKey:@"community_id"];

    [[HTTPrequest sharedHDNetworking] postUrl:@"app/convenience/appLineOrder" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            block ( info );

        }else{
            block ( info );

        }
    }];
}

+ (void)getBalanceVerifyCode:(NSString *)mSellerName andLoginName:(NSString *)mLoginName andPayMoney:(int)mMoney andPayName:(NSString *)mPayName andIdentify:(NSString *)mIdentify andPhone:(NSString *)mPhone andBalance:(int)mBalance andBankCard:(NSString *)mBankCard andBankTime:(NSString *)mTime andCVV:(NSString *)mCVV block:(void(^)(mBaseData *resb))block{
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mSellerName forKey:@"merchantName"];
    [para setObject:mLoginName forKey:@"userMoblie"];
    [para setObject:NumberWithInt(mBalance) forKey:@"userBalance"];
    [para setObject:NumberWithInt(mMoney) forKey:@"buyerMoney"];
//    [para setObject:NumberWithFloat(0.1) forKey:@"buyerMoney"];
    [para setObject:mPayName forKey:@"buyerName"];
    [para setObject:mIdentify forKey:@"buyerCard"];
    [para setObject:mPhone forKey:@"buyerPhone"];
    [para setObject:mBankCard forKey:@"buyerBankCard"];
    [para setObject:mTime forKey:@"buyerBankExpire"];
    [para setObject:mCVV forKey:@"buyerBankCvv"];
    [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];

    [[HTTPrequest sharedHDNetworking] postUrl:@"app/epos/pay/appHandleFunc" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
            block( info );
            
        }else{
            block( info );
        }
    }];
    
}

+ (void)getCodeAndPay:(NSString *)mOrderCode andYBOrderCode:(NSString *)mYBOrderCode andPhoneCode:(NSString *)mCode block:(void(^)(mBaseData *resb))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];
    [para setObject:mOrderCode forKey:@"orderCode"];
    [para setObject:mYBOrderCode forKey:@"ybOrderCode"];
    [para setObject:mCode forKey:@"verifyCode"];
    [para setObject:NumberWithInt([mUserInfo backNowUser].mCommunityId) forKey:@"community_id"];

    [[HTTPrequest sharedHDNetworking] postUrl:@"app/epos/pay/vertifyCodePay" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
            block( info );
            
        }else{
            block( info );
        }
    }];
    
    
    
}
#pragma mark----实名认证（获取省市区）
/**
 *  实名认证（获取省市区）
 *
 *  @param block 返回值
 */
- (void)getCodeAddress:(void(^)(mBaseData *resb,NSArray *mArr))block{

    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/region/getRegion" parameters:nil call:^(mBaseData *info) {
        if (info.mSucess) {
            
            NSMutableArray *tempArr = [NSMutableArray new];
            for (NSDictionary *dic in info.mData) {
                [tempArr addObject:[[GCodeProvince alloc] initWithObj:dic]];
            }
            
            block ( info ,tempArr );
            
        }else{
            block ( info ,nil );
        }
    }];

    
    
}

+ (void)getCityId:(int)mCityId block:(void(^)(mBaseData *resb,NSArray *mArr))block{
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mCityId) forKey:@"parentId"];
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/city/appWebSite" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
            NSMutableArray *tempArr = [NSMutableArray new];
            for (NSDictionary *dic in info.mData) {
                [tempArr addObject:[[GCity alloc] initWithObj:dic]];
            }
            
            block ( info ,tempArr );
            
        }else{
            block ( info ,nil );
        }
    }];
}

+ (void)getArearId:(NSString *)mProvince andArear:(NSString*)mArear andCity:(NSString *)mCity block:(void(^)(mBaseData *resb,NSArray *mArr))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mProvince forKey:@"propertyId"];
    [para setObject:mArear forKey:@"cityId"];
    [para setObject:mCity forKey:@"areaId"];

    [[HTTPrequest sharedHDNetworking] postUrl:@"app/zocompany/appZocompany" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
            NSMutableArray *tempArr = [NSMutableArray new];
            
            for (NSDictionary *dic in info.mData) {
                [tempArr addObject:[[GCommunity alloc] initWithObj:dic]];
            }
            
            block ( info ,tempArr);
            
        }else{
            block ( info ,nil);
        }
    }];
}



+ (void)getBuildId:(int)mCId block:(void (^)(mBaseData *))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mCId) forKey:@"cId"];
    [[HTTPrequest sharedHDNetworking] postUrl:@"zm/front/personal/village.do" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
        }else{
            
        }
    }];
}

+ (void)getBuilNum:(int)mId block:(void(^)(mBaseData *resb,NSArray *mArr))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mId) forKey:@"propertyId"];
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/house/appHouseList" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            NSMutableArray *tempArr = [NSMutableArray new];
            for (NSDictionary *dic in info.mData) {
                [tempArr addObject:[dic objectForKey:@"ban"]];
            }
            
            block ( info , tempArr);
            
        }else{
            block ( info , nil);
        }
    }];
}

+ (void)getDoorNum:(int )mName andBuildName:(int)mBuildName block:(void(^)(mBaseData *resb,NSArray *mArr))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mName) forKey:@"propertyId"];
    [para setObject:NumberWithInt(mBuildName) forKey:@"unitNum"];
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/house/appHouseUnit" parameters:para call:^(mBaseData *info) {
        
        if (info.mSucess) {
            
            NSMutableArray *tempArr = [NSMutableArray new];
            
            for (NSDictionary *dic in info.mData) {
                
                [tempArr addObject:[[GdoorNum alloc] initWithObj:dic]];
                
            }
            
            block (info,tempArr);

            
        }else{
            block (info,nil);
        }
    }];
}

+ (void)getBundleMsg:(int)mUserId block:(void (^)(mBaseData *, SVerifyMsg *))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mUserId) forKey:@"userId"];
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/epos/realVerify/appBankInfo" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            SVerifyMsg *mVerify = [[SVerifyMsg alloc] initWithObj:info.mData];
            
            block( info,mVerify);
        }else{
            block( info,nil);

        }
    }];
}
#pragma mark----获取楼栋门牌号
/**
 *  获取楼栋门牌号
 *
 *  @param mCommunityId 小区id
 *  @param block        返回值
 */
- (void)getBanAndUnitAndFloors:(NSString *)mCommunityId block:(void(^)(mBaseData *resb,NSArray *mArr))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mCommunityId forKey:@"communityId"];
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/communityCenter/getBan" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {

            NSMutableArray *tempArr = [NSMutableArray new];
            
            for (NSDictionary *dic in info.mData) {
                
                GAddArearObj *mAddObj = [[GAddArearObj alloc] initWithObj:dic];
               
              
                
                [tempArr addObject:mAddObj];
            }
            
            block( info,tempArr);
        }else{
            block( info,nil);
            
        }
    }];
    
    
    
}

+ (void)realCode:(NSString *)mName andUserId:(int)mUserid andCommunityId:(int)mCommunityId andBannum:(NSString *)mBannum andUnnitnum:(NSString *)mUnitNum andFloor:(NSString *)mFloor andDoornum:(NSString *)mDoorNum andIdentity:(NSString *)mId block:(void(^)(mBaseData *resb))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    
    if (mName) {
        [para setObject:mName forKey:@"userName"];
    }
    if (mId) {
        [para setObject:mId forKey:@"customerType"];

    }
    [para setObject:NumberWithInt(mUserid) forKey:@"userId"];
    [para setObject:NumberWithInt(mCommunityId) forKey:@"propertyId"];
    [para setObject:mBannum forKey:@"banNum"];
    [para setObject:mUnitNum forKey:@"unitNum"];
    [para setObject:mFloor forKey:@"floorNum"];
    [para setObject:mDoorNum forKey:@"roomNum"];
    
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/house/appBindHouse" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
            block( info);
        }else{
            block( info);
            
        }
    }];

    
}

#pragma mark----实名认证
- (void)realyCodeAndCommunityId:(int)mType andName:(NSString *)mName andCommunityId:(NSString *)mCommunityId andBanNum:(NSString *)mBanNum andUnitNum:(NSString *)mUnitNum andFloorNum:(NSString *)mFloor andRoomNum:(NSString *)mroomNum andIdentify:(NSString *)mIdentify andAddcommunity:(BOOL)mIsAddCommunity andcommunityName:(NSString *)mcommunityName andAddress:(NSString *)mAddress andProvinceID:(NSString *)mProvinceId andArearId:(NSString *)mArearId andCityId:(NSString *)mCityID andPhone:(NSString *)mPhone block:(void(^)(mBaseData *resb))block{

    NSString *mUrlStr = nil;
    NSMutableDictionary *para = [NSMutableDictionary new];

    if (mType == 1) {
        mUrlStr = @"app/house/appBindHouse";
    }else{
        mUrlStr = @"app/house/appAddHouse";
    }

    [para setObject:mName forKey:@"ownerName"];

    
   
    [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];
    [para setObject:mPhone forKey:@"mobile"];

    [para setObject:mCommunityId forKey:@"propertyId"];
    [para setObject:mBanNum forKey:@"banNum"];
    [para setObject:mUnitNum forKey:@"unitNum"];
    [para setObject:mFloor forKey:@"floorNum"];
    [para setObject:mroomNum forKey:@"roomNum"];
    [para setObject:mIdentify forKey:@"customerType"];
    [para setObject:NumberWithBool(mIsAddCommunity) forKey:@"isAddCommunity"];
    
    if (mIsAddCommunity) {
        [para setObject:mcommunityName forKey:@"communityName"];
        [para setObject:mAddress forKey:@"address"];
        [para setObject:mProvinceId forKey:@"province"];
        [para setObject:mArearId forKey:@"city"];
        [para setObject:mCityID forKey:@"county"];

    }
    
    
    [[HTTPrequest sharedHDNetworking] postUrl:mUrlStr parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
            block( info);
        }else{
            block( info);
            
        }
    }];

    
    
    
}







- (void)addHouse:(int)mCommunityId andBannum:(NSString *)mBannum andUnnitnum:(NSString *)mUnitNum andFloor:(NSString *)mFloor andDoornum:(NSString *)mDoorNum andIdentity:(NSString *)mId block:(void(^)(mBaseData *resb))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    
    
    [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];
    [para setObject:NumberWithInt(mCommunityId) forKey:@"propertyId"];
    [para setObject:mBannum forKey:@"banNum"];
    [para setObject:mUnitNum forKey:@"unitNum"];
    [para setObject:mFloor forKey:@"floorNum"];
    [para setObject:mDoorNum forKey:@"roomNum"];
    if (mId) {
        [para setObject:mId forKey:@"customerType"];
        
    }
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/house/appAddHouse" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
            block( info);
        }else{
            block( info);
            
        }
    }];
}



+ (void)getbank:(void(^)(mBaseData *resb,NSArray *marr))block
{    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/bank/appBankList?&paramName=bankname" parameters:nil call:^(mBaseData *info) {
        if (info.mData) {
            NSMutableArray *tempArr = [NSMutableArray new];
            
            for (NSDictionary *dic in info.mData) {
                [tempArr addObject:[dic objectForKey:@"bankname"]];
            }
            
            block( info,tempArr);
        }else{
            block( info,nil);
            
        }
    }];
    
    

}

+ (void)getBankOfCity:(NSString *)mCity andProvince:(NSString *)mProvince andBankName:(NSString *)mName andType:(int)mType block:(void(^)(mBaseData *resb,NSArray *marr))block{

    NSMutableDictionary *para = [NSMutableDictionary new];

    NSString *url = nil;
    
   if (mType ==2){
       url = @"app/bank/appBankList?&paramName=province";
       [para setObject:mName forKey:@"bankname"];
       
    }else if (mType ==3){
        url = @"app/bank/appBankList?&paramName=city&";
        
        [para setObject:mProvince forKey:@"province"];
        [para setObject:mName forKey:@"bankname"];

        
    }else if (mType == 4){
        url = @"app/bank/appBankList?&paramName=name&";
        [para setObject:mProvince forKey:@"province"];
        [para setObject:mCity forKey:@"city"];
        [para setObject:mName forKey:@"bankname"];

    }
    
    
    [[HTTPrequest sharedHDNetworking] postUrl:url parameters:para call:^(mBaseData *info) {

        if (info.mSucess) {
            NSMutableArray *tempArr = [NSMutableArray new];
            
            
            if (mType == 3) {
                for (NSDictionary *dic in info.mData) {
                    
                    [tempArr addObject:[dic objectForKey:@"city"]];
                }
                
            }else if(mType ==4){
                
                [tempArr addObjectsFromArray:info.mData];
            }else{
                for (NSDictionary *dic in info.mData) {
                    
                    [tempArr addObject:[dic objectForKey:@"province"]];
                }
            }
            
            
            
            block( info,tempArr);
        }else{
            block( info,nil);
            
        }
    }];
}



+ (void)geBankCode:(NSString *)mName andUserId:(int)mUserId andIdentify:(NSString *)mIdentify andBankName:(NSString *)mBankName andProvince:(NSString *)mProvince andCity:(NSString *)mCity andPoint:(NSString *)mPoint andBankCard:(NSString *)mCard andBankCode:(NSString *)mBankCode block:(void(^)(mBaseData *resb))block{

    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mUserId) forKey:@"userId"];
    [para setObject:mName forKey:@"name"];
    [para setObject:mIdentify forKey:@"card"];
    [para setObject:mBankName forKey:@"bankName"];
    [para setObject:mProvince forKey:@"bankProvince"];
    [para setObject:mCity forKey:@"bankCity"];
    [para setObject:mPoint forKey:@"bankWebSite"];
    [para setObject:mCard forKey:@"bankCard"];
    
    [para setObject:mBankCode forKey:@"bankCode"];

    
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/epos/realVerify/appRealNameVerify" parameters:para call:^(mBaseData *info) {
        if (info.mSucess ) {
            
            block (info);
            
        }else{
            block (info);
        }
    }];

    
    
    
    
}




+ (void)getBaner:(void (^)(mBaseData *, NSArray *))block{
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/banner/getBanner" parameters:nil call:^(mBaseData *info) {
        NSMutableArray *temparr = [NSMutableArray new];
        if (info.mSucess ) {
            
            for (NSDictionary *dic in info.mData) {
                [temparr addObject:[[MBaner alloc] initWithObj:[dic objectForKey:@"attrs"]]];
            }
            block (info,temparr);
            
        }else{
            block (info,nil);
        }
    }];
}


#pragma mark----获取跑跑腿baner横幅
/**
 *  获取baner横幅
 *
 *  @param block 返回值
 */
- (void)getPPTbaner:(void(^)(mBaseData *resb,NSArray *mBaner))block{

    
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/legwork/user/appLegBanner" parameters:nil call:^(mBaseData *info) {
        NSMutableArray *temparr = [NSMutableArray new];
        if (info.mSucess ) {
            
            for (NSDictionary *dic in info.mData) {
                [temparr addObject:[[GPPTBaner alloc] initWithObj:dic]];
            }
            block (info,temparr);
            
        }else{
            block (info,nil);
        }
    }];
    
    
    
}


+ (void)feedCompany:(int)mUserId andContent:(NSString *)mContent block:(void(^)(mBaseData *resb))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mUserId) forKey:@"userId"];
    [para setObject:mContent forKey:@"complainReason"];
    [para setObject:@"3" forKey:@"type"];
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/complain/companyOpinion" parameters:para call:^(mBaseData *info) {
        if (info.mSucess ) {
            block (info);
        }else{
            block (info);
        }
    }];
}

+ (void)feedPerson:(NSString *)mValligeId andBuilId:(NSString *)mBuildId andUnit:(NSString *)mUnitId andFloor:(NSString *)mFloor andDoornum:(NSString *)mdoornum andReason:(NSString *)mReason block:(void(^)(mBaseData *resb))blovk{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];
    [para setObject:@"1" forKey:@"type"];
    [para setObject:mValligeId forKey:@"communityId"];
    [para setObject:mBuildId forKey:@"ban"];
    [para setObject:mUnitId forKey:@"unit"];
    [para setObject:mFloor forKey:@"floor"];
    [para setObject:mdoornum forKey:@"roomNumber"];
    [para setObject:mReason forKey:@"complainReason"];
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/complain/residentsComplaints" parameters:para call:^(mBaseData *info) {
        if (info.mSucess ) {
            
            blovk (info);

        }else{
            blovk (info);

        }
    }];
    
    
}

+ (void)feedCanal:(int)mArearId andName:(NSString *)mName andReason:(NSString *)mReason block:(void(^)(mBaseData *resb))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];
    [para setObject:NumberWithInt(mArearId) forKey:@"communityId"];
    [para setObject:mName forKey:@"staffName"];
    [para setObject:mReason forKey:@"complainReason"];
    [para setObject:@"2" forKey:@"type"];

    [[HTTPrequest sharedHDNetworking] postUrl:@"app/complain/propertyComplaints" parameters:para call:^(mBaseData *info) {
        if (info.mSucess ) {
            block ( info );
        }else{
            block ( info );
        }
    }];
    
}

- (void)getCanalMsg:(void(^)(mBaseData *resb,GCanalList *mList))block{

    [[HTTPrequest sharedHDNetworking] postUrl:@"app/propertyCost/getPropertyCost" parameters:@{@"userId":[NSString stringWithFormat:@"%d",[mUserInfo backNowUser].mUserId]} call:^(mBaseData *info) {
        
        NSMutableArray *tempArr = [NSMutableArray new];
        
        if (info.mSucess) {
            
            GCanalList *mCanal = [[GCanalList alloc] initWithObj:info.mData];
            
            
            for (NSDictionary *dic in mCanal.mList) {
                
                [tempArr addObject:[[GCanal alloc] initWithObj:dic]];
            }
            mCanal.mList = tempArr;
            
            block ( info,mCanal);
            
        }else{
            block ( info,nil);
        }
        
    }];

}

- (void)payCanal:(NSMutableDictionary *)mPara block:(void(^)(mBaseData *resb))block{

    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/propertyCost/deliveryCharge" parameters:mPara call:^(mBaseData *info) {
        if (info.mSucess) {
            block ( info );
        }else{
            block ( info );
        }
    }];
    
}

- (void)FindPublickType:(int)mType andId:(NSString *)mId block:(void(^)(mJHBaseData *resb,NSArray *mArr))block{

    NSMutableDictionary *para = [NSMutableDictionary new];

    NSString *posturl = nil;
    
    if (mType == 1) {
        posturl = @"province";
        [para setObject:JH_KEY forKey:@"key"];

    }else{
        posturl = @"city";
        [para setObject:JH_KEY forKey:@"key"];
        [para setObject:mId forKey:@"provid"];

    }
    [[JHJsonRequst sharedHDNetworking] postUrl:[NSString stringWithFormat:@"%@%@",[JHJsonRequst returnNowURL],posturl] parameters:para call:^(mJHBaseData *info) {
        

        
        NSMutableArray *tempArr = [NSMutableArray new];
        [tempArr removeAllObjects];
        if (info.mSucess) {
            
            if (mType == 1) {
                for ( NSDictionary *dic in info.mData) {
                    [tempArr addObject:[[JHProvince alloc] initWithObj:dic]];
                }
            }else{
                for (NSDictionary *dic in info.mData) {
                    [tempArr addObject:[[JHCity alloc]initWithObj:dic]];
                }
                
            }
            
        
            
            block ( info ,tempArr);
            
        }else{
            block ( info ,nil);
        }
        
    }];

}

- (void)FindPublic:(int )mType andPara:(NSDictionary *)mParas block:(void(^)(mJHBaseData *resb,NSArray *mArr))block{
    NSString *posturl = nil;
    
    if (mType == 1) {
        posturl = @"province";
        
    }else if(mType == 2){
        posturl = @"city";
        
    }else if(mType == 3){
        posturl = @"project";
        
    }else if(mType == 4){
        posturl = @"unit";
        
    }else if(mType == 5){
        posturl = @"query";
    }
    [[JHJsonRequst sharedHDNetworking] postUrl:[NSString stringWithFormat:@"%@%@",[JHJsonRequst returnNowURL],posturl] parameters:mParas call:^(mJHBaseData *info) {
        
        NSMutableArray *tempArr = [NSMutableArray new];
        [tempArr removeAllObjects];
        if (info.mSucess) {
            
            for (NSDictionary *dic in info.mData) {
                [tempArr addObject:[[JHPayData alloc]initWithObj:dic]];
            }

            block ( info ,tempArr);
            
        }else{
            block ( info ,nil);
        }
        
    }];

    
}
- (void)Inquire:(NSDictionary *)mParas block:(void(^)(mJHBaseData *resb))block{

    [[JHJsonRequst sharedHDNetworking] postUrl:[NSString stringWithFormat:@"%@mbalance",[JHJsonRequst returnNowURL]] parameters:mParas call:^(mJHBaseData *info) {
        
        NSMutableArray *tempArr = [NSMutableArray new];
        [tempArr removeAllObjects];
        if (info.mSucess) {
            
            for (NSDictionary *dic in info.mData) {
                [tempArr addObject:[[JHPayData alloc]initWithObj:dic]];
            }
            
            block ( info );
            
        }else{
            block ( info );
        }
        
    }];

}

- (void)goPay:(NSDictionary *)mParas block:(void(^)(mJHBaseData *resb))block{
    
    [[JHJsonRequst sharedHDNetworking] postUrl:[NSString stringWithFormat:@"%@order",[JHJsonRequst returnNowURL]] parameters:mParas call:^(mJHBaseData *info) {

        
        NSMutableArray *tempArr = [NSMutableArray new];
        [tempArr removeAllObjects];
        if (info.mSucess) {
            
            for (NSDictionary *dic in info.mData) {
                [tempArr addObject:[[JHPayData alloc]initWithObj:dic]];
            }
            
            block ( info );
            
        }else{
            block ( info );
        }
        
    }];
}


+(void)getCash:(int)mUid andMoney:(NSString *)mMoney andPresentManner:(NSString *)mPresentManner block:(void(^)(mBaseData *resb))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mUid) forKey:@"userId"];
    [para setObject:mMoney forKey:@"money"];
    [para setObject:@"0" forKey:@"presentManner"];
    [para setObject:NumberWithInt([mUserInfo backNowUser].mCommunityId) forKey:@"community_id"];
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/wallet/present" parameters:para call:^(mBaseData *info) {
        if (info.mSucess ) {
            
            block ( info );
            
        }else{
            block ( info );
        }
    }];

}

+ (void)getClass:(int)mType block:(void(^)(mBaseData *resb,NSArray *array))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(2) forKey:@"level"];
    [para setObject:NumberWithInt(mType) forKey:@"type"];
    [[HTTPrequest sharedHDNetworking] postUrl:@"classify/getClassify.do" parameters:para call:^(mBaseData *info) {
        
        NSMutableArray *tempArr = [NSMutableArray new];
        if (info.mSucess ) {
            
            for (NSDictionary *dic in info.mData) {
                [tempArr addObject:[[GFix alloc] initWithObj:dic]];

                block(info,tempArr);
            }
            
        }else{
            block(info,nil);

        }
        
    }];
}

+ (void)getFixDetail:(NSString *)mSuperiorId andLevel:(NSString *)mLevel block:(void(^)(mBaseData *resb,NSArray *marr))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mSuperiorId forKey:@"superiorId"];
    [para setObject:mLevel forKey:@"level"];

    [[HTTPrequest sharedHDNetworking] postUrl:@"app/classify/getClassify" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
            NSMutableArray *tempArr = [NSMutableArray new];
            
            for (NSDictionary *dic in info.mData) {
                [tempArr addObject:[[GFix alloc] initWithObj:dic]];
            }
            
            block (info,tempArr);
            
        }else{
            block (info,nil);

        }
    }];
}

#pragma mark---提交保修订单
- (void)commitFixOrder:(NSString *)mSuperId andSubClass:(NSString *)mSubClass andNote:(NSString *)mNote andServiceTime:(NSString *)mServiceTime andAddress:(NSString *)mAddress andCommunityId:(NSString *)mCommunityId andServicerId:(int)mId andImgUrl:(NSString *)mImgUrl andVideoUrl:(NSString *)mVideoUrl block:(void(^)(mBaseData *resb))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"uid"];
    [para setObject:NumberWithInt(mId) forKey:@"mId"];
    
    [para setObject:mSubClass forKey:@"classification1"];
    [para setObject:mSuperId forKey:@"classification2"];
    [para setObject:mNote forKey:@"remarks"];
    
    [para setObject:mServiceTime forKey:@"appointmentTime"];
    
    [para setObject:[mUserInfo backNowUser].mPhone forKey:@"phone"];
    
    [para setObject:mAddress forKey:@"address"];
    [para setObject:mCommunityId forKey:@"communityId"];
    [para setObject:mImgUrl forKey:@"imageUrl"];
    
    
    if (mVideoUrl) {
        [para setObject:mVideoUrl forKey:@"vidoeUrl"];
    }
    
    
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/warrantyOrder/addRepairOrder" parameters:para call:^(mBaseData *info) {
        
        block (info );
        
    }];
    
    
    
}



+ (void)getServiceName:(NSString *)mAddress andLng:(NSString *)mLng andLat:(NSString *)mLat andOneLevel:(NSString *)mOne andTwoLevel:(NSString *)mTwo andPage:(int)mStart andEnd:(int)mEnd block:(void(^)(mBaseData *resb,GServiceList *mList))block{

    NSMutableDictionary *para = [NSMutableDictionary new];

    if (mAddress) {
        [para setObject:mAddress forKey:@"address"];
        
    }else {
        [para setObject:mLng forKey:@"lng"];
        [para setObject:mLat forKey:@"lat"];
    }
    [para setObject:mOne forKey:@"classification1"];
    [para setObject:mTwo forKey:@"classification2"];
    [para setObject:@"1" forKey:@"isAuthentication"];
    [para setObject:NumberWithInt(mStart) forKey:@"pageNumber"];
    [para setObject:NumberWithInt(mEnd) forKey:@"pageSize"];


    [[HTTPrequest sharedHDNetworking] postUrl:@"app/warrantyOrder/MerchantList" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
            NSMutableArray *tempArr = [NSMutableArray new];
            
            GServiceList *GService = [[GServiceList alloc] initWithObj:info.mData];
            
            for (NSDictionary *dic in GService.mArray) {
                
                [tempArr addObject:[[SServicer alloc] initWithObj:dic]];
            }
            GService.mArray = tempArr;
            
            block ( info,GService);
            
        }else{
            block (info, nil );
        }
    }];
    
}


+ (void)getFixOrderComfirm:(int)mOrderId andmId:(int)mId block:(void(^)(mBaseData *resb,GFixOrder *mOrder))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mOrderId) forKey:@"orderId"];
    [para setObject:NumberWithInt(mId) forKey:@"mId"];
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/warrantyOrder/getPreOrder" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {

            block ( info ,[[GFixOrder alloc] initWithObj:info.mData]);
        }else{
            block ( info ,nil);
        }
    }];
}


+ (void)getOrderPaySuccess:(int)mUserId andOrderId:(int)mOrderId block:(void (^)(mBaseData *))block{
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mOrderId) forKey:@"orderId"];
    [para setObject:NumberWithInt(mUserId) forKey:@"mId"];
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/warrantyOrder/reserve" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            block (info);
        }else{
            block (info);
        }
    }];
    
}
+ (void)upDateOrderStatus:(int)mUserId andOrderId:(int)mOrderId block:(void(^)(mBaseData *resb,NSArray *array))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mOrderId) forKey:@"orderId"];
    [para setObject:NumberWithInt(mUserId) forKey:@"userId"];
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"merchantOrder/modifyOrderWgtStatus.do" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
            NSMutableArray *tempArr = [NSMutableArray new];
            for (NSDictionary *dic in info.mData) {
                
                [tempArr addObject:[[SSellerList alloc]initWithObj:dic]];
            }
            block (info,tempArr);
            
        }else{
            block (info,nil);
        }
    }];
}


- (void)getUserAppointment:(int)mOrderid andSellerId:(int)mSellerId block:(void(^)(mBaseData *resb))block
{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mOrderid) forKey:@"orderId"];
    [para setObject:NumberWithInt(mSellerId) forKey:@"merchantId"];
    [[HTTPrequest sharedHDNetworking] postUrl:@"merchant/reserve.do" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
  
            
        }else{
        }
    }];

}


- (void)getSellerMsg:(int)mOid andmId:(int)mId block:(void(^)(mBaseData *resb))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mOid) forKey:@"oId"];
    [para setObject:NumberWithInt(mId) forKey:@"mId"];
    [[HTTPrequest sharedHDNetworking] postUrl:@"merchantOrder/getOrderInfo.do" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
            
            
        }else{
        }
    }];


}

- (void)finishFixOrder:(NSString *)mOrderId andPayType:(NSString *)mPayType andRate:(NSString *)mRate block:(void(^)(mBaseData *resb))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mOrderId forKey:@"orderId"];
    [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];
    
    if (mPayType) {
    [para setObject:mPayType forKey:@"payWay"];
    }
    if (mRate) {
        [para setObject:mRate forKey:@"praiseRate"];
    }
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/warrantyOrder/userConfirmation" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
            block ( info );
            
        }else{
            block ( info );
        }
    }];
    
    
    
}



- (void)getArear:(void(^)(mBaseData *resb,NSArray *mArr))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];

    [[HTTPrequest sharedHDNetworking] postUrl:@"app/communityCenter/getCommunity" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
            NSMutableArray *tempArr = [NSMutableArray new];
            
            for (NSDictionary *dic in info.mData) {
                [tempArr addObject:[[GArear alloc] initWithObj:dic]];
            }
            block ( info,tempArr );
            
        }else{
            block ( info,nil );
        }
    }];

    
}

- (void)getWallete:(int)mUserID block:(void (^)(mBaseData *))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/wallet/walletInfo" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            block ( info );
            
        }else{
            block ( info );
        }
    }];
}
#pragma mark----获取订单列表
- (void)getOrderList:(int)mType block:(void(^)(mBaseData *resb,NSArray *mArr))block{
    NSString *mUrl = nil;
  
    mUrl = @"app/order/countOrderList";
   
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];
    
    [[HTTPrequest sharedHDNetworking] postUrl:mUrl parameters:para call:^(mBaseData *info) {
        
        NSMutableArray *tempArr = [NSMutableArray new];
        
        if (info.mSucess) {
            
            for (NSDictionary *dic in info.mData) {
                [tempArr addObject:[[GOrderCount alloc] initWithObj:dic]];
            }
            
            block ( info , tempArr );
            
        }else{
            block ( info , nil );
        }
    }];
 
}

- (void)getOrder:(NSString *)mType andStart:(int)mStart andEd:(int)mEnd block:(void(^)(mBaseData *resb,NSArray *mArr))block{

    NSString *mUrl = nil;
    
    if ([mType isEqualToString:@"2"]) {
        mUrl = @"app/order/getMobileOrderList";
    }else if ([mType isEqualToString:@"1"]){
        mUrl = @"app/order/getWarrantyOrderList";
    }
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];
    [para setObject:NumberWithInt(mStart) forKey:@"pageNumber"];
    [para setObject:NumberWithInt(mEnd) forKey:@"pageSize"];

    
    [[HTTPrequest sharedHDNetworking] postUrl:mUrl parameters:para call:^(mBaseData *info) {
        
        NSMutableArray *tempArr = [NSMutableArray new];
        
        if (info.mSucess) {
            
            for (NSDictionary *dic in [info.mData objectForKey:@"list"]) {
                [tempArr addObject:[[GFixOrder alloc] initWithObj:dic]];
            }
            
            block ( info , tempArr );
            
        }else{
            block ( info , nil );
        }
    }];

    
    
    
}

- (void)getOrderDetail:(NSString *)mOrderID block:(void(^)(mBaseData *resb,GFixOrder *mFixOrder))block{
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mOrderID forKey:@"orderId"];

    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/warrantyOrder/getOrderDetails" parameters:para call:^(mBaseData *info) {
        
        if (info.mSucess) {
            
            GFixOrder *mFix = [[GFixOrder alloc] initWithObj:info.mData];
            
            block ( info , mFix );
            
        }else{
            block ( info , nil );
        }
    }];
    
    
    
}

- (void)getScoreList:(int)mType andPage:(int)mPage andNum:(int)mNum block:(void(^)(mBaseData *resb,NSArray *mArr))block{

    
    NSString *mUrl = nil;
    
    if (mType == 1) {
        mUrl = @"app/wallet/getWalletRecordList";
    }else{
        mUrl = @"app/wallet/getIntegralRecord";

    }
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];
    [para setObject:NumberWithInt(mPage) forKey:@"pageNumber"];
    [para setObject:NumberWithInt(mNum) forKey:@"pageSize"];
    
    
    [[HTTPrequest sharedHDNetworking] postUrl:mUrl parameters:para call:^(mBaseData *info) {
        
        NSMutableArray *tempArr = [NSMutableArray new];
        
        if (info.mSucess) {
            
            
            for (NSDictionary *dic in [info.mData objectForKey:@"list"]) {
                
                
                [tempArr addObject:[[GScroe alloc] initWithObj:dic]];
                
            }
            
            block ( info , tempArr );
            
        }else{
            block ( info , nil );
        }
    }];
    
}
#pragma mark----阿凡达菜谱
- (void)getCookList:(int)mPage block:(void(^)(mJHBaseData *resb,NSArray *mArr))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:AVADA_KEY forKey:@"key"];
    [para setObject:NumberWithInt(mPage) forKey:@"page"];
    [para setObject:NumberWithInt(20) forKey:@"rows"];
    [para setObject:@"JSON" forKey:@"dtype"];
    [para setObject:NumberWithBool(false) forKey:@"format"];
    
    [[AVAndaJson sharedHDNetworking] postUrl:@"List" parameters:para call:^(mJHBaseData *info) {
              
        
        NSMutableArray *tempArr = [NSMutableArray new];
        
        if (info.mSucess) {
            
            for (NSDictionary *dic in info.mData) {
                
                [tempArr addObject:[[GCook alloc] initWithObj:dic]];
                
            }
            
            block ( info,tempArr );
            
        }else{
        
            block ( info,nil );
        }
        
        
    }];

    
}



- (void)getAddress:(void(^)(mBaseData *resb,NSArray *mArr))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/warrantyOrder/warrantyUserInfo" parameters:para call:^(mBaseData *info) {
        
        NSMutableArray *tempArr = [NSMutableArray new];
        
        if (info.mSucess) {
            
            for (NSDictionary *dic in [info.mData objectForKey:@"address"]) {
             
                [tempArr addObject:[[GAddress alloc] initWithObj:dic]];
                
            }
                        
            block ( info ,tempArr);
        }else{
            block ( info ,nil);
        }
        
        
    }];
    
}



+ (void)openPush{

    NSString* t = [NSString stringWithFormat:@"%d", [mUserInfo backNowUser].mUserId];
    
    t = [@"buyer_" stringByAppendingString:t];
    
    //别名
    //1."seller_1"
    //2."buyer_1"
    
    
    //标签
    //1."seller"/"buyer"
    //2."重庆"/...
    
    
    NSSet* labelset = [[NSSet alloc]initWithObjects:@"buyer", @"ios",nil];
    
    [APService setTags:labelset alias:t callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:[UIApplication sharedApplication].delegate];

}
+ (void)closePush{
    [APService setTags:[NSSet set] alias:@"" callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:[UIApplication sharedApplication].delegate];

}

- (void)getCommunityClass:(void(^)(mBaseData *resb,NSArray *mArr))block{

    [[HTTPrequest sharedHDNetworking] postUrl:@"app/newsType/getNewsTypeList" parameters:nil call:^(mBaseData *info) {
        
        if (info.mSucess) {
            
            NSMutableArray *tempArr = [NSMutableArray new];
            
            for (NSDictionary *dic in info.mData) {
                
                [tempArr addObject:[[GCommunityClass alloc] initWithObj:dic]];
                
            }
            block (info,tempArr);
            
        }else{
            
            block (info,nil);
        }
        
    }];
}


#pragma mark----获取社区动态
- (void)getCommunityStatus:(int)mCommunityId andPage:(int)mPage andType:(int)mType block:(void(^)(mBaseData *resb,NSArray *mArr))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mCommunityId) forKey:@"communityId"];
    [para setObject:NumberWithInt(mPage) forKey:@"pageIndex"];
    [para setObject:NumberWithInt(10) forKey:@"pageSize"];
    [para setObject:NumberWithInt(mType) forKey:@"newsType"];
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/news/getNewSContentList" parameters:para call:^(mBaseData *info) {
        
        if (info.mSucess) {

            NSMutableArray *tempArr = [NSMutableArray new];
            
            for (NSDictionary *dic in [info.mData objectForKeyMy:@"list"]) {
                
                [tempArr addObject:[[GCommunityNews alloc] initWithObj:dic]];
                
            }
            
            block (info,tempArr);
        }else{
        
            block (info,nil);
            
        }
        
    }];

    
}

/**
 *  获取新闻详情
 *
 *  @param mNewsId 新闻ID
 *  @param block   返回
 */
- (void)getCommunityDetail:(int)mNewsId block:(void(^)(mBaseData *resb))block{

    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mNewsId) forKey:@"id"];
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/news/getNewSContent" parameters:para call:^(mBaseData *info) {
        
        if (info.mSucess) {
            
            
            block (info);
        }else{
            
            block (info);
            
        }
        
    }];
}


#pragma mark----获取地址标签
- (void)getPPTaddressTag:(void(^)(mBaseData *resb,NSArray *mArr))block{

    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/legwork/user/appSysAddressTag" parameters:nil call:^(mBaseData *info) {
        
        if (info.mSucess) {
            
            NSMutableArray *tempArr = [NSMutableArray new];
            
            for (NSDictionary *dic in info.mData) {
                [tempArr addObject:[[GPPTaddressTag alloc] initWithObj:dic]];
            }
            
            block (info,tempArr);
        }else{
            
            block (info,nil);
            
        }
        
    }];

}

#pragma mark----查询常用地址
- (void)getPPTaddressList:(void(^)(mBaseData *resb,NSArray *mArr))block{
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];
    
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/legwork/user/appUserAddrList" parameters:para call:^(mBaseData *info) {
        
        if (info.mSucess) {
            
            NSMutableArray *tempArr = [NSMutableArray new];
            
            for (NSDictionary *dic in info.mData) {
                [tempArr addObject:[[GPPTaddress alloc] initWithObj:dic]];
            }
                       
            block (info,tempArr);
        }else{
            
            block (info,nil);
            
        }
        
    }];


}

#pragma mark----获取附近跑跑腿我想买订单
- (void)getPPTNeaerbyOrder:(int)mType andMlat:(NSString *)mLat andLng:(NSString *)mLng andPage:(int)mPage andNum:(int)mNum block:(void(^)(mBaseData *resb,NSArray *mArr))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    
    if (mLat) {
        [para setObject:mLat forKey:@"lat"];

    }if (mLng) {
        [para setObject:mLng forKey:@"lng"];

    }
    
    [para setObject:NumberWithInt(mPage) forKey:@"page"];
    [para setObject:NumberWithInt(mNum) forKey:@"rows"];

    
    NSString *mUrl = nil;
    
    if (mType == 1) {
        mUrl = @"app/legwork/user/appOrderBuyList";
    }else if (mType == 2){
        mUrl = @"app/legwork/user/appOrderTransactList";
    }else{
        mUrl = @"app/legwork/user/appOrderCarryList";

    }

    
    [[HTTPrequest sharedHDNetworking] postUrl:mUrl parameters:para call:^(mBaseData *info) {
        
        if (info.mSucess) {
            
            NSMutableArray *tempArr = [NSMutableArray new];
            
            for (NSDictionary *dic in info.mData) {
                [tempArr addObject:[[GPPTOrder alloc] initWithObj:dic]];
            }
            
            block (info,tempArr);
        }else{
            
            block (info,nil);
            
        }
        
    }];
}


#pragma mark----获取买东西 标签
- (void)getReleaseTags:(int)mType block:(void(^)(mBaseData *resb,NSArray *mArr))block{
    
    NSString *mUrl = nil;
    
    if (mType == 1) {
        mUrl = @"app/legwork/user/appBuyType";
    }else if (mType == 2){
    
    }else{
        mUrl = @"app/legwork/user/appGoodsType";
    }
    
    [[HTTPrequest sharedHDNetworking] postUrl:mUrl parameters:nil call:^(mBaseData *info) {
        
        if (info.mSucess) {
            
            NSMutableArray *tempArr = [NSMutableArray new];
            
            for (NSDictionary *dic in info.mData) {
                [tempArr addObject:[[GReleaseTag alloc] initWithObj:dic]];
            }
            
            block (info,tempArr);
        }else{
            
            block (info,nil);
            
        }
        
    }];

}

#pragma mark----添加常用地址
- (void)gPPtaddAddress:(NSString *)mName andSex:(NSString *)mSex andAddress:(NSString *)mAddress andPhone:(NSString *)mPhone andDetailAddress:(NSString *)mDetailAddress andTag:(NSString *)mTag block:(void(^)(mBaseData *resb))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];
    [para setObject:mName forKey:@"userName"];
    [para setObject:mSex forKey:@"sex"];
    [para setObject:mAddress forKey:@"address"];
    [para setObject:mDetailAddress forKey:@"detailsAddr"];
    [para setObject:mPhone forKey:@"phone"];
    [para setObject:mTag forKey:@"addrTagId"];
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/legwork/user/appUserAddr" parameters:para call:^(mBaseData *info) {

        if (info.mSucess) {
            block (info );
        }else{
            block (info );
        }
        
    }];


}
#pragma mark----发布跑单
- (void)releasePPTorder:(int)mType andTagId:(NSString *)mTagId andMin:(NSString *)mMin andMAx:(NSString *)mMax andLat:(NSString *)mLat andLng:(NSString *)mLng andContent:(NSString *)mContent andMoney:(NSString *)mMoney andAddress:(NSString *)mAddress andPhone:(NSString *)mPhone andNote:(NSString *)mNote andArriveTime:(NSString *)mTime block:(void(^)(mBaseData *resb))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    
    [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];
    [para setObject:mContent forKey:@"context"];
    [para setObject:mMoney forKey:@"legworkMoney"];
    [para setObject:mNote forKey:@"comments"];
    [para setObject:mPhone forKey:@"phone"];
    [para setObject:mLng forKey:@"lng"];
    [para setObject:mLat forKey:@"lat"];
    [para setObject:mTime forKey:@"arrivedTime"];
    
    NSString *mUrlStr = nil;
    
    if (mType == 1) {
        mUrlStr = @"app/legwork/user/appOrderBuy";
        
        [para setObject:mMin forKey:@"startPrice"];
        [para setObject:mMax forKey:@"maxPrice"];
        [para setObject:mAddress forKey:@"arrivedId"];
        [para setObject:mTagId forKey:@"orderType"];

    }else if (mType == 2) {
        mUrlStr = @"app/legwork/user/appOrderTransact";
        [para setObject:mAddress forKey:@"address"];


    }else{
        mUrlStr = @"app/legwork/user/appOrderCarry";

    }
    [para setObject:NumberWithInt([mUserInfo backNowUser].mCommunityId) forKey:@"community_id"];
    
    [[HTTPrequest sharedHDNetworking] postUrl:mUrlStr parameters:para call:^(mBaseData *info) {
        
        if (info.mSucess) {
            block (info );
        }else{
            block (info );
        }
        
    }];
    
    
}


- (void)releasePPTSendorder:(int)mType andTagId:(NSString *)mTagId andMin:(NSString *)mMin andMAx:(NSString *)mMax andLat:(NSString *)mLat andLng:(NSString *)mLng andContent:(NSString *)mContent andMoney:(NSString *)mMoney andAddress:(NSString *)mAddress andPhone:(NSString *)mPhone andNote:(NSString *)mNote andArriveTime:(NSString *)mTime andGoodsName:(NSString *)mGoodsName andGoodsPrice:(NSString *)mGoodsPrice andSendAddress:(NSString *)mSendAddress andArriveAddress:(NSString *)mArriveAddress andTool:(NSString *)mTool block:(void(^)(mBaseData *resb))block{

    
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    
    [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];
    [para setObject:mGoodsName forKey:@"goodsName"];
    [para setObject:mMoney forKey:@"legworkMoney"];
    [para setObject:mTagId forKey:@"goodsTypeId"];
    [para setObject:mGoodsPrice forKey:@"goodsPrice"];

    [para setObject:mSendAddress forKey:@"sendAddress"];
    [para setObject:mArriveAddress forKey:@"arrivedAddress"];
    [para setObject:mPhone forKey:@"phone"];
    [para setObject:mTool forKey:@"trafficId"];

    [para setObject:mNote forKey:@"comments"];
    [para setObject:mLng forKey:@"lng"];
    [para setObject:mLat forKey:@"lat"];

    [[HTTPrequest sharedHDNetworking] postUrl:@"app/legwork/user/appOrderCarry" parameters:para call:^(mBaseData *info) {
        
        if (info.mSucess) {
            block (info );
        }else{
            block (info );
        }
        
    }];

}


#pragma mark----获取订单详情
- (void)getOrderDetail:(int)mType andMorderID:(NSString *)mOrderId andOrderCode:(NSString *)mOrderCode block:(void(^)(mBaseData *resb,GPPTOrder *mOrder))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    
    [para setObject:mOrderId forKey:@"id"];
    [para setObject:mOrderCode forKey:@"orderCode"];
    NSString *mUrlStr = nil;

    if (mType == 1) {

        mUrlStr = @"app/legwork/user/appOrderBuyInfo";

    }else if (mType == 2) {

        mUrlStr = @"app/legwork/user/appOrderTransactInfo";

        
    }else{
        mUrlStr = @"app/legwork/user/appOrderCarryInfo";
        
    }

    
    [[HTTPrequest sharedHDNetworking] postUrl:mUrlStr parameters:para call:^(mBaseData *info) {
        
        if (info.mSucess) {
            
            GPPTOrder *mOrder = [[GPPTOrder alloc] initWithObj:info.mData];
            
            block (info ,mOrder);
        }else{
            block (info ,nil);
        }
        
    }];
}
#pragma mark----获取跑跑腿个人信息
- (void)getPPTPersonMsg:(void(^)(mBaseData *resb))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    
    [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"legworkUserId"];
    
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/legwork/service/user/queryUserInfo" parameters:para call:^(mBaseData *info) {
        
        if (info.mSucess) {
            
            
            block (info );
        }else{
            block (info );
        }
        
    }];

    
    
}

- (void)getPPTRoll:(int)mPage andNum:(int)mNum block:(void(^)(mBaseData *resb,NSArray *mArr))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
//    [para setObject:NumberWithInt([GPPTer backPPTUser].mPPTerId) forKey:@"legworkUserId"];
    [para setObject:NumberWithInt(mPage) forKey:@"pageNumber"];
    [para setObject:NumberWithInt(10) forKey:@"pageSize"];

    [[HTTPrequest sharedHDNetworking] postUrl:@"app/legwork/service/user/rankingList" parameters:para call:^(mBaseData *info) {
        
        if (info.mSucess) {
            
            NSMutableArray *tempArr = [NSMutableArray new];
            
            for (NSDictionary *dic in [info.mData objectForKeyMy:@"list"]) {
                [tempArr addObject:[[GPPTRankList alloc] initWithObj:dic]];
            }
            
            block (info ,tempArr);
        }else{
            block (info ,nil);
        }
        
    }];
}


- (void)getTool:(void(^)(mBaseData *resb,NSArray *mArr))block{

    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/legwork/user/appTrafficMethod" parameters:nil call:^(mBaseData *info) {
        
        if (info.mSucess) {
            
            NSMutableArray *tempArr = [NSMutableArray new];
            
            for (NSDictionary *dic in info.mData) {
                [tempArr addObject:[[GPPTools alloc] initWithObj:dic]];
            }
            
            block (info ,tempArr);
        }else{
            block (info ,nil);
        }
        
    }];

}

- (void)getPPTOrderHisTory:(int)mLeft andRight:(int)mRight and:(int)mPage andNum:(int)mNum block:(void(^)(mBaseData *resb,NSArray *mArr))block{
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mPage) forKey:@"page"];
    [para setObject:NumberWithInt(mNum) forKey:@"rows"];

    NSString *mUrl = nil;
    
    if (mLeft == 1) {
        [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];

        if (mRight == 1) {
            mUrl = @"app/legwork/user/appOrderBuyRecord";
        }else if (mRight == 2){
            mUrl = @"app/legwork/user/appOrderTransactRecord";

        }else{
            mUrl = @"app/legwork/user/appOrderCarryRecord";

        }
    }else{
        [para setObject:NumberWithInt([mUserInfo backNowUser].mLegworkUserId) forKey:@"legId"];

        if (mRight == 1) {
            mUrl = @"app/legwork/user/appOrderBuyLegwrokRecord";
        }else if (mRight == 2){
            mUrl = @"app/legwork/user/appOrderTransactLegwrokRecord";
            
        }else{
            mUrl = @"app/legwork/user/appOrderCarryLegwrokRecord";
            
        }
    }
    
    
    [[HTTPrequest sharedHDNetworking] postUrl:mUrl parameters:para call:^(mBaseData *info) {
        
        if (info.mSucess) {
            
            NSMutableArray *tempArr = [NSMutableArray new];
            
            for (NSDictionary *dic in info.mData) {
                [tempArr addObject:[[GPPTOrder alloc] initWithObj:dic]];
            }
            
            block (info ,tempArr);
        }else{
            block (info ,nil);
        }
        
    }];
    
  
}


- (void)applePPT:(NSString *)mName andSex:(NSString *)mSex andPhone:(NSString *)mPhone andIdentify:(NSString *)mIdentify andHandImg:(NSString *)mHandImg andForntImg:(NSString *)mFrontImg andForwordImg:(NSString *)mForwordImg block:(void(^)(mBaseData *resb))block{

    NSMutableDictionary *para = [NSMutableDictionary new];

    [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];
    [para setObject:mName forKey:@"realName"];
    [para setObject:mSex forKey:@"realSex"];
    [para setObject:mPhone forKey:@"realTel"];
    [para setObject:mIdentify forKey:@"cardID"];
    [para setObject:NumberWithFloat(100) forKey:@"money"];
    [para setObject:mHandImg forKey:@"persons"];
    [para setObject:mFrontImg forKey:@"cardFace"];
    [para setObject:mForwordImg forKey:@"cardBack"];

    [[HTTPrequest sharedHDNetworking] postUrl:@"app/legwork/service/auth/legworkRegUser" parameters:para call:^(mBaseData *info) {
        
        if (info.mSucess) {
            
            block (info );
        }else{
            block (info );
        }
        
    }];

    

}
- (void)payPPTAplly:(void(^)(mBaseData *resb))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    
    [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];
    [para setObject:NumberWithInt(100) forKey:@"money"];
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/legwork/service/auth/depositPay" parameters:para call:^(mBaseData *info) {
        
        if (info.mSucess) {
            
            block (info );
        }else{
            block (info );
        }
        
    }];

}

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
- (void)getPPTOrder:(int)mLegUserId andOrderCode:(NSString *)mOrderCode andOrderType:(NSString *)mOrderType andLat:(NSString *)mLat andLng:(NSString *)mLng block:(void(^)(mBaseData *resb))block{


    NSMutableDictionary *para = [NSMutableDictionary new];
    
    [para setObject:NumberWithInt(mLegUserId) forKey:@"legworkUserId"];
    [para setObject:mOrderCode forKey:@"orderCode"];
    [para setObject:mOrderType forKey:@"orderType"];
    [para setObject:mLat forKey:@"lat"];
    [para setObject:mLng forKey:@"lon"];

    [[HTTPrequest sharedHDNetworking] postUrl:@"app/legwork/service/order/grabOrder" parameters:para call:^(mBaseData *info) {
        
        if (info.mSucess) {
            
            block (info );
        }else{
            block (info );
        }
        
    }];
    
}
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
- (void)cancelOrder:(int)mUserId andOrderCode:(NSString *)mOrderCode andOrderType:(int)mOrderType andLat:(NSString *)mLat andLng:(NSString *)mLng block:(void(^)(mBaseData *resb))block{
    
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mUserId) forKey:@"userId"];
    [para setObject:NumberWithInt(mOrderType) forKey:@"orderType"];
    [para setObject:mOrderCode forKey:@"orderCode"];
    
    [para setObject:mLat forKey:@"lat"];
    [para setObject:mLng forKey:@"lon"];
    
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/legwork/user/appOrderCancel" parameters:para call:^(mBaseData *info) {
        
        
        if (info.mSucess) {
            
            block (info);
            
        }else{
            
            block (info);
        }
    }];
    
    
    
}
#pragma mark----获取系统标签
/**
 *  获取系统标签
 *
 *  @param block 返回值
 */
- (void)getSystemTags:(void(^)(mBaseData *resb,NSArray *mArr))block{

    [[HTTPrequest sharedHDNetworking] postUrl:@"app/legwork/user/appSysTag" parameters:nil call:^(mBaseData *info) {
        
        if (info.mSucess) {
            
            NSMutableArray *tempArr = [NSMutableArray new];
            
            for (NSDictionary *dic in info.mData) {
                [tempArr addObject:[[GSystemTags alloc]initWithObj:dic]];
            }
            
            block (info ,tempArr);
        }else{
            block (info ,nil);
        }
        
    }];
    
    
}


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
- (void)rateOrder:(int)mUserId andLegUserId:(int)mLegId andSpeed:(int)mSpeed andMass:(int)mMass andOrderCode:(NSString *)mOrdeCode andOrderType:(int)mOrderType andContent:(NSString *)mContent andTags:(NSString *)mTags block:(void(^)(mBaseData *resb))block{

    
    NSMutableDictionary *para = [NSMutableDictionary new];

    [para setObject:NumberWithInt(mUserId) forKey:@"userId"];
    [para setObject:NumberWithInt(mLegId) forKey:@"legworkUserId"];
    
    [para setObject:mOrdeCode forKey:@"orderCode"];
    [para setObject:NumberWithInt(mOrderType) forKey:@"orderType"];
    
    [para setObject:NumberWithInt(mSpeed) forKey:@"speed"];
    [para setObject:NumberWithInt(mMass) forKey:@"quality"];
    
    [para setObject:mTags forKey:@"tags"];
    [para setObject:mContent forKey:@"content"];
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/legwork/user/appEvaluate" parameters:para call:^(mBaseData *info) {
        
        if (info.mSucess) {
         
            
            block (info );
        }else{
            block (info );
        }
        
    }];
    
    
    
}

#pragma mark----获取投诉标签
/**
 *  获取投诉标签
 *
 *  @param block 返回值
 */
- (void)getFeedBackTags:(void(^)(mBaseData *resb,NSArray *mArr))block{
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/legwork/user/appTreaty" parameters:nil call:^(mBaseData *info) {
        
        if (info.mSucess) {
            
            NSMutableArray *tempArr = [NSMutableArray new];
            
            for (NSDictionary *dic in info.mData) {
                [tempArr addObject:[[GFeedTags alloc] initWithObj:dic]];
            }
            
            
            block (info ,tempArr);
        }else{
            block (info ,nil);
        }
        
    }];
    
    
}
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
- (void)feedBackOrder:(int)mUserId andLegUserId:(int)mLegId andContent:(NSString *)mContent andFeedTagId:(int)mTagId andOrderType:(int)mOrderType andOrderCode:(NSString *)mOrderCode andImags:(NSString *)mImages block:(void(^)(mBaseData *resb))block{

    
    
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    
    [para setObject:NumberWithInt(mUserId) forKey:@"userId"];
    [para setObject:NumberWithInt(mLegId) forKey:@"legworkUserId"];
    
    [para setObject:mOrderCode forKey:@"orderCode"];
    [para setObject:NumberWithInt(mOrderType) forKey:@"orderType"];
    
    [para setObject:NumberWithInt(mTagId) forKey:@"treatyId"];
    [para setObject:mContent forKey:@"content"];
    
    if (mImages) {
        [para setObject:mImages forKey:@"url"];
    }
    
    
    
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/legwork/user/appComplaints" parameters:para call:^(mBaseData *info) {
        
        if (info.mSucess) {
            
            
            block (info );
        }else{
            block (info );
        }
        
    }];

    
}
#pragma mark----实名认证 获取小区
/**
 *  实名认证 获取小区
 *
 *  @param block 返回值
 */
- (void)getCodeArear:(NSString *)mProvinceId andArearId:(NSString *)mArearId andCityId:(NSString *)mCityId andName:(NSString *)mName andLat:(NSString *)mLat andLng:(NSString *)mLng block:(void(^)(mBaseData *resb,NSArray *mArr))block{

    
    NSMutableDictionary *para = [NSMutableDictionary new];
    
    [para setObject:mProvinceId forKey:@"provinceId"];
    [para setObject:mArearId forKey:@"cityId"];
    [para setObject:mCityId forKey:@"countyId"];
    
    if (mLat) {
        [para setObject:mLat forKey:@"lat"];
    }
    if (mLng) {
        [para setObject:mLng forKey:@"lng"];
    }
    
    if (mName) {
        [para setObject:mName forKey:@"name"];
    }
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/communityCenter/verificationCell" parameters:para call:^(mBaseData *info) {
        
        if (info.mSucess) {
            
            NSMutableArray *tempArr = [NSMutableArray new];
            
            for (NSDictionary *dic in info.mData) {
                [tempArr addObject:[[GGetArear alloc] initWithObj:dic]];
            }
            
            block (info ,tempArr);
        }else{
            block (info ,nil);
        }
        
    }];
    
    
    
}

#pragma mark----更新跑跑腿用户状态接口
/**
 *  更新跑跑腿用户状态接口
 *
 *  @param mLat  纬度
 *  @param mLng  经度
 *  @param block 返回值
 */
- (void)ipDataPPTUserStatus:(NSString *)mLat andLng:(NSString *)mLng block:(void(^)(mBaseData *resb))block{
    
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    
    [para setObject:NumberWithInt([mUserInfo backNowUser].mLegworkUserId) forKey:@"legworkUserId"];
    
    if (mLat) {
        [para setObject:mLat forKey:@"lat"];
    }
    if (mLng) {
        [para setObject:mLng forKey:@"lng"];
    }
    
    [para setObject:@"1" forKey:@"isOnline"];
    [para setObject:@"1" forKey:@"device"];

    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/legwork/service/user/updateUserState" parameters:para call:^(mBaseData *info) {
        
        if (info.mSucess) {
            
            
            block (info );
        }else{
            block (info );
        }
        
    }];

    
}


#pragma mark----获取物管费历史纪录
/**
 *  获取物管费历史纪录
 *
 *  @param block 返回值
 */
- (void)getCanelHistory:(int)mPage block:(void(^)(mBaseData *resb,NSArray *mArr))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    
    [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];
    [para setObject:NumberWithInt(mPage) forKey:@"pageIndex"];
    [para setObject:NumberWithInt(10) forKey:@"pageSize"];

    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/propertyCost/findHistoryPropertyCost" parameters:para call:^(mBaseData *info) {
        
        if (info.mSucess) {
            
            NSMutableArray *tempArr = [NSMutableArray new];
            
        
            
            for (NSDictionary *dic in [info.mData objectForKey:@"propertyCostHistory"]) {
                
                [tempArr addObject:[[GCanal alloc] initWithObj:dic]];
            }

            
            
            block (info,tempArr );
        }else{
            block (info, nil );
            
        }
        
    }];
    
    
}

#pragma mark----获取消息列表
/**
 *  获取消息列表
 *
 *  @param mPage 分页
 *  @param block 返回值
 */
- (void)getMsgList:(int)mPage block:(void(^)(mBaseData *resb,NSArray *mArr))block{

    
    NSMutableDictionary *para = [NSMutableDictionary new];
    
    [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];
    [para setObject:NumberWithInt(mPage) forKey:@"pageNumber"];
    [para setObject:NumberWithInt(10) forKey:@"pageSize"];
    

    [[HTTPrequest sharedHDNetworking] postUrl:@"app/msg/queryUserMsg" parameters:para call:^(mBaseData *info) {
        
        if (info.mSucess) {
            
            NSMutableArray *tempArr = [NSMutableArray new];
            
            
            
            for (NSDictionary *dic in [info.mData objectForKey:@"list"]) {
                
                [tempArr addObject:[[GMsgObj alloc] initWithObj:dic]];
            }
            
            
            
            block (info,tempArr );
        }else{
            block (info, nil );
            
        }
        
    }];
    

    
}


#pragma mark----读消息
/**
 *  读消息
 *
 *  @param mId   消息id
 *  @param block 返回值
 */
- (void)readMsg:(int)mId block:(void(^)(mBaseData *resb))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    
    [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];
    [para setObject:NumberWithInt(mId) forKey:@"id"];
    
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/msg/readMsgInfo" parameters:para call:^(mBaseData *info) {
        
        if (info.mSucess) {
            block (info );
        }else{
            block (info );
            
        }
        
    }];
    
    
    
}

#pragma mark----删除消息
/**
 *  删除消息
 *
 *  @param mId   消息id
 *  @param block 返回值
 */
- (void)deleteMsg:(int)mId block:(void(^)(mBaseData *resb))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    
    [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];
    [para setObject:NumberWithInt(mId) forKey:@"ids"];
    
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/msg/deleteMsgInfo" parameters:para call:^(mBaseData *info) {
        
        if (info.mSucess) {
            block (info );
        }else{
            block (info );
            
        }
        
    }];
}


@end

@implementation SMessage

-(id)initWithObj:(NSDictionary*)obj
{
    self = [super init];
    
    if( self )
    {
        self.mTitle = [obj objectForKeyMy:@"title"];
        self.mContent = [obj objectForKeyMy:@"content"];
        self.mArgs = [obj objectForKeyMy:@"args"];
        self.mType = [[obj objectForKeyMy:@"type"] intValue];
        self.mId = [[obj objectForKeyMy:@"id"] intValue];
        self.mUserId = [[obj objectForKeyMy:@"userId"] intValue];
        self.mIsLook = [[obj objectForKeyMy:@"isLook"] boolValue];
        self.mCreateTime = [obj objectForKeyMy:@"addTime"];
    }
    
    return self;
}

+ (void)getMsgNum:(int)mUserId andIsLook:(int)mIsLook andType:(NSString *)mType block:(void (^)(mBaseData *))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mUserId) forKey:@"userId"];
    [para setObject:NumberWithInt(mIsLook) forKey:@"isLook"];
    [para setObject:mType forKey:@"type"];
    [[HTTPrequest sharedHDNetworking] postUrl:@"front/personal/informationCount.do" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
        }else{
        
        }
    }];
}
@end

@implementation SRedBag

-(id)initWithObj:(NSDictionary*)obj
{
    self = [super init];
    if( self )
    {
        [self fetch:obj];
    }
    return self;
}
-(void)fetch:(NSDictionary*)obj
{
    self.mId = [[obj objectForKeyMy:@"id"] intValue];
    self.mUserId = [[obj objectForKeyMy:@"userId"] intValue];
    self.mType = [obj objectForKeyMy:@"type"];
    self.mMoney = [[obj objectForKeyMy:@"money"] floatValue];
    self.mCreateTime = [obj objectForKeyMy:@"getTime"];
    self.mName = [obj objectForKeyMy:@"nick_name"];
}

@end

@implementation SVerifyMsg


- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self )
    {
        [self fetch:obj];
    }
    return self;
}
-(void)fetch:(NSDictionary*)obj
{

    self.mCompanyName = [obj objectForKeyMy:@"companyName"];
    self.mVillageName = [obj objectForKeyMy:@"villageName"];
    self.mBuildName = [obj objectForKeyMy:@"buildName"];
    self.mDoorNumber = [obj objectForKeyMy:@"buildNumber"];
    self.mProvince = [obj objectForKeyMy:@"province"];
    self.mCity = [obj objectForKeyMy:@"city"];
    self.cId = [[obj objectForKeyMy:@"cId"] intValue];
    
    
    
    self.mBankCard = [obj objectForKeyMy:@"bankCard"];
    self.mBankName = [obj objectForKeyMy:@"bankName"];
    self.mBankCity = [obj objectForKeyMy:@"bankCity"];
    self.mBankProvince = [obj objectForKeyMy:@"bankProvince"];
    self.mCard = [obj objectForKeyMy:@"card"];
    self.mReal_name = [obj objectForKeyMy:@"real_name"];
    self.mWebsite = [obj objectForKeyMy:@"website"];
    self.mCommunityName = [obj objectForKeyMy:@"communityName"];
    self.mAddr = [obj objectForKeyMy:@"addr"];

    
    
}

@end

@implementation SSellerList

-(id)initWithObj:(NSDictionary*)obj{
    self = [super init];
    if( self )
    {
        [self fetch:obj];
    }
    return self;
}
-(void)fetch:(NSDictionary*)obj
{
    self.mId = [[obj objectForKeyMy:@"id"] intValue];
    self.mSellerName = [obj objectForKeyMy:@"merchantName"];
    self.mSellerPhone = [obj objectForKeyMy:@"merchantPhone"];
    self.mEvolution = [[obj objectForKeyMy:@"praiseRate"] floatValue];
    self.mDistance = [[obj objectForKeyMy:@"distance"] floatValue];
    self.mSellerImg = [obj objectForKeyMy:@"merchantImage"];
    
}

@end
@implementation MBaner

-(id)initWithObj:(NSDictionary*)obj{
    self = [super init];
    if( self )
    {
        [self fetch:obj];
    }
    return self;
}
-(void)fetch:(NSDictionary*)obj
{
    self.mImgUrl = [NSString stringWithFormat:@"%@%@",[HTTPrequest currentResourceUrl],[obj objectForKeyMy:@"img"]];
    
    self.mContentUrl = [obj objectForKeyMy:@"url"];
    self.mName = [obj objectForKeyMy:@"name"];
    self.mB_index = [[obj objectForKeyMy:@"b_index"] intValue];
}

@end


@implementation GPPTBaner

-(id)initWithObj:(NSDictionary*)obj{
    self = [super init];
    if( self )
    {
        [self fetch:obj];
    }
    return self;
}
-(void)fetch:(NSDictionary*)obj
{
    self.mImgUrl = [NSString stringWithFormat:@"%@%@",[HTTPrequest currentResourceUrl],[obj objectForKeyMy:@"img"]];
    
    self.mContentUrl = [obj objectForKeyMy:@"url"];
    self.mName = [obj objectForKeyMy:@"name"];
    self.mB_index = [[obj objectForKeyMy:@"bIndex"] intValue];
    self.mId = [[obj objectForKeyMy:@"id"] intValue];
    self.mVisite = [[obj objectForKeyMy:@"isVisit"] intValue];
    
    self.mUUID = [obj objectForKeyMy:@"uuid"];
    self.mStatus = [[obj objectForKeyMy:@"state"] intValue];
    
    
    
}

@end

@implementation GFix
-(id)initWithObj:(NSDictionary*)obj{
    self = [super init];
    if( self )
    {
        [self fetch:obj];
    }
    return self;
}
-(void)fetch:(NSDictionary*)obj
{
    self.mClassName = [obj objectForKeyMy:@"classificationName"];
    self.mId = [[obj objectForKeyMy:@"id"] intValue];
    self.mLevel = [[obj objectForKeyMy:@"level"] intValue];
    self.mSuperID = [[obj objectForKeyMy:@"superiorId"] intValue];
    self.mType = [[obj objectForKeyMy:@"type"] intValue];
    
    self.mDescribe = [obj objectForKeyMy:@"describe"];
    
    
    
    self.mSmallImage = [NSString stringWithFormat:@"%@%@",[HTTPrequest currentResourceUrl],[obj objectForKeyMy:@"minImage"]];
    self.mBigImage = [NSString stringWithFormat:@"%@%@",[HTTPrequest currentResourceUrl],[obj objectForKeyMy:@"maxImage"]];

    self.mEstimatedPrice = [obj objectForKeyMy:@"estimatedPrice"];


}


@end

@implementation SServicer

-(id)initWithObj:(NSDictionary*)obj{
    self = [super init];
    if( self )
    {
        [self fetch:obj];
    }
    return self;
}
-(void)fetch:(NSDictionary*)obj
{
    self.mAddress = [obj objectForKeyMy:@"address"];
    
    float distance = [[obj objectForKeyMy:@"distance"] floatValue];
    
    
    
    self.mDistance = [NSString stringWithFormat:@"%.2fkm",distance/1000];
    
    self.mId = [[obj objectForKeyMy:@"id"] intValue];
    self.mMerchantName  = [obj objectForKeyMy:@"merchantName"];
    self.mMerchantImage = [obj objectForKeyMy:@"merchantImage"];
    self.mMerchantPhone = [obj objectForKeyMy:@"merchantPhone"];
    self.mPraiseRate = [[obj objectForKeyMy:@"praiseRate"] intValue];

    
    
    
}


@end

@implementation GFixOrder

-(id)initWithObj:(NSDictionary*)obj{
    self = [super init];
    if( self )
    {
        [self fetch:obj];
    }
    return self;
}
-(void)fetch:(NSDictionary*)obj
{
    
    self.mAppointmentTime = [obj objectForKeyMy:@"appointmentTime"];
    self.mBuyerAddress = [obj objectForKeyMy:@"buyerAddress"];
    self.mClassificationName = [obj objectForKeyMy:@"classificationName"];
    self.mMerchantName = [obj objectForKeyMy:@"merchantName"];
    self.mNote = [obj objectForKeyMy:@"note"];
    self.mOrderId = [[obj objectForKeyMy:@"orderId"] intValue];
    self.mOrderCode = [obj objectForKeyMy:@"orderCode"];
    self.mStatus = [[obj objectForKeyMy:@"status"] intValue];
    self.mPhone = [obj objectForKeyMy:@"phone"];

    self.mAddress = [obj objectForKeyMy:@"addRess"];
    self.mCommunityId = [obj objectForKeyMy:@"communityId"];
    self.mOrderMerchanid = [obj objectForKeyMy:@"merchantId"];
    self.mOrderPrice = [[obj objectForKeyMy:@"price"] floatValue];
    self.mOrderStatus = [obj objectForKeyMy:@"statusName"];
    self.mOrderImage = [obj objectForKeyMy:@"imageUrl"];
    
    self.mClassificationName2 = [obj objectForKeyMy:@"classificationName2"];
    self.mOrderServiceTime = [obj objectForKeyMy:@"appointmentTime"];
    self.mOrderID = [obj objectForKeyMy:@"id"];
    
    self.addTime = [obj objectForKeyMy:@"addTime"];
    self.mDescription = [obj objectForKeyMy:@"description"];
    self.serviceTime = [obj objectForKeyMy:@"serviceTime"];
    self.tel = [obj objectForKeyMy:@"tel"];
    
    
    self.mSerialNumber = [obj objectForKeyMy:@"serialNumber"];
    self.mIntegral = [obj objectForKeyMy:@"integral"];
    self.mRechargeTime = [obj objectForKeyMy:@"rechargeTime"];
    self.mPaymentMethod = [obj objectForKeyMy:@"paymentMethod"];
    
}

@end

@implementation GArear

-(id)initWithObj:(NSDictionary*)obj{
    self = [super init];
    if( self )
    {
        [self fetch:obj];
    }
    return self;
}
-(void)fetch:(NSDictionary*)obj
{
    
    self.mAddress = [obj objectForKeyMy:@"address"];
    self.mId = [[obj objectForKeyMy:@"id"] intValue];

    
}

@end

@implementation GCity

-(id)initWithObj:(NSDictionary*)obj{
    self = [super init];
    if( self )
    {
        [self fetch:obj];
    }
    return self;
}
-(void)fetch:(NSDictionary*)obj
{
    
    self.mAreaName = [obj objectForKeyMy:@"areaName"];
    self.mAreaId = [obj objectForKeyMy:@"areaId"];
    self.mParentId = [obj objectForKeyMy:@"parentId"];

    
}

@end

@implementation  GCommunity

-(id)initWithObj:(NSDictionary*)obj{
    self = [super init];
    if( self )
    {
        [self fetch:obj];
    }
    return self;
}
-(void)fetch:(NSDictionary*)obj
{
    
    self.mCommunityName = [obj objectForKeyMy:@"communityName"];
    self.mPropertyId = [[obj objectForKeyMy:@"id"] intValue];
    self.mAreaName = [obj objectForKeyMy:@"areaName"];
    
}

@end

@implementation GdoorNum

-(id)initWithObj:(NSDictionary*)obj{
    self = [super init];
    if( self )
    {
        [self fetch:obj];
    }
    return self;
}
-(void)fetch:(NSDictionary*)obj
{
    
    self.mFloor = [obj objectForKeyMy:@"floor"];
    self.mRoomNumber = [obj objectForKeyMy:@"roomNumber"];
    self.mUnit = [obj objectForKeyMy:@"unit"];

    
    
}

@end

@implementation GServiceList


-(id)initWithObj:(NSDictionary*)obj{
    self = [super init];
    if( self )
    {
        [self fetch:obj];
    }
    return self;
}
-(void)fetch:(NSDictionary*)obj
{
    
    self.mArray = [obj objectForKeyMy:@"merchantList"];
    self.pageSize = [[obj objectForKeyMy:@"pageSize"] intValue];
    self.pageNumber = [[obj objectForKeyMy:@"pageNumber"] intValue];
    
}

@end


@implementation  GCanalList
-(id)initWithObj:(NSDictionary*)obj{
    self = [super init];
    if( self )
    {
        [self fetch:obj];
    }
    return self;
}
-(void)fetch:(NSDictionary*)obj
{
    
    self.mMoney = [[obj objectForKeyMy:@"money"] floatValue];
    self.mList = [obj objectForKeyMy:@"propertyCostList"];
    
}


@end

@implementation GCanal

-(id)initWithObj:(NSDictionary*)obj{
    self = [super init];
    if( self )
    {
        [self fetch:obj];
    }
    return self;
}
-(void)fetch:(NSDictionary*)obj
{
    
    self.mActualPayment = [[obj objectForKeyMy:@"actualPayment"] floatValue];
    self.mMoney = [[obj objectForKeyMy:@"money"] floatValue];
    self.mPaymentUnit = [obj objectForKeyMy:@"paymentUnit"];
    self.mCommunityId = [[obj objectForKeyMy:@"communityId"] intValue];
    self.mDeadline = [obj objectForKeyMy:@"deadline"];
    self.mUserName = [obj objectForKeyMy:@"userName"];
    self.mPayableMoney = [[obj objectForKeyMy:@"payableMoney"] floatValue];
    self.mPaymentAccount = [obj objectForKeyMy:@"paymentAccount"];
    self.mStatus = [[obj objectForKeyMy:@"status"] intValue];
    
    if (self.mStatus == 1) {
        self.mStatustr = @"已支付";
    }else{
        self.mStatustr = @"未支付";
    }
    
    self.mId = [obj objectForKeyMy:@"id"];
    
}

@end

@implementation JHProvince

-(id)initWithObj:(NSDictionary*)obj{
    self = [super init];
    if( self )
    {
        [self fetch:obj];
    }
    return self;
}
-(void)fetch:(NSDictionary*)obj
{
    
    self.mProvinceId = [obj objectForKeyMy:@"provinceId"];
    self.mProvinceName = [obj objectForKeyMy:@"provinceName"];
    
}

@end

@implementation JHCity

-(id)initWithObj:(NSDictionary*)obj{
    self = [super init];
    if( self )
    {
        [self fetch:obj];
    }
    return self;
}
-(void)fetch:(NSDictionary*)obj
{
    
    self.mProvinceId = [obj objectForKeyMy:@"provinceId"];
    self.mCityName = [obj objectForKeyMy:@"cityName"];
    self.mCityId = [obj objectForKeyMy:@"cityId"];
    
}

@end

@implementation JHPayData

-(id)initWithObj:(NSDictionary*)obj{
    self = [super init];
    if( self )
    {
        [self fetch:obj];
    }
    return self;
}
-(void)fetch:(NSDictionary*)obj
{
    self.mProvinceId = [obj objectForKeyMy:@"provinceId"];
    self.mProvinceName = [obj objectForKeyMy:@"provinceName"];
    self.mCityName = [obj objectForKeyMy:@"cityName"];
    self.mCityId = [obj objectForKeyMy:@"cityId"];
    self.mPayProjectId = [obj objectForKeyMy:@"payProjectId"];
    self.mPayProjectName = [obj objectForKeyMy:@"payProjectName"];
    self.mPayUnitId = [obj objectForKeyMy:@"payUnitId"];
    self.mPayUnitName = [obj objectForKeyMy:@"payUnitName"];

    self.mProductId = [obj objectForKeyMy:@"productId"];
    self.mProductName = [obj objectForKeyMy:@"productName"];
    self.mInprice = [obj objectForKeyMy:@"inprice"];

}

@end

@implementation GOrderCount

-(id)initWithObj:(NSDictionary*)obj{
    self = [super init];
    if( self )
    {
        [self fetch:obj];
    }
    return self;
}
-(void)fetch:(NSDictionary*)obj
{
    self.mOrderNum = [obj objectForKeyMy:@"count"];
    self.mOrderType = [obj objectForKeyMy:@"type"];
    self.mOrderName = [obj objectForKeyMy:@"orderTypeName"];
}

@end

@implementation GScroe
-(id)initWithObj:(NSDictionary*)obj{
    self = [super init];
    if( self )
    {
        [self fetch:obj];
    }
    return self;
}
-(void)fetch:(NSDictionary*)obj
{
    self.mAddTime = [obj objectForKeyMy:@"addTime"];
    self.mConsumerId = [obj objectForKeyMy:@"consumerId"];
    self.mDescribe = [obj objectForKeyMy:@"describe"];

    self.mId = [[obj objectForKeyMy:@"id"] intValue];
    self.mMoney = [[obj objectForKeyMy:@"money"] floatValue];
    self.mPaymentType = [[obj objectForKeyMy:@"paymentType"] intValue];
    self.mScore = [[obj objectForKeyMy:@"score"] intValue];
    self.mType = [[obj objectForKeyMy:@"type"] intValue];
    self.mWid = [[obj objectForKeyMy:@"wid"] intValue];
    self.mRed = [[obj objectForKeyMy:@"red "] intValue];

}


@end

@implementation GCook


-(id)initWithObj:(NSDictionary*)obj{
    self = [super init];
    if( self )
    {
        [self fetch:obj];
    }
    return self;
}
-(void)fetch:(NSDictionary*)obj
{
  
    self.mId = [[obj objectForKeyMy:@"id"] intValue];
    self.mCount = [[obj objectForKeyMy:@"count"] intValue];
    self.mDescription = [obj objectForKeyMy:@"description"];
    self.mFood = [obj objectForKeyMy:@"food"];
    self.mImg = [obj objectForKeyMy:@"img"];
    self.mKeywords = [obj objectForKeyMy:@"keywords"];
    self.mName = [obj objectForKeyMy:@"name"];

    
}
@end

@implementation GAddress

-(id)initWithObj:(NSDictionary*)obj{
    self = [super init];
    if( self )
    {
        [self fetch:obj];
    }
    return self;
}
-(void)fetch:(NSDictionary*)obj
{
    

    self.mAddressName = [obj objectForKeyMy:@"userAddress"];
    self.mAddressId = [NSString stringWithFormat:@"%d",[[obj objectForKeyMy:@"communityId"] intValue]];
    
}


@end

@implementation RCCInfo

static RCCInfo *g_rcc = nil;
bool g_rccbined = NO;

+ (RCCInfo *)backRCCInfo{

    if (g_rcc) {
        return g_rcc;
    }
    if (g_rccbined) {
        MLLog(@"警告！递归错误！");
        return nil;
    }
    g_rccbined = YES;
    
    
    @synchronized (self) {
        if (!g_rcc) {
            g_rcc = [RCCInfo loadRCCInfo];
        }
    }
    g_rccbined = NO;
    return g_rcc;
}

+ (RCCInfo *)loadRCCInfo{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSDictionary* dat = [def objectForKey:@"Rccinfo"];
    if( dat )
    {
        RCCInfo* tu = [[RCCInfo alloc]initWithObj:dat];
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
    
    
    self.mRCCToken = [obj objectForKeyMy:@"token"];
    self.mRCCUserId = [obj objectForKeyMy:@"userId"];
    self.mRCCUserName = [obj objectForKeyMy:@"userName"];
    
}
+ (void)saveRCCInfo:(NSDictionary *)dic{
    dic = [Util delNUll:dic];
    
    NSMutableDictionary *dcc = [[NSMutableDictionary alloc] initWithDictionary:dic];
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    
    [def setObject:dcc forKey:@"Rccinfo"];
    
    
    
    [def synchronize];
}

+ (void)getToken:(NSString *)mType andValue:(NSString *)mValue andUserName:(NSString *)mUserName andPrtraitUri:(NSString *)mHeader block:(void(^)(mBaseData *resb,RCCInfo *mrcc))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mType forKey:@"type"];
    [para setObject:mValue forKey:@"value"];
    [para setObject:mUserName forKey:@"userName"];
    [para setObject:mHeader forKey:@"portraitUri"];
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/rongCloud/appGetToken" parameters:para call:^(mBaseData *info) {
        
        [self dealSession:info block:block];
 
    }];
    
    
}
+ (void)getArearWithRcc:(int)mPage andNum:(int)mNum block:(void(^)(mBaseData *resb,NSArray *mArr))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mNum) forKey:@"pageSize"];
    [para setObject:NumberWithInt(mPage) forKey:@"pageNumber"];
    [para setObject:[RCCInfo backRCCInfo].mRCCUserId forKey:@"userId"];

    
    
    [[HTTPrequest sharedHDNetworking] getUrl:@"app/rongCloud/appGetCommunityUsers" parameters:para call:^(mBaseData *info) {
        
        
        NSMutableArray *tempArr = [NSMutableArray new];
        
        if (info.mSucess) {
            
            for (NSDictionary *dic in [info.mData objectForKeyMy:@"list"]) {
                [tempArr addObject:[[RCCUserInfo alloc] initWithObj:dic]];
            }
            
            block (info ,tempArr);
        }else{
            block (info ,nil);
        }

    }];
}


+ (void)getDistanceWith:(int)mPage andNum:(int)mNum andLat:(NSString *)mLat andLng:(NSString *)mLng block:(void(^)(mBaseData *resb,NSArray *mArr))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mNum) forKey:@"pageSize"];
    [para setObject:NumberWithInt(mPage) forKey:@"pageNumber"];
    [para setObject:[RCCInfo backRCCInfo].mRCCUserId forKey:@"userId"];
    [para setObject:mLng forKey:@"lon"];
    [para setObject:mLat forKey:@"lat"];

    [[HTTPrequest sharedHDNetworking] getUrl:@"app/rongCloud/appGetNearbyUsers" parameters:para call:^(mBaseData *info) {
        
        
        NSMutableArray *tempArr = [NSMutableArray new];
        
        if (info.mSucess) {
            for (NSDictionary *dic in [info.mData objectForKeyMy:@"list"]) {
                [tempArr addObject:[[RCCUserInfo alloc] initWithObj:dic]];
            }
            block (info ,tempArr);
        }else{
            block (info ,nil);
        }
        
    }];
}

#pragma mark----获取融云用户信息
/**
 *  获取融云用户信息
 *
 *  @param mUserId userid
 *  @param block   返回值
 */
+ (void)getUserInfo:(NSString *)mUserId block:(void (^)(mBaseData *resb))block{

    NSMutableDictionary *para = [NSMutableDictionary new];

    [para setObject:mUserId forKey:@"userId"];
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/rongCloud/appGetUserInfo" parameters:para call:^(mBaseData *info) {

        if (info.mSucess) {
        

            block (info);
        }else{
            block ( info );
        }
        
    }];
    
}



+ (void)dealSession:(mBaseData *)info block:(void(^)(mBaseData* resb, RCCInfo*rcc))block{
#warning 返回的数据是整个RCC信息对象
    if ( info.mSucess ) {
        NSDictionary* tmpdic = info.mData;
        
        NSMutableDictionary* tdic = [[NSMutableDictionary alloc]initWithDictionary:info.mData];
        
        RCCInfo* tu = [[RCCInfo alloc]initWithObj:tdic];
        tmpdic = tdic;
        
        [RCCInfo saveRCCInfo:tmpdic];
        
    }
    
    
    block( info , [RCCInfo backRCCInfo] );
    
}

@end

@implementation RCCUserInfo

- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
    
    
    self.totalRow = [obj objectForKeyMy:@"totalRow"];
    self.pageNumber = [obj objectForKeyMy:@"pageNumber"];
    self.totalPage = [obj objectForKeyMy:@"totalPage"];
    self.pageSize = [obj objectForKeyMy:@"pageSize"];
    self.userId = [obj objectForKeyMy:@"userId"];
    self.userName = [obj objectForKeyMy:@"userName"];
    self.portraitUri = [obj objectForKeyMy:@"portraitUri"];
    self.mList = [obj objectForKeyMy:@"list"];
    
    self.distance = [obj objectForKeyMy:@"distance"];
}

@end

@implementation SWxPayInfo
-(id)initWithObj:(NSDictionary*)obj
{
    self = [super init];
    if( self && obj )
    {
        self.mPayType = [obj objectForKeyMy:@"type"];
        self.noncestr = [obj objectForKeyMy:@"nonce_str"];
        self.out_trade_no = [obj objectForKeyMy:@"out_trade_no"];
        self.prepayid = [obj objectForKeyMy:@"prepay_id"];
        self.mtimeStamp = [[obj objectForKeyMy:@"timeStamp"] intValue];
        self.partnerid = [obj objectForKeyMy:@"partnerid"];
        
        self.package = @"Sign=WXPay";
        self.appid = [obj objectForKeyMy:@"appid"];
        
        self.sign = [obj objectForKeyMy:@"sign"];
        
        
        
//        self.sign = [Util getMd5_32Bit:[NSString stringWithFormat:@"appid=%@&noncestr=%@&package=%@&partnerid=%@&prepayid=%@&timestamp=%d&key=%@",WXPAYKEY,[obj objectForKeyMy:@"nonce_str"],@"Sign=WXPay",[obj objectForKeyMy:@"partnerid"],[obj objectForKeyMy:@"prepay_id"],[[obj objectForKeyMy:@"timeStamp"] intValue],@"CHAOer68190809PAYCHAOer68190809P"]];
        
        MLLog(@"sig:%@",self.sign);
    }
    return self;
}


@end

@implementation GCommunityClass

- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
    

    self.mId = [[obj objectForKeyMy:@"id"] intValue];
    self.mName = [obj objectForKeyMy:@"typeName"];
    
}

@end

@implementation GCommunityNews

- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
    
    
    self.mId = [[obj objectForKeyMy:@"id"] intValue];
    self.mContent = [obj objectForKeyMy:@"content"];
    self.mDateTime = [obj objectForKeyMy:@"dateTime"];
    self.mNewsImage = [NSString stringWithFormat:@"%@%@",[HTTPrequest currentResourceUrl],[obj objectForKeyMy:@"newsImage"]];
    self.mNewTypeId = [[obj objectForKeyMy:@"newsTypeId"] intValue];
    self.mSource = [obj objectForKeyMy:@"source"];
    
    self.mStatus = [[obj objectForKeyMy:@"state"] intValue];
    self.mSubContent = [obj objectForKeyMy:@"subContent"];
    self.mTitel = [obj objectForKeyMy:@"title"];
    self.mTypeName = [obj objectForKeyMy:@"type_name"];
    self.mWriter = [obj objectForKeyMy:@"writer"];
    
    self.mSubTitel = [obj objectForKeyMy:@"subTitle"];
    
}

@end

@implementation GPPTaddress

- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
    
    self.mId = [[obj objectForKeyMy:@"id"] intValue];
    self.mAddress = [obj objectForKeyMy:@"address"];
    self.mAddressName = [obj objectForKeyMy:@"addrName"];
    self.mAlternativePhone = [obj objectForKeyMy:@"alternativePhone"];
    self.mPhone = [obj objectForKeyMy:@"phone"];
    self.mDetailsAddr = [obj objectForKeyMy:@"detailsAddr"];
    self.mUserId = [obj objectForKeyMy:@"userId"];
    self.mUserSex = [obj objectForKeyMy:@"userSex"];
    self.mUserName = [obj objectForKeyMy:@"userName"];


}

@end
#pragma mark----标签对象
@implementation GPPTaddressTag

- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
    
    self.mId = [[obj objectForKeyMy:@"id"] intValue];
    self.mTagName = [obj objectForKeyMy:@"addrName"];
    
}


@end

@implementation GReleaseTag

- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
    
    self.mId = [[obj objectForKeyMy:@"id"] intValue];
    self.mTagName = [obj objectForKeyMy:@"typeName"];
    self.mTypeName = [obj objectForKeyMy:@"typeName"];
}




@end

@implementation GPPTOrder

- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
    
    self.mId = [[obj objectForKeyMy:@"id"] intValue];

    self.mUserId = [obj objectForKeyMy:@"userId"];
    self.mArrivedTime = [obj objectForKeyMy:@"arrivedTime"];
    self.mContext = [obj objectForKeyMy:@"context"];
    self.mDistance = [obj objectForKeyMy:@"distance"];
    self.mGenTime = [obj objectForKeyMy:@"genTime"];
    self.mLegworkMoney = [obj objectForKeyMy:@"legworkMoney"];
    self.mMaxPrice = [obj objectForKeyMy:@"maxPrice"];
    self.mOrderCode = [obj objectForKeyMy:@"orderCode"];
    self.mStartPrice = [obj objectForKeyMy:@"startPrice"];
    self.mAdress = [obj objectForKeyMy:@"address"];
    self.mGoodsName = [obj objectForKeyMy:@"goodsName"];
    self.mGoodsPrice = [obj objectForKeyMy:@"goodsPrice"];
    self.mComments = [obj objectForKeyMy:@"comments"];
    self.mStatusName = [obj objectForKeyMy:@"statusName"];
    
    
    
    self.mPhone = [obj objectForKeyMy:@"phone"];
    self.mPortrait = [obj objectForKeyMy:@"portrait"];
    self.mTypeName = [obj objectForKeyMy:@"typeName"];
    self.mAddrName = [obj objectForKeyMy:@"addrName"];
    self.mSId = [[obj objectForKeyMy:@"sId"] intValue];
    self.mProcessStatus = [[obj objectForKeyMy:@"processStatus"] intValue];
    self.mStatusCommet = [obj objectForKeyMy:@"statusCommet"];
    self.mUserSex = [obj objectForKeyMy:@"userSex"];
    self.mUserName = [obj objectForKeyMy:@"userName"];
    
    int kake = [[obj objectForKeyMy:@"isTake"] intValue];
    
    if (kake == 0) {
        self.mIsTake = NO;
    }else{
        self.mIsTake = YES;
    }
    self.mSendAddress = [obj objectForKeyMy:@"sendAddress"];
    self.mArrivedAddress = [obj objectForKeyMy:@"arrivedAddress"];
    self.mTrafficName = [obj objectForKeyMy:@"trafficName"];
    self.mGoodsTypeName = [obj objectForKeyMy:@"goodsTypeName"];
    self.mPayType = [[obj objectForKeyMy:@"payMethod"] intValue];


}

@end

@implementation GPPTer
static GPPTer *pptuser = nil;
bool pptbined = NO;

+ (GPPTer *)backPPTUser{
    if (pptuser) {
        return pptuser;
    }
    if (pptbined) {
        MLLog(@"警告！递归错误！");
        return nil;
    }
    pptbined = YES;
    @synchronized (self) {
        if (!pptuser) {
            pptuser = [GPPTer loadpptUserInfo];
        }
    }
    pptbined = NO;
    return pptuser;
}
+(GPPTer*)loadpptUserInfo
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSDictionary* dat = [def objectForKey:@"pptuserInfo"];
    if( dat )
    {
        GPPTer* tu = [[GPPTer alloc]initWithObj:dat];
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
    
    self.mUserId = [[obj objectForKeyMy:@"user_id"] intValue];
    self.mPPTerId = [mUserInfo backNowUser].mLegworkUserId;
    self.mLevel = [obj objectForKeyMy:@"user_level"];
    self.mFAQUrl = [obj objectForKeyMy:@"url"];
    self.mName = [obj objectForKeyMy:@"real_name"];
    self.mInfoId = [obj objectForKeyMy:@"info_id"];
    
    self.mRateNum = [obj objectForKeyMy:@"praise_num"];
    
    int mCancel = [[obj objectForKeyMy:@"is_cancel"] intValue];
    if (mCancel == 0) {
        self.mIscancel = NO;
    }else{
        self.mIscancel = YES;
    }
    
    mCancel = [[obj objectForKeyMy:@"is_off"] intValue];
    if (mCancel == 0) {
        self.mIsOff = NO;
    }else{
        self.mIsOff = YES;
    }
    
    
    self.mFeedNum = [obj objectForKeyMy:@"complaints_count"];
    
    self.mHeaderImg = [obj objectForKeyMy:@"portrait"];
    
    self.mTotleMoney = [obj objectForKeyMy:@"pile_money"];
    
    self.mCreateTime = [obj objectForKeyMy:@"gen_time"];
    
    self.mGetOrderNum = [obj objectForKeyMy:@"order_take_num"];
    
    self.mDepositMoney = [obj objectForKeyMy:@"legwork_deposit"];

    
    
    self.mGoodRateCount = [[obj objectForKeyMy:@"high_evaluate"] intValue];
    self.mMidRateCount = [[obj objectForKeyMy:@"medium_evaluate"] intValue];
    self.mBadRatecount = [[obj objectForKeyMy:@"bad_evaluate"] intValue];
    
    
    
    self.mTotleRateCount = self.mBadRatecount + self.mGoodRateCount + self.mMidRateCount;

    
    self.mPhone =[obj objectForKeyMy:@"phone"];
    
}
- (BOOL)isVaildpptUser{
    return YES;
}

+ (void)getPPTerInfo:(int)mUserId block:(void (^)(mBaseData *resb, GPPTer *mUser))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mUserId) forKey:@"userId"];
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/legwork/service/user/queryUser" parameters:para call:^(mBaseData *info) {
        
        [self dealpptUserSession:info block:block];
    }];

    
}
+(void)dealpptUserSession:(mBaseData*)info block:(void(^)(mBaseData* resb, GPPTer*user))block{

#warning 返回的数据是整个用户信息对象
    if ( info.mSucess || info.mState == 200011) {
        NSDictionary* tmpdic = info.mData;
        
        NSMutableDictionary* tdic = [[NSMutableDictionary alloc]initWithDictionary:info.mData];
        
        GPPTer* tu = [[GPPTer alloc]initWithObj:tdic];
        tmpdic = tdic;
        if ([tu isVaildpptUser]) {
            [GPPTer savepptUserInfo:tmpdic];
            pptuser = nil;
            
        }
        
        
        
    }
    
    
    block( info , [GPPTer backPPTUser] );
}
+(void)savepptUserInfo:(NSDictionary *)dccat{
    dccat = [Util delNUll:dccat];
    
    NSMutableDictionary *dcc = [[NSMutableDictionary alloc] initWithDictionary:dccat];
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    
    [def setObject:dcc forKey:@"pptuserInfo"];
    
    
    
    [def synchronize];
}

- (void)getPPTBaseUserInfo:(void(^)(mBaseData* resb, GPPTUserInfo*user))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt([GPPTer backPPTUser].mPPTerId) forKey:@"legworkUserId"];
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/legwork/service/user/queryUserInfo" parameters:para call:^(mBaseData *info) {
        
        block (info ,[[GPPTUserInfo alloc] initWithObj:info.mData]);
    }];
}

- (void)getPPTMsgList:(int)mPage andNum:(int)mNum block:(void(^)(mBaseData* resb, NSArray*mArr))block{
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt([GPPTer backPPTUser].mPPTerId) forKey:@"legworkUserId"];
    
    [para setObject:NumberWithInt(mPage) forKey:@"pageNumber"];
    [para setObject:NumberWithInt(mNum) forKey:@"pageSize"];

    [[HTTPrequest sharedHDNetworking] postUrl:@"app/legwork/service/user/queryUserMsg" parameters:para call:^(mBaseData *info) {
        

        if (info.mSucess) {
            
            NSMutableArray *tempArr = [NSMutableArray new];
            
            for (NSDictionary *dic in [info.mData objectForKey:@"list"]) {
                [tempArr addObject:[[GPPTMsgInfo alloc] initWithObj:dic]];
            }
            
            block (info,tempArr);
            
        }else{
        
            block (info,nil);
        }
    }];

}


- (void)getPPTTotleMoney:(int)mPage andNum:(int)mNum block:(void(^)(mBaseData* resb, NSArray*mArr))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt([GPPTer backPPTUser].mPPTerId) forKey:@"legworkUserId"];
    
    [para setObject:NumberWithInt(mPage) forKey:@"pageNumber"];
    [para setObject:NumberWithInt(mNum) forKey:@"pageSize"];
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/legwork/service/user/queryUserPile" parameters:para call:^(mBaseData *info) {
        
        
        if (info.mSucess) {
            
            NSMutableArray *tempArr = [NSMutableArray new];
            
            for (NSDictionary *dic in [info.mData objectForKeyMy:@"list"]) {
                [tempArr addObject:[[GPPTReward alloc] initWithObj:dic]];
            }
            
            block (info,tempArr);
            
        }else{
            
            block (info,nil);
        }
    }];
}
- (void)getPPTRateList:(int)mType andPage:(int)mPage andNum:(int)mNum block:(void(^)(mBaseData* resb, NSArray*mArr))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt([GPPTer backPPTUser].mPPTerId) forKey:@"legworkUserId"];
    [para setObject:NumberWithInt(mType) forKey:@"type"];

    [para setObject:NumberWithInt(mPage) forKey:@"pageNumber"];
    [para setObject:NumberWithInt(mNum) forKey:@"pageSize"];
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/legwork/service/user/queryUserEvaluate" parameters:para call:^(mBaseData *info) {
        
        
        if (info.mSucess) {
            
            NSMutableArray *tempArr = [NSMutableArray new];
            
            for (NSDictionary *dic in [info.mData objectForKey:@"list"]) {
                [tempArr addObject:[[GPPTRateList alloc] initWithObj:dic]];
            }
            
            block (info,tempArr);
            
        }else{
            
            block (info,nil);
        }
    }];
    
}

- (void)getMyTags:(void(^)(mBaseData* resb, NSArray*mArr))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt([GPPTer backPPTUser].mPPTerId) forKey:@"legworkUserId"];
    
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/legwork/service/user/queryUserTags" parameters:para call:^(mBaseData *info) {
        
        
        if (info.mSucess) {
            
            NSMutableArray *tempArr = [NSMutableArray new];
            
            for (NSDictionary *dic in info.mData) {
                [tempArr addObject:[[GPPTMyTag alloc] initWithObj:dic]];
            }
            
            block (info,tempArr);
            
        }else{
            
            block (info,nil);
        }
    }];
}
/**
 *  注销身份
 *
 *  @param block 返回值
 */
- (void)cancelPPTIdentify:(void(^)(mBaseData* resb))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt([GPPTer backPPTUser].mPPTerId) forKey:@"legworkUserId"];
    
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/legwork/service/user/cancel" parameters:para call:^(mBaseData *info) {
        
        
        if (info.mSucess) {
  
            block (info);
            
        }else{
            
            block (info);
        }
    }];
    
}


- (void)pptDeleteMessages:(NSString *)mMessageIds block:(void(^)(mBaseData *resb))block{


    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt([GPPTer backPPTUser].mPPTerId) forKey:@"legworkUserId"];
    [para setObject:mMessageIds forKey:@"ids"];
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/legwork/service/user/deleteUserMsg" parameters:para call:^(mBaseData *info) {
        
        
        if (info.mSucess) {
            
            block (info);
            
        }else{
            
            block (info);
        }
    }];
    
    
    
    
}

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
- (void)finishPPTOrder:(int)mUserId andOrderCode:(NSString *)mOrderCode andOrderType:(int)mOrderType andLat:(NSString *)mLat andLng:(NSString *)mLng block:(void(^)(mBaseData *resb))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mUserId) forKey:@"userId"];
    [para setObject:NumberWithInt(mOrderType) forKey:@"orderType"];
    [para setObject:mOrderCode forKey:@"orderCode"];

    [para setObject:mLat forKey:@"lat"];
    [para setObject:mLng forKey:@"lon"];
    
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/legwork/user/appComfirmOrder" parameters:para call:^(mBaseData *info) {
        
        
        if (info.mSucess) {
            
            block (info);
            
        }else{
            
            block (info);
        }
    }];
    
    
}

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
- (void)mServicefinishPPTOrder:(int)mUserId andMoney:(int)mMoney andOrderCode:(NSString *)mOrderCode andOrderType:(int)mOrderType andLat:(NSString *)mLat andLng:(NSString *)mLng block:(void(^)(mBaseData *resb))block{


    
    NSMutableDictionary *para = [NSMutableDictionary new];
    
#pragma mark----发布者传userid  跑腿者传legid
    
    [para setObject:NumberWithInt(mUserId) forKey:@"legworkUserId"];
    [para setObject:NumberWithInt(mOrderType) forKey:@"orderType"];
    [para setObject:mOrderCode forKey:@"orderCode"];
    
    [para setObject:mLat forKey:@"lat"];
    [para setObject:mLng forKey:@"lon"];
    
    
    if (mOrderType == 1) {
        [para setObject:NumberWithInt(mMoney) forKey:@"money"];
    }
    
    [[HTTPrequest sharedHDNetworking] postUrl:@"app/legwork/service/order/confirmOrder" parameters:para call:^(mBaseData *info) {
        
        
        if (info.mSucess) {
            
            block (info);
            
        }else{
            
            block (info);
        }
    }];
    
    
    

}

@end
@implementation GPPTUserInfo
- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
    
    self.mLevel = [[obj objectForKeyMy:@"level"] intValue];
    self.mPile = [[obj objectForKeyMy:@"pile"] intValue];
    self.mCardID = [obj objectForKeyMy:@"cardID"];
    
    self.mComplaints = [[obj objectForKeyMy:@"complaints"] intValue];
    
    self.mName = [obj objectForKeyMy:@"name"];
    
    int sex = [[obj objectForKeyMy:@"sex"] intValue];
    if (sex == 0) {
        self.mSex = @"女";
    }else{
        self.mSex = @"男";
    }
    

    
    self.mDeposit = [[obj objectForKeyMy:@"deposit"] intValue];
    
    self.mOrders = [obj objectForKeyMy:@"orders"];
    
    self.mTel = [obj objectForKeyMy:@"tel"];
    
    self.mGen_time = [obj objectForKeyMy:@"gen_time"];
    
    self.mPraise = [obj objectForKeyMy:@"praise"];
    
    
    
}



@end
@implementation GPPTRankList

- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
    
    self.mLevel = [[obj objectForKeyMy:@"user_level"] intValue];
    
    self.mName = [obj objectForKeyMy:@"real_name"];
    
    int sex = [[obj objectForKeyMy:@"real_sex"] intValue];
    if (sex == 0) {
        self.mSex = @"女";
    }else{
        self.mSex = @"男";
    }
    
    self.mId = [[obj objectForKeyMy:@"user_id"] intValue];
    
    self.mHeaderImg = [obj objectForKeyMy:@"portrait"];
    
    
    self.mTel = [obj objectForKeyMy:@"real_tel"];
    
    self.mOrderNum = [[obj objectForKeyMy:@"order_take_num"] intValue];
    
    self.mTags = [obj objectForKeyMy:@"tags"];
}


@end

@implementation GPPTMyTag
- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
    
    self.mTagNum = [[obj objectForKeyMy:@"count"] intValue];
    
    self.mTagName = [obj objectForKeyMy:@"tag_name"];

}


@end

@implementation GPPTReward

- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
    
    self.mOrderType = [[obj objectForKeyMy:@"order_type"] intValue];
    
    self.mPileMoney = [[obj objectForKeyMy:@"pile_money"] intValue];
    
    self.mGenTime = [obj objectForKeyMy:@"gen_time"];
    self.mPileTitle = [obj objectForKeyMy:@"pile_title"];
    self.mOrderCode = [obj objectForKeyMy:@"order_code"];

}


@end

@implementation GPPTMsgInfo


- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
    
    self.mMsgType = [[obj objectForKeyMy:@"msg_type"] intValue];
    
    self.mId = [[obj objectForKeyMy:@"id"] intValue];
    
    self.mGenTime = [obj objectForKeyMy:@"gen_time"];
    self.mContent = [obj objectForKeyMy:@"msg_content"];
    self.mTitle = [obj objectForKeyMy:@"msg_title"];
    
}
@end

@implementation GPPTools
- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
    
    
    self.mId = [[obj objectForKeyMy:@"id"] intValue];

    self.mToolName = [obj objectForKeyMy:@"trafficName"];
    
}


@end

@implementation GPPTRateList

- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
    
    self.mService_efficiency = [[obj objectForKeyMy:@"service_efficiency"] intValue];
    self.mService_satisfaction = [[obj objectForKeyMy:@"service_satisfaction"] intValue];
    
    self.mContent = [obj objectForKeyMy:@"evaluate_context"];
    self.mNickName = [obj objectForKeyMy:@"nick_name"];
    self.mGenTime = [obj objectForKeyMy:@"gen_time"];

    
}

@end

@implementation GSystemTags

- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{

    self.mTagId = [[obj objectForKeyMy:@"id"] intValue];
    self.mTagName = [obj objectForKeyMy:@"sysTagName"];
    
}

@end

@implementation GFeedTags

- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
    
    self.mTagId = [[obj objectForKeyMy:@"id"] intValue];
    self.mTagName = [obj objectForKeyMy:@"title_alias"];
    
}

@end

@implementation GCodeProvince
- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
    
    self.mProvinceId = [[obj objectForKeyMy:@"provinceId"] intValue];
    self.mProvinceName = [obj objectForKeyMy:@"provinceName"];

    
    NSMutableArray *tempArr = [NSMutableArray new];
    
    for (NSDictionary *dic in [obj objectForKeyMy:@"cityList"]) {
        [tempArr addObject:[[GCodeArear alloc] initWithObj:dic]];
    }
    self.mProvinceArr = tempArr;

    
}


@end
@implementation GCodeArear
- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
    
    self.mArearId = [[obj objectForKeyMy:@"cityId"] intValue];
    self.mArearName = [obj objectForKeyMy:@"cityName"];
    
    NSMutableArray *tempArr = [NSMutableArray new];
    
    for (NSDictionary *dic in [obj objectForKeyMy:@"countyList"]) {
        [tempArr addObject:[[GCodeCity alloc] initWithObj:dic]];
    }
    self.mArearArr = tempArr;
    
    
}


@end
@implementation GCodeCity
- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
    
    self.mCityId = [[obj objectForKeyMy:@"countyId"] intValue];
    self.mCityName = [obj objectForKeyMy:@"countyName"];
    self.mCityCode = [obj objectForKeyMy:@"countyJianpin"];
    
}


@end

@implementation GGetArear

-(id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
    
    self.mId = [[obj objectForKeyMy:@"id"] intValue];
    self.mArearName = [obj objectForKeyMy:@"areaName"];
    self.mName = [obj objectForKeyMy:@"communityName"];
    self.mDistance = [obj objectForKeyMy:@"distance"];

}

@end


@implementation GMsgObj
-(id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
    
    self.mId = [[obj objectForKeyMy:@"id"] intValue];
    
    self.mIsRead = [[obj objectForKeyMy:@"is_read"] boolValue];
    self.mType = [[obj
                   objectForKeyMy:@"msg_type"] intValue];
    self.mMsg_title = [obj objectForKeyMy:@"msg_title"];
    self.mMsg_content = [obj objectForKeyMy:@"msg_content"];
    self.mGen_time = [obj objectForKeyMy:@"gen_time"];
    
    
    self.mExtras = [[GExtra alloc] initWithObj:[Util dictionaryWithJsonString:[obj objectForKeyMy:@"extras"]]];
    
    

}


@end

@implementation GExtra
-(id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
    
    
    
    self.mOrderType = [obj objectForKeyMy:@"order_type"];
    
    self.mModel = [obj objectForKeyMy:@"model"];
    
    self.mPlaformtType = [[obj objectForKeyMy:@"type"] intValue];
    
    self.mOrderCode = [obj objectForKeyMy:@"order_code"];
    
    self.mUrl = [obj objectForKeyMy:@"url "];
    
    
    
}

@end
#pragma mark----认证地址对象
/**
 *  认证地址对象
 */
@implementation GAddArearObj

-(id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
    
    NSMutableArray *mUniArr = [NSMutableArray new];
    
    NSArray *mArr = [obj objectForKeyMy:@"umitList"];
    
    
    for (NSDictionary *dic in mArr) {
        
        GArearUnitAndFloorObj *mUnitObj = [[GArearUnitAndFloorObj alloc]initWithObj:dic];
        
        [mUniArr addObject:mUnitObj];
    }
    
    self.mUnitList = mUniArr;
    
    self.mBan = [[obj objectForKeyMy:@"ban"] intValue];

    
}

@end

@implementation GArearUnitAndFloorObj

-(id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
    
    
    
    self.mUnit = [[obj objectForKeyMy:@"unit"] intValue];
    self.mRoomNum = [[obj objectForKeyMy:@"room_number"] intValue];
    self.mFloor = [[obj objectForKeyMy:@"floor"] intValue];

    
}

@end