//
//  mSuperMarketViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/12.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mSuperMarketViewController.h"
#import "mSuperMarketTableViewCell.h"

#import "mAddressView.h"



@interface mSuperMarketViewController ()<UITableViewDelegate,UITableViewDataSource,WKSegmentControlDelagate>

@end

@implementation mSuperMarketViewController
{

    
    UITableView         *mTableView;
    
    UITableView         *mShopCarTable;
    
    WKSegmentControl    *mHeaderView;
    /**
     *  底部view
     */
    mAddressView        *mBottomView;
    /**
     *  购物车背景view
     */
    UIView              *mBgkView;
    /**
     *  付款详情背景view
     */
    UIView              *mPayBgkView;
    /**
     *  付款详情
     */
    UIScrollView        *mBgkScrollerView;
    /**
     *  付款详情
     */
    mAddressView        *mPayDetailView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.hiddenTabBar = YES;
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.Title = self.mPageName = @"社区服务";
    [self initShopCarView];
    [self initView];
    
    [self initShopCarTableView];
    [self initPayDetailView];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
    
}
- (void)initView{
    
    mHeaderView = [WKSegmentControl initWithSegmentControlFrame:CGRectMake(0, 64, DEVICE_Width, 40) andTitleWithBtn:@[@"最快送达",@"价格实惠",@"销量最高",@"打折活动"] andBackgroudColor:[UIColor whiteColor] andBtnSelectedColor:[UIColor colorWithRed:0.39 green:0.39 blue:0.39 alpha:1] andBtnTitleColor:[UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1] andUndeLineColor:M_CO andBtnTitleFont:[UIFont fontWithName:@".Helvetica Neue Interface" size:14.0f] andInterval:0 delegate:self andIsHiddenLine:NO];
    [self.view addSubview:mHeaderView];
    
    mTableView = [UITableView new];
    mTableView.backgroundColor = [UIColor whiteColor];
    mTableView.frame = CGRectMake(0, 104, DEVICE_Width, DEVICE_Height-149);
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.separatorStyle = UITableViewCellSelectionStyleNone;

    [self.view addSubview:mTableView];
    
    
    UINib   *nib = [UINib nibWithNibName:@"mSuperMarketTableViewCell" bundle:nil];
    [mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    


}
- (void)WKDidSelectedIndex:(NSInteger)mIndex{
    NSLog(@"第%ld个",(long)mIndex);
}
#pragma mark----底部view
- (void)initShopCarView{
    mBottomView = [mAddressView shareShopCar];
    mBottomView.frame = CGRectMake(0, DEVICE_Height-50, DEVICE_Width, 50);
    [mBottomView.mShopCar addTarget:self action:@selector(mShopCarAction:) forControlEvents:UIControlEventTouchUpInside];
    [mBottomView.mGoPay addTarget:self action:@selector(mGoPayAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mBottomView];
}
- (void)mShopCarAction:(UIButton *)sender{

    sender.selected = !sender.selected;
    
    if (sender.selected) {
        [self showShopCarView];
    }else{
        [self hiddenShopCarView];

    }
    
}
- (void)mGoPayAction:(UIButton *)sender{
    [self showPayDetailView];
}
#pragma mark----初始化购物车view
- (void)initShopCarTableView{
    
    
    CGRect mrrr = self.view.bounds;
    mrrr.size.height = self.view.bounds.size.height-50;
    
    
    mBgkView = [UIView new];
    mBgkView.frame = mrrr;
    mBgkView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    mBgkView.alpha = 0;
    [self.view addSubview:mBgkView];
    
    UIButton *mDelAllBtn = [UIButton new];
    mDelAllBtn.frame = CGRectMake(0, 0, DEVICE_Width, 45);
    [mDelAllBtn setTitleColor:[UIColor colorWithRed:0.39 green:0.39 blue:0.4 alpha:1] forState:0];
    [mDelAllBtn setTitle:@"全部清除" forState:0];
    mDelAllBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    mDelAllBtn.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
    mDelAllBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [mDelAllBtn addTarget:self action:@selector(mDelAllAction:) forControlEvents:UIControlEventTouchUpInside];
    
    mShopCarTable = [UITableView new];
    mShopCarTable.backgroundColor = [UIColor whiteColor];
    mShopCarTable.frame = CGRectMake(0, DEVICE_Height-50, DEVICE_Width, 0);
    mShopCarTable.delegate = self;
    mShopCarTable.dataSource = self;
//    mShopCarTable.separatorStyle = UITableViewCellSelectionStyleNone;
    
    UINib   *nib = [UINib nibWithNibName:@"mShopCarCell" bundle:nil];
    [mShopCarTable registerNib:nib forCellReuseIdentifier:@"cell1"];

    
    [self.view addSubview:mShopCarTable];
    
    [mShopCarTable setTableHeaderView:mDelAllBtn];

    
}
#pragma mark----加载购物车
- (void)showShopCarView{

    [UIView animateWithDuration:0.30 animations:^{
        mBgkView.alpha = 1;

        mBgkView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];

        CGRect mrrr = mShopCarTable.frame;
        mrrr.origin.y = DEVICE_Height/2-45;
        mrrr.size.height = DEVICE_Height/2;
        mShopCarTable.frame = mrrr;
    }];
}
#pragma mark----全部清除
- (void)mDelAllAction:(UIButton *)sender{

}
#pragma mark----背景点击事件
- (void)tapAction{
    [self hiddenShopCarView];
    [self hiddenPayDetailView];
}
#pragma mark----收起购物车
- (void)hiddenShopCarView{
    [UIView animateWithDuration:0.30 animations:^{
        mBgkView.alpha = 0;
        CGRect mrrr = mShopCarTable.frame;
        mrrr.origin.y = DEVICE_Height-45;
        mrrr.size.height = 0;
        mShopCarTable.frame = mrrr;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark----初始化付款详情
- (void)initPayDetailView{
    
    mPayBgkView = [UIView new];
    mPayBgkView.frame = self.view.bounds;
    mPayBgkView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    mPayBgkView.alpha = 0;
    [self.view addSubview:mPayBgkView];
    
    mBgkScrollerView = [UIScrollView new];
    mBgkScrollerView.frame = CGRectMake(0, DEVICE_Height, DEVICE_Width, 431);
    [self.view addSubview:mBgkScrollerView];
    
    mPayDetailView = [mAddressView sharepayDetailView];
    mPayDetailView.frame = CGRectMake(0, 0, DEVICE_Width, 531);
    [mPayDetailView.mCloseBtn addTarget:self action:@selector(mPayDetailAction) forControlEvents:UIControlEventTouchUpInside];
    [mBgkScrollerView addSubview:mPayDetailView];

    
    mBgkScrollerView.contentSize = CGSizeMake(DEVICE_Width, 531);

    

}
- (void)mPayDetailAction{
    [self hiddenPayDetailView];
}
#pragma mark----显示付款详情
- (void)showPayDetailView{
    [UIView animateWithDuration:0.30 animations:^{
        mPayBgkView.alpha = 1;
        
        mPayBgkView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        
        CGRect mrrr = mBgkScrollerView.frame;
        mrrr.origin.y = DEVICE_Height-431;
        mBgkScrollerView.frame = mrrr;
    }];
}
#pragma mark----收起付款详情
- (void)hiddenPayDetailView{
    [UIView animateWithDuration:0.30 animations:^{
        mPayBgkView.alpha = 0;
        CGRect mrrr = mBgkScrollerView.frame;
        mrrr.origin.y = DEVICE_Height;
        mBgkScrollerView.frame = mrrr;
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == mTableView) {
        return 5;
        
    }else{
        return 4;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == mTableView) {
        return 220;

    }else{
        return 45;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *  reuseCellId = nil;
    
    if (tableView == mTableView) {
        reuseCellId = @"cell";
        
        mSuperMarketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        [cell.mLeftBtn addTarget:self action:@selector(mLeftAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.mRightBtn addTarget:self action:@selector(mRightAction:) forControlEvents:UIControlEventTouchUpInside];

        return cell;
    }else{
        reuseCellId = @"cell1";
        
        mSuperMarketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        return cell;
    }

    
}
#pragma mark----左边的按钮
- (void)mLeftAction:(UIButton *)sender{
    NSLog(@"left");
    mGoodsDetailViewController *mmm = [[mGoodsDetailViewController alloc] initWithNibName:@"mGoodsDetailViewController" bundle:nil];
    mmm.mTitle = @"左边的";
    [self pushViewController:mmm];
}
#pragma mark----右边的按钮
- (void)mRightAction:(UIButton *)sender{
    NSLog(@"right");
    mGoodsDetailViewController *mmm = [[mGoodsDetailViewController alloc] initWithNibName:@"mGoodsDetailViewController" bundle:nil];
    mmm.mTitle = @"右边的";
    [self pushViewController:mmm];
}

@end
