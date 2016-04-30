//
//  ChatListViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/30.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "ChatListViewController.h"
#import "RCChatViewController.h"
#import<RongIMKit/RCConversationViewController.h>


@interface ChatListViewController ()<RCIMUserInfoDataSource>
{
    NSArray *_chatlist;  //会话列表

}
@end

@implementation ChatListViewController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager]setEnableAutoToolbar:NO];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
    //    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    //    self.navigationController.navigationBar.barTintColor = M_CO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}
- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置聊天头像形状
    [self setConversationAvatarStyle:RC_USER_AVATAR_CYCLE];
    
    [super viewDidLoad];
    //    self.mPageName = @"消息";
    //    self.Title = self.mPageName;
    
    
    self.title = @"消息";
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                        @(ConversationType_SYSTEM)]];
    //设置需要将哪些类型的会话在会话列表中聚合显示
    //    [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),
    //                                          @(ConversationType_GROUP)]];
    
    //自定义导航左右按钮
    /*
     UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"单聊" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemPressed:)];
     [rightButton setTintColor:[UIColor whiteColor]];
     
     self.navigationItem.rightBarButtonItem = rightButton;
     */
    self.conversationListTableView.tableFooterView = [UIView new];
    
    //更新网络状态
    self.showConnectingStatusOnNavigatorBar = YES;
    
    //获取会话列表
    _chatlist = [[RCIMClient sharedRCIMClient] getConversationList:@[@(ConversationType_PRIVATE),
                                                                     @(ConversationType_SYSTEM)]];
    
    //是否有系统消息
    for (RCConversation *cs in _chatlist) {
        
        if (cs.targetId == 0) {//系统消息
            
            //设置系统消息置顶
            [[RCIMClient sharedRCIMClient] setConversationToTop:ConversationType_SYSTEM targetId:@"0" isTop:YES];
        }
    }
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
    

    
}

/**
 
 *此方法中要提供给融云用户的信息，建议缓存到本地，然后改方法每次从您的缓存返回
 
 */

//- (void)getUserInfoWithUserId:(NSString *)userId completion:(void(^)(RCUserInfo* userInfo))completion
//
//{
//    
// 
//    if (self.mLat == nil || [self.mLat isEqualToString:@""]) {
//        self.mLat = @"";
//    }
//    if (self.mLng == nil || [self.mLng isEqualToString:@""]) {
//        self.mLng = @"";
//    }
//    
//    [RCCInfo getDistanceWith:1 andNum:10 andLat:self.mLat andLng:self.mLng block:^(mBaseData *resb, NSArray *mArr) {
//        
//        
//
//        if (resb.mSucess) {
//            
//            for (RCCUserInfo *mRccUser in mArr) {
//                RCUserInfo *user = [[RCUserInfo alloc]init];
//                
//                user.userId = mRccUser.userId;
//                
//                user.name = mRccUser.userName;
//                
//                user.portraitUri = mRccUser.portraitUri;
//                
//                return completion(user);
//
//            }
//            
//            
//
//            
//        }else{
//            
//
//        }
//        
//        
//        
//    }];
//
//    
//}

//网络连接成功后更新标题
- (void)setNavigationItemTitleView{
    
    self.title = @"消息";
}
//重写RCConversationListViewController的onSelectedTableRow事件
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    
    RCChatViewController *conversationVC = [[RCChatViewController alloc]init];
    conversationVC.conversationType = model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title = model.conversationTitle;
    
    [self.navigationController pushViewController:conversationVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
