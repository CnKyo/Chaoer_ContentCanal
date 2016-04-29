//
//  RCChatViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "RCChatViewController.h"

@interface RCChatViewController ()

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
    //[[UINavigationBar appearance]
    //setBarTintColor:[UIColor colorWithRed:(1 / 255.0f) green:(149 / 255.0f) blue:(255 / 255.0f) alpha:1]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"NavImg"] forBarMetrics:UIBarMetricsDefault];
    
    
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    
    self.hidesBottomBarWhenPushed = YES;

    self.conversationType = ConversationType_PRIVATE;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
