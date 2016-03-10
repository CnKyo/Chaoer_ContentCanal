//
//  dateModel.m
//  YiZanService
//
//  Created by zzl on 15/3/19.
//  Copyright (c) 2015年 zywl. All rights reserved.
//

#import "CustomDefine.h"
#import "SVProgressHUD.h"
#import "dateModel.h"
#import "NSObject+myobj.h"
#import "APIClient.h"
#import "Util.h"
#import "OSSClient.h"
#import "OSSTool.h"
#import "OSSData.h"
#import "OSSLog.h"
#import "OSSBucket.h"
#import <CoreLocation/CoreLocation.h>

#import "AFURLSessionManager.h"
#import "APService.h"

#import <QMapKit/QMapKit.h>
#import <objc/message.h>
#import "WXApi.h"
#import "WXApiObject.h"

#import <AlipaySDK/AlipaySDK.h>

@class SStaff;
@class SCar;
@class SShop;
static SShop* g_shopinfo = nil;

@implementation dateModel

@end

@implementation SAutoEx

-(id)copyWithZone:(NSZone *)zone
{
    id retobj = [[self class]allocWithZone:zone];
    unsigned int outCount, i;
    id leaderClass = [self class];
    objc_property_t *properties = class_copyPropertyList(leaderClass, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(property)];
        
        id tttt = [[self valueForKey:propName] copy];
        [retobj setValue:tttt forKey:propName];
        
    }
    
    return retobj;
}

-(id)initWithObj:(NSDictionary*)obj
{
    self = [super init];
    if( self && obj )
    {
        [self fetchIt:obj];
    }
    return self;
}

-(void)fetchIt:(NSDictionary*)obj
{
    if( obj == nil ) return;
    NSMutableDictionary* nameMapProp = NSMutableDictionary.new;
    id leaderClass = [self class];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(leaderClass, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(property)];
        [nameMapProp setObject:[NSString stringWithFormat:@"%s",property_getAttributes(property)] forKey:propName];
    }
    if( properties )
    {
        free( properties );
    }
    
    if( nameMapProp.count == 0 ) return;
    
    NSArray* allnames = [nameMapProp allKeys];
    for ( NSString* oneName in allnames ) {
        if( ![oneName hasPrefix:@"m"] ) continue;
        //mId....like this
        NSString* jsonkey = [oneName stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:[[oneName substringWithRange:NSMakeRange(1, 1)] lowercaseString] ];
        //mId ==> mid;
        jsonkey = [jsonkey substringFromIndex:1];
        //mid ==> id;
        
        
        id itobj = [obj objectForKeyMy:jsonkey];

        if( itobj == nil ) continue;
        [self setValue:itobj forKey:oneName];
    }
}
@end
@interface SResBase()

@property (nonatomic,strong)    id mcoredat;

@end

@implementation SResBase


-(id)initWithObj:(NSDictionary *)obj
{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
        self.mcoredat = obj;
    }
    return self;
}

-(void)fetchIt:(NSDictionary *)obj
{
    _mcode = [[obj objectForKeyMy:@"code"] intValue];
    _msuccess = _mcode == 0;
    self.mmsg = [obj objectForKeyMy:@"msg"];
    self.mdebug = [obj objectForKeyMy:@"debug"];
    self.mdata = [obj objectForKey:@"data"];
}

+(SResBase*)infoWithError:(NSString*)error
{
    SResBase* retobj = SResBase.new;
    retobj.mcode = 1;
    retobj.msuccess = NO;
    retobj.mmsg = error;
    return retobj;
}
@end

@implementation SUserState

-(id)initWithObj:(NSDictionary*)dic
{
    self = [super init];
    if( self )
    {
        self.mbHaveNewMsg = [[dic objectForKeyMy:@"hasNewMessage"] boolValue];
    }
    return self;
}

@end

@interface SUser()

@property (nonatomic,strong)    id  mcoredat;

@end

@implementation SUser

static SUser* g_user = nil;
//返回当前用户
bool g_bined = NO;
+(SUser*)currentUser
{
    if( g_user ) return g_user;
    if( g_bined )
    {
        NSLog(@"fuck err rrrr");
        return nil;//递归问题,
    }
    g_bined = YES;
    @synchronized(self) {
        
        if ( !g_user )
        {
            g_user = [SUser loadUserInfo];
        }
    }
    g_bined = NO;
    return g_user;
}

+(void)saveUserInfo:(NSDictionary *)dccat
{
    dccat = [Util delNUll:dccat];
    
    NSMutableDictionary *dcc = [[NSMutableDictionary alloc] initWithDictionary:dccat];
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    
    [def setObject:dcc forKey:@"userInfo"];

    
    
    [def synchronize];
}

+(SUser*)loadUserInfo
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSDictionary* dat = [def objectForKey:@"userInfo"];
    if( dat )
    {
        SUser* tu = [[SUser alloc]initWithObj:dat];
        return tu;
    }
    return nil;
}
+(NSDictionary*)loadUserJson
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    return [def objectForKey:@"userInfo"];
}

+(void)cleanUserInfo
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    [def setObject:nil forKey:@"userInfo"];
    [def synchronize];
}


-(BOOL)isSeller//是否有商家角色
{
    return _mRole & E_R_Seller;
}

-(BOOL)isSender//是否有配送人员角色
{
    return _mRole & E_R_Sender;
}

-(BOOL)isServicer//是否有服务人员角色
{
    return _mRole & E_R_Servicer;
}


//是否是一个合法的用户对象
-(BOOL)isVaildUser
{
    return self.mUserId != 0 && self.mToken.length != 0;
}

//判断是否需要登录
+(BOOL)isNeedLogin
{
    return [SUser currentUser] == nil;
}

//退出登陆
+(void)logout
{
    [SUser clearTokenWithPush];
    [SUser cleanUserInfo];
    g_user = nil;
    g_shopinfo = nil;
    [[APIClient sharedClient] postUrl:@"user.logout" parameters:nil call:^(SResBase *info) {
        
    }];
    
}
//发送短信
+(void)sendSM:(NSString*)phone block:(void(^)(SResBase* resb))block
{
    NSMutableDictionary* param = NSMutableDictionary.new;
    [param setObject:phone forKey:@"mobile"];
    
    [[APIClient sharedClient] postUrl:@"user.mobileverify" parameters:param call:^(SResBase *info) {
        block( info );
    }];
}

///校验手机号码
+(void)checkPhone:(NSString *)mPhone andCode:(NSString *)mCode block:(void(^)(SResBase* resb))block{
    NSMutableDictionary* param = NSMutableDictionary.new;
    [param setObject:mPhone forKey:@"mobile"];
    [param setObject:mCode forKey:@"verifyCode"];
    
    [[APIClient sharedClient]postUrl:@"user.info.verifymobile" parameters:param call:^(SResBase *info) {
        block ( info );
    }];


}

///更新手机号码
+(void)changePhone:(NSString *)mNewPhone andOldphone:(NSString *)oldPhone andCode:(NSString *)mCode block:(void(^)(SResBase* resb))block{
    NSMutableDictionary* param = NSMutableDictionary.new;
    [param setObject:mNewPhone forKey:@"mobile"];
    [param setObject:oldPhone forKey:@"oldmobile"];
    [param setObject:mCode forKey:@"verifyCode"];
    
    [[APIClient sharedClient]postUrl:@"user.info.mobile" parameters:param call:^(SResBase *info) {

        [self dealUserSession:info block:^(SResBase *resb, SUser *user) {
            
            block(info);
            
        }];
        
    }];
}

+(void)dealUserSession:(SResBase*)info block:(void(^)(SResBase* resb, SUser*user))block
{
    if( info.msuccess && info.mdata)
    {
        NSDictionary* tmpdic = info.mdata;
        
        NSMutableDictionary* tdic = [[NSMutableDictionary alloc]initWithDictionary:info.mdata];
        NSString* fucktoken = [info.mcoredat objectForKeyMy:@"token"];
        if( fucktoken.length )
            [tdic setObject:fucktoken forKey:@"token"];
        else
        {//如果没有token,那弄原来的
            [tdic setObject:[SUser currentUser].mToken forKey:@"token"];
        }
        SUser* tu = [[SUser alloc]initWithObj:tdic];
        tmpdic = tdic;
        
        if( [tu isVaildUser] )
        {
            [SUser saveUserInfo: tmpdic];
            g_user = nil;
            [SUser relTokenWithPush];
        }
    }
    block( info , [SUser currentUser] );
}

//登录,
+(void)loginWithPhone:(NSString*)phone psw:(NSString*)psw vcode:(NSString*)vcode block:(void(^)(SResBase* resb, SUser*user))block
{
    NSMutableDictionary* param = NSMutableDictionary.new;
    [param setObject:phone forKey:@"mobile"];
    if( psw )
        [param setObject:psw forKey:@"pwd"];
    if( vcode )
        [param setObject:vcode forKey:@"verifyCode"];
    [[APIClient sharedClient] postUrl:@"user.login" parameters:param call:^(SResBase *info) {
        [self dealUserSession:info block:block];
    }];
}
///密码登录,
+(void)loginWithPhone:(NSString*)phone psw:(NSString*)psw block:(void(^)(SResBase* resb, SUser*user))block
{
    NSMutableDictionary* param = NSMutableDictionary.new;
    [param setObject:phone forKey:@"mobile"];
    [param setObject:psw forKey:@"pwd"];
    
    [[APIClient sharedClient] postUrl:@"user.login" parameters:param call:^(SResBase *info) {
        [SUser dealUserSession:info block:block];
    }];
}

//重置密码
+(void)reSetPswWithPhone:(NSString*)phone newpsw:(NSString*)newpsw smcode:(NSString*)smcode  block:(void(^)(SResBase* resb, SUser*user))block
{
    NSMutableDictionary* param = NSMutableDictionary.new;
    [param setObject:phone forKey:@"mobile"];
    [param setObject:newpsw forKey:@"pwd"];
    [param setObject:smcode forKey:@"verifyCode"];
    
    [[APIClient sharedClient] postUrl:@"user.repwd" parameters:param call:^(SResBase *info) {
        [self dealUserSession:info block:block];
    }];
}


-(id)initWithObj:(NSDictionary *)obj
{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
}


-(void)fetchIt:(NSDictionary *)obj
{
    
    
    self.mToken = [obj objectForKeyMy:@"token"];
    self.mUserId = [[obj objectForKeyMy:@"id"] intValue];
    self.mUserName = [obj objectForKeyMy:@"name"];
    self.mHeadImgURL = [obj objectForKeyMy:@"avatar"];
    self.mPhone = [obj objectForKeyMy:@"mobile"];
    self.mRole = [[obj objectForKeyMy:@"role"] intValue];
    self.mBg = [obj objectForKeyMy:@"bg"];
    
    
}

