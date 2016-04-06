//
//  activityCenterViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "activityCenterViewController.h"

#import "zhongchouViewController.h"
#import "mPublicWalerViewController.h"
@interface activityCenterViewController ()

@end

@implementation activityCenterViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.mZongchou.selected = NO;
    self.mGongyi.selected = NO;
    self.mChoujiang.selected = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"活动中心";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
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

- (IBAction)mChoujiang:(id)sender {
    UIButton *bbb = sender;
    bbb.selected = !bbb.selected;
}

- (IBAction)mZongchou:(id)sender {
    UIButton *bbb = sender;
    bbb.selected = !bbb.selected;
    zhongchouViewController *zzz = [[zhongchouViewController alloc] initWithNibName:@"zhongchouViewController" bundle:nil];
    [self pushViewController:zzz];
    
}

- (IBAction)mGongyi:(id)sender {
    UIButton *bbb = sender;
    bbb.selected = !bbb.selected;
    mPublicWalerViewController *zzz = [[mPublicWalerViewController alloc] initWithNibName:@"mPublicWalerViewController" bundle:nil];
    [self pushViewController:zzz];
}


@end
