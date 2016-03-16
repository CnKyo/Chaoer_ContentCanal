//
//  zhongchouViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "zhongchouViewController.h"
#import "mZhongchouView.h"

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
//
//    mainScrollerView = [UIScrollView new];
//    mainScrollerView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-50);
//    [self.view addSubview:mainScrollerView];
    
    
    mTopView = [mZhongchouView shareTopView];
//    mTopView.backgroundColor = [UIColor redColor];
    mTopView.frame = CGRectMake(0, 64,self.view.bounds.size.width, 500);
    [self.view addSubview:mTopView];
    
    mBottomView = [mZhongchouView shareBottomView];
//    mBottomView.backgroundColor = [UIColor redColor];
    mBottomView.frame = CGRectMake(0, 337, self.view.bounds.size.width, 130);
    [self.view addSubview:mBottomView];
    
//    mainScrollerView.contentSize = CGSizeMake(DEVICE_Width, 500);
    
    
    
    
    mSubScrollerView = [UIScrollView new];
    mSubScrollerView.frame = CGRectMake(0, 0, mTopView.mMainView.mwidth, mTopView.mMainView.mheight);
    [mTopView.mMainView addSubview:mSubScrollerView];
    
    CGFloat width = mTopView.mMainView.mwidth/3;
    float x = 0;
    float y = 0;
    for (int i = 0; i<8; i ++) {
        mSubView = [mZhongchouView shareSubView];
        mSubView.frame = CGRectMake(x,y, width, 90);
        [mSubScrollerView addSubview:mSubView];
        x += width;
        if (x>=mTopView.mMainView.mwidth) {
            x=0;
            y+=100;
        }
    }
    mSubScrollerView.contentSize = CGSizeMake(mTopView.mMainView.mwidth, y+100);
    
    
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
