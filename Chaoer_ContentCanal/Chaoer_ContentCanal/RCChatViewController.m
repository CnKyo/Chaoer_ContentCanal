//
//  RCChatViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "RCChatViewController.h"
#import <RongIMKit/RongIMKit.h>
@interface RCChatViewController ()<RCIMReceiveMessageDelegate,RCIMUserInfoDataSource>

@end

@implementation RCChatViewController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager]setEnableAutoToolbar:NO];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
    
}

- (void)viewDidLoad {
    //设置聊天界面的颜色,风格
    UIFont *font = [UIFont systemFontOfSize:19.f];
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName : font,
                                     NSForegroundColorAttributeName : [UIColor whiteColor]
                                     };
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:M_CO];
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"NavImg"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundColor:M_CO];
    
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    
    self.hidesBottomBarWhenPushed = YES;

    self.conversationType = ConversationType_PRIVATE;
    
 
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
}
/**
 *  收到融云的消息
 *
 *  @param message <#message description#>
 *  @param nLeft   <#nLeft description#>
 *  @param object  <#object description#>
 */
- (void)onRCIMReceiveMessage:(RCMessage *)message
                        left:(int)left{
    [self showMsg];

}
-(void)showMsg
{
    UITabBarItem* it = self.tabBarController.viewControllers[0].tabBarItem;
    //收到消息,,, 
    int allunread = [[RCIMClient sharedRCIMClient] getTotalUnreadCount];
    if( allunread > 0 )
    {//如果有 没有读的消息
        it.badgeValue = [NSString stringWithFormat:@"%d",allunread];
    }
    else
    {
        it.badgeValue = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion{
//    if ([@"9069" isEqual:userId]) {
//        RCUserInfo *user = [[RCUserInfo alloc]init];
//        user.userId = self.mUserId;
//        user.name = self.mName;
//        user.portraitUri = self.mHeaderUrl;
//        return completion(user);
//    }
//    return completion(nil);
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/*!
 即将显示消息Cell的回调
 
 @param cell        消息Cell
 @param indexPath   该Cell对应的消息Cell数据模型在数据源中的索引值
 
 @discussion 您可以在此回调中修改Cell的显示和某些属性。
 */
//- (void)willDisplayMessageCell:(RCMessageBaseCell *)cell
//                   atIndexPath:(NSIndexPath *)indexPath{
//
//    if ([cell isMemberOfClass:[RCMessageBaseCell class]]) {
//        RCMessageBaseCell *msgCell = (RCMessageBaseCell *)cell;
//        UIView *msgBgk = (UIView *)msgCell.contentView;
//        msgBgk.backgroundColor = M_CO;
//    }
//    
//    
//}


#pragma mark----发送消息(除图片消息外的所有消息)，会自动更新UI
//- (void)sendMessage:(RCMessageContent *)messageContent
//        pushContent:(NSString *)pushContent{
//
//}
//- (void)sendImageMessage:(RCImageMessage *)imageMessage
//             pushContent:(NSString *)pushContent{
//
//    
//}
//- (void)appendAndDisplayMessage:(RCMessage *)message{
//    BOOL saveToDB = NO;
//    
//    RCMessage *insertMessage;
//    if (saveToDB) {
//        // 如果保存到本地数据库，需要调用insertMessage生成消息实体并插入数据库。
//        insertMessage = [[RCIMClient sharedRCIMClient] insertMessage:self.conversationType
//                                                            targetId:self.targetId
//                                                        senderUserId:[RCIM sharedRCIM].currentUserInfo.userId
//                                                          sendStatus:SentStatus_SENT
//                                                             content:nil];
//    } else {
//        // 如果不保存到本地数据库，需要初始化消息实体并将messageId要设置为－1。
//        insertMessage =[[RCMessage alloc] initWithType:self.conversationType
//                                              targetId:self.targetId
//                                             direction:MessageDirection_SEND
//                                             messageId:-1
//                                               content:nil];
//        
//    }
//    
//    // 在当前聊天界面插入该消息
//    [self appendAndDisplayMessage:insertMessage];
//}

@end
