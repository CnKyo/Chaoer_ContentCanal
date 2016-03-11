//
//  canalViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "canalViewController.h"
#import "canPayView.h"

#import "mBalanceViewController.h"

@interface canalViewController ()<UITextFieldDelegate>

@end

@implementation canalViewController

{
    
    UIScrollView *mScrollerView;
    canPayView *mCanView;
    
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
    self.Title = self.mPageName = _mTitel;
    self.hiddenTabBar = YES;
    self.hiddenlll = YES;
    
    self.rightBtnTitle = @"纪录查询";
    CGRect  mrr = self.navBar.rightBtn.frame;
    mrr.size.width = 100;
    mrr.origin.x = DEVICE_Width-80;
    self.navBar.rightBtn.frame = mrr;
    [self initView];
    
}
- (void)initView{
    
    
    mScrollerView = [UIScrollView new];
    mScrollerView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-50);
    mScrollerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mScrollerView];

    
    mCanView = [canPayView shareView];
    mCanView.frame = CGRectMake(0, 0, mScrollerView.mwidth, 568);
    
    mCanView.mMoneyTx.delegate = mCanView.mNumTx.delegate = mCanView.mNameTx.delegate = self;
    
    [mCanView.mTopup addTarget:self action:@selector(mTopupAction:) forControlEvents:UIControlEventTouchUpInside];
    [mCanView.mBalanceBtn addTarget:self action:@selector(mBalanceAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [mScrollerView addSubview:mCanView];
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 568);
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
    
    
}
#pragma  mark -----键盘消失
- (void)tapAction{
    [mCanView.mMoneyTx resignFirstResponder];
    [mCanView.mNumTx resignFirstResponder];
    [mCanView.mNameTx resignFirstResponder];
    
}
/**
 *  充值
 *
 *  @param sender
 */
- (void)mTopupAction:(UIButton *)sender{
    NSLog(@"充值");
    mBalanceViewController *bbb = [[mBalanceViewController alloc] initWithNibName:@"mBalanceViewController" bundle:nil];
    [self pushViewController:bbb];
}
/**
 *  缴费
 *
 *  @param sender
 */
- (void)mBalanceAction:(UIButton *)sender{
    NSLog(@"缴费");
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
