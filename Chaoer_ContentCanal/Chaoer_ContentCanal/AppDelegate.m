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
#import <QMapKit/QMapKit.h>

#import "MyViewController.h"
#import "APService.h"

#import "WebVC.h"
#import "ViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"


#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"

#import <RongIMKit/RongIMKit.h>


@interface AppDelegate ()<UIAlertViewDelegate,WXApiDelegate>

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
    [MAMapServices sharedServices].apiKey = @"d4ff1a6b1fa8db2ec9ee2d016d03a8e0";
    [AMapSearchServices sharedServices].apiKey = @"d4ff1a6b1fa8db2ec9ee2d016d03a8e0";
    [AMapLocationServices sharedServices].apiKey = @"d4ff1a6b1fa8db2ec9ee2d016d03a8e0";
    [MTA startWithAppkey:@"I1DMN7E2WA6K"];
    [QMapServices sharedServices].apiKey = QQMAPKEY;
    [WXApi registerApp:@"wxa2ca4ec0aa044c24" withDescription:[Util getAPPName]];// 配置info.plist的 Scheme,
    
    
    [[RCIM sharedRCIM] initWithAppKey:@"n19jmcy59znh9"];
    
    
    
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:@"iosv1101"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeMail),
                            @(SSDKPlatformTypeSMS),
                            @(SSDKPlatformTypeCopy),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeRenren),
                            @(SSDKPlatformTypeGooglePlus)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;

             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"11070552590dc"
                                           appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                       appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"100371282"
                                      appKey:@"11070552590dc"
                                    authType:SSDKAuthTypeBoth];
                 break;
                 
                default:
                 break;
         }
     }];

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    
    [self initExtComp];
    
    
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
    
    
    [APService setupWithOption:launchOptions];
    
//    [SUser relTokenWithPush];
//    
//    
//    [GInfo getGInfo:^(SResBase *resb, GInfo *gInfo) {
//        
//        if (resb.msuccess) {
//            
//        }
//        else{
//        
//        }
//        
//    }];
    
    
    [self dealFuncTab];
    NSDictionary *notificationPayload = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if( notificationPayload )
    {
#warning push->notification

        [self performSelector:@selector(pushView:) withObject:notificationPayload afterDelay:1.0f];
         
    }
    return YES;
}

- (void)pushView:(NSDictionary *)dic{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notify"object:dic];

}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    // url:wx206e0a3244b4e469://pay/?returnKey=&ret=0 withsouce url:com.tencent.xin
    MLLog(@"url:%@ withsouce url:%@",url,sourceApplication);
    if( [sourceApplication isEqualToString:@"com.tencent.xin"] )
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
        
//        SResBase* retobj = SResBase.new;
//        if( resp.errCode == -1 )
//        {//
//            retobj.msuccess = NO;
//            retobj.mmsg = @"支付出现异常";
//        }
//        else if( resp.errCode == -2 )
//        {
//            retobj.msuccess = NO;
//            retobj.mmsg = @"用户取消了支付";
//        }
//        else
//        {
//            retobj.msuccess = YES;
//            retobj.mmsg = @"支付成功";
//        }
//        
//        if( [SAppInfo shareClient].mPayBlock )
//        {
//            [SAppInfo shareClient].mPayBlock(retobj);
//        }
//        else
//        {
//            MLLog(@"may be err no block to back");
//        }
    }
    else
    {
        MLLog(@"may be err what class one onResp");
    }
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [application setApplicationIconBadgeNumber:0];
    [APService resetBadge];

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)gotoLogin
{
    UINavigationController* navvc = (UINavigationController*)((UITabBarController*)self.window.rootViewController).selectedViewController;
    
    if( [navvc.topViewController isKindOfClass:[ViewController class]] )
    {
        return;
    }
    
    
//    [SUser logout];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    id viewController = [storyboard instantiateViewControllerWithIdentifier:@"login"];
    
    [(UINavigationController*)((UITabBarController*)self.window.rootViewController).selectedViewController pushViewController:viewController animated:YES];
}
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"reg push err:%@",error);
}
#pragma mark*-*----加载推送通知
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [APService registerDeviceToken:deviceToken];
    
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    if (application.applicationState == UIApplicationStateActive) {
        
        [self dealPush:userInfo bopenwith:NO];
    }
    else
    {
        [self dealPush:userInfo bopenwith:YES];
    }
}
-(void)dealPush:(NSDictionary*)userinof bopenwith:(BOOL)bopenwith
{
//    SMessageInfo* pushobj = [[SMessageInfo alloc]initWithAPN:userinof];
    
    if( !bopenwith )
    {//当前用户正在APP内部,,
        myalert *alertVC = [[myalert alloc]initWithTitle:@"提示" message:@"有新的消息是否查看?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好的", nil];
//        alertVC.obj = pushobj;
        [alertVC show];
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

- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias {
    
    NSLog(@"tag:%@ alias%@ irescod:%d",tags,alias,iResCode);
    if( iResCode == 6002 )
    {
//        [SUser  relTokenWithPush];
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        
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




@end
