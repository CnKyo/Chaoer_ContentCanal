//
//  RCChatViewController.h
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>

@interface RCChatViewController : RCConversationViewController

/**
 *  昵称
 */
@property (strong,nonatomic) NSString *mName;
/**
 *  头像
 */
@property (strong,nonatomic) NSString *mHeaderUrl;
/**
 *  id
 */
@property (strong,nonatomic) NSString * mUserId;


@end
