//
//  AppDelegate.m
//  O2O_XiCheSeller
//
//  Created by 密码为空！ on 15/6/18.
//  Copyright (c) 2015年 zongyoutec.com. All rights reserved.
//

#import "AppDelegate.h"
#import "MTA.h"
#import "MTAConfig.h"

#import "MyViewController.h"
#import "JPUSHService.h"

#import "WebVC.h"
#import "ViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>


#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

#import <RongIMKit/RongIMKit.h>

#import "QUCustomDefine.h"
#import "APIObjectDefine.h"
#import "mSenderViewController.h"
#import "homeViewController.h"
#import "PushAudioPlayer.h"

@interface AppDelegate ()<UIAlertViewDelegate,WXApiDelegate,RCIMConnectionStatusDelegate,RCIMReceiveMessageDelegate>

@end
@interface myalert : UIAlertView

@property (nonatomic,strong) id obj;

@end

@implementation myalert


@end
@implementation AppDelegate
{
    UIViewController* _theshop;
}
-(void)initExtComp
{
    [MAMapServices sharedServices].apiKey = AMAP_KEY;
    [AMapSearchServices sharedServices].apiKey = AMAP_KEY;
    [AMapLocationServices sharedServices].apiKey = AMAP_KEY;
    [MTA startWithAppkey:@"IBW9PAI485ZQ"];
    
    
    /**
     融云
     
     - returns:
     */
    [[RCIM sharedRCIM] initWithAppKey:RCCAPP_KEY];
    
    
    
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:@"11070552590dc"
     
          activePlatforms:@[@(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeWechat)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1105204239"
                                      appKey:@"5SShQsbv5YgKswaF"
                                    authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wxf8feb845b3a4d04e"
                                       appSecret:@"5060f2cb199015e81b74c6d5fc26e4a6"];
                 break;
                 
                default:
                 break;
         }
     }];

    [WXApi registerApp:WXPAYKEY withDescription:[Util getAPPName]];// 配置info.plist的 Scheme,

}
#pragma mark----加载融云
- (void)loadRongCloud{
    // 注册自定义测试消息
    [[RCIM sharedRCIM] registerMessageType:[RCTextMessage class]];
    
    
    //设置接收消息代理
    [RCIM sharedRCIM].receiveMessageDelegate=self;
    //    [RCIM sharedRCIM].globalMessagePortraitSize = CGSizeMake(46, 46);
    //开启输入状态监听
    [RCIM sharedRCIM].enableTypingStatus=YES;
    //开启发送已读回执（只支持单聊）
    [RCIM sharedRCIM].enableReadReceipt=YES;
    //设置显示未注册的消息
    //如：新版本增加了某种自定义消息，但是老版本不能识别，开发者可以在旧版本中预先自定义这种未识别的消息的显示
    [RCIM sharedRCIM].showUnkownMessage = YES;
    [RCIM sharedRCIM].showUnkownMessageNotificaiton = YES;
    
    [mUserInfo OpenRCConnect];

    

}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.

    [self initExtComp];
    [self loadRongCloud];
    
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
#warning 发布版本在这里将product设置为yes不然收不到推送
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:@"5e3e27da01ec6cb61b8e2b4d"
                          channel:@"25b4503e82ad1f91cfc56061"
                 apsForProduction:NO
            advertisingIdentifier:nil];
    
//    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                   UIRemoteNotificationTypeSound |
//                                                   UIRemoteNotificationTypeAlert)
//                                       categories:nil];
//    
//    
//    [APService setupWithOption:launchOptions];
    

    [mUserInfo openPush];
    
    
    [self dealFuncTab];