//获取消息列表 all => SMessageInfo
-(void)getMyMsg:(int)page block:(void(^)( SResBase* resb , NSArray* all ))block
{
    [[APIClient sharedClient]postUrl:@"msg.lists" parameters:@{@"page":@(page)} call:^(SResBase *info) {
        if( info.msuccess )
        {
            NSMutableArray* t = NSMutableArray.new;
            for ( NSDictionary* one in info.mdata ) {
                [t addObject: [[SMessageInfo alloc]initWithObj:one]];
            }
            block(info,t);
        }
        else
            block( info ,nil);
    }];
}

//是否有新消息
-(void)getMsgStatus:(void(^)( SResBase* resb ,BOOL bhavenew ))block
{
    [[APIClient sharedClient]postUrl:@"msg.status" parameters:nil call:^(SResBase *info) {
       
        block( info, [[info.mdata objectForKeyMy:@"hasNewMessage"] boolValue]);
        
    }];
    
}


#define APPKEY      [GInfo shareClient].mOssid
#define APPSEC      [GInfo shareClient].mOssKey
#define BUCKET      [GInfo shareClient].mOssBucket
#define OSSHOST     [GInfo shareClient].mOssHost


//修改用户信息,修改成功会更新对应属性
-(void)updateUserInfo:(NSString*)name HeadImg:(UIImage*)Head Brief:(NSString *)brief block:(void(^)(SResBase* resb ))block
{
    NSString* filepath = nil;
    if( Head )
    {//上传头像
        
        [SVProgressHUD showWithStatus:@"正在保存头像..."];
        OSSClient* _ossclient = [OSSClient sharedInstanceManage];
        _ossclient.globalDefaultBucketHostId = OSSHOST;
        
        NSString *accessKey = APPKEY;
        NSString *secretKey = APPSEC;
        [_ossclient setGenerateToken:^(NSString *method, NSString *md5, NSString *type, NSString *date, NSString *xoss, NSString *resource){
            NSString *signature = nil;
            NSString *content = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@%@", method, md5, type, date, xoss, resource];
            signature = [OSSTool calBase64Sha1WithData:content withKey:secretKey];
            signature = [NSString stringWithFormat:@"OSS %@:%@", accessKey, signature];
            //NSLog(@"here signature:%@", signature);
            return signature;
        }];
        
        OSSBucket* _ossbucket = [[OSSBucket alloc] initWithBucket:BUCKET];
        NSData *dataObj = UIImageJPEGRepresentation(Head, 1.0);
        filepath = [SUser makeFileName:@"jpg"];
        OSSData *testData = [[OSSData alloc] initWithBucket:_ossbucket withKey:filepath];
        [testData setData:dataObj withType:@"jpg"];
        [testData uploadWithUploadCallback:^(BOOL bok, NSError *err) {
            if( !bok )
            {
                SResBase* resb = [SResBase infoWithError:err.description];
                block( resb  );
            }
            else
            {   [SVProgressHUD dismiss];
                [self realUpdate:name file:filepath block:block];
            }
            
        } withProgressCallback:^(float process) {
            
            NSLog(@"process:%f",process);
          //  block(nil,NO,process);
            
        }];
    }
    else
    {
        [SVProgressHUD dismiss];
        [self realUpdate:name file:nil block:block];
    }
}
-(void)realUpdate:(NSString*)name file:(NSString*)file block:(void(^)(SResBase* resb ))block
{
    NSMutableDictionary *param = NSMutableDictionary.new;
    if( name.length )
        [param setObject:name forKey:@"name"];
    if( file.length )
        [param setObject:file forKey:@"avatar"];

    [SVProgressHUD showWithStatus:@"正在修改" maskType:SVProgressHUDMaskTypeClear];
    [[APIClient sharedClient] postUrl:@"user.info.update" parameters:param call:^(SResBase *info) {
        
        [SUser dealUserSession:info block:^(SResBase *resb, SUser *user) {
            block( info );
        }];
        
    }];
}


//获取我的订单,,
-(void)getMyOrders:(int)page status:(int)status date:(NSString*)date keywords:(NSString*)keywords block:(void(^)(SResBase* resb,SOrderPack* retobj))block
{
    NSMutableDictionary* param = NSMutableDictionary.new;
    [param setObject:NumberWithInt(page) forKey:@"page"];
    [param setObject:@(status) forKey:@"status"];
    if( date )
        [param setObject:date forKey:@"date"];
    if( keywords )
        [param setObject:keywords forKey:@"keywords"];
    
    [[APIClient sharedClient] postUrl:@"order.lists" parameters:param call:^(SResBase *info) {
         
        if( info.msuccess )
        {
            block( info, [[SOrderPack alloc] initWithObj:info.mdata] );
        }else
            block(info,nil);
    }];
}
-(void)getSchedulesWithDate:(int)mPage nadType:(int)mType block:(void(^)(SResBase* resb ,NSArray* mDateList ))block{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:NumberWithInt(mPage) forKey:@"page"];
    [dic setObject:NumberWithInt(mType) forKey:@"type"];
    
    [[APIClient sharedClient] postUrl:@"order.schedule" parameters:dic call:^(SResBase *info) {
        
        
        if( info.msuccess )
        {
            NSMutableArray* tt = NSMutableArray.new;
            for ( NSDictionary* one in info.mdata ) {
                SchedulDate* oneobj = [[SchedulDate alloc]initWithObj: one];
                [tt addObject: oneobj];
            }
            block( info , tt );
        }
        else
            block( info , nil);
    }];

}

static int g_index = 0;
+(NSString*)makeFileName:(NSString*)extName
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString* t = [dateFormatter stringFromDate:[NSDate date]];
    
    [dateFormatter setDateFormat:@"HH-mm-ss"];
    NSString* s = [dateFormatter stringFromDate:[NSDate date]];
    g_index++;
    
    return [NSString stringWithFormat:@"temp/%@/%d_%u_%@.%@",t,[SUser currentUser].mUserId,g_index,s,extName];
}



+(void)clearTokenWithPush
{
    [APService setTags:[NSSet set] alias:@"" callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:[UIApplication sharedApplication].delegate];
}
+(void)relTokenWithPush
{
    NSString* t = [NSString stringWithFormat:@"%d", [SUser currentUser].mUserId];
    
    t = [@"staff_" stringByAppendingString:t];
    
    //别名
    //1."seller_1"
    //2."buyer_1"
    

    //标签
    //1."seller"/"buyer"
    //2."重庆"/...
    
    
    NSSet* labelset = [[NSSet alloc]initWithObjects:@"staff", @"ios",nil];
    
    [APService setTags:labelset alias:t callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:[UIApplication sharedApplication].delegate];
    
}

+(NSString*)uploadImagSyn:(UIImage*)tagimg error:(NSError**)error
{
    OSSClient* _ossclient = [OSSClient sharedInstanceManage];
    _ossclient.globalDefaultBucketHostId = OSSHOST;
    //_ossclient.globalDefaultBucketHostId = @"osscn-hangzhou.aliyuncs.com";
    
    NSString *accessKey = APPKEY;
    NSString *secretKey = APPSEC;
    [_ossclient setGenerateToken:^(NSString *method, NSString *md5, NSString *type, NSString *date, NSString *xoss, NSString *resource){
        NSString *signature = nil;
        NSString *content = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@%@", method, md5, type, date, xoss, resource];
        signature = [OSSTool calBase64Sha1WithData:content withKey:secretKey];
        signature = [NSString stringWithFormat:@"OSS %@:%@", accessKey, signature];
        //NSLog(@"here signature:%@", signature);
        return signature;
    }];
    
    OSSBucket* _ossbucket = [[OSSBucket alloc] initWithBucket:BUCKET];
    UIImage* tempimg = [Util scaleImg:tagimg maxsizeW:640.0f];
    NSData *dataObj = UIImageJPEGRepresentation(tempimg, 1.0);
    NSString* filepath = [SUser makeFileName:@"jpg"];
    OSSData *testData = [[OSSData alloc] initWithBucket:_ossbucket withKey:filepath];
    [testData setData:dataObj withType:@"jpg"];
    [testData upload:error];
    if( *error ) return nil;
    return filepath;
}

+(void)uploadImg:(UIImage*)tagimg block:(void(^)(NSString* err,NSString* filepath))block
{
    
    OSSClient* _ossclient = [OSSClient sharedInstanceManage];
    _ossclient.globalDefaultBucketHostId = OSSHOST;

    //_ossclient.globalDefaultBucketHostId = @"osscn-hangzhou.aliyuncs.com";
    
    NSString *accessKey = APPKEY;
    NSString *secretKey = APPSEC;
    [_ossclient setGenerateToken:^(NSString *method, NSString *md5, NSString *type, NSString *date, NSString *xoss, NSString *resource){
        NSString *signature = nil;
        NSString *content = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@%@", method, md5, type, date, xoss, resource];
        signature = [OSSTool calBase64Sha1WithData:content withKey:secretKey];
        signature = [NSString stringWithFormat:@"OSS %@:%@", accessKey, signature];
        //NSLog(@"here signature:%@", signature);
        return signature;
    }];
    
    OSSBucket* _ossbucket = [[OSSBucket alloc] initWithBucket:BUCKET];
    UIImage* tempimg = [Util scaleImg:tagimg maxsizeW:640.0f];
    NSData *dataObj = UIImageJPEGRepresentation(tempimg, 1.0);
    NSString* filepath = [SUser makeFileName:@"jpg"];
    OSSData *testData = [[OSSData alloc] initWithBucket:_ossbucket withKey:filepath];
    [testData setData:dataObj withType:@"jpg"];
    [testData uploadWithUploadCallback:^(BOOL bok, NSError *err) {
        if( !bok )
        {
            block(err.description,nil);
        }
        else
        {
            block(nil,filepath);
        }
    } withProgressCallback:^(float process) {
        
        [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"正在上传图片:%.1f%%",process*100.0f] maskType:SVProgressHUDMaskTypeClear];
    }];
}



//++++++++++++++++++++++++++++++++++
NSMutableArray* g_allWaiterKey = nil;

