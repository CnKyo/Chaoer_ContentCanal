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
    self.mCredit = [[obj objectForKeyMy:@"cret"] intValue];
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
    self.mPhone = [obj objectForKeyMy:@"mPhone"];
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
    [para setObject:mPhone forKey:@"loginName"];
    [para setObject:@"1" forKey:@"from"];
    [[HTTPrequest sharedClient] postUrl:@"zm/login/fgetVerfyCode.do" parameters:para call:^(mBaseData *info) {
        if (info.mData) {
            block (info);
        }else
            block(nil);
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
    [para setObject:mLoginName forKey:@"loginName"];
    [para setObject:mPwd forKey:@"newPassword"];
    [[HTTPrequest sharedClient] postUrl:@"zm/login/resetpwd.do" parameters:para call:^(mBaseData *info) {
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
        [tdic setObject:mPhone forKey:@"mPhone"];
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
    [para setObject:NumberWithInt(mUserid) forKey:@"id"];
    [para setObject:mLoginName forKey:@"loginName"];
    
    if (nickName) {
        [para setObject:nickName forKey:@"nickName"];

    }
    if (mSex) {
        [para setObject:mSex forKey:@"sex"];

    }
    if (mSignate) {
        [para setObject:mSignate forKey:@"signature"];

    }
    [[HTTPrequest sharedClient] postUrl:@"zm/front/personal/udtBaseMessage.do" parameters:para call:^(mBaseData *info) {
        if (info.mData) {
            int sucess = [[info.mData objectForKeyMy:@"r_msg"] intValue];
            
            if (sucess == 1) {
                
                if (nickName) {
                    [mUserInfo backNowUser].mNickName = nickName;
                    
                }
                if (mSex) {
                    if ([mSex isEqualToString:@"m"]) {
                        [mUserInfo backNowUser].mNickName = @"男";

                    }else
                    {
                        [mUserInfo backNowUser].mNickName = @"女";

                    }
                    
                }
                if (mSignate) {
                    [mUserInfo backNowUser].mNickName = mSignate;
                    
                }
                
            
                [self dealUserSession:info andPhone:mLoginName block:block];

            }else{
                block ( info,nil );

            }
            
        }else{
            block ( info,nil );

        }
    }];
    
}
+ (void)modifyUserImg:(int)mUserId andImage:(UIImage *)mImg block:(void (^)(mBaseData *))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mUserId) forKey:@"userId"];
    [para setObject:mImg forKey:@"img"];
    [para setObject:@"" forKey:@"saveDirectory"];
    [[HTTPrequest sharedClient] postUrl:@"zm/front/personal/uploadHeadImg.ad" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
        }else{
            
        }
    }];
}
+ (void)getRedBag:(int)mUserId andType:(NSString *)mType block:(void(^)(mBaseData *resb,NSArray *marray))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mUserId) forKey:@"userId"];
    [para setObject:mType forKey:@"type"];
    [[HTTPrequest sharedClient] postUrl:@"zm/front/personal/redPackage.do" parameters:para call:^(mBaseData *info) {
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
    [para setObject:NumberWithFloat(mMoney) forKey:@"num"];
    [[HTTPrequest sharedClient] postUrl:@"zm/front/conven/phone/IsRecharge.do" parameters:para call:^(mBaseData *info) {
        
        if (info.mSucess) {
            
        }else{
            
        }
    }];
}
+ (void)topUpPhone:(NSString *)mPhone andNum:(float)mMoney andUserId:(int)mUserId block:(void (^)(mBaseData *))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mPhone forKey:@"phone"];
    [para setObject:NumberWithFloat(mMoney) forKey:@"num"];
    [para setObject:NumberWithInt(mUserId) forKey:@"userId"];
    [[HTTPrequest sharedClient] postUrl:@"zm/front/conven/phone/onlineOrder.do" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
        }else{
            
        }
    }];
}

+ (void)getBalanceVerifyCode:(NSString *)mSellerName andLoginName:(NSString *)mLoginName andPayMoney:(int)mMoney andPayName:(NSString *)mPayName andIdentify:(NSString *)mIdentify andPhone:(NSString *)mPhone andBalance:(int)mBalance andBankCard:(NSString *)mBankCard andBankTime:(NSString *)mTime andCVV:(NSString *)mCVV block:(void(^)(mBaseData *resb))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mSellerName forKey:@"merchantName"];
    [para setObject:mLoginName forKey:@"merchantLogin"];
    [para setObject:NumberWithInt(mBalance) forKey:@"merchantMoney"];
    [para setObject:NumberWithInt(mMoney) forKey:@"buyerMoney"];
    [para setObject:mPayName forKey:@"buyerName"];
    [para setObject:mIdentify forKey:@"buyerCard"];
    [para setObject:mPhone forKey:@"buyerPhone"];
    [para setObject:mBankCard forKey:@"buyerBankCard"];
    [para setObject:mTime forKey:@"buyerBankExpire"];
    [para setObject:mCVV forKey:@"buyerBankCvv"];
    
    [[HTTPrequest sharedClient] postUrl:@"ybpay/epos/costMoney.do" parameters:para call:^(mBaseData *info) {
        if (info.mData) {
            
            block( info );
            
        }else{
            block (nil);
        }
    }];
    
}




