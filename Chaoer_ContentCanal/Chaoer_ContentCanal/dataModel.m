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
    retobj.mMessage = @"网络连接错误!";
    return retobj;
}
@end

@implementation Ginfo

+ (void)getGinfo:(void (^)(mBaseData *))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt([mUserInfo backNowUser].mLoginId) forKey:@"loginId"];
    [para setObject:[Util getAppVersion] forKey:@"appVersion"];
    [para setObject:[Util getDeviceModel] forKey:@"mobileVersion"];
    [para setObject:[Util getDeviceVersion] forKey:@"mobileSystem"];
    [para setObject:[Util getDeviceUUID] forKey:@"imei"];
    [para setObject:@"ios" forKey:@"type"];
    
    [[HTTPrequest sharedClient] postUrl:@"app/login/loginlog" parameters:para call:^(mBaseData *info) {
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
    
    self.mIsRegist = [[obj objectForKeyMy:@"isRegist"] boolValue];
    self.mIsBundle = [[obj objectForKeyMy:@"isBindHourse"] boolValue];
    self.mPhone = [obj objectForKeyMy:@"moblie"];
    self.mPwd = @"";
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
    return self.mPwd != 0;
}
- (BOOL)isNeedLogin{
    return self.mPwd.length == 0;
}

+ (void)getRegistVerifyCode:(NSString *)mPhone block:(void(^)(mBaseData *resb))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mPhone forKey:@"moblie"];
    [para setObject:@"1" forKey:@"from"];
    [[HTTPrequest sharedClient] postUrl:@"app/verfyCode/appVerfyCode" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            block (info);
        }else
            block(info);
    }];
}