+(void)addSearchWaiterKey:(NSString*)key
{
    if( g_allWaiterKey == nil )
        g_allWaiterKey = NSMutableArray.new;
    
    if( key.length )
    {
        if( ![g_allWaiterKey containsObject:key] )
        {
            [g_allWaiterKey addObject:key];
            [SUser saveHistoryWaiter:g_allWaiterKey];
        }
    }
}
+(NSArray*)loadHistoryWaiter
{
    if( g_allWaiterKey ) return g_allWaiterKey;
    
    NSUserDefaults* st = [NSUserDefaults standardUserDefaults];
    int userid = [SUser currentUser].mUserId;
    NSString* key = [NSString stringWithFormat:@"%d_wat_his",userid];
    g_allWaiterKey =  [st objectForKey:key];
    return g_allWaiterKey;
}
+(void)clearHistoryWaiter
{
    [SUser saveHistoryWaiter:@[]];
    g_allWaiterKey = NSMutableArray.new;
}
+(void)saveHistoryWaiter:(NSArray*)dat
{
    NSUserDefaults* st = [NSUserDefaults standardUserDefaults];
    int userid = [SUser currentUser].mUserId;
    NSString* key = [NSString stringWithFormat:@"%d_wat_his",userid];
    [st setObject:dat forKey:key];
    [st synchronize];
}
//++++++++++++++++++++++++++++++++++



//++++++++++++++++++++++++++++++++++
NSMutableArray* g_allGoodsKey = nil;

+(void)addSearchKey:(NSString*)key
{
    if( g_allGoodsKey == nil )
        g_allGoodsKey = NSMutableArray.new;
    
    if( key.length )
    {
        if( ![g_allGoodsKey containsObject:key] )
        {
            [g_allGoodsKey addObject:key];
            [SUser saveHistory:g_allGoodsKey];
        }
    }
}

+(NSArray*)loadHistory
{
    if( g_allGoodsKey ) return g_allGoodsKey;
    g_allGoodsKey = NSMutableArray.new;
    
    NSUserDefaults* st = [NSUserDefaults standardUserDefaults];
    int userid = [SUser currentUser].mUserId;
    NSString* key = [NSString stringWithFormat:@"%d_srv_his",userid];
    NSArray* tt = [st objectForKey:key];
    if( tt )
        [g_allGoodsKey addObjectsFromArray:tt];
    return g_allGoodsKey;
}
+(void)clearHistory
{
    [SUser saveHistory:@[]];
    g_allGoodsKey = NSMutableArray.new;
}
+ (void)OpenAndCloseOrder:(int)mStatus block:(void(^)( SResBase* resb))block{
    [[APIClient sharedClient]postUrl:@"user.open.status" parameters:@{@"status":NumberWithInt(mStatus)} call:block];
}


+(void)saveHistory:(NSArray*)dat
{
    NSUserDefaults* st = [NSUserDefaults standardUserDefaults];
    int userid = [SUser currentUser].mUserId;
    NSString* key = [NSString stringWithFormat:@"%d_srv_his",userid];
    [st objectForKey:key];
    [st setObject:dat forKey:key];
    [st synchronize];
}
#pragma mark----获取佣金
- (void)getMoney:(int)mPage block:(void(^)( SResBase* resb , SMyMoney* money ))block
{
    [[APIClient sharedClient]postUrl:@"user.commission" parameters:@{@"page":NumberWithInt(mPage)} call:^(SResBase *info) {
        if (info.msuccess) {
//            NSMutableArray *tt = [NSMutableArray new];
//            for (NSDictionary *dic in info.mdata) {
//                [tt addObject:[[SMyMoney alloc]initWithObj:dic]];
//            }
            SMyMoney *mone = [[SMyMoney alloc]initWithObj:info.mdata];
            block( info , mone);
        }else{
            block( info , nil);
        }
    }];
}
//++++++++++++++++++++++++++++++++++
//获取服务时间设置,
-(void)getTimeSet:(void(^)( SResBase* resb , NSArray* all ))block
{
    
    [[APIClient sharedClient]postUrl:@"staffstime.lists" parameters:nil call:^(SResBase *info) {
        
        if( info.msuccess )
        {
            NSMutableArray* ttt = NSMutableArray.new;
            for ( NSDictionary* one in info.mdata)  {
                [ttt addObject: [[STimeSet alloc]initWithObj: one]];
            }
            block( info , ttt );
            
        }else
            block( info , nil );
    }];
    
}

//
-(void)addTimeSet:(int)maybeid weeks:(NSArray*)weeks hours:(NSArray*)hours block:(void(^)(SResBase* resb ,STimeSet* retobj))block
{
    
    NSMutableDictionary* param = NSMutableDictionary.new;
    [param setObject:weeks forKey:@"weeks"];
    [param setObject:hours forKey:@"hours"];
    if( maybeid )
    {
        [param setObject:NumberWithInt(maybeid) forKey:@"id"];
        
        [[APIClient sharedClient]postUrl:@"staffstime.update" parameters:param call:^(SResBase *info) {
            
            if( info.msuccess )
            {
                block( info, nil );
            }
            else
                block( info , nil );
        }];
    }
    else
    {
        [[APIClient sharedClient]postUrl:@"staffstime.add" parameters:param call:^(SResBase *info) {
            
            if( info.msuccess )
            {
                block( info, nil );
            }
            else
                block( info , nil );
        }];
    }
}

-(void)leaveReq:(int)starttime endtime:(int)endtime text:(NSString *)text block:(void(^)(SResBase* resb))block
{
    NSMutableDictionary* param = NSMutableDictionary.new;
    [param setObject:text  forKey:@"remark"];
    [param setObject:NumberWithInt(starttime) forKey:@"beginTime"];
    [param setObject:NumberWithInt(endtime) forKey:@"endTime"];
    
    [[APIClient sharedClient]postUrl:@"staffleave.create" parameters:param call:block];
}

-(void)leaveList:(int)page block:(void(^)(NSArray* arr, SResBase*  resb))block
{
    NSMutableDictionary* param = NSMutableDictionary.new;
    [param setObject:NumberWithInt( page ) forKey:@"page"];
    [[APIClient sharedClient] postUrl:@"staffleave.lists" parameters:param call:^(SResBase *info) {
        
        if( info.msuccess )
        {
            NSMutableArray* tarr = NSMutableArray.new;
            for ( NSDictionary* one in info.mdata  )
            {
                [tarr addObject:[[SLeave alloc]initWithObj:one] ];
            }
            block( tarr , info);
        }
        else
        {
            block( nil , info);
        }
        
    }];
}

//获取银行账户信息
-(void)getBankInfo:(void(^)( SResBase*  resb,SWithDrawInfo* retobj ))block
{
    [[APIClient sharedClient]postUrl:@"user.bankinfo" parameters:nil call:^(SResBase *info) {
       
        if( info.msuccess )
        {
            SWithDrawInfo* t = [[SWithDrawInfo alloc]initWithObj:info.mdata];
            block( info,t);
        }
        else
            block( info,nil);
        
    }];
}
//提现到银行卡里面
-(void)getWithDraw:(double)amount block:(void(^)( SResBase*  resb ))block
{
    [[APIClient sharedClient]postUrl:@"user.withdraw" parameters:@{@"amount":@(amount)} call:block];
}


@end


static GInfo* g_info = nil;
@implementation GInfo
{
}

+(GInfo*)shareClient
{
    if( g_info ) return g_info;
    @synchronized(self) {
        
        if ( !g_info )
        {
            GInfo* t = [GInfo loadGInfo];
            if( [t isGInfoVaild] )
                g_info = t;
        }
        return g_info;
    }
}
-(BOOL)isGInfoVaild
{//这个全局数据是否有效,,目前只判断了,token,应该判断所有的字段,:todo
    return self.mGToken.length > 0;
}
-(id)initWithObj:(NSDictionary *)obj
{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
}
-(void)fetchIt:(NSDictionary *)obj
{
    self.mGToken = [obj objectForKeyMy:@"token"];
    NSString* sssssss = [obj objectForKeyMy:@"key"];
    if( sssssss.length )
    {
        char keyPtr[10]={0};
        [sssssss getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
        self.mivint  = (int)strtoul(keyPtr,NULL,24);
    }
    
    NSDictionary* data = [obj objectForKeyMy:@"data"];

    NSArray* tt = [data objectForKeyMy:@"payments"];
    NSMutableArray* t = NSMutableArray.new;
    for (NSDictionary* one in tt ) {
        [t addObject: [[SPayment alloc]initWithObj: one]];
    }
    self.mPayments = t;
    
    self.mAppVersion    = [data objectForKeyMy:@"appVersion"];
    self.mForceUpgrade  = [[data objectForKeyMy:@"forceUpgrade"] boolValue];
    self.mAppDownUrl    = [data objectForKeyMy:@"appDownUrl"];
    self.mUpgradeInfo   = [data objectForKeyMy:@"upgradeInfo"];
    self.mServiceTel    = [data objectForKeyMy:@"serviceTel"];
    
    
    NSDictionary* tttt = [data objectForKeyMy:@"oss"];
    
    self.mOssBucket = [tttt objectForKey:@"bucket"];
    self.mOssHost = [tttt objectForKey:@"host"];
    self.mOssid = [tttt objectForKey:@"access_id"];
    self.mOssKey = [tttt objectForKey:@"access_key"];
    
    
    float nowver = [[Util getAppVersion] floatValue];
    float srvver = [self.mAppVersion floatValue];
    if(  nowver >= srvver )
    {
        self.mAppDownUrl = nil;
    }
    
    self.mHelpUrl = [data objectForKeyMy:@"helpUrl"];//使用帮助
    self.mAboutUrl = [data objectForKeyMy:@"aboutUrl"];          //关于我们Url
    self.mProtocolUrl = [data objectForKeyMy:@"protocolUrl"];       //用户协议Url
    self.mRestaurantTips = [data objectForKeyMy:@"restaurantTips"];    //餐厅订餐说明
    self.mShareQrCodeImage = [data objectForKeyMy:@"shareQrCodeImage"];  //分享二维码图片地址
    
    
}
static bool g_blocked = NO;
static bool g_startlooop = NO;
+(void)getGInfoForce:(void(^)(SResBase* resb, GInfo* gInfo))block
{
    NSMutableDictionary* param = NSMutableDictionary.new;
    [param setObject:DeviceType()   forKey:@"systemInfo"];
    [param setObject:@"ios"  forKey:@"deviceType"];
    [param setObject:DeviceSys()    forKey:@"systemVersion"];
    NSString *version =  [Util getAppVersion];
    [param setObject:version  forKey:@"appVersion"];
    [[APIClient sharedClient] postUrl:@"app.init" parameters:param call:^(SResBase *info) {
        if( info.msuccess )
        {//如果网络获取成功,并且数据有效,就覆盖本地的,
            GInfo* obj = [[GInfo alloc] initWithObj: info.mcoredat];
            if( [obj isGInfoVaild] )
            {//有效
                [GInfo saveGInfo:info.mcoredat];
                obj = [GInfo shareClient] ;
                if( [obj isGInfoVaild] )
                {
                    block( info, obj);
                    return ;
                }
            }
        }
        
        block(info,nil);
    }];
}

+(void)getGInfo:(void(^)(SResBase* resb, GInfo* gInfo))block
{
    if( !g_startlooop )
    {
        GInfo* s = [GInfo shareClient];
        if( s )
        {
            SResBase* objret = [[SResBase alloc]init];
            objret.msuccess = YES;
            
            block( objret , s );
            g_blocked = YES;
        }
    }
    
    NSMutableDictionary* param = NSMutableDictionary.new;
    [param setObject:DeviceType()   forKey:@"systemInfo"];
    [param setObject:@"ios"  forKey:@"deviceType"];
    [param setObject:DeviceSys()    forKey:@"systemVersion"];
    NSString *version =  [Util getAppVersion];
    [param setObject:version  forKey:@"appVersion"];
    [[APIClient sharedClient] postUrl:@"app.init" parameters:param call:^(SResBase *info) {
        if( info.msuccess )
        {//如果网络获取成功,并且数据有效,就覆盖本地的,
            GInfo* obj = [[GInfo alloc] initWithObj: info.mcoredat];
            if( [obj isGInfoVaild] )
            {//有效
                [GInfo saveGInfo:info.mcoredat];
                obj = [GInfo shareClient] ;
                if( [obj isGInfoVaild] )
                {
                    if( !g_blocked )
                    {
                        g_blocked = YES;
                        block( info, obj);
                    }
                    
                    if( g_startlooop )
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"UserGinfoSuccess" object:nil];
                    
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"checkappupdate" object:nil];
                    
                    return ;//这里就不用再下去了,,
                }
            }
        }
        else
        {
            //这里就是,没有网络或者数据无效了,就本地看看
            GInfo* tmp = [GInfo shareClient];
            if( tmp )
            {//如果本地有也可以
                if( !g_blocked )
                {
                    g_blocked = YES;
                    block(info,tmp);
                }
            }
            else
            {
                //连本地都没得,,,那么要一直循环获取了,,直到成功为止
                if( !g_blocked )
                {
                    g_blocked = YES;
                    
                    block([SResBase infoWithError:@"获取配置信息失败"] ,nil);
                }
                [GInfo loopGInfo];
            }
        }
    }];
}
+(void)loopGInfo
{
    g_startlooop = YES;
    MLLog(@"loopGInfo...");
    int64_t delayInSeconds = 1.0*20;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [GInfo getGInfo:^(SResBase *resb, GInfo *gInfo) {
            
            
        }];
        
    });
}
+(void)saveGInfo:(id)dat
{
    dat = [Util delNUll:dat];
    
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    [def setObject:dat  forKey:@"GInfo"];
    [def synchronize];
}
+(GInfo*)loadGInfo
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSDictionary* dat = [def objectForKey:@"GInfo"];
    if( dat)
    {
        return [[GInfo alloc]initWithObj:dat];
    }
    return nil;
}




