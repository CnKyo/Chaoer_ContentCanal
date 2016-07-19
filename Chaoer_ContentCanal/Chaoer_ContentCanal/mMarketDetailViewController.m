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
#import "QHLShoppingCarController.h"
@interface mMarketDetailViewController ()<UITableViewDelegate,UITableViewDataSource,WKSegmentControlDelagate,TypeViewDelegate,WKGoodsCellDelegate>


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
    
    int mIsFoucs;
    int mIsCP;
    
    
    int mLeftType;
    int mRightType;
    
    int mShopCollect;

    
    NSMutableArray *mClass;
    
    NSMutableArray *mDataSource;
    
}
@synthesize mShopId;

- (void)viewDidLoad {
    self.hiddenTabBar = YES;

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    mIsCP = mIsFoucs = 0;
    
    self.hiddenlll = YES;
    self.Title = self.mPageName = @"超市详情";
    self.rightBtnImage = [UIImage imageNamed:@"search-1"];
    mType = 0;
    mShopCarNum = 0;
    mClass = [NSMutableArray new];
    mDataSource = [NSMutableArray new];
    mLeftType  = mRightType = mShopCollect = 0;
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

    self.haveHeader = YES;
    self.haveFooter = YES;
    
    mHeaderView = [mMarketHeaderView shareView];
    mHeaderView.frame = CGRectMake(0, 0, DEVICE_Width, 150);
    mHeaderView.mName.text = _mShopList.mShopName;
    
    [mHeaderView.mCollectBtn addTarget:self action:@selector(mShopCollectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView setTableHeaderView:mHeaderView];
  
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

- (void)upDatePage{

    if (mIsFoucs == 0) {
        [mHeaderView.mCollectBtn setBackgroundImage:[UIImage imageNamed:@"my_ uncollect"] forState:0];
    }else{
        [mHeaderView.mCollectBtn setBackgroundImage:[UIImage imageNamed:@"my_ collect"] forState:0];
    }

    
    mHeaderView.mCollectNum.text = [NSString stringWithFormat:@"收藏数：%d",_mShopList.mSalesNum];
    mHeaderView.mNum.text = [NSString stringWithFormat:@"全部商品：%d",_mShopList.mGoodsNum];
    
}
- (void)mShopCollectAction:(UIButton *)sender{

    if (mIsFoucs == 0) {
        mShopCollect = 1;
    }else{
        mShopCollect = 0;

    }
    [self showWithStatus:@"正在操作中..."];
    [[mUserInfo backNowUser] collectShop:mShopId andType:mShopCollect block:^(mBaseData *resb) {
        [self dismiss];
        if (resb.mSucess) {
            mIsFoucs = 1;
            [self upDatePage];
            
        }else{
        
            [self showErrorStatus:resb.mMessage];
        }
    }];
    
}
- (void)loadSectionView{
    
    NSMutableArray *mclassArr = [NSMutableArray new];
    [mclassArr removeAllObjects];
    for (GClassN *Class in mClass) {
        [mclassArr addObject:Class.mName];
    }

    typeView =[[YT_ShopTypeView alloc] initZhongXiaoTypeViewWithPoint:CGPointMake(0, 64) AndArray:mclassArr];
    typeView.delegate=self;
}
- (void)headerBeganRefresh{
    self.page = 1;
    
    [[mUserInfo backNowUser] getMaeketDetail:self.page andMarketId:mShopId block:^(mBaseData *resb, NSArray *mArr, int mIsCoup, int mIsCollect,NSArray *mClassArr) {
        
        [self dismiss];
        [self headerEndRefresh];
        [self removeEmptyView];
        [self.tempArray removeAllObjects];
        [mClass removeAllObjects];
        if (resb.mSucess) {
            
            [mClass addObjectsFromArray:mClassArr];
            [self loadSectionView];
            mIsCP = mIsCoup;
            mIsFoucs = mIsCollect;
            [self upDatePage];
            if (mArr.count <= 0) {
                [self addEmptyView:nil];

            }else{
                [self.tempArray addObjectsFromArray:mArr];
                [self.tableView reloadData];
            }
        }else{
            [self addEmptyView:nil];
            [self showErrorStatus:resb.mMessage];
        }
        
    }];
}
- (void)footetBeganRefresh{
    self.page ++;
    
    [[mUserInfo backNowUser] getMaeketDetail:self.page andMarketId:mShopId block:^(mBaseData *resb, NSArray *mArr, int mIsCoup, int mIsCollect,NSArray *mClassArr) {
        
        [self dismiss];
        [self footetEndRefresh];
        [self removeEmptyView];
        [mClass removeAllObjects];

        if (resb.mSucess) {
            mIsCP = mIsCoup;
            mIsFoucs = mIsCollect;
            [mClass addObjectsFromArray:mClassArr];
            [self loadSectionView];
            [self upDatePage];
            if (mArr.count <= 0) {
                [self addEmptyView:nil];

            }else{
                [self.tempArray addObjectsFromArray:mArr];
                [self.tableView reloadData];
            }
        }else{
            [self addEmptyView:nil];
            [self showErrorStatus:resb.mMessage];
        }
        
    }];
    
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
    
    
    GClassN *Class = mClass[mIndex];
    [self.tempArray removeAllObjects];

    [[mUserInfo backNowUser] findGoodsWithShop:mShopId andCatigory:Class.mId andPage:1 andKeyWord:nil block:^(mBaseData *resb, NSArray *mArr) {
        if (resb.mSucess) {
            if (mArr.count<= 0) {
                [self addEmptyView:nil];
            }else{
                [self.tempArray addObjectsFromArray:mArr];

            }
            [self.tableView reloadData];

            
        }else{
            [self showErrorStatus:resb.mMessage];
        }
        
    }];
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
//    shopCarViewController *shopCar = [[shopCarViewController alloc] initWithNibName:@"shopCarViewController" bundle:nil];
//    [self pushViewController:shopCar];
    
    QHLShoppingCarController *shopcar = [QHLShoppingCarController new];
    [self pushViewController:shopcar];
    
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
    
    return self.tempArray.count%2==0?self.tempArray.count/2:self.tempArray.count/2+1;
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
    
    cell.delegate = self;
    
    MGoods *mGoods1 = self.tempArray[indexPath.row*2];
    MGoods *mGoods2;
    if ((indexPath.row+1)*2>self.tempArray.count) {
        cell.mRightView.hidden = YES;
    }else{
        mGoods2 = [self.tempArray objectAtIndex:indexPath.row*2+1];
        cell.mRightView.hidden = NO;
    }
    
    
    cell.mLeftName.text = mGoods1.mGoodsName;
    cell.mLeftContent.text = mGoods1.mGoodsDetail;
    cell.mLeftNum.text = [NSString stringWithFormat:@"月销：%d",mGoods1.mSalesNum];
    cell.mLeftPrice.text = [NSString stringWithFormat:@"¥%.2f",mGoods1.mGoodsPrice];
    [cell.mLeftImg sd_setImageWithURL:[NSURL URLWithString:mGoods1.mGoodsImg] placeholderImage:[UIImage imageNamed:@"DefaultImg"]];
    if (mGoods1.mIsCollect == 0) {
        [cell.mLeftCollect setBackgroundImage:[UIImage imageNamed:@"collection_empty"] forState:0];
        mLeftType = 1;
    }else{
        [cell.mLeftCollect setBackgroundImage:[UIImage imageNamed:@"collection_real"] forState:0];
        mLeftType = 0;
    }
    
    if (mGoods1.mGoodsHot != nil || mGoods1.mGoodsHot.length != 0) {
        cell.mLeftTagImg.image = [UIImage imageNamed:@"market_hot"];
    }else if (mGoods1.mGoodsCampain != nil || mGoods1.mGoodsCampain.length != 0){
        cell.mLeftTagImg.image = [UIImage imageNamed:@"market_ Promotion"];
    }else{
        cell.mLeftTagImg.hidden = YES;
    }
    
    cell.mLeftCollect.tag = mGoods1.mGoodsId;
    
    cell.mRightName.text = mGoods2.mGoodsName;
    cell.mRightContent.text = mGoods2.mGoodsDetail;
    cell.mRightNum.text = [NSString stringWithFormat:@"月销：%d",mGoods2.mSalesNum];
    cell.mRightPrice.text = [NSString stringWithFormat:@"¥%.2f",mGoods2.mGoodsPrice];
    [cell.mRightImg sd_setImageWithURL:[NSURL URLWithString:mGoods2.mGoodsImg] placeholderImage:[UIImage imageNamed:@"DefaultImg"]];
    
    if (mGoods2.mIsCollect == 0) {
        [cell.mRightCollect setBackgroundImage:[UIImage imageNamed:@"collection_empty"] forState:0];
        mRightType = 1;
    }else{
        [cell.mRightCollect setBackgroundImage:[UIImage imageNamed:@"collection_real"] forState:0];
        mRightType = 0;
    }
    
    if (mGoods2.mGoodsHot != nil || mGoods2.mGoodsHot.length != 0) {
        cell.mRightTagImg.image = [UIImage imageNamed:@"market_hot"];
    }else if (mGoods2.mGoodsCampain != nil || mGoods2.mGoodsCampain.length != 0){
        cell.mRightTagImg.image = [UIImage imageNamed:@"market_ Promotion"];
    }else{
        cell.mRightTagImg.hidden = YES;
    }
    cell.mRightCollect.tag = mGoods2.mGoodsId;

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


#pragma mark---- cell的点击代理方法
- (void)cellWithLeftBtnClick:(NSInteger)mTag{

    [self showWithStatus:@"正在操作中..."];
    [[mUserInfo backNowUser] collectGoods:mShopId andGoodsId:[[NSString stringWithFormat:@"%ld",(long)mTag] intValue] andType:mLeftType block:^(mBaseData *resb, NSArray *mArr) {
        [self dismiss];
        if (resb.mSucess) {
            
            for (MGoods *goods in self.tempArray) {
                if ([[NSString stringWithFormat:@"%ld",(long)mTag] intValue] == goods.mGoodsId) {
                    goods.mIsCollect = mLeftType;
                    
                }
            }
            
            [self.tableView reloadData];
            
        }else{
            [self showErrorStatus:resb.mMessage];
        }
        
    }];
    
    
}
- (void)cellWithRightBtnClick:(NSInteger)mTag{
    [self showWithStatus:@"正在操作中..."];
    [[mUserInfo backNowUser] collectGoods:mShopId andGoodsId:[[NSString stringWithFormat:@"%ld",(long)mTag] intValue] andType:mRightType block:^(mBaseData *resb, NSArray *mArr) {
        [self dismiss];
        if (resb.mSucess) {
            
            for (MGoods *goods in self.tempArray) {
                if ([[NSString stringWithFormat:@"%ld",(long)mTag] intValue] == goods.mGoodsId) {
                    goods.mIsCollect = mRightType;
                    
                }
            }
            
            [self.tableView reloadData];
            
        }else{
            [self showErrorStatus:resb.mMessage];
        }
        
    }];
    
}

@end
