//
//  mClassMoreViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mClassMoreViewController.h"
#import "WKLabelView.h"

@interface mClassMoreViewController ()<ViewWithBgViewDidSelectedDelegate>

@end

@implementation mClassMoreViewController
{

    UIScrollView *mScrollerView;
    
    WKLabelView *mBtnView;

    
}
- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.mPageName = self.Title = @"更多分类";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    [self initView];
    [self loadData];
}
- (void)initView{

    mScrollerView = [UIScrollView new];
    mScrollerView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    [self.view addSubview:mScrollerView];
    
    [mScrollerView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).offset(@0);
        make.top.equalTo(self.view).offset(@64);
    }];
    
    
}

- (void)loadData{

    mBtnView=[[WKLabelView alloc]init];
    
    [mBtnView setArray:nil];
    mBtnView.delegate = self;
    mBtnView.backgroundColor=[UIColor whiteColor];

    
    [mScrollerView addSubview:mBtnView];

    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, mBtnView.frame.origin.y+mBtnView.mheight+30);

    
    
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
