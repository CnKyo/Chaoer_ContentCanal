//
//  payViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "payViewController.h"

#import "canalViewController.h"
#import "wpgViewController.h"
@interface payViewController ()

@end

@implementation payViewController
{
    mAddressView *mAdView;
}
- (void)viewDidLoad {
    self.hiddenTabBar = YES;

    [super viewDidLoad];


    self.Title = self.mPageName = @"缴费功能";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    
    [self initView];
    
}

- (void)initView{

    mAdView = [mAddressView shareView];
    [self.view addSubview:mAdView];
    [mAdView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0);
        make.top.equalTo(self
                         .view).offset(64);
        make.height.offset(50);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  物管费
 *
 *  @param sender
 */
- (IBAction)mCanalAction:(id)sender {
    canalViewController *ccc= [canalViewController new];
    
    ccc.mTitel= @"缴费－物管费";
    [self pushViewController:ccc];
    
}
/**
 *  水电气费
 *
 *  @param sender
 */
- (IBAction)mThreeAction:(id)sender {
    wpgViewController *www = [wpgViewController new];
    [self pushViewController:www];
}
/**
 *  停车费
 *
 *  @param sender
 */
- (IBAction)mParkAction:(id)sender {
    canalViewController *ccc= [canalViewController new];
    ccc.mTitel= @"缴费－停车费";

    [self pushViewController:ccc];
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