//    if ([application
//         
//         respondsToSelector:@selector(registerUserNotificationSettings:)]) {
//        
//        //注册推送, iOS 8
//        
//        UIUserNotificationSettings *settings = [UIUserNotificationSettings
//                                                
//                                                settingsForTypes:(UIUserNotificationTypeBadge |
//                                                                  
//                                                                  UIUserNotificationTypeSound |
//                                                                  
//                                                                  UIUserNotificationTypeAlert)
//                                                
//                                                categories:nil];
//        
//        [application registerUserNotificationSettings:settings];
//        
//    } else {
//        
//        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge |
//        
//        UIRemoteNotificationTypeAlert |
//        
//        UIRemoteNotificationTypeSound;
//        
//        [application registerForRemoteNotificationTypes:myTypes];
//        
//    }
    
    //融云即时通讯
    
    [[NSNotificationCenter defaultCenter]
     
     addObserver:self
     
     selector:@selector(didReceiveMessageNotification:)
     
     name:RCKitDispatchMessageNotification
     
     object:nil];
    
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];

    NSDictionary *notificationPayload = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if( notificationPayload )
    {
#warning push->notification
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:notificationPayload forKey:@"push"];
        
        [defaults synchronize];

        [self performSelector:@selector(pushView:) withObject:notificationPayload afterDelay:1.0f];
         
    }
    return YES;
}

- (void)pushView:(NSDictionary *)dic{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notify"object:dic];

}
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        
        UIAlertView *alert = [[UIAlertView alloc]
                              
                              initWithTitle:@"提示"
                              
                              message:@"您"
                              
                              @"的帐号在别的设备上登录，您被迫下线！"
                              
                              delegate:self
                              
                              cancelButtonTitle:@"重新登录！"
                              
                              otherButtonTitles:nil, nil];
        alert.tag = 10000;
        
        [alert show];
        
        
    }
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    // url:wx206e0a3244b4e469://pay/?returnKey=&ret=0 withsouce url:com.tencent.xin
    
    
    
    MLLog(@"url:%@ withsouce url:%@",url,sourceApplication);
    if ([url.host isEqualToString:@"safepay"]) {
        
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                                  standbyCallback:^(NSDictionary *resultDic) {
                                                      
                                                      MLLog(@"xxx:%@",resultDic);
                                                      
                                                      mBaseData* retobj = nil;
                                                      
                                                      if (resultDic)
                                                      {
                                                          
                                                          if ( [[resultDic objectForKey:@"resultStatus"] intValue] == 9000 )
                                                          {
                                                              [[NSNotificationCenter defaultCenter] postNotificationName:MyOrderPaySuccessNotification object:nil];
                                                              
                                                              mBaseData* retobj = [[mBaseData alloc]init];
                                                              retobj.mSucess = YES;
                                                              retobj.mMessage = @"支付成功";
                                                              retobj.mState = 200000;
                                                              [SVProgressHUD showSuccessWithStatus:retobj.mMessage];
                                                              
                                                              if( [mUserInfo backNowUser].mPayBlock )
                                                              {
                                                                  [mUserInfo backNowUser].mPayBlock(retobj);
                                                              }
                                                              else
                                                              {
                                                                  MLLog(@"may be err no block to back");
                                                              }
                                                          }
                                                          else
                                                          {
                                                              retobj = [mBaseData infoWithError: [resultDic objectForKey:@"memo" ]];
                                                              [SVProgressHUD showErrorWithStatus:retobj.mMessage];
                                                          }
                                                      }
                                                      else
                                                      {
                                                          retobj = [mBaseData infoWithError: @"支付出现异常"];
                                                          [SVProgressHUD showErrorWithStatus:retobj.mMessage];
                                                      }
                                                  }];

        
        return YES;
    }
    else if( [sourceApplication isEqualToString:@"com.tencent.xin"] )
    {
        return  [WXApi handleOpenURL:url delegate:self];
    }
    return NO;
}

