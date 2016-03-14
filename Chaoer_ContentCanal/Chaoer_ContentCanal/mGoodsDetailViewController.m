//
//  mGoodsDetailViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/12.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mGoodsDetailViewController.h"


#import "mAddressView.h"

@interface mGoodsDetailViewController ()

@end

@implementation mGoodsDetailViewController
{

    UIScrollView *mScrollerView;
    
    mAddressView *mGoodsDetailView;
    
    mAddressView *mBottomView;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.hiddenTabBar = YES;
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.Title = self.mPageName = _mTitle;
    self.view.backgroundColor = [UIColor colorWithRed:0.19 green:0.19 blue:0.19 alpha:1];
    [self initView];
}
- (void)initView{

    mScrollerView = [UIScrollView new];
    mScrollerView.backgroundColor = [UIColor whiteColor];
    mScrollerView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-114);
    [self.view addSubview:mScrollerView];
    

    
    NSString *str = @"你实在是忘记了  就打电话 13648384838你实在是忘记了  就打电话 13648384838你实在是忘记了  就打电话 13648384838你实在是忘记了  就打电话 13648384838";
    

    
    mGoodsDetailView = [mAddressView shareGoodsDetailView];
    mGoodsDetailView.mGoodsBrief.text = str;
    CGFloat mBH = [Util labelText:str fontSize:15 labelWidth:mGoodsDetailView.mGoodsBrief.mwidth];
    
    CGFloat mTH = 440-18+mBH;
    
    if (mTH <= 440) {
        mTH = 440;
    }
    
    mGoodsDetailView.frame = CGRectMake(0, 0, mScrollerView.mwidth, mTH);
    [mScrollerView addSubview:mGoodsDetailView];
    

    
    mBottomView = [mAddressView shareShopCar];
    mBottomView.frame = CGRectMake(0, DEVICE_Height-50, self.view.bounds.size.width, 50);
    [self.view addSubview:mBottomView];
    

    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, mTH);

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
