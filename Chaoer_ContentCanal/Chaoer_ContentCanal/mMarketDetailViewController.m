//
//  mMarketDetailViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/27.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mMarketDetailViewController.h"
#import "mCommunityMyViewCell.h"

#import "mMarketHeaderView.h"

#import "shopCarViewController.h"

#import "mGoodsDetailViewController.h"

#import "goodsSearchViewController.h"
#import "YT_ShopTypeView.h"

#import "mClassMoreViewController.h"

@interface mMarketDetailViewController ()<UITableViewDelegate,UITableViewDataSource,WKSegmentControlDelagate,TypeViewDelegate>


@end

@implementation mMarketDetailViewController
{

    int mType;

    mMarketHeaderView *mHeaderView;
 
    UIView *mSectionView;
    
    
    NSMutableArray *mBanerArr;
    /**
     *  购物车按钮
     */
    UIButton *mShopCarBtn;
    /**
     *  购物车view
     */
    UIView *mShopCarView;
    /**
     *  购物车气泡
     */
    UILabel *mShopCarBadge;
    /**
     *  购物车数量
     */
    int mShopCarNum;
    
    YT_ShopTypeView *typeView;

}

- (void)viewDidLoad {
    self.hiddenTabBar = YES;

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    self.hiddenlll = YES;
    self.Title = self.mPageName = @"超市详情";
    self.rightBtnImage = [UIImage imageNamed:@"search-1"];
    mType = 1;
    mShopCarNum = 0;
    [self currentArrar];
    [self initView];
}

- (void)currentArrar{
    mBanerArr = [NSMutableArray new];
    
    for (int i = 0; i<6; i++) {
        [mBanerArr addObject:[NSString stringWithFormat:@"第%d个",i]];
    }
    
    
}

- (void)initView{
    

    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    
    self.haveHeader = YES;
    
    
    UINib   *nib = [UINib nibWithNibName:@"mCommunityCollectCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    
    
    mHeaderView = [mMarketHeaderView shareView];
    mHeaderView.frame = CGRectMake(0, 0, DEVICE_Width, 90);
    [self.tableView setTableHeaderView:mHeaderView];
    
 
    
    typeView =[[YT_ShopTypeView alloc] initZhongXiaoTypeViewWithPoint:CGPointMake(0, 64) AndArray:@[@"生鲜",@"水果",@"蔬菜",@"饮料",@"肉类",@"食品"]];
    typeView.delegate=self;
    
    
   
    mShopCarView = [UIView new];
    mShopCarView.frame = CGRectMake(DEVICE_Width-80, DEVICE_Height-100, 60, 60);
    mShopCarView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mShopCarView];
    
    mShopCarBtn = [UIButton new];
    mShopCarBtn.frame = CGRectMake(0, 0, 60, 60);
    
    [mShopCarBtn setBackgroundImage:[UIImage imageNamed:@"market_shopcar"] forState:0];
    [mShopCarBtn addTarget:self action:@selector(mshopCarAction:) forControlEvents:UIControlEventTouchUpInside];
    [mShopCarView addSubview:mShopCarBtn];
    
    mShopCarBadge = [UILabel new];
    mShopCarBadge.hidden = YES;

    mShopCarBadge.frame = CGRectMake(mShopCarView.mwidth-15, 0, 18, 18);
    mShopCarBadge.layer.masksToBounds = YES;
    mShopCarBadge.layer.cornerRadius = mShopCarBadge.mwidth/2;
    mShopCarBadge.textColor = [UIColor whiteColor];
    mShopCarBadge.backgroundColor = [UIColor redColor];
    mShopCarBadge.textAlignment = NSTextAlignmentCenter;
    mShopCarBadge.font = [UIFont systemFontOfSize:12];
    [mShopCarView addSubview:mShopCarBadge];
    


}
#pragma mark----更多按钮
- (void)clickXiaBtn:(BOOL)isClicked{

    mClassMoreViewController *class = [[mClassMoreViewController alloc] initWithNibName:@"mClassMoreViewController" bundle:nil];
    [self pushViewController:class];
    
    if (isClicked) {
        NSLog(@"点击了？");
    }else{
        NSLog(@"取消？");
    }
}
- (void)clickBtnIndex:(NSInteger)mIndex{
    NSLog(@"%ld",(long)mIndex);
}

/**
 *  验证
 */
- (void)verifyBadge{

    if (mShopCarNum <= 0) {
        mShopCarBadge.hidden = YES;
        
    }else{
        mShopCarBadge.hidden = NO;
        
    }
}
- (void)mshopCarAction:(UIButton *)sender{

    MLLog(@"购物车");
    shopCarViewController *shopCar = [[shopCarViewController alloc] initWithNibName:@"shopCarViewController" bundle:nil];
    [self pushViewController:shopCar];
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
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    return typeView;
    
}

- (void)moreAction:(UIButton *)sender{

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 5;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    return 200;

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellId = nil;
    
    cellId = @"cell";
    
    mCommunityMyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.mLeftTagImg.hidden = cell.mRightTagImg.hidden = NO;
    
    return cell;
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    mGoodsDetailViewController *goods = [[mGoodsDetailViewController alloc] initWithNibName:@"mGoodsDetailViewController" bundle:nil];
    [self pushViewController:goods];
}
- (void)WKDidSelectedIndex:(NSInteger)mIndex{
    MLLog(@"点击了%lu",(unsigned long)mIndex);
    
    mType = [[NSString stringWithFormat:@"%ld",(long)mIndex+1] intValue];
    [self.tableView reloadData];
    //    [self.tableView headerBeginRefreshing];
    
}
#pragma mark----搜索
- (void)rightBtnTouched:(id)sender{

    goodsSearchViewController *mSearch = [[goodsSearchViewController alloc] initWithNibName:@"goodsSearchViewController" bundle:nil];
    [self pushViewController:mSearch];
    
}

@end
