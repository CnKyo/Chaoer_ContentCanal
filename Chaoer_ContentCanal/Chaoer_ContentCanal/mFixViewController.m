//
//  mFixViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mFixViewController.h"

#import "mFixView.h"


#import "takeFixViewController.h"
@interface mFixViewController ()

@end

@implementation mFixViewController
{
    UIScrollView *mScrollerView;
    mFixView *mView;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /**
     IQKeyboardManager为自定义收起键盘
     **/
    [[IQKeyboardManager sharedManager] setEnable:YES];///视图开始加载键盘位置开启调整
    [[IQKeyboardManager sharedManager]setEnableAutoToolbar:YES];///是否启用自定义工具栏
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;///启用手势
    //    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];///视图消失键盘位置取消调整
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];///关闭自定义工具栏
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Title = self.mPageName = @"物业报修";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    [self initView];
    
}
- (void)initView{
    
    
    UIImageView *mbgk = [UIImageView new];
    CGRect  mrr = self.view.bounds;
    mrr.origin.y = 64;
    mbgk.frame = mrr;
    mbgk.image = [UIImage imageNamed:@"mBaseBgkImg"];
    [self.view addSubview:mbgk];
    
    mScrollerView = [UIScrollView new];
    mScrollerView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-50);
    mScrollerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mScrollerView];
    
    
    mView = [mFixView shareView];
    mView.frame = CGRectMake(0, 0, DEVICE_Width, 568);
    [mView.mYuyueBtn addTarget:self action:@selector(mTakeAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mPayBtn addTarget:self action:@selector(mPayAction:) forControlEvents:UIControlEventTouchUpInside];

    
    [mScrollerView addSubview:mView];
    
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 568);
    
    
}
- (void)mTakeAction:(UIButton *)sender{
    takeFixViewController *ttt = [takeFixViewController new];
    ttt.mTitle = @"预约报修";
    [self pushViewController:ttt];
}

- (void)mPayAction:(UIButton *)sender{
    takeFixViewController *ttt = [takeFixViewController new];
    ttt.mTitle = @"付款报修";
    [self pushViewController:ttt];
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