@end


@interface SAppInfo()<CLLocationManagerDelegate>

@property (atomic,strong) NSMutableArray*   allblocks;

@end
SAppInfo* g_appinfo = nil;
@implementation SAppInfo
{
    CLLocationManager* _llmgr;
    BOOL            _blocing;
    NSDate*          _lastget;
}

+(void)feedback:(NSString*)content block:(void(^)(SResBase* resb))block
{
    NSMutableDictionary* param = NSMutableDictionary.new;
    [param setObject:content forKey:@"content"];
    [param setObject:@"ios" forKey:@"deviceType"];
    [[APIClient sharedClient]postUrl:@"feedback.create" parameters:param call:block];
}

+(SAppInfo*)shareClient
{
    if( g_appinfo ) return g_appinfo;
    @synchronized(self) {
        
        if ( !g_appinfo )
        {
            SAppInfo* t = [SAppInfo loadAppInfo];
            g_appinfo = t;
        }
        return g_appinfo;
    }
}

+(SAppInfo*)loadAppInfo
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSDictionary* dat = [def objectForKey:@"gappinfo"];
    SAppInfo* tt = SAppInfo.new;
    if( dat )
    {
        tt.mCityId = [[dat objectForKey:@"cityid"] intValue];
        tt.mSelCity = [dat objectForKey:@"selcity"];
    }
    return tt;
}
-(id)init
{
    self = [super init];
    self.allblocks = NSMutableArray.new;
    return self;
}
-(void)updateAppInfo
{
    NSMutableDictionary* dic = NSMutableDictionary.new;
    [dic setObject:self.mSelCity forKey:@"selcity"];
    [dic setObject:NumberWithInt(self.mCityId) forKey:@"cityid"];
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    [def setObject:dic forKey:@"gappinfo"];
    [def synchronize];
}

//定位,
-(void)getUserLocation:(BOOL)bforce block:(void(^)(NSString*err))block
{
    NSDate *nowt = [NSDate date];
    long diff = [nowt timeIntervalSince1970] - [_lastget timeIntervalSince1970];
    if( diff > 60*5 && !bforce && _mlat != 0.0f && _mlng != 0.0f )
    {
        block(nil);
        return;
    }
    
    [_allblocks addObject:block];
    if( _blocing )
    {
        return;
    }
    _blocing = YES;
    _llmgr = [[CLLocationManager alloc] init];
    _llmgr.delegate = self;
    _llmgr.desiredAccuracy = kCLLocationAccuracyBest;
    _llmgr.distanceFilter = kCLDistanceFilterNone;
    if([_llmgr respondsToSelector:@selector(requestWhenInUseAuthorization)])
        [_llmgr  requestWhenInUseAuthorization];
    
    
    [_llmgr startUpdatingLocation];
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    [manager stopUpdatingLocation];
    
    CLLocation* location = [locations lastObject];
    
    _mlat = location.coordinate.latitude;
    _mlng = location.coordinate.longitude;
    
    
    [SAppInfo getPointAddress:_mlng lat:_mlat block:^(NSString *address, NSString *err) {
        if( !err )
        {
            self.mAddr = address;
            _lastget = [NSDate date];
        }
        
        for(int j = 0; j < _allblocks.count;j++ )
        {
            void(^block)(NSString*err) = _allblocks[j];
            block(err);
        }
        [_allblocks removeAllObjects];
        _blocing = NO;
        
    }];
    
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSString* str = nil;
    if( error.code ==1 )
    {
        str = @"定位权限失败";
    }
    else
    {
        str = @"定位失败";
    }
    for(int j = 0; j < _allblocks.count;j++ )
    {
        void(^block)(NSString*err) = _allblocks[j];
        block(str);
    }
    [_allblocks removeAllObjects];
    _blocing = NO;
}
    

+(void)getPointAddressBubyer:(float)lng lat:(float)lat block:(void(^)(NSString* address,NSString* city,NSString*err))block;
{
    
    NSString* requrl = @"http://apis.map.qq.com/ws/geocoder/v1";
    [[APIClient sharedClient] GET:requrl parameters:@{@"location":[NSString stringWithFormat:@"%.6f,%.6f",lat,lng],@"key":QQMAPKEY,@"get_poi":@(1)} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString* addr = [[[responseObject objectForKey:@"result"] objectForKey:@"formatted_addresses"] objectForKey:@"recommend"];
        NSString* city = [[[responseObject objectForKey:@"result"] objectForKey:@"address_component"] objectForKey:@"city"];
        if( addr == nil || city == nil )
            block(nil,nil,@"获取位置信息失败");
        else
        {
            block(addr,city,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        block(nil,nil,@"获取位置信息失败");
        
    }];
}
+(void)getPointAddress:(float)lng lat:(float)lat block:(void(^)(NSString* address,NSString*err))block
{
    NSString* requrl =
    [NSString stringWithFormat:@"http://apis.map.qq.com/ws/geocoder/v1/?location=%.6f,%.6f&key=%@&get_poi=1",lat,lng, QQMAPKEY];
    
    [[APIClient sharedClient] GET:requrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString* addr = [[[responseObject objectForKey:@"result"] objectForKey:@"formatted_addresses"] objectForKey:@"recommend"];
        if( addr == nil )
            block(nil,@"获取位置信息失败");
        else
        {
            block(addr,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        block(nil,@"获取位置信息失败");
        
    }];
}





@end


@implementation SNorms

-(NSDictionary*)mdic
{
    NSMutableDictionary* tdic = NSMutableDictionary.new;
    if( self.mName )
        [tdic setObject:self.mName forKey:@"name"];
    if( self.mPrice )
        [tdic setObject:@(self.mPrice) forKey:@"price"];
    [tdic setObject:@(self.mStock) forKey:@"stock"];
    [tdic setObject:@(self.mId) forKey:@"id"];
    
    
    self.mdic = tdic;
    
    return _mdic;
}
-(void)fetchIt:(NSDictionary *)obj
{
    [super fetchIt:obj];
}

@end

@implementation SGoods


-(void)fetchIt:(NSDictionary *)obj
{
    [super fetchIt:obj];
    
    NSMutableArray* t = NSMutableArray.new;
    for ( NSDictionary*one in self.mNorms ) {
        [t addObject:[[SNorms alloc]initWithObj:one]];
    }
    self.mNorms = t;
    
    t = NSMutableArray.new;
    for ( NSDictionary*one in self.mStaff) {
        [t addObject:[[SPeople alloc]initWithObj:one]];
    }
    self.mStaff = t;
    
}

//添加这个商品
-(void)addThis:(void(^)(SResBase* resb))block
{
    [self realdoit:block];
}

//更新这个商品
-(void)updateThis:(void(^)(SResBase* resb))block
{
    [self realdoit:block];
}
-(void)realdoit:(void(^)(SResBase* resb))block
{
    NSMutableDictionary* param = NSMutableDictionary.new;
    if( _mId )
        [param setObject:@(_mId) forKey:@"id"];
    if( _mTradeId )
        [param setObject:@(_mTradeId) forKey:@"tradeId"];
    [param setObject:self.mName forKey:@"name"];
    if ( self.mBrief ) {
        [param setObject:self.mBrief forKey:@"brief"];

    }
    [param setObject:@(_mPrice) forKey:@"price"];
    [param setObject:@(_mDuration) forKey:@"duration"];
    [param setObject:@(_mStock) forKey:@"stock"];
    if(self.mStaff)
        [param setObject:self.mStaff forKey:@"staffs"];
    if(self.mDeductType)
        [param setObject:@(self.mDeductType) forKey:@"deductType"];
    if(self.mDeductVal)
        [param setObject:@(self.mDeductVal) forKey:@"deductVala"];
    if( self.mNorms.count )
    {
        NSMutableArray* t = NSMutableArray.new;
        for( SNorms* one in self.mNorms )
        {
            [t addObject:one.mdic];
        }
        [param setObject:t forKey:@"norms"];
    }
    NSMutableArray* t = NSMutableArray.new;
    NSMutableArray* tuiimage = NSMutableArray.new;
    if( self.mImgs.count )
    {
        for( UIImage* one in self.mImgs )
        {
            if( [one isKindOfClass:[UIImage class]] )
            {
                [tuiimage addObject: one];
            }
            else if( [one isKindOfClass:[NSString class]] )
            {
                [t addObject: one];
            }
        }
    }
    
    if( tuiimage.count )
    {//如果有图片要传,,,就传
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSMutableArray* ttt = [[NSMutableArray alloc]initWithArray:self.mImgs];
            int j = 1;
            int c = tuiimage.count;
            for ( UIImage* one in tuiimage )
            {
                dispatch_async(dispatch_get_main_queue(),^{
                    [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"正在上传图片:%d/%d",j,c] maskType:SVProgressHUDMaskTypeClear];
                });
                j++;
                NSError* errror = nil;
                NSString* uploadkey = [SUser uploadImagSyn:one error:&errror];
                if( uploadkey == nil )
                {
                    dispatch_async(dispatch_get_main_queue(),^{
                        block( [SResBase infoWithError:@"上传图片失败"] );
                    });
                    return ;
                }
                NSUInteger i = [ttt indexOfObject:one];
                [ttt replaceObjectAtIndex:i withObject:uploadkey];
            }
            [param setObject:ttt forKey:@"imgs"];
            [[APIClient sharedClient]postUrl:@"goods.edit" parameters:param call:block];
        });
        
    }
    else
    {
        [param setObject:t forKey:@"imgs"];
        [[APIClient sharedClient]postUrl:@"goods.edit" parameters:param call:block];
    }
}