+ (void)getCityId:(int)mCityId block:(void (^)(mBaseData *))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mCityId) forKey:@"parentId"];
    [[HTTPrequest sharedClient] postUrl:@"zm/front/personal/website.do" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
        }else{
            
        }
    }];
}

+ (void)getArearId:(int)mCityId andProvince:(int)mProvince block:(void (^)(mBaseData *))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mCityId) forKey:@"city"];
    [para setObject:NumberWithInt(mProvince) forKey:@"province"];
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

+ (void)getBuilNum:(NSString *)mName block:(void (^)(mBaseData *))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mName forKey:@"name"];
    [[HTTPrequest sharedClient] postUrl:@"zm/front/personal/building.do" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
        }else{
            
        }
    }];
}

+ (void)getDoorNum:(NSString *)mName andBuildName:(NSString *)mBuildName block:(void (^)(mBaseData *))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mName forKey:@"villageName"];
    [para setObject:mBuildName forKey:@"buildName"];
    [[HTTPrequest sharedClient] postUrl:@"zm/front/personal/buildNumber.do" parameters:para call:^(mBaseData *info) {
        
        if (info.mSucess) {
        

            
        }else{
            
        }
    }];
}

+ (void)getBundleMsg:(int)mUserId block:(void (^)(mBaseData *, SVerifyMsg *))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mUserId) forKey:@"userId"];
    [[HTTPrequest sharedClient] postUrl:@"zm/front/personal/getBindHourseMessage.do" parameters:para call:^(mBaseData *info) {
        if (info.mData) {
            SVerifyMsg *mVerify = [[SVerifyMsg alloc] initWithObj:info.mData];
            
            block( info,mVerify);
        }else{
            block( info,nil);

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
    [para setObject:mContent forKey:@"content"];
    [[HTTPrequest sharedClient] postUrl:@"zm/front/personal/suggest.do" parameters:para call:^(mBaseData *info) {
        if (info.mSucess ) {
            
        }else{
            
        }
    }];
}

+ (void)feedPerson:(int)mUserId andVillageName:(NSString *)mVillageName andBuildName:(NSString *) mBuildName andDoorNum:(NSString *)mDoorNum andReason:(NSString *)mReason block:(void(^)(mBaseData *resb))blovk{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mUserId) forKey:@"userId"];
    [para setObject:mVillageName forKey:@"villageName"];
    [para setObject:mBuildName forKey:@"buildName"];
    [para setObject:mDoorNum forKey:@"buildingNumebr"];
    [para setObject:mReason forKey:@"cause"];
    [[HTTPrequest sharedClient] postUrl:@"zm/front/personal/complaintresident.do" parameters:para call:^(mBaseData *info) {
        if (info.mSucess ) {
            
        }else{
            
        }
    }];
    
    
}

+ (void)feedCanal:(int)mUserId andName:(NSString *)mName andReason:(NSString *)mReason block:(void(^)(mBaseData *resb))block{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mUserId) forKey:@"userId"];
    [para setObject:mName forKey:@"name"];
    [para setObject:mReason forKey:@"cause"];
    [[HTTPrequest sharedClient] postUrl:@"zm/front/personal/complaintmanager.do" parameters:para call:^(mBaseData *info) {
        if (info.mSucess ) {
            
        }else{
            
        }
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

+ (void)commiteFixOrder:(NSString *)mUid andOneLevel:(NSString *)mLevel andClassification:(NSString *)mClassification andRemark:(NSString *)mRemark andtime:(NSString *)mTime andPhone:(NSString *)mPhone andAddress:(NSString *)mAddress andImg:(NSData *)mImgData block:(void(^)(mBaseData *resb))blck{

    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mUid forKey:@"uid"];
    [para setObject:mLevel forKey:@"classification1"];
    [para setObject:mClassification forKey:@"classification2"];
    [para setObject:mRemark forKey:@"remarks"];
    [para setObject:mTime forKey:@"appointmentTime"];
    [para setObject:mPhone forKey:@"phone"];
    [para setObject:@"cqasdas" forKey:@"address"];
    [para setObject:mImgData forKey:@"img"];

    
    
    [[HTTPrequest sharedClient] postUrlWithString:@"app/warrantyOrder/addRepairOrder" andFileName:mImgData andPara:para block:^(mBaseData *info) {
        if (info.mSucess) {
            
        }else{
            blck( info );
        }
    }];
        
  
    
}

+ (void)getFixOrderComfirm:(int)mOrderId andmId:(int)mId block:(void(^)(mBaseData *resb))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mOrderId) forKey:@"orderId"];
    [para setObject:NumberWithInt(mId) forKey:@"mId"];
    [[HTTPrequest sharedClient] postUrl:@"merchantOrder/getOrderWgt.do" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
        }else{
            
        }
    }];
}


+ (void)getOrderPaySuccess:(int)mUserId andOrderId:(int)mOrderId block:(void (^)(mBaseData *))block{
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:NumberWithInt(mOrderId) forKey:@"orderId"];
    [para setObject:NumberWithInt(mUserId) forKey:@"userId"];
    
    [[HTTPrequest sharedClient] postUrl:@"merchantOrder/getOrderWgtPay.do" parameters:para call:^(mBaseData *info) {
        if (info.mSucess) {
            
        }else{
            
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