-(void) onResp:(BaseResp*)resp
{
    if( [resp isKindOfClass: [PayResp class]] )
    {
        NSString *strMsg    =   [NSString stringWithFormat:@"errcode:%d errmsg:%@ payinfo:%@", resp.errCode,resp.errStr,((PayResp*)resp).returnKey];
        MLLog(@"payresp:%@",strMsg);
        
        mBaseData* retobj = mBaseData.new;
        if( resp.errCode == -1 )
        {//
            retobj.mSucess = NO;
            retobj.mMessage = @"支付出现异常";
        }
        else if( resp.errCode == -2 )
        {
            retobj.mSucess = NO;
            retobj.mMessage = @"用户取消了支付";
//            retobj.mMessage = strMsg;
        }
        else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:MyOrderPaySuccessNotification object:nil];
            
            retobj.mSucess = YES;
            retobj.mMessage = @"支付成功";
        }
        
        if( [mUserInfo backNowUser].mPayBlock )
        {
            [mUserInfo backNowUser].mPayBlock(retobj);
        }
        else
        {
            MLLog(@"may be err no block to back");
        }
    }
    else
    {
        MLLog(@"may be err what class one onResp");
    }
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([[options objectForKey:@"UIApplicationOpenURLOptionsSourceApplicationKey"] isEqualToString:@"com.alipay.iphoneclient"]) {
        
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                                  standbyCallback:^(NSDictionary *resultDic) {
                                                      
                                                      MLLog(@"xxx:%@",resultDic);
                                                      
                                                      mBaseData* retobj = nil;
                                                      
                                                      
                                                      if (resultDic)
                                                      {
                                                          if ( [[resultDic objectForKey:@"resultStatus"] intValue] == 9000 )
                                                          {
                                                              
                                                              [[NSNotificationCenter defaultCenter] postNotificationName:MyOrderPaySuccessNotification object:nil];
                                                              mBaseData* retobj = [[mBaseData alloc]init];
                                                              retobj.mSucess = YES;
                                                              retobj.mMessage = @"支付成功";
                                                              retobj.mState = 200000;
                                                              [SVProgressHUD showSuccessWithStatus:retobj.mMessage];
                                                              
                                                              if( [mUserInfo backNowUser].mPayBlock )
                                                              {
                                                                  [mUserInfo backNowUser].mPayBlock(retobj);
                                                              }
                                                              else
                                                              {
                                                                  MLLog(@"may be err no block to back");
                                                              }
                                                          }
                                                          else
                                                          {
                                                              retobj = [mBaseData infoWithError: [resultDic objectForKey:@"memo" ]];
                                                              [SVProgressHUD showErrorWithStatus:retobj.mMessage];
                                                          }
                                                      }
                                                      else
                                                      {
                                                          retobj = [mBaseData infoWithError: @"支付出现异常"];
                                                          [SVProgressHUD showErrorWithStatus:retobj.mMessage];
                                                      }
                                                  }];

        
        return YES;
    }
    else if([[options objectForKey:@"UIApplicationOpenURLOptionsSourceApplicationKey"] isEqualToString:@"com.tencent.xin"]){
        
        return  [WXApi handleOpenURL:url delegate:self];
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    MLLog(@"hhhhhhurl:%@",url);
    return  [WXApi handleOpenURL:url delegate:self];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    int unreadMsgCount = [[RCIMClient sharedRCIMClient] getUnreadCount:@[
                                                                         @(ConversationType_PRIVATE),
                                                                         @(ConversationType_DISCUSSION),
                                                                         @(ConversationType_APPSERVICE),
                                                                         @(ConversationType_PUBLICSERVICE),
                                                                         @(ConversationType_GROUP)
                                                                         ]];
    application.applicationIconBadgeNumber = unreadMsgCount;
}
- (void)redirectNSlogToDocumentFolder {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MMddHHmmss"];
    NSString *formattedDate = [dateformatter stringFromDate:currentDate];
    
    NSString *fileName = [NSString stringWithFormat:@"rc%@.log", formattedDate];
    NSString *logFilePath =
    [documentDirectory stringByAppendingPathComponent:fileName];
    
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+",
            stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+",
            stderr);
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [application setApplicationIconBadgeNumber:0];
    [JPUSHService resetBadge];
    [self performSelector:@selector(ddddoti:) withObject:nil afterDelay:1];
}