//上架
+(void)getOn:(NSArray*)ids block:(void(^)(SResBase* resb))block
{
    [[APIClient sharedClient]postUrl:@"goods.op" parameters:@{@"ids":ids,@"type":@"1"} call:block];
}

//下架
+(void)getOff:(NSArray*)ids block:(void(^)(SResBase* resb))block
{
    [[APIClient sharedClient]postUrl:@"goods.op" parameters:@{@"ids":ids,@"type":@"2"} call:block];
}

//删除
+(void)delSome:(NSArray*)ids block:(void(^)(SResBase* resb))block
{
    [[APIClient sharedClient]postUrl:@"goods.op" parameters:@{@"ids":ids,@"type":@"3"} call:block];
}

@end

@implementation SOrder

-(void)fetchIt:(NSDictionary *)obj
{
    [super fetchIt:obj];
    
    if( self.mStaff )
        self.mStaff = [[SPeople alloc]initWithObj:(NSDictionary*)self.mStaff];
    
    NSMutableArray* t = NSMutableArray.new;
    for ( NSDictionary*one in self.mOrderGoods ) {
        [t addObject:[[SOrderGoods alloc]initWithObj:one]];
    }
    self.mOrderGoods = t;
    
    self.mLongit = [[self.mMapPoint objectForKeyMy:@"y"] floatValue];
    self.mLat = [[self.mMapPoint objectForKeyMy:@"x"] floatValue];
    
    if( [SAppInfo shareClient].mlat == 0.0f || [SAppInfo shareClient].mlng == 0.0f  )
    {//如果没有定位成功,
        self.mDistStr = @"未知距离";
    }
    else
    {
        QMapPoint q1 =  QMapPointForCoordinate( CLLocationCoordinate2DMake(self.mLat, self.mLongit));
        QMapPoint q2 =  QMapPointForCoordinate( CLLocationCoordinate2DMake([SAppInfo shareClient].mlat, [SAppInfo shareClient].mlng));
        
        self.mDist  = QMetersBetweenMapPoints(q1,q2);
        if( self.mDist < 1000 )
            self.mDistStr = [NSString stringWithFormat:@"%dm",self.mDist];
        else
            self.mDistStr = [NSString stringWithFormat:@"%.1fkm",self.mDist/1000.0f];
    }
}



//订单详情
-(void)getDetail:(void(^)(SResBase* resb))block
{
    NSMutableDictionary * param = NSMutableDictionary.new;
    [param setObject:NumberWithInt(_mId) forKey:@"id"];
    [[APIClient sharedClient]postUrl:@"order.detail" parameters:param call:^(SResBase *info) {
        
        if( info.msuccess )
        {
            [self fetchIt: info.mdata];
        }
        block( info );
    }];
    
}


-(void)startSrv:(void(^)(SResBase* resb))block
{
    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:NumberWithInt(_mId) forKey:@"id"];
    [param setObject:NumberWithInt(200) forKey:@"status"];
    [[APIClient sharedClient] postUrl:@"order.status" parameters:param call:^(SResBase *info) {
        
        if( info.msuccess )
        {
            [self fetchIt:info.mdata];
        }
        block(info);
    }];
}




-(void)postNote:(NSString*)content block:(void(^)(SResBase* resb))block{
    NSMutableDictionary* param = NSMutableDictionary.new;
    [param setObject:content forKey:@"content"];
    [param setObject:@(_mId) forKey:@"orderId"];
    [[APIClient sharedClient]postUrl:@"order.stafflog" parameters:param call:block];
}

- (void)rateAndreply:(NSString *)content block:(void(^)(SResBase* resb))block{
    NSMutableDictionary* param = NSMutableDictionary.new;
    [param setObject:content forKey:@"content"];
    [param setObject:@(_mId) forKey:@"id"];
    [[APIClient sharedClient]postUrl:@"rate.staff.reply" parameters:param call:block];
}

///选择人员,配送人员或者服务人员 staffid选择的人员ID
-(void)selectPeople:(int)staffid block:(void(^)(SResBase* resb))block
{
    [[APIClient sharedClient]postUrl:@"order.designate" parameters:@{@"id":@(_mId),@"staffId":@(staffid)} call:^(SResBase *info) {
       
        if( info.msuccess )
            [self fetchIt:info.mdata];
        
        block( info );
        
    }];
}

//取消订单 remark订单备注
-(void)cancleThis:(NSString*)remark block:(void(^)(SResBase* resb))block
{
    NSMutableDictionary* param = NSMutableDictionary.new;
    [param setObject:@(_mId) forKey:@"id"];
    [param setObject:@(1) forKey:@"status"];
    if( remark )
        [param setObject:remark forKey:@"remark"];
    [[APIClient sharedClient]postUrl:@"order.status" parameters:param call:^(SResBase *info) {
       
        if( info.msuccess )
            [self fetchIt:info.mdata];
        
        block( info );
        
    }];
}

//订单确认
-(void)confirmThis:(void(^)(SResBase* resb))block
{
    [[APIClient sharedClient]postUrl:@"order.status" parameters:@{@"id":@(_mId),@"status":@(2)} call:^(SResBase *info) {
        
        if( info.msuccess )
            [self fetchIt:info.mdata];
        
        block( info );
        
    }];
}

//订单完成
-(void)completeThis:(void(^)(SResBase* resb))block
{
    [[APIClient sharedClient]postUrl:@"order.status" parameters:@{@"id":@(_mId),@"status":@(3)} call:^(SResBase *info) {
        
        if( info.msuccess )
            [self fetchIt:info.mdata];
        
        block( info );
        
    }];
}

//订单完成
-(void)startThis:(void(^)(SResBase* resb))block
{
    [[APIClient sharedClient]postUrl:@"order.status" parameters:@{@"id":@(_mId),@"status":@(4)} call:^(SResBase *info) {
        
        if( info.msuccess )
            [self fetchIt:info.mdata];
        
        block( info );
        
    }];
}




//支付 paytype 支付方式 ==> SPayment.mName
-(void)payIt:(NSString*)paytype block:(void(^)(SResBase* resb))block
{
    if( [paytype isEqualToString:@"alipay"] )
    {
        [self aliPay:block];
    }
    else
        if( [paytype isEqualToString:@"weixin"] )
        {
            [self wxPay:block];
        }
        else if( [paytype isEqualToString:@"yinlian"] )
        {
            [self yinlianPay:block];
        }
        else if( [paytype isEqualToString:@"cashOnDelivery"] )
        {
            [self huodaoPay:block];
        }
        else
        {
            block( [SResBase infoWithError:@"不支持的支付方式"] );
        }
}
-(void)yinlianPay:(void(^)(SResBase* retobj))block
{
    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:@(_mTotalFee)  forKey:@"money"];
    [param setObject:@"yinlian" forKey:@"payment"];
    [[APIClient sharedClient] postUrl:@"seller.recharge" parameters:param call:^(SResBase *info) {
        
        if( info.msuccess )
        {
            [self getDetail:block];
        }
        else
        {
            block(info);//再回调获取
        }
    }];
}
-(void)huodaoPay:(void(^)(SResBase* retobj))block
{
    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:@(_mTotalFee)  forKey:@"money"];
    [param setObject:@"cashOnDelivery" forKey:@"payment"];
    [[APIClient sharedClient] postUrl:@"seller.recharge" parameters:param call:^(SResBase *info) {
        
        if( info.msuccess )
        {
            [self getDetail:block];
        }
        else
        {
            block(info);//再回调获取
        }
    }];
}
-(void)aliPay:(void(^)(SResBase* retobj))block
{
    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:@(_mTotalFee)  forKey:@"money"];
    [param setObject:@"alipay" forKey:@"payment"];
    [[APIClient sharedClient] postUrl:@"seller.recharge" parameters:param call:^(SResBase *info) {
        
        if( info.msuccess )
        {
            //            self.mPayedSn = [info.mdata objectForKeyMy:@"sn"];
            //            self.mPayMoney = [[info.mdata objectForKeyMy:@"money"] floatValue];
            NSString* typestr = [info.mdata objectForKeyMy:@"paymentType"];
            if( [typestr isEqualToString:@"alipay"] )
            {
                NSString* payinfo = [[info.mdata objectForKeyMy:@"payRequest"] objectForKeyMy:@"packages"];
                
                [SAppInfo shareClient].mPayBlock = ^(SResBase *retobj) {
                    
                    if( retobj.msuccess )
                    {//如果成功了,就更新下
                        [self getDetail:block];
                    }else
                        block(retobj);//再回调获取
                    [SAppInfo shareClient].mPayBlock = nil;
                    
                };
                
                [SVProgressHUD dismiss];
                
                [[AlipaySDK defaultService] payOrder:payinfo fromScheme:@"yz_cm_seller" callback:^(NSDictionary *resultDic) {
                    
                    NSLog(@"xxx:%@",resultDic);
                    
                    SResBase* retobj = nil;
                    
                    if (resultDic)
                    {
                        if ( [[resultDic objectForKey:@"resultStatus"] intValue] == 9000 )
                        {
                            retobj = [[SResBase alloc]init];
                            retobj.msuccess = YES;
                            retobj.mmsg = @"支付成功";
                            retobj.mcode = 0;
                        }
                        else
                        {
                            retobj = [SResBase infoWithError: [resultDic objectForKey:@"memo" ]];
                        }
                    }
                    else
                    {
                        retobj = [SResBase infoWithError: @"支付出现异常"];
                    }
                    
                    if( [SAppInfo shareClient].mPayBlock )
                    {
                        [SAppInfo shareClient].mPayBlock( retobj );
                    }
                    else
                    {
                        MLLog(@"alipay block nil?");
                    }
                    
                }];
                return;
            }
            else
            {
                SResBase* retobj = [SResBase infoWithError:@"支付出现异常,请稍后再试"];
                block(retobj);
            }
        }
        else block( info );
        
    }];
    
}

