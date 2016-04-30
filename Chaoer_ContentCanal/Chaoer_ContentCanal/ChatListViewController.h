//
//  ChatListViewController.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/30.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>
#import <RongIMKit/RongIMKit.h>

@interface ChatListViewController : RCConversationListViewController
/**
 *  纬度
 */
@property (nonatomic,strong) NSString *mLat;
/**
 *  经度
 */
@property (nonatomic,strong) NSString *mLng;
@end
