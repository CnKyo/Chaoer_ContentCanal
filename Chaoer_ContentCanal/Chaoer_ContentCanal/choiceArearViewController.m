//
//  choiceArearViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/20.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "choiceArearViewController.h"

@interface choiceArearViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation choiceArearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"选择小区";
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



@end