//=======================微信支付===================================
-(void)wxPay:(void(^)(SResBase* retobj))block
{
    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:@(_mTotalFee)  forKey:@"money"];
    [param setObject:@"weixin" forKey:@"payment"];
    [[APIClient sharedClient] postUrl:@"seller.recharge" parameters:param call:^(SResBase *info) {
        
        if( info.msuccess )
        {
            // self.mPayedSn = [info.mdata objectForKeyMy:@"sn"];
            // self.mPayMoney = [[info.mdata objectForKeyMy:@"money"] floatValue];
            
            NSString* typestr = [info.mdata objectForKeyMy:@"paymentType"];
            if( [typestr isEqualToString:@"weixin"] )
            {
                [SVProgressHUD dismiss];
                SWxPayInfo* wxpayinfo = [[SWxPayInfo alloc]initWithObj:[info.mdata objectForKeyMy:@"payRequest"]];
                [SAppInfo shareClient].mPayBlock = ^(SResBase *retobj) {
                    
                    if( retobj.msuccess )
                    {//如果成功了,就更新下
                        [self getDetail:block];
                    }else
                        block(retobj);//再回调获取
                    [SAppInfo shareClient].mPayBlock = nil;
                    
                };
                [self gotoWXPayWithSRV:wxpayinfo];
            }
            else
            {
                SResBase* itretobj = [SResBase infoWithError:@"支付出现异常,请稍后再试"];
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
    payobj.partnerId = payinfo.mpartnerId;
    payobj.prepayId = payinfo.mprepayId;
    payobj.nonceStr = payinfo.mnonceStr;
    payobj.timeStamp = payinfo.mtimeStamp;
    payobj.package = @"Sign=WXPay";
    payobj.sign = payinfo.msign;
    [WXApi sendReq:payobj];
    
}



@end


@implementation SStatisic

-(id)initWithObj:(NSDictionary*)obj
{
    self = [super init];
    if( self )
    {
//        NSString* tt = [obj objectForKeyMy:@"month"];
//        if( tt.length == 6 )
//        {
//            self.mMonth = [[tt substringFromIndex:4] intValue];
//            self.mYear = [[tt substringToIndex:4] intValue];
//        }
        self.mNum = [[obj objectForKeyMy:@"num"] intValue];
        self.mTotal = [[obj objectForKeyMy:@"total"] floatValue];
        self.mMonth =[[obj objectForKeyMy:@"month"] intValue];;
        self.mYear =[[obj objectForKeyMy:@"year"] intValue];;
    }
    return self;
}
-(id)initWtihOrderDic:(NSDictionary*)order
{
    self = [super init];
    if( self )
    {
        SOrder* or = [[SOrder alloc]initWithObj: order];
  
        self.mTimeStr = [Util dateForint:[[order objectForKeyMy:@"payEndTime"] floatValue] bfull:NO];

        self.mTotal = [[order objectForKeyMy:@"payFee"] floatValue];;
        self.mOrderId = or.mId;
        
        self.mGooods = [order objectForKeyMy:@"goods"];
        
        self.mOrderSn = [order objectForKeyMy:@"orderSn"];
        self.mTimeStr = [order objectForKeyMy:@"createTime"];
        self.mMoney = [[order objectForKeyMy:@"money"] floatValue];
    }
    return self;
}

+(void)getStatisic:(int)yeaer month:(int)month page:(int)page block:(void(^)(SResBase* resb,NSArray* all))block
{
    if( month == -1 )
    {//按照月份统计
        NSMutableDictionary* param =    NSMutableDictionary.new;
        [param setObject:NumberWithInt(page) forKey:@"page"];
        [[APIClient sharedClient]postUrl:@"statistics.month" parameters:param call:^(SResBase *info) {
            //这个返回的是订单,,,
            NSArray* t  = nil;
            if( info.msuccess )
            {
                NSMutableArray* ta = NSMutableArray.new;
                for ( NSDictionary* one in info.mdata ) {
                    [ta addObject: [[SStatisic alloc]initWithObj:one]];
                }
                t = ta;

            }
            block(info,t);
        }];
        
    }
    else
    {
        NSMutableDictionary* param =    NSMutableDictionary.new;
        [param setObject:NumberWithInt(month) forKey:@"month"];
        [param setObject:NumberWithInt(page) forKey:@"page"];
        if( month > 0 )
        {
            if( month < 10 )
                [param setObject:[NSString stringWithFormat:@"%d0%d",yeaer,month] forKey:@"month"
                 ];
            else
                [param setObject:[NSString stringWithFormat:@"%d%d",yeaer,month] forKey:@"month"
                 ];
        }
        
        [[APIClient sharedClient] postUrl:@"statistics.detail" parameters:param call:^(SResBase *info) {
            NSArray* t  = nil;
            if( info.msuccess )
            {
                NSMutableArray* ta = NSMutableArray.new;
                for ( NSDictionary* one in [info.mdata objectForKey:@"commisssions"] ) {
                    [ta addObject: [[SStatisic alloc]initWtihOrderDic:one]];
                }
                t = ta;

            }
            block(info,t);
        }];
    }
    
}





@end


@implementation SMessageInfo

-(id)initWithAPN:(NSDictionary*)objapn
{
    self = [super init];
    if( self )
    {
        self.mId = [[objapn objectForKeyMy:@"id"] intValue];
        self.mTitle = [objapn objectForKeyMy:@"title"];
        self.mContent = [objapn objectForKeyMy:@"content"];
        self.mCreateTime = [Util dateForint:[[objapn objectForKeyMy:@"sendTime"] floatValue] bfull:NO];
        self.mArgs = [objapn objectForKeyMy:@"args"];
        self.mType = [[objapn objectForKeyMy:@"type"] intValue];
        self.mStatus = [[objapn objectForKeyMy:@"status"] intValue];
//        self.mType = [[objapn objectForKeyMy:@"createType"] intValue];
    }
    
    return self;
}

///是否有新消息

//阅读消息
-(void)readThis:(void(^)(SResBase* resb))block
{
    [SMessageInfo realAll:@[@(_mId)] block:block];
}
+(void)realAll:(NSArray*)all block:(void(^)(SResBase* resb))block
{
    [[APIClient sharedClient]postUrl:@"msg.read" parameters:@{@"id":all} call:block];
}

+ (void)isHaveMessage:(void(^)(SResBase* resb))block{
    [[APIClient sharedClient]postUrl:@"msg.status" parameters:nil call:block];

}

//删除消息
-(void)delThis:(void(^)(SResBase* resb))block
{
    [SMessageInfo delAll:@[@(_mId)] block:block];
}


+(void)delAll:(NSArray*)all block:(void(^)(SResBase* resb))block
{
    [[APIClient sharedClient]postUrl:@"msg.delete" parameters:@{@"id":all} call:block];
}


+(void)readAllMessage:(void(^)(SResBase* retobj))block{
    NSMutableDictionary* param = NSMutableDictionary.new;
    [param setObject:NumberWithInt(0) forKey:@"id"];
    [[APIClient sharedClient] postUrl:@"msg.read" parameters:param call:block];
}

+(void)readSomeMsg:(NSArray*)msgid block:(void(^)(SResBase* retobj))block
{
    NSMutableDictionary* param = NSMutableDictionary.new;
    [param setObject:msgid forKey:@"id"];
    [[APIClient sharedClient]postUrl:@"msg.read" parameters:param call:block];
}

+(void)delMessages:(NSArray*)msgids block:(void(^)(SResBase* retobj))block
{
    NSMutableDictionary* param = NSMutableDictionary.new;
    [param setObject:msgids forKey:@"id"];
    [[APIClient sharedClient]postUrl:@"msg.delete" parameters:param call:block];
    
}

@end

@implementation SchedulDate

-(id)initWithObj:(NSDictionary*)obj
{
    self = [super init];
    
    if( self )
    {
        
        NSString *timeStr = [NSString stringWithFormat:@"%@",[obj objectForKeyMy:@"day"]];
        self.mDateStr = [Util startTimeStr:timeStr];
        NSArray* ta = [obj objectForKeyMy:@"list"];
        if( ta )
        {
            NSMutableArray* aa = NSMutableArray.new;
            for( NSDictionary* one in ta )
            {
                [aa addObject: [[SOrder alloc]initWithObj:one] ];
            }
            self.mInfos = aa;
        }

    }
    
    return self;
}


@end


@implementation STimeSet

-(void)delThis:(void(^)(SResBase* resb))block
{
    NSMutableDictionary* param = NSMutableDictionary.new;
    [param setObject:NumberWithInt( _mId) forKey:@"id"];
    [[APIClient sharedClient]postUrl:@"staffstime.delete" parameters:param call:block];
}

-(id)initWithObj:(NSDictionary *)obj
{
    self = [super init];
    if( self )
    {
        self.mId = [[obj objectForKeyMy:@"id"] intValue];
        self.mWeek = [obj objectForKeyMy:@"weeks"];
//        self.mTimesInfo = [obj objectForKeyMy:@"hours"];
        self.mWeekInfo = [obj objectForKeyMy:@"week"];
        
        NSString *str = @"";
        NSArray *ary = [obj objectForKeyMy:@"shifts"];
        NSArray *ary2 = [obj objectForKeyMy:@"hours"];
        for (int i = 0; i< ary.count; i++) {
            
            str = [[str stringByAppendingString:[ary objectAtIndex:i]] stringByAppendingString:[NSString stringWithFormat:@"(%@)、",[ary2 objectAtIndex:i]]];
        }
        self.mShifts = str;

        
    }
    return self;
}


@end

@implementation SLeave

///删除一组请假记录
+(void)delAll:(NSArray*)allids block:(void(^)(SResBase* resb))block
{
    NSMutableDictionary * param = NSMutableDictionary.new;
    [param setObject:allids forKey:@"ids"];
    [[APIClient sharedClient] postUrl:@"staffleave.delete" parameters:param call:block];
}


-(id)initWithObj:(NSDictionary*)obj
{
    self = [super init];
    if( self )
    {
        
        /*
         
         id	int	是			请假记录编号
         beginTime	date	是			请假开始时间
         endTime	date	是			请假结束时间
         remark	string	否			请假理由
         createTime
         */
        self.mId = [[obj objectForKeyMy:@"id"] intValue];
        self.mText = [obj objectForKey:@"remark"];
        
        self.mStartTimeStr = [obj objectForKeyMy:@"beginTime"];
        
        self.mEndTimeStr = [obj objectForKeyMy:@"endTime"];
        
        self.mTimeStr = [obj objectForKeyMy:@"createTime"];
        
        self.mStatusStr = [obj objectForKeyMy:@"statusStr"];
        
    }
    return self;
}


@end


@implementation SMyMoney

-(id)initWithObj:(NSDictionary*)obj
{
    self = [super init];
    if( self )
    {
        NSMutableArray *arr = [NSMutableArray new];
        self.mTotleMoney = [[obj objectForKeyMy:@"total"] floatValue];
        
        for (NSDictionary *dic in [obj objectForKeyMy:@"commisssions"]) {
            SMoney *money = [[SMoney alloc]initWithObj:dic];
            [arr addObject:money];
        }
        self.mContent = arr;
        
    }
    return self;
}

@end

@implementation SMoney

-(id)initWithObj:(NSDictionary*)obj
{
    self = [super init];
    if( self )
    {
        
        self.mMoney = [[obj objectForKeyMy:@"money"] floatValue];
        self.mCreateTime = [obj objectForKeyMy:@"createTime"];
        self.mContent = [obj objectForKeyMy:@"content"];
        self.mOrderId = [obj objectForKeyMy:@"orderSn"];
    }
    return self;
}

@end

@implementation SAvd

@end

@implementation STrade


@end

@implementation SOrderGoods


@end
@implementation SOrderRateInfo


-(void)replayThis:(NSString*)content block:(void(^)(SResBase* resb))block
{
    [[APIClient sharedClient] postUrl:@"seller.evareply" parameters:@{@"id":@(_mId),@"content":content} call:block];
}



@end

@implementation SEvaPack

-(void)fetchIt:(NSDictionary *)obj
{
    [super fetchIt:obj];
    NSMutableArray* t = NSMutableArray.new;
    for ( NSDictionary*one in self.mEva ) {
        [t addObject:[[SOrderRateInfo alloc]initWithObj:one]];
    }
    self.mEva = t;
}

@end
@implementation SSeller

-(void)fetchIt:(NSDictionary *)obj
{
    [super fetchIt:obj];
    NSMutableArray* t = NSMutableArray.new;
    for ( NSDictionary*one in self.mBanner) {
        [t addObject:[[SAvd alloc]initWithObj:one]];
    }
    self.mBanner = t;
    
}


//获取经营类型列表 all => STrade
+(void)getTradeList:(void(^)(SResBase* resb,NSArray* all))block
{
    [[APIClient sharedClient]postUrl:@"seller.trade" parameters:nil call:^(SResBase *info) {
        NSMutableArray* t = NSMutableArray.new;
        for ( NSDictionary*one in info.mdata) {
            [t addObject:[[STrade alloc]initWithObj:one]];
        }
        block( info,t);
    }];
}

//获取评价 page 页码, type 1:未回复；2：已回复 all
+(void)getEvaList:(int)page type:(int)type block:(void(^)(SResBase* info,SEvaPack* evapack))block
{
    [[APIClient sharedClient]postUrl:@"seller.evalist" parameters:@{@"page":@(page),@"type":@(type)} call:^(SResBase *info) {
       
         SEvaPack *eva = [[SEvaPack alloc]initWithObj:info.mdata];
        
        block(info,eva);
    }];
}
@end



@implementation SWithDrawInfo


-(void)EditBank:(NSString *)bank bankNo:(NSString *)bankNo mobile:(NSString *)mobile name:(NSString *)name verifyCode:(NSString *)verifyCode block:(void(^)(SResBase* resb,SWithDrawInfo *draw))block{

    [[APIClient sharedClient]postUrl:@"seller.savebankinfo" parameters:@{@"id":@(_mId),@"bank":bank,@"bankNo":bankNo,@"mobile":mobile,@"name":name,@"verifyCode":verifyCode} call:^(SResBase *info) {
        
        if( info.msuccess )
        {
            SWithDrawInfo* t = [[SWithDrawInfo alloc]initWithObj:info.mdata];
            block( info,t);
        }
        else
            block( info,nil);
        
    }];
}

+ (void)AddBank:(NSString *)bank bankNo:(NSString *)bankNo mobile:(NSString *)mobile name:(NSString *)name verifyCode:(NSString *)verifyCode block:(void (^)(SResBase *, SWithDrawInfo *))block{

    [[APIClient sharedClient]postUrl:@"seller.savebankinfo" parameters:@{@"bank":bank,@"bankNo":bankNo,@"mobile":mobile,@"name":name,@"verifyCode":verifyCode} call:^(SResBase *info) {
        
        if( info.msuccess )
        {
            SWithDrawInfo* t = [[SWithDrawInfo alloc]initWithObj:info.mdata];
            block( info,t);
        }
        else
            block( info,nil);
        
    }];
}

+(void)GetBankInfo:(void(^)(SResBase* resb,SWithDrawInfo *draw))block{
    
    [[APIClient sharedClient]postUrl:@"seller.getbankinfo" parameters:nil call:^(SResBase *info) {
        
        if( info.msuccess )
        {
            SWithDrawInfo* t = [[SWithDrawInfo alloc]initWithObj:info.mdata];
            block( info,t);
        }
        else
            block( info,nil);
        
    }];
}

-(void)DeleteBankInfo:(void(^)(SResBase* resb))block{

    [[APIClient sharedClient]postUrl:@"seller.delbankinfo" parameters:@{@"id":@(_mId)} call:^(SResBase *info) {
         block( info);
        
    }];

    
}


@end

@implementation SShopBill


@end

@implementation SProvince

- (id)initWithObj:(NSDictionary *)obj{
    
    [super fetchIt:obj];
    
    NSMutableArray *arry = NSMutableArray.new;
    
    if (_mChild) {
        NSDictionary *dic = (NSDictionary *)_mChild;
        for (NSDictionary *d in [dic allValues]) {
            
            SProvince *p = [[SProvince alloc] initWithObj:d];
            
            [arry addObject:p];
        }
        _mChild = arry;
    }
    
    return self;
}

+ (void)GetProvice:(void(^)(NSArray* all))block{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"txt"];
    
    //获取数据
    NSData *reader = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:reader options:NSJSONReadingAllowFragments error:nil];
    
    NSMutableArray *all = NSMutableArray.new;
    NSArray *arry = [dic allValues];
    for (NSDictionary *d in arry) {
        
        SProvince *p = [[SProvince alloc] initWithObj:d];
        
        [all addObject:p];
    }
    block(all);
}

@end



@implementation SShop

//获取店铺信息
+(void)getShopInfo:(void(^)(SResBase* info,SShop* retobj))block
{
//    if( g_shopinfo != nil )
//    {
//        SResBase* ff = SResBase.new;
//        ff.msuccess = YES;
//        block( ff, g_shopinfo);
//        return;
//    }
    [[APIClient sharedClient]postUrl:@"shop.info" parameters:nil call:^(SResBase *info) {
       
        SShop *shop;
        if( info.msuccess )
        {
            shop = [[SShop alloc]initWithObj:info.mdata];
        }
        block( info,shop);
    }];
}

-(void)updateAvrH:(int)benable block:(void(^)(SResBase* info))block
{
    [[APIClient sharedClient]postUrl:@"shop.edit" parameters:@{@"shopdatas":@{@"isCashOnDelivery":@(benable)}} call:^(SResBase *info) {
        
        if( info.msuccess )
            self.mIsCashOnDelivery = benable;
        block( info );
        
    }];
}

///修改店铺名称
- (void)updateDianpuName:(NSString *)mName block:(void(^)(SResBase* info))block{
    [[APIClient sharedClient]postUrl:@"shop.edit" parameters:@{@"shopdatas":@{@"name":mName}} call:^(SResBase *info) {
        
        if( info.msuccess )
            self.mName = mName;
        block( info );
        
    }];
}
///修改店铺logo
- (void)upDateDianpuLogo:(UIImage *)mLogo block:(void(^)(SResBase* info))block{
    NSString* filepath = nil;
    if( mLogo )
    {//上传头像
        
        [SVProgressHUD showWithStatus:@"正在保存图片..."];
        OSSClient* _ossclient = [OSSClient sharedInstanceManage];
        _ossclient.globalDefaultBucketHostId = OSSHOST;
        
        NSString *accessKey = APPKEY;
        NSString *secretKey = APPSEC;
        [_ossclient setGenerateToken:^(NSString *method, NSString *md5, NSString *type, NSString *date, NSString *xoss, NSString *resource){
            NSString *signature = nil;
            NSString *content = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@%@", method, md5, type, date, xoss, resource];
            signature = [OSSTool calBase64Sha1WithData:content withKey:secretKey];
            signature = [NSString stringWithFormat:@"OSS %@:%@", accessKey, signature];
            //NSLog(@"here signature:%@", signature);
            return signature;
        }];
        
        OSSBucket* _ossbucket = [[OSSBucket alloc] initWithBucket:BUCKET];
        NSData *dataObj = UIImageJPEGRepresentation(mLogo, 1.0);
        filepath = [SUser makeFileName:@"jpg"];
        OSSData *testData = [[OSSData alloc] initWithBucket:_ossbucket withKey:filepath];
        [testData setData:dataObj withType:@"jpg"];
        [testData uploadWithUploadCallback:^(BOOL bok, NSError *err) {
            if( !bok )
            {
                SResBase* resb = [SResBase infoWithError:err.description];
                block( resb  );
            }
            else
            {   [SVProgressHUD dismiss];
                [self upDateLogo:filepath block:block];
            }
            
        } withProgressCallback:^(float process) {
            
            NSLog(@"process:%f",process);
            //  block(nil,NO,process);
            
        }];
    }
    else
    {
        [SVProgressHUD dismiss];
        [self upDateLogo:filepath block:block];
    }

}
- (void)upDateLogo:(NSString *)mLogo block:(void(^)(SResBase* resb ))block{
    
    [[APIClient sharedClient]postUrl:@"shop.edit" parameters:@{@"shopdatas":@{@"img":mLogo}} call:^(SResBase *info) {
        
        if( info.msuccess )
            self.mImg = [info.mdata objectForKey:@"img"];
        block( info );
        
    }];

}
//修改公告
-(void)updateArticle:(NSString*)content block:(void(^)(SResBase* info))block
{
    [[APIClient sharedClient]postUrl:@"shop.edit" parameters:@{@"shopdatas":@{@"article":content}} call:^(SResBase *info) {
        
        if( info.msuccess )
            self.mArticle = content;
        block( info );
        
    }];
}
///营业状态
- (void)upDateYingyeStatus:(int)mStatus block:(void(^)(SResBase* info))block{
    [[APIClient sharedClient]postUrl:@"shop.edit" parameters:@{@"shopdatas":@{@"status":NumberWithInt(mStatus)}} call:^(SResBase *info) {
        
        if( info.msuccess )
            self.mStatus = mStatus;
        block( info );
        
    }];
}
//修改简介
-(void)updateBrief:(NSString*)content block:(void(^)(SResBase* info))block
{
    [[APIClient sharedClient]postUrl:@"shop.edit" parameters:@{@"shopdatas":@{@"brief":content}} call:^(SResBase *info) {
        
        if( info.msuccess )
            self.mBrief = content;
        block( info );
        
    }];
}

//修改电话
-(void)updateTel:(NSString*)content block:(void(^)(SResBase* info))block
{
    [[APIClient sharedClient]postUrl:@"shop.edit" parameters:@{@"shopdatas":@{@"tel":content}} call:^(SResBase *info) {
        
        if( info.msuccess )
            self.mTel = content;
        block( info );
        
    }];
}

//修改配送费
-(void)updatePs:(NSString*)content block:(void(^)(SResBase* info))block
{
    [[APIClient sharedClient]postUrl:@"shop.edit" parameters:@{@"shopdatas":@{@"deliveryFee":content}} call:^(SResBase *info) {
        
        if( info.msuccess )
            self.mTel = content;
        block( info );
        
    }];
}

//修改起送价
-(void)updateQs:(NSString*)content block:(void(^)(SResBase* info))block
{
    [[APIClient sharedClient]postUrl:@"shop.edit" parameters:@{@"shopdatas":@{@"serviceFee":content}} call:^(SResBase *info) {
        
        if( info.msuccess )
            self.mTel = content;
        block( info );
        
    }];
}

//修改配送时间
-(void)updateDeliveryTimes:(NSDictionary *)allnew block:(void(^)(SResBase* info))block
{
    [[APIClient sharedClient]postUrl:@"shop.edit" parameters:@{@"shopdatas":@{@"deliveryTime":allnew}} call:^(SResBase *info) {
        
        if( info.msuccess )
            self.mDeliveryTime = allnew;
        block( info );
        
    }];
}

//修改营业时间
-(void)updateBusinessTime:(NSArray*)allnew andHourArr:(NSArray *)hourArr block:(void(^)(SResBase* info))block
{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:allnew forKey:@"weeks"];
    [dic setValue:hourArr forKey:@"hours"];
    
    [[APIClient sharedClient]postUrl:@"shop.edit" parameters:@{@"shopdatas":@{@"businessHour":dic}} call:^(SResBase *info) {
        
        if( info.msuccess )
            self.mBusinessHour = dic;
        block( info );
        
    }];
}

