//
//  choiseServicerViewController.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/23.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "BaseVC.h"

@interface choiseServicerViewController : BaseVC

@property (strong,nonatomic) mBaseData  *mData;


@property (strong,nonatomic) GFixOrder *mFix;

@property (nonatomic,assign) int    Type;

@property (nonatomic,strong) NSString *mAddress;
/**
 *  主类型
 */
@property (assign,nonatomic) int mID;
@property (nonatomic,strong) NSString *mSubClass;

@property (nonatomic,strong) void(^block)(NSString *block ,NSString *mId);

@end
