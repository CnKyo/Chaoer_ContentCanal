//
//  senderDetailViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/6.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "senderDetailViewController.h"
#import "senderSubView.h"
@interface senderDetailViewController ()

@end

@implementation senderDetailViewController
{

    UIScrollView *mScrollerView;
    
    senderSubView   *mView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.Title = self.mPageName = @"跑腿详情";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    [self initView];
}



- (void)initView{

    mScrollerView = [UIScrollView new];
    mScrollerView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64);
    mScrollerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mScrollerView];
    
    mView = [senderSubView shareView];
    mView.frame = CGRectMake(0, 0, DEVICE_Width, 568);
    [mScrollerView addSubview:mView];
    
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 568);
    
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