//更新区域
-(void)updateAddressInfo:(NSString*)addr lat:(float)lat lng:(float)lng block:(void(^)(SResBase* info))block
{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    if( addr )
        [dic setValue:addr forKey:@"address"];
    
    NSString* ss = [NSString stringWithFormat:@"%.6f,%.6f",lat,lng];
    [dic setObject:ss forKey:@"mapPointStr"];
    [[APIClient sharedClient]postUrl:@"shop.edit" parameters:@{@"shopdatas":dic} call:^(SResBase *info) {
        
        if( info.msuccess )
        {
            self.mAddress = addr;
            self.mMapPointStr = ss;
        }
        block( info );
    }];
}

//更新详细地址
-(void)updateAddressDetailInfo:(NSString*)addr block:(void(^)(SResBase* info))block{

    NSMutableDictionary *dic = [NSMutableDictionary new];
    if( addr )
        [dic setValue:addr forKey:@"addressDetail"];
    
   
    [[APIClient sharedClient]postUrl:@"shop.edit" parameters:@{@"shopdatas":dic} call:^(SResBase *info) {
        
        if( info.msuccess )
        {
            self.mAddressDetail = addr;
        }
        block( info );
    }];

    
}


//更新区域
-(void)updatePCA:(int)pid cid:(int)cid aid:(int)aid block:(void(^)(SResBase* info))block
{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:@(pid) forKey:@"provinceId"];
    [dic setValue:@(cid) forKey:@"cityId"];
    [dic setValue:@(aid) forKey:@"areaId"];
    
    [[APIClient sharedClient]postUrl:@"shop.edit" parameters:@{@"shopdatas":dic} call:^(SResBase *info) {
        
        if( info.msuccess )
        {
            self.mProvinceId = pid;
            self.mCityId = cid;
            self.mAreaId = aid;
        }
        block( info );
    }];
    
}


