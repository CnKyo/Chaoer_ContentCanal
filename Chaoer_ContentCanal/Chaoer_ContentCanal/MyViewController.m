//
//  MyViewController.m
//  O2O_XiCheSeller
//
//  Created by 密码为空！ on 15/6/18.
//  Copyright (c) 2015年 zongyoutec.com. All rights reserved.
//

#import "MyViewController.h"

#import "mPersonView.h"


#import "mCodeNameViewController.h"

#import "activityCenterViewController.h"
#import "myRedBagViewController.h"
#import "myOrderViewController.h"
@interface MyViewController ()

@end

@implementation MyViewController{

    UIScrollView *mScrollerView;
    
    mPersonView *mHeaderView;
    
    mPersonView *mRightView;
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Title = self.mPageName = @"个人中心";
    self.hiddenBackBtn = YES;
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    self.navBar.hidden = NO;
    [self loadRightView];
    [self initView];
}
#pragma mark----初始化右边的按钮
- (void)loadRightView{

    mRightView = [mPersonView shareRightView];
    mRightView.frame = CGRectMake(DEVICE_Width-80, 16, 80, 50);
    
    [mRightView.mMessageBtn addTarget:self action:@selector(mRightAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:mRightView];
    
}
- (void)mRightAction:(UIButton *)sender{
    NSLog(@"消息");
}
#pragma mark----构造主页面
- (void)initView{

    mScrollerView = [UIScrollView new];
    mScrollerView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-114);
    mScrollerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mScrollerView];

    mHeaderView = [mPersonView shareView];
    mHeaderView.frame = CGRectMake(0, 0, DEVICE_Width, 250);
    [mScrollerView addSubview:mHeaderView];
    
    
    float x = 0;
    float y = mHeaderView.mbottom+10;
    
    float btnWidth = DEVICE_Width/3;
    
    NSArray *mRR = @[@"实名认证",@"活动中心",@"我的红包",@"出租房",@"我的订单",@"设置"];
    
    for (int i = 0; i<mRR.count; i++) {
        
        UIButton    *btn = [UIButton new];
        btn.frame = CGRectMake(x, y, btnWidth, 110);
        [btn setImage:[UIImage imageNamed:@"meassage"] forState:0];
        [btn setTitle:mRR[i] forState:0];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];

        [btn setTitleColor:[UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1] forState:0];
        btn.imageEdgeInsets  = UIEdgeInsetsMake(-20, 24, 0, 0);
        btn.titleEdgeInsets = UIEdgeInsetsMake(90, -75, 20, 0);
        
        [btn setBackgroundColor:[UIColor whiteColor] forUIControlState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor lightGrayColor] forUIControlState:UIControlStateSelected];
        
        btn.tag = i;
        [btn addTarget:self action:@selector(mCusBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [mScrollerView addSubview:btn];
        
        x += btnWidth;
        
        if (x >= DEVICE_Width) {
            x = 0;
            y += 110;
        }
        
        
    }
    
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, y);
    
}
#pragma mark----按钮点击事件
- (void)mCusBtnAction:(UIButton *)sender{
    NSLog(@"第%ld个",(long)sender.tag);
    
    switch (sender.tag) {
        case 0:
        {
            mCodeNameViewController *mmm = [[mCodeNameViewController alloc] initWithNibName:@"mCodeNameViewController" bundle:nil];
            [self pushViewController:mmm];
        
        }
            break;
        case 1:
        {
            activityCenterViewController *mmm = [[activityCenterViewController alloc] initWithNibName:@"activityCenterViewController" bundle:nil];
            [self pushViewController:mmm];
            
        }
            break;
        case 2:
        {
            myRedBagViewController *mmm = [[myRedBagViewController alloc] initWithNibName:@"myRedBagViewController" bundle:nil];
            [self pushViewController:mmm];
            
        }
            break;
            
        case 4:
        {
            myOrderViewController *mmm = [[myOrderViewController alloc] initWithNibName:@"myOrderViewController" bundle:nil];
            [self pushViewController:mmm];
            
        }
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
