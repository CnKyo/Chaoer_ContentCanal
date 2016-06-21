//
//  homeNavView.h
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/4/1.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homeNavView : UIView
/**
 *  地址
 */
@property (strong, nonatomic) IBOutlet UILabel *mAddress;
/**
 *  聊天室
 */
@property (weak, nonatomic) IBOutlet UIButton *mChtListBtn;
/**
 *  新消息提示
 */
@property (weak, nonatomic) IBOutlet UIImageView *mMsgPoint;



+ (homeNavView *)shareView;
/**
 *  设置
 */
@property (strong, nonatomic) IBOutlet UIButton *mSetupBtn;
/**
 *  消息
 */
@property (strong, nonatomic) IBOutlet UIButton *mMsgBtn;
/**
 *  消息气泡
 */
@property (weak, nonatomic) IBOutlet UILabel *mBadge;

+ (homeNavView *)sharePersonNav;


@property (weak, nonatomic) IBOutlet UIButton *mBackBtn;

+ (homeNavView *)shareChatNav;

@end