//账单查询
-(void)searchBill:(int)page type:(int)type status:(int)status block:(void(^)(SResBase* info,NSArray *bill))block{
    
    NSMutableDictionary * param = NSMutableDictionary.new;
    [param setObject:@(page) forKey:@"page"];
    [param setObject:@(type) forKey:@"type"];
    
    if (status) {
        [param setObject:@(status) forKey:@"status"];
    }
    
    [[APIClient sharedClient]postUrl:@"shop.account" parameters:param call:^(SResBase *info) {
        
        NSMutableArray* t = NSMutableArray.new;
        for ( NSDictionary*one in info.mdata) {
            [t addObject:[[SShopBill alloc]initWithObj:one]];
        }
        
        block(info,t);
    }];
}

- (void)setArear:(void(^)(SResBase* info))block{

    [[APIClient sharedClient]postUrl:@"shop.sellermap" parameters:nil call:^(SResBase *info) {
        
        if( info.msuccess )
            block( info );

        
    }];
}

@end


@implementation SOrderPack

-(void)fetchIt:(NSDictionary *)obj
{
    [super fetchIt:obj];
    
    NSMutableArray* t = NSMutableArray.new;
    for ( NSDictionary*one in self.mOrders ) {
        [t addObject:[[SOrder alloc]initWithObj:one]];
    }
    self.mOrders = t;
    
}


@end

@implementation SPeople

//获取配送人员和服务人员 type ==>2:服务人员；1：配送人员（添加服务时使用）   all=>>SPeople
+(void)getPeoples:(int)type block:(void(^)(SResBase* resb,NSArray*all))block
{
    [[APIClient sharedClient]postUrl:@"order.stafflist" parameters:@{@"type":@(type)} call:^(SResBase *info) {
       
        if( info.msuccess )
        {
            NSMutableArray* t = NSMutableArray.new;
            for ( NSDictionary*one in info.mdata) {
                [t addObject:[[SPeople alloc]initWithObj:one]];
            }
            block( info, t);
        }
        else
            block( info,nil);
        
    }];
}


@end



@implementation SGoodsCate


-(void)fetchIt:(NSDictionary *)obj
{
    [super fetchIt:obj];
    
    
    self.mTrade = [[STrade alloc] initWithObj:[obj objectForKeyMy:@"cates"]];
    
}

+(void)getGoodCates:(int)type block:(void(^)(SResBase* resb,NSArray*all))block
{
    [[APIClient sharedClient]postUrl:@"goodscate.lists" parameters:@{@"type":@(type)} call:^(SResBase *info) {
       
        if( info.msuccess )
        {
            NSMutableArray* t = NSMutableArray.new;
            for ( NSDictionary*one in info.mdata) {
                [t addObject:[[SGoodsCate alloc]initWithObj:one]];
            }
            block( info,t);
        }
        else
            block(info,nil);
        
    }];
    
}

//更新排序
+(void)updateSort:(NSArray*)newsort block:(void(^)(SResBase* resb))block
{
    [[APIClient sharedClient]postUrl:@"goodscate.sort" parameters:@{@"data":newsort} call:block];
}


//删除
-(void)delThis:(void(^)(SResBase* resb))block
{
    [[APIClient sharedClient]postUrl:@"goodscate.del" parameters:@{@"id":@(_mId)} call:block];
}

//修改名字
-(void)changeName:(NSString*)name tradeId:(int)tradeId type:(int)type block:(void(^)(SResBase* resb))block
{
    [[APIClient sharedClient]postUrl:@"goodscate.edit" parameters:@{ @"id":@(_mId),@"name":name,@"tradeId":@(tradeId),@"type":@(type)} call:block];
}

//添加一个分类
+(void)addOne:(NSString*)name tradeid:(int)tradeid type:(int)type block:(void(^)(SResBase* resb))block
{
    [[APIClient sharedClient]postUrl:@"goodscate.edit" parameters:@{@"tradeId":@(tradeid),@"name":name,@"type":@(type)} call:block];
}

//获取这个分类的商品 status 1：上架；2：下架
-(void)getGoodsList:(int)status keywords:(NSString*)keywords page:(int)page block:(void(^)(SResBase* resb,NSArray* all))block
{
    NSMutableDictionary* param = NSMutableDictionary.new;
    [param setObject:@(_mId) forKey:@"id"];
    [param setObject:@(status) forKey:@"status"];
    if( keywords )
        [param setObject:keywords forKey:@"keywords"];
    [param setObject:@(page) forKey:@"page"];
    
    [[APIClient sharedClient]postUrl:@"goods.lists" parameters:param call:^(SResBase *info) {
        
        if( info.msuccess )
        {
            NSMutableArray* t = NSMutableArray.new;
            for ( NSDictionary*one in info.mdata) {
                [t addObject:[[SGoods alloc]initWithObj:one]];
            }
            block( info,t);
        }
        else
            block(info,nil);
        
    }];
    
}




@end


@implementation SWxPayInfo
-(id)initWithObj:(NSDictionary*)obj
{
    self = [super init];
    if( self && obj )
    {
        self.mpartnerId = [obj objectForKeyMy:@"partnerid"];//	string	是			商户号
        self.mprepayId = [obj objectForKeyMy:@"prepayid"];//	string	是			预支付交易会话标识
        self.mpackage = [obj objectForKeyMy:@"packages"];//	string	是			扩展字段
        self.mnonceStr = [obj objectForKeyMy:@"noncestr"];//	string	是			随机字符串
        self.mtimeStamp = [[obj objectForKeyMy:@"timestamp"] intValue];//	int	是			时间戳
        self.msign = [obj objectForKeyMy:@"sign"];//	string	是			签名
        
    }
    return self;
}


@end



@implementation SPayment


-(id)initWithObj:(NSDictionary *)obj
{
    self = [super init];
    if( self && obj != nil )
    {
        self.mCode = [obj objectForKeyMy:@"code"];
        self.mName = [obj objectForKeyMy:@"name"];
        self.mIconName = [obj objectForKeyMy:@"icon"];
        self.mDefault = [[obj objectForKeyMy:@"isDefault"] boolValue];
    }
    return self;
}

@end
