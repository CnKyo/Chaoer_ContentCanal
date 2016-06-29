//
//  mGoodsDetailViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/29.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mGoodsDetailViewController.h"

#import "GoodsDetailNavView.h"

@interface mGoodsDetailViewController ()

@end

@implementation mGoodsDetailViewController
{

    GoodsDetailNavView *mNavView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self initNavBarView];
    
    
}

#pragma mark----初始化导航条
- (void)initNavBarView{

    mNavView = [GoodsDetailNavView shareView];
    mNavView.frame = CGRectMake(0, 0, DEVICE_Width, 64);
    [mNavView.mBackBtn addTarget:self action:@selector(mBackAction:) forControlEvents:UIControlEventTouchUpInside];
    [mNavView.mShareBtn addTarget:self action:@selector(mShareAction:) forControlEvents:UIControlEventTouchUpInside];
    [mNavView.mCollectBtn addTarget:self action:@selector(mCollectionAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:mNavView];
    
}
#pragma mark----返回按钮
- (void)mBackAction:(UIButton *)sender{

}
#pragma mark----分享按钮
- (void)mShareAction:(UIButton *)sender{
    
}
#pragma mark----收藏按钮
- (void)mCollectionAction:(UIButton *)sender{
    
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