-(void)ddddoti:(id)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"showMsg" object:nil];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//-(void)gotoLogin
//{
//    UINavigationController* navvc = (UINavigationController*)((UITabBarController*)self.window.rootViewController).selectedViewController;
//    
//    if( [navvc.topViewController isKindOfClass:[ViewController class]] )
//    {
//        return;
//    }
//    
//    
////    [SUser logout];
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    
//    id viewController = [storyboard instantiateViewControllerWithIdentifier:@"login"];
//    
//    [(UINavigationController*)((UITabBarController*)self.window.rootViewController).selectedViewController pushViewController:viewController animated:YES];
//}
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];

}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    MLLog(@"reg push err:%@",error);
}
#pragma mark*-*----加载推送通知
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [JPUSHService registerDeviceToken:deviceToken];
    //融云的
    NSString *token =[[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"withString:@""]stringByReplacingOccurrencesOfString:@">"
                                                                                                                                    withString:@""]
                      stringByReplacingOccurrencesOfString:@" "
                      withString:@""];
    
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
    
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [JPUSHService handleRemoteNotification:userInfo];
    if (application.applicationState == UIApplicationStateActive) {
        
        [self dealPush:userInfo bopenwith:NO];
    }
    else
    {
        [self dealPush:userInfo bopenwith:YES];
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [self application:application didReceiveRemoteNotification:userInfo];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}



