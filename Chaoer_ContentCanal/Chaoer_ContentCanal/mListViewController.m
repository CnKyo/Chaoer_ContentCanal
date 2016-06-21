//
//  mListViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/21.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mListViewController.h"
#import "homeNavView.h"
#import "RCChatViewController.h"

@interface mListViewController ()<RCIMUserInfoDataSource>

@end

@implementation mListViewController
{
    homeNavView *mNavView;
    
}
- (id)init{
    self = [super init];
    if (self) {
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE)]];
        [self setCollectionConversationType:@[@(ConversationType_PRIVATE)]];
    }
    return self;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    self.title = @"聊天室";
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;

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
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath{
    
    if (conversationModelType == RC_CONVERSATION_MODEL_TYPE_COLLECTION) {
        
        mListViewController *mList = [[mListViewController alloc] init];
        
        NSArray *mArr = [NSArray arrayWithObject:NumberWithInt(model.conversationType)];
        
        [mList setDisplayConversationTypeArray:mArr];
        [mList setCollectionConversationType:nil];
        mList.isEnteredToCollectionViewController = YES;
        mList.isShowNetworkIndicatorView = YES;
        [self.navigationController pushViewController:mList animated:YES];
        
    }else if (model.conversationType == ConversationType_PRIVATE){
        __weak typeof(&*self)  weakSelf = self;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            RCChatViewController *rcc = [[RCChatViewController alloc] init];
            
            rcc.conversationType = ConversationType_PRIVATE;
            
            rcc.targetId = model.targetId;
            rcc.displayUserNameInCell = YES;
            rcc.title = model.senderUserId;
            
            
            UITabBarController *tabbarVC = weakSelf.navigationController.viewControllers[0];
            [tabbarVC.navigationController  pushViewController:rcc animated:YES];
        });
    }
    
}
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion{
    
    [RCCInfo getUserInfo:userId block:^(mBaseData *resb) {
        RCUserInfo *userinfo = [[RCUserInfo alloc] init];
        if (resb.mSucess) {
            userinfo.userId = userId;
            userinfo.name = [resb.mData objectForKey:@"userName"];
            userinfo.portraitUri = [resb.mData objectForKey:@"portraitUri"];
          return  completion(userinfo);
        }else{
           return  completion(userinfo);
            
        }
        
    }];
  
    
}

@end
