//
//  zhongchouViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "zhongchouViewController.h"
#import "mZhongchouView.h"

#import "mTouzhiViewController.h"
@interface zhongchouViewController ()

@end

@implementation zhongchouViewController
{
    /**
     *  主视图
     */
    UIScrollView    *mainScrollerView;
    /**
     *  子视图
     */
    UIScrollView    *mSubScrollerView;
    /**
     *  顶部视图
     */
    mZhongchouView  *mTopView;
    /**
     *  底部视图
     */
    mZhongchouView  *mBottomView;
    /**
     *  子视图
     */
    mZhongchouView  *mSubView;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.Title = self.mPageName = @"众筹活动";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.95 alpha:1];
    [self initView];
}


- (void)initView{

    mainScrollerView = [UIScrollView new];
    mainScrollerView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64);
    mainScrollerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mainScrollerView];
    
    
    mTopView = [mZhongchouView shareTopView];
    mTopView.frame = CGRectMake(0, 0,DEVICE_Width, 302);
    [mainScrollerView addSubview:mTopView];

    
    mSubScrollerView = [UIScrollView new];
    mSubScrollerView.frame = CGRectMake(10, 0, DEVICE_Width-20, mTopView.mMainView.mheight);
    mSubScrollerView.showsVerticalScrollIndicator = NO;
    mSubScrollerView.showsHorizontalScrollIndicator = NO;
    [mTopView.mMainView addSubview:mSubScrollerView];
    
    CGFloat width = (DEVICE_Width-20)/3;
    float x = 0;
    float y = 5;
    for (int i = 0; i<80; i ++) {
        mSubView = [mZhongchouView shareSubView];
        mSubView.frame = CGRectMake(x,y, width-5, 90);
        [mSubScrollerView addSubview:mSubView];
        x += width;
        if (x>=DEVICE_Width-width) {
            x=0;
            y+=100;
        }
    }
    mSubScrollerView.contentSize = CGSizeMake(mTopView.mMainView.mwidth-20, y+100);
    
    
    mBottomView = [mZhongchouView shareBottomView];
    mBottomView.frame = CGRectMake(0, mTopView.mbottom+5, DEVICE_Width, 150);
    [mBottomView.mActivityBtn addTarget:self action:@selector(mJoinAction:) forControlEvents:UIControlEventTouchUpInside];
    [mainScrollerView addSubview:mBottomView];
    
    mainScrollerView.contentSize = CGSizeMake(DEVICE_Width, mBottomView.mbottom+10);
    
}
#pragma mark----众筹活动按钮
- (void)mJoinAction:(UIButton *)sender{

    mTouzhiViewController *mmm = [[mTouzhiViewController alloc] initWithNibName:@"mTouzhiViewController" bundle:nil];
    [self pushViewController:mmm];
    
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
