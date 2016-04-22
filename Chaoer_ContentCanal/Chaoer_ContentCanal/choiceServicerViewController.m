//
//  choiceServicerViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/23.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "choiceServicerViewController.h"
#import "serviceDetailView.h"
@interface choiceServicerViewController ()

@end

@implementation choiceServicerViewController
{

    UIScrollView *mScrollerVie;
    
    serviceDetailView   *mView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Title = self.mPageName = @"维修人员信息";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    [self initView];
}
- (void)initView{

    mScrollerVie = [UIScrollView new];
    mScrollerVie.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64);
    mScrollerVie.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    [self.view addSubview:mScrollerVie];
    
    
    mView = [serviceDetailView shareView];
    mView.frame = CGRectMake(0, 0, DEVICE_Width, 568);
    
    
    
    mView.mName.text = self.mS.mMerchantName;
    mView.mPhpone.text  = self.mS.mMerchantPhone;
    
    mView.mPrice.text = @"暂无";
    mView.mCompany.text = @"暂无";
    
    float x = self.mS.mPraiseRate;
    mView.mRaitView.numberOfStars = 5;
    mView.mRaitView.scorePercent = x/10;
    mView.mRaitView.allowIncompleteStar = YES;
    mView.mRaitView.hasAnimation = YES;
    
    [mScrollerVie addSubview:mView];
    
    mScrollerVie.contentSize = CGSizeMake(DEVICE_Width, 568);
    
    
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
