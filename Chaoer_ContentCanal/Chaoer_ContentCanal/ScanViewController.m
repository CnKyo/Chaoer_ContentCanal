//
//  ScanViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/22.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "ScanViewController.h"
#import "mScanViewController.h"
@interface ScanViewController ()

@end

@implementation ScanViewController

- (void)viewDidLoad {
    self.hiddenTabBar   = YES;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Title = self.mPageName = @"扫描";
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    [self initView];

}
- (void)initView{
    
    mScanViewController *mmm = [[mScanViewController alloc] init];
    mmm.view.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64);
    [self addChildViewController:mmm];
    [self.view addSubview:mmm.view];
    
    
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