-(void)dealPush:(NSDictionary*)userinof bopenwith:(BOOL)bopenwith
{
    NSLog(@"userinof: %@", userinof);
    JPushReceiveObject *it = [JPushReceiveObject mj_objectWithKeyValues:userinof];
    if( !bopenwith ) {
        if (it.aps.alert.length>0) {
            [[PushAudioPlayer sharedClient] play:it.aps.sound];
            myalert *alertVC = [[myalert alloc] initWithTitle:@"提示" message:it.aps.alert delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好的", nil];
            alertVC.obj = it;
            [alertVC show];
        }
        
    } else {
        [self goToVCWithPush:it];
    }

    
//    SMessageInfo* pushobj = [[SMessageInfo alloc]initWithAPN:userinof];
    
    if( !bopenwith )
    {//当前用户正在APP内部,,
//        myalert *alertVC = [[myalert alloc]initWithTitle:@"提示" message:@"有新的消息是否查看?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好的", nil];
////        alertVC.obj = pushobj;
//        [alertVC show];
    }
    else
    {
        
//        if( pushobj.mType == 1 )
//        {
//            myMessageViewController* vc = [[myMessageViewController alloc]init];
//            [(UINavigationController*)((UITabBarController*)self.window.rootViewController).selectedViewController pushViewController:vc animated:YES];
//        }
//        else if( pushobj.mType == 2 )
//        {
//            WebVC* vc = [[WebVC alloc]init];
//            vc.mName = @"详情";
//            vc.mUrl = pushobj.mArgs;
//        }
//        else if( pushobj.mType == 3 )
//        {
//            orderDetail* vc = [[orderDetail alloc]initWithNibName:@"orderDetail" bundle:nil];
//            vc.mtagOrder = SOrder.new;
//            vc.mtagOrder.mId = [pushobj.mArgs intValue];
//            [(UINavigationController*)((UITabBarController*)self.window.rootViewController).selectedViewController pushViewController:vc animated:YES];
//        }
    }
}

-(void)goToVCWithPush:(JPushReceiveObject *)item
{
    if (![item.model isEqualToString:@"service"]) { //如果不是跑跑接收者消息
        return;
    }
    
    UITabBarController *tabVC = ((UITabBarController*)self.window.rootViewController);
    tabVC.selectedIndex = 0;
    
    if (tabVC != nil) {
        UINavigationController *navVC = (UINavigationController*)tabVC.selectedViewController;
        NSArray *arr = navVC.viewControllers;
        
        if (arr.count > 0) {
            NSMutableArray *arrNew = [NSMutableArray array];
            homeViewController *vc = (homeViewController *)[arr objectAtIndex:0];
            vc.withOutLogin = YES;
            [arrNew addObject:vc];
            [navVC setViewControllers:arrNew animated:NO];
            
            BOOL haveLoginVC = [ViewController haveViewController];
            if (haveLoginVC == YES) {
                ViewController *vc = [ViewController shareInstance];
                [vc dismissViewControllerAnimated:YES completion:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"back"object:nil];
            }
            
            [vc performSelector:@selector(jPushToSenderVCWithType:) withObject:item.order_type afterDelay:0.1];
        }

    }

}

- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias {
    
    MLLog(@"tag:%@ alias%@ irescod:%d",tags,alias,iResCode);
    if( iResCode == 6002 )
    {
//        [SUser  relTokenWithPush];
        [mUserInfo openPush];
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 10000) {
        
        if (buttonIndex == 0) {
            [mUserInfo logOut];
            [self gotoLogin];

        }
    }else{
        if (buttonIndex == 1) {
            JPushReceiveObject* pushobj = ((myalert *)alertView).obj;
            
            [self goToVCWithPush:pushobj];
            //        SMessageInfo* pushobj = ((myalert *)alertView).obj;
            
            //        if( pushobj.mType == 1 )
            //        {
            //            myMessageViewController* vc = [[myMessageViewController alloc]init];
            //            [(UINavigationController*)((UITabBarController*)self.window.rootViewController).selectedViewController pushViewController:vc animated:YES];
            //        }
            //        else if( pushobj.mType == 2 )
            //        {
            //            WebVC* vc = [[WebVC alloc]init];
            //            vc.mName = @"详情";
            //            vc.mUrl = pushobj.mArgs;
            //        }
            //        else if( pushobj.mType == 3 )
            //        {
            //
            //            orderDetail *order = [[orderDetail alloc] initWithNibName:@"orderDetail" bundle:nil];
            //            SOrder *s = [[SOrder alloc] init];
            //            s.mId = [pushobj.mArgs intValue];
            //            order.mtagOrder = s;
            //            [(UINavigationController*)((UITabBarController*)self.window.rootViewController).selectedViewController pushViewController:order animated:YES];
            //        }
            //
        }
        
    }
}
-(void)gotoLogin
{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    id viewController = [storyboard instantiateViewControllerWithIdentifier:@"login"];
    UINavigationController* nownav = (UINavigationController*)((UITabBarController*)self.window.rootViewController).selectedViewController;
    
    UIViewController* vcvc = [nownav topViewController];
    
    if( [vcvc isKindOfClass:[ViewController class]] )
    {//如果顶层是 LoginVC 就不去了
        
    }
    else
    {
        //这里还处理一个事情,就是退出登陆,,要把无效的token,去除..
        
        [mUserInfo logOut];
        [vcvc presentViewController:viewController animated:YES completion:nil];
        
    }
}

-(void)dealFuncTab
{
    
//    UITabBarController* rootvc = (UITabBarController*)self.window.rootViewController;
//    if( ![SUser currentUser].isSeller )
//    {
//        NSMutableArray* a = [NSMutableArray arrayWithArray: rootvc.viewControllers];
//        if( a.count == 4 )
//        {
//            _theshop = [a objectAtIndex:2];
//            [a removeObjectAtIndex:2];
//            [rootvc setViewControllers:a animated:YES];
//        }
//    }
//    else
//    {
//        NSMutableArray* a = [NSMutableArray arrayWithArray: rootvc.viewControllers];
//        if( a.count == 2 )
//        {
//            [a insertObject:_theshop atIndex:3];
//            [rootvc setViewControllers:a animated:YES];
//        }
//    }
    
}


- (void)didReceiveMessageNotification:(NSNotification *)notification {
    
    RCMessage *message = notification.object;
    if (message.messageDirection == MessageDirection_RECEIVE) {
        [UIApplication sharedApplication].applicationIconBadgeNumber =
        [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
    }

}



@end