+ (void)mUserRegist:(NSString *)mPhoneNum andCode:(NSString *)mCode andPwd:(NSString *)mPwd andIdentity:(NSString *)mId block:(void (^)(mBaseData *))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mPhoneNum forKey:@"userName"];
    [para setObject:mCode forKey:@"verfyCode"];
    [para setObject:mPwd forKey:@"passWord"];
    [para setObject:mId forKey:@"identity"];
    [[HTTPrequest sharedClient] postUrl:@"app/auth/register" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
        
            block (info);
        }else{
            block (info);
        }
    }];
}
+ (void)mUserLogin:(NSString *)mLoginName andPassword:(NSString *)mPwd block:(void (^)(mBaseData *resb, mUserInfo *mUser))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mLoginName forKey:@"userName"];
    [para setObject:mPwd forKey:@"passWord"];
    
    [[HTTPrequest sharedClient] postUrl:@"app/login/applogin" parameters:para call:^(mBaseData *info) {
        [self dealUserSession:info andPhone:mLoginName block:block];
    }];
}
+(void)mForgetPwd:(NSString *)mLoginName andNewPwd:(NSString *)mPwd block:(void (^)(mBaseData *))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mLoginName forKey:@"userName"];
    [para setObject:mPwd forKey:@"newPassword"];
    [[HTTPrequest sharedClient] postUrl:@"app/auth/updatePassowrd" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            block (info);

        }else{
            block (info);

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
+(void)dealUserSession:(mBaseData*)info andPhone:(NSString *)mPhone block:(void(^)(mBaseData* resb, mUserInfo*user))block
{
    
#warning 返回的数据是整个用户信息对象
    if ( info.mSucess ) {
        NSDictionary* tmpdic = info.mData;
        
        NSMutableDictionary* tdic = [[NSMutableDictionary alloc]initWithDictionary:info.mData];
//        NSString* fucktoken = [info.mcoredat objectForKeyMy:@"token"];
//        if( fucktoken.length )
//            [tdic setObject:fucktoken forKey:@"token"];
//        else
//        {//如果没有token,那弄原来的
////            [tdic setObject:[SUser currentUser].mToken forKey:@"token"];
//        }
        
        if (mPhone) {
            [tdic setObject:mPhone forKey:@"mPhone"];
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

+ (void)editUserMsg:(int)mUserid andLoginName:(NSString *)mLoginName andNickName:(NSString *)nickName andSex:(NSString *)mSex andSignate:(NSString *)mSignate block:(void(^)(mBaseData *resb,mUserInfo *mUser))block{
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
    
    
    [para setObject:[mUserInfo backNowUser].mPhone forKey:@"moblie"];

    [[HTTPrequest sharedClient] postUrl:@"app/updUser/appModfiyUser" parameters:para call:^(mBaseData *info) {
        
        [self dealUserSession:info andPhone:nil block:block];

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
    NSLog(@"reveive Response:\n%@",response);
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    if (!_reveivedData) {
        _reveivedData = [[NSMutableData alloc]init];
    }
    
    [_reveivedData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"received Data:\n%@",[[NSString alloc] initWithData:_reveivedData encoding:NSUTF8StringEncoding]);
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"fail connect:\n%@",error);
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


+ (void)getRedBag:(int)mUserId andType:(NSString *)mType block:(void(^)(mBaseData *resb,NSArray *marray))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mUserId) forKey:@"userId"];
    [para setObject:mType forKey:@"type"];
    [[HTTPrequest sharedClient] postUrl:@"app/redpackage/appRedPackage" parameters:para call:^(mBaseData *info) {
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
    [[HTTPrequest sharedClient] postUrl:@"app/convenience/appIsRecharge" parameters:para call:^(mBaseData *info) {
        
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
    [[HTTPrequest sharedClient] postUrl:@"app/convenience/appLineOrder" parameters:para call:^(mBaseData *info) {
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
    [para setObject:mPayName forKey:@"buyerName"];
    [para setObject:mIdentify forKey:@"buyerCard"];
    [para setObject:mPhone forKey:@"buyerPhone"];
    [para setObject:mBankCard forKey:@"buyerBankCard"];
    [para setObject:mTime forKey:@"buyerBankExpire"];
    [para setObject:mCVV forKey:@"buyerBankCvv"];
    [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];
    [para setObject:@"t+0" forKey:@"paymentMethod"];
    [[HTTPrequest sharedClient] postUrl:@"app/epos/pay/appHandleFunc" parameters:para call:^(mBaseData *info) {
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
    [[HTTPrequest sharedClient] postUrl:@"app/epos/pay/vertifyCodePay" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
            block( info );
            
        }else{
            block( info );
        }
    }];
    
    
    
}



+ (void)getCityId:(int)mCityId block:(void(^)(mBaseData *resb,NSArray *mArr))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mCityId) forKey:@"parentId"];
    [[HTTPrequest sharedClient] postUrl:@"app/city/appWebSite" parameters:para call:^(mBaseData *info) {
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

+ (void)getArearId:(int)mCityId andProvince:(int)mProvince block:(void(^)(mBaseData *resb,NSArray *mArr))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mCityId) forKey:@"cityId"];
    [para setObject:NumberWithInt(mProvince) forKey:@"areaId"];
    
    [[HTTPrequest sharedClient] postUrl:@"app/zocompany/appZocompany" parameters:para call:^(mBaseData *info) {
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
    [[HTTPrequest sharedClient] postUrl:@"zm/front/personal/village.do" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
        }else{
            
        }
    }];
}

+ (void)getBuilNum:(int)mId block:(void(^)(mBaseData *resb,NSArray *mArr))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mId) forKey:@"propertyId"];
    [[HTTPrequest sharedClient] postUrl:@"app/house/appHouseList" parameters:para call:^(mBaseData *info) {
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
    [[HTTPrequest sharedClient] postUrl:@"app/house/appHouseUnit" parameters:para call:^(mBaseData *info) {
        
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
    [[HTTPrequest sharedClient] postUrl:@"app/epos/realVerify/appBankInfo" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            SVerifyMsg *mVerify = [[SVerifyMsg alloc] initWithObj:info.mData];
            
            block( info,mVerify);
        }else{
            block( info,nil);

        }
    }];
}


+ (void)realCode:(NSString *)mName andUserId:(int)mUserid andCommunityId:(int)mCommunityId andBannum:(int)mBannum andUnnitnum:(int)mUnitNum andFloor:(int)mFloor andDoornum:(int)mDoorNum block:(void(^)(mBaseData *resb))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    
    if (mName) {
        [para setObject:mName forKey:@"userName"];
    }
    
    [para setObject:NumberWithInt(mUserid) forKey:@"userId"];
    [para setObject:NumberWithInt(mCommunityId) forKey:@"propertyId"];
    [para setObject:NumberWithInt(mBannum) forKey:@"banNum"];
    [para setObject:NumberWithInt(mUnitNum) forKey:@"unitNum"];
    [para setObject:NumberWithInt(mFloor) forKey:@"floorNum"];
    [para setObject:NumberWithInt(mDoorNum) forKey:@"roomNum"];
    
    [[HTTPrequest sharedClient] postUrl:@"app/house/appBindHouse" parameters:para call:^(mBaseData *info) {
        if (info.mData) {
            
            block( info);
        }else{
            block( info);
            
        }
    }];
    

    
    
    
}




+ (void)getbank:(void(^)(mBaseData *resb,NSArray *marr))block
{    
    [[HTTPrequest sharedClient] postUrl:@"app/bank/appBankList?&paramName=bankname" parameters:nil call:^(mBaseData *info) {
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

    NSString *url = @"app/bank/appBankList";
    
   if (mType ==2){
       url = @"app/bank/appBankList?&paramName=province";
       
    }else if (mType ==3){
        url = @"app/bank/appBankList?&paramName=province&";
        
        [para setObject:mCity forKey:@"province"];
        
    }else if (mType == 4){
        url = @"app/bank/appBankList?&paramName=name&";
        [para setObject:mProvince forKey:@"city"];
        [para setObject:mCity forKey:@"province"];
        [para setObject:mName forKey:@"bankname"];

    }
    
    
    [[HTTPrequest sharedClient] postUrl:url parameters:para call:^(mBaseData *info) {

        if (info.mData) {
            NSMutableArray *tempArr = [NSMutableArray new];
            
            
            if (mType == 3) {
                for (NSDictionary *dic in info.mData) {
                    
                    [tempArr addObject:[dic objectForKey:@"province"]];
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

    
    
    [[HTTPrequest sharedClient] postUrl:@"app/epos/realVerify/appRealNameVerify" parameters:para call:^(mBaseData *info) {
        if (info.mSucess ) {
            
            block (info);
            
        }else{
            block (info);
        }
    }];

    
    
    
    
}




+ (void)getBaner:(void (^)(mBaseData *, NSArray *))block{
    [[HTTPrequest sharedClient] postUrl:@"app/banner/getBanner" parameters:nil call:^(mBaseData *info) {
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


+ (void)feedCompany:(int)mUserId andContent:(NSString *)mContent block:(void(^)(mBaseData *resb))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mUserId) forKey:@"userId"];
    [para setObject:mContent forKey:@"complainReason"];
    [para setObject:@"3" forKey:@"type"];
    [[HTTPrequest sharedClient] postUrl:@"app/complain/companyOpinion" parameters:para call:^(mBaseData *info) {
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
    [[HTTPrequest sharedClient] postUrl:@"app/complain/residentsComplaints" parameters:para call:^(mBaseData *info) {
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

    [[HTTPrequest sharedClient] postUrl:@"app/complain/propertyComplaints" parameters:para call:^(mBaseData *info) {
        if (info.mSucess ) {
            block ( info );
        }else{
            block ( info );
        }
    }];
    
}

- (void)getCanalMsg:(void(^)(mBaseData *resb,NSArray *mArr))block{

    [[HTTPrequest sharedClient] postUrl:@"app/propertyCost/getPropertyCost" parameters:@{@"userId":[NSString stringWithFormat:@"%d",[mUserInfo backNowUser].mUserId]} call:^(mBaseData *info) {
        
        NSMutableArray *tempArr = [NSMutableArray new];
        
        if (info.mSucess) {
            
            for (NSDictionary *dic in info.mData) {
                
                [tempArr addObject:[[GCanal alloc] initWithObj:dic]];
            }
            
            block ( info,tempArr);
            
        }else{
            block ( info,nil);
        }
        
    }];

}

- (void)payCanal:(NSMutableDictionary *)mPara block:(void(^)(mBaseData *resb))block{

    
    [[HTTPrequest sharedClient] postUrl:@"app/propertyCost/deliveryCharge" parameters:mPara call:^(mBaseData *info) {
        if (info.mSucess) {
            block ( info );
        }else{
            block ( info );
        }
    }];
    
}

- (void)FindPublickProvince:(void(^)(mBaseData *resb,NSArray *mArr))block{

    
    [JHJsonRequst httpNsynchronousRequestUrl:JH_API postStr:[NSString stringWithFormat:@"?key=%@",JH_KEY] finshedBlock:^(NSString *dataString) {
        NSLog(@"nsynResult:%@",dataString);

        
    
    }];
}





+(void)getCash:(int)mUid andMoney:(float)mMoney andPresentManner:(int)mPresentManner block:(void(^)(mBaseData *resb))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mUid) forKey:@"uid"];
    [para setObject:NumberWithFloat(mMoney) forKey:@"money"];
    [para setObject:NumberWithInt(mPresentManner) forKey:@"presentManner"];
    [[HTTPrequest sharedClient] postUrl:@"ybpay/epos/withdrawals.do" parameters:para call:^(mBaseData *info) {
        if (info.mSucess ) {
            
        }else{
            
        }
    }];

}

+ (void)getClass:(int)mType block:(void(^)(mBaseData *resb,NSArray *array))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(2) forKey:@"level"];
    [para setObject:NumberWithInt(mType) forKey:@"type"];
    [[HTTPrequest sharedClient] postUrl:@"classify/getClassify.do" parameters:para call:^(mBaseData *info) {
        
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

    [[HTTPrequest sharedClient] postUrl:@"app/classify/getClassify" parameters:para call:^(mBaseData *info) {
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
#pragma mark－－－－提交保修表单
+ (void)commiteFixOrder:(NSString *)mUid andOneLevel:(NSString *)mLevel andClassification:(NSString *)mClassification andRemark:(NSString *)mRemark andtime:(NSString *)mTime andPhone:(NSString *)mPhone andAddress:(NSString *)mAddress andImg:(NSData *)mImgData block:(void(^)(mBaseData *resb))blck{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mUid forKey:@"uid"];
    [para setObject:mLevel forKey:@"classification1"];
    [para setObject:mClassification forKey:@"classification2"];
    [para setObject:mRemark forKey:@"remarks"];
    [para setObject:mTime forKey:@"appointmentTime"];
    [para setObject:mPhone forKey:@"phone"];
    [para setObject:@"重庆市渝中区大坪石油路万科锦程1栋1004" forKey:@"address"];
//    
//        AFHTTPSessionManager *session = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[HTTPrequest returnNowURL]]];
//        
//        [session POST:[NSString stringWithFormat:@"%@app/warrantyOrder/addRepairOrder",[HTTPrequest returnNowURL]] parameters:para constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//            
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            formatter.dateFormat = @"yyyyMMddHHmmss";
//            NSString *nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
//            
//            NSString *fileName = [NSString stringWithFormat:@"%@%@.png",nowTimeStr,mImgData];
//            [formData appendPartWithFileData:mImgData name:@"img" fileName:fileName mimeType:@"image/png"];
//            
//            
//        } success:^(NSURLSessionDataTask *task, id responseObject) {
//            NSLog(@"%@ˆ",responseObject);
//            
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            NSLog(@"%@",error);
//            
//        }];
//        
    
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestOperation *operator = [manager POST:[NSString stringWithFormat:@"%@app/warrantyOrder/addRepairOrder",[HTTPrequest returnNowURL]] parameters:para constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
            
            NSString *fileName = [NSString stringWithFormat:@"%@%@.png",nowTimeStr,mImgData];
            
            [formData appendPartWithFileData:mImgData name:@"file" fileName:fileName mimeType:@"image/png"];
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@ˆ",responseObject);

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);

        }];
    
    [operator setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
         NSLog(@"bytesWritten=%lu, totalBytesWritten=%lld, totalBytesExpectedToWrite=%lld", (unsigned long)bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
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


    [[HTTPrequest sharedClient] postUrl:@"app/warrantyOrder/MerchantList" parameters:para call:^(mBaseData *info) {
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
    [[HTTPrequest sharedClient] postUrl:@"app/warrantyOrder/getPreOrder" parameters:para call:^(mBaseData *info) {
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
    
    [[HTTPrequest sharedClient] postUrl:@"app/warrantyOrder/reserve" parameters:para call:^(mBaseData *info) {
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
    
    [[HTTPrequest sharedClient] postUrl:@"merchantOrder/modifyOrderWgtStatus.do" parameters:para call:^(mBaseData *info) {
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
    [[HTTPrequest sharedClient] postUrl:@"merchant/reserve.do" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
  
            
        }else{
        }
    }];

}


- (void)getSellerMsg:(int)mOid andmId:(int)mId block:(void(^)(mBaseData *resb))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mOid) forKey:@"oId"];
    [para setObject:NumberWithInt(mId) forKey:@"mId"];
    [[HTTPrequest sharedClient] postUrl:@"merchantOrder/getOrderInfo.do" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
            
            
        }else{
        }
    }];


}


- (void)getArear:(void(^)(mBaseData *resb,NSArray *mArr))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];

    [[HTTPrequest sharedClient] postUrl:@"app/communityCenter/getCommunity" parameters:para call:^(mBaseData *info) {
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
    
    [[HTTPrequest sharedClient] postUrl:@"app/wallet/walletInfo" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            block ( info );
            
        }else{
            block ( info );
        }
    }];
}


+ (void)openPush{

    NSString* t = [NSString stringWithFormat:@"%d", [mUserInfo backNowUser].mUserId];
    
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
+ (void)closePush{
    [APService setTags:[NSSet set] alias:@"" callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:[UIApplication sharedApplication].delegate];

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
    [[HTTPrequest sharedClient] postUrl:@"front/personal/informationCount.do" parameters:para call:^(mBaseData *info) {
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
    self.mName = [obj objectForKeyMy:@"getUserName"];
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
    self.mImgUrl = [obj objectForKeyMy:@"img"];
    self.mContentUrl = [obj objectForKeyMy:@"url"];
    self.mName = [obj objectForKeyMy:@"name"];
    self.mB_index = [[obj objectForKeyMy:@"b_index"] intValue];
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
    self.mPropertyId = [obj objectForKeyMy:@"id"];
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
    
    self.mFloor = [[obj objectForKeyMy:@"floor"] intValue];
    self.mRoomNumber = [[obj objectForKeyMy:@"roomNumber"] intValue];
    self.mUnit = [[obj objectForKeyMy:@"unit"] intValue];

    
    
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