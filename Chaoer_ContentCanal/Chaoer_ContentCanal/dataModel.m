//
//  dataModel.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "dataModel.h"
#import "HTTPrequest.h"
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
    _mTitle = [obj objectForKey:@"title"];
    _mState = [[obj objectForKey:@"state"] intValue];
    self.mMessage = [obj objectForKey:@"message"];
    self.mAlert = [[obj objectForKey:@"alert"] intValue];
    self.mData = [obj objectForKey:@"data"];
    
    
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

- (id)initWithObj:(NSDictionary *)obj{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
    }
    return self;
    
}
- (void)fetchIt:(NSDictionary *)obj{
}

+ (void)mUserLogin:(NSString *)mLoginName andPassword:(NSString *)mPwd block:(void (^)(mUserInfo *mUser, mBaseData *resb))block{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:mLoginName forKey:@"loginName"];
    [para setObject:mPwd forKey:@"password"];
    [[HTTPrequest sharedClient] postUrl:@"login/flogin.do" parameters:para call:^(mBaseData *info) {
        

        if (info.mSucess) {

            mUserInfo *mUser = [[mUserInfo alloc] initWithObj:info.mData];
            
            block( mUser , info );
        }else
            block( nil , info );

        
    }];
}

@end