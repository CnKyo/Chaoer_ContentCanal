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

#import "mGoodsDetailViewController.h"

#import "goodsSearchViewController.h"
#import "YT_ShopTypeView.h"

#import "mClassMoreViewController.h"
#import "QHLShoppingCarController.h"
#import "ShoppingCarViewController.h"
#import "mActivitySubView.h"

@interface mMarketDetailViewController ()<UITableViewDelegate,UITableViewDataSource,WKSegmentControlDelagate,TypeViewDelegate,WKGoodsCellDelegate>
/**
 *  购物车数组
 */
@property (strong,nonatomic) NSMutableArray *mShopCarArr;

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
     *  优惠券按钮
     */
    UIButton *mCoupBtn;
    
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
    mActivitySubView *mActView;
    /**
     *  搜索关键字
     */
    NSString *mKeyWords;
    /**
     *  搜索分类的索引
     */
    int mWIndex;
    
}
@synthesize mShopId;

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}

- (void)viewDidLoad {
    self.hiddenTabBar = YES;

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    mIsCP = mIsFoucs = 0;
    mWIndex = 0;
    self.hiddenlll = YES;
    self.Title = self.mPageName = @"超市详情";
    self.rightBtnImage = [UIImage imageNamed:@"search-1"];
    mType = 0;
    mShopCarNum = 0;
    mClass = [NSMutableArray new];
    mDataSource = [NSMutableArray new];
    mLeftType  = mRightType = mShopCollect = 0;
    
    self.mShopCarArr = [NSMutableArray new];
    
    mKeyWords = nil;
    
    [self currentArrar];
}

- (void)currentArrar{
    self.page = 1;
    
    [[mUserInfo backNowUser] getMaeketDetail:self.page andMarketId:mShopId block:^(mBaseData *resb, NSArray *mArr, int mIsCoup, int mIsCollect,NSArray *mClassArr) {
        
        [mClass removeAllObjects];
        if (resb.mSucess) {
            
            [mClass addObjectsFromArray:mClassArr];
            [self loadSectionView];

        }else{
            
        }
        
    }];

    
    
}
- (void)loadData{
    
    [[mUserInfo backNowUser] getMaeketDetail:1 andMarketId:mShopId block:^(mBaseData *resb, NSArray *mArr, int mIsCoup, int mIsCollect,NSArray *mClassArr) {

        [self removeEmptyView];
        [self.tempArray removeAllObjects];

        if (resb.mSucess) {
            mShopCarNum = [[[resb.mData objectForKey:@"shop"] objectForKey:@"cart"] intValue];

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
- (void)upDatePage{
    NSDictionary *mStyle = @{@"color":[UIColor colorWithRed:0.91 green:0.13 blue:0.13 alpha:0.75]};

    if (mIsCP != 0) {
        mCoupBtn.hidden = NO;
    }else{
        mCoupBtn.hidden = YES;
    }
    
    if (mIsFoucs == 0) {
        [mHeaderView.mCollectBtn setBackgroundImage:[UIImage imageNamed:@"my_ uncollect"] forState:0];
    }else{
        [mHeaderView.mCollectBtn setBackgroundImage:[UIImage imageNamed:@"my_ collect"] forState:0];
    }

    [mHeaderView.mLogo sd_setImageWithURL:[NSURL URLWithString:_mShopList.mShopLogo] placeholderImage:[UIImage imageNamed:@"img_default"]];
    
    mHeaderView.mCollectNum.attributedText =[[NSString stringWithFormat:@"营业时间：<color>%@-%@</color>",_mShopList.mOpenTime,_mShopList.mCloseTime] attributedStringWithStyleBook:mStyle];
    
    
    mHeaderView.mNum.attributedText = [[NSString stringWithFormat:@"全部商品：<color>%d</color> 收藏数：<color>%d</color>",_mShopList.mGoodsNum,_mShopList.mFocus] attributedStringWithStyleBook:mStyle];
    mHeaderView.mName.text = _mShopList.mShopName;
    
   
    [self verifyBadge];

}
#pragma mark ----领取优惠券按钮
- (void)mCoupAction:(UIButton *)sender{

    
    NSString *url = [NSString stringWithFormat:@"%@/sm/coupon/coupon_receive?userId=%@&shopId=%@&couponId=%@&device=ios",[HTTPrequest returnNowURL],[Util RSAEncryptor:[NSString stringWithFormat:@"%d",[mUserInfo backNowUser].mUserId]],[Util RSAEncryptor:[NSString stringWithFormat:@"%d",mShopId]],[Util RSAEncryptor:[NSString stringWithFormat:@"%d",mIsCP]]];
    
    
    
    WebVC* vc = [[WebVC alloc]init];
    vc.mName = @"领取优惠券";
    vc.mUrl = url;
    [self pushViewController:vc];

    
    
}
#pragma mark ----店铺收藏事件
- (void)mShopCollectAction:(UIButton *)sender{

    if (mIsFoucs == 0) {
        mShopCollect = 1;
    }else{
        mShopCollect = 0;

    }
    [self showWithStatus:@"正在操作中..."];
    [[mUserInfo backNowUser] collectShop:mShopId andType:mShopCollect block:^(mBaseData *resb) {
        
        if (resb.mSucess) {
            mIsFoucs = mShopCollect;
            [self upDatePage];
            [self showSuccessStatus:resb.mMessage];
        }else{
        
            [self showErrorStatus:resb.mMessage];
        }
    }];
    
}
- (void)loadSectionView{
    
    mHeaderView = [mMarketHeaderView shareView];
    CGFloat mHH;
    if (_mShopList.mActivityArr.count <= 0) {
        mHH = 80;
        
    }else {
        
        
        CGFloat mYY = 0;
        
        for (UIView *vvv in mHeaderView.mActView.subviews) {
            [vvv removeFromSuperview];
        }
        
        for (GCampain *mAct in _mShopList.mActivityArr) {
            mActView = [mActivitySubView shareView];
            
            mActView.frame = CGRectMake(0, mYY, mHeaderView.size.width, 30);
            
            mActView.mName.text = mAct.mName;
            mActView.mContent.text = mAct.mContent;
            if ([mAct.mCode isEqualToString:@"A"]) {
                mActView.mName.backgroundColor = [UIColor colorWithRed:0.91 green:0.13 blue:0.14 alpha:0.75];
            }else if ([mAct.mCode isEqualToString:@"B"]){
                mActView.mName.backgroundColor = [UIColor colorWithRed:0.82 green:0.47 blue:0.62 alpha:0.75];
                
            }else if ([mAct.mCode isEqualToString:@"C"]){
                mActView.mName.backgroundColor = [UIColor colorWithRed:0.52 green:0.76 blue:0.22 alpha:0.75];
                
            }else if ([mAct.mCode isEqualToString:@"D"]){
                mActView.mName.backgroundColor = [UIColor colorWithRed:0.16 green:0.53 blue:1.00 alpha:0.75];
                
            }else{
                mActView.mName.backgroundColor = M_CO;
                
            }
            [mHeaderView.mActView addSubview:mActView];
            
            
            mYY += 32;
            
        }
        mHH = 90 + mYY;
        
        
    }
    
    [mHeaderView.mCollectBtn addTarget:self action:@selector(mShopCollectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:mHeaderView];
    
    [mHeaderView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(@64);
        make.left.right.equalTo(self.view).offset(@0);
        make.height.offset(mHH);
    }];
    [mHeaderView layoutIfNeeded];

    
    GClassN *all = [GClassN new];
    all.mId = 0;
    all.mName = @"全部";
    
    NSMutableArray *classNewArr = [NSMutableArray new];
    [classNewArr addObject:all];
    [classNewArr addObjectsFromArray:mClass];
    [mClass setArray:classNewArr];
    
    
    NSMutableArray *mclassArr = [NSMutableArray new];
    for (GClassN *Class in mClass) {
        [mclassArr addObject:Class.mName];
    }

    typeView =[[YT_ShopTypeView alloc] initZhongXiaoTypeViewWithPoint:CGPointMake(0, mHeaderView.mbottom) AndArray:mclassArr];
    typeView.delegate=self;
    [self.view addSubview:typeView];
    
    [self loadTableView:CGRectMake(0, typeView.mbottom, DEVICE_Width, DEVICE_Height-mHeaderView.mheight-typeView.mheight) delegate:self dataSource:self];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    
    
    
    UINib   *nib = [UINib nibWithNibName:@"mCommunityCollectCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    self.haveFooter = YES;
    
    mCoupBtn = [UIButton new];
    mCoupBtn.frame = CGRectMake(DEVICE_Width-80, DEVICE_Height-180, 60, 60);
    
    [mCoupBtn setBackgroundImage:[UIImage imageNamed:@"market_coup"] forState:0];
    [mCoupBtn addTarget:self action:@selector(mCoupAction:) forControlEvents:UIControlEventTouchUpInside];
    mCoupBtn.backgroundColor = [UIColor clearColor];
    mCoupBtn.hidden = YES;
    [self.view addSubview:mCoupBtn];
    
    
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
    [self loadData];

}
- (void)headerBeganRefresh{
    self.page = 1;
    
    if (mWIndex == 0) {
        [self headerEndRefresh];
        [self loadData];
    }else{
        [[mUserInfo backNowUser] findGoodsWithShop:mShopId andCatigory:mWIndex andPage:self.page andKeyWord:nil block:^(mBaseData *resb, NSArray *mArr) {
            [self.tempArray removeAllObjects];
            [self headerEndRefresh];
            
            if (resb.mSucess) {
                [self verifyBadge];
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
    
    

    
}
- (void)footetBeganRefresh{
    self.page ++;
    
    [[mUserInfo backNowUser] findGoodsWithShop:mShopId andCatigory:mWIndex andPage:self.page andKeyWord:nil block:^(mBaseData *resb, NSArray *mArr) {
        [self footetEndRefresh];

        if (resb.mSucess) {
            [self verifyBadge];
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
#pragma mark ---- 点击查询分类商品
- (void)clickBtnIndex:(NSInteger)mIndex{
    NSLog(@"%ld",(long)mIndex);
    
    
    
    GClassN *Class = mClass[mIndex];
    [self.tempArray removeAllObjects];

    mWIndex = Class.mId;
    
    [self headerBeganRefresh];
   
}

- (void)initSearch{
    [self showWithStatus:@"正在搜索中..."];
    [[mUserInfo backNowUser] findGoodsWithShop:mShopId andCatigory:mWIndex andPage:1 andKeyWord:mKeyWords block:^(mBaseData *resb, NSArray *mArr) {
        
        [self.tempArray removeAllObjects];
        if (resb.mSucess) {
            [self dismiss];
            [self verifyBadge];
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
        mShopCarBadge.text = [NSString stringWithFormat:@"%d",mShopCarNum];
        
    }
}
- (void)mshopCarAction:(UIButton *)sender{

    MLLog(@"购物车");
    
    ShoppingCarViewController *shopcar = [ShoppingCarViewController new];
    shopcar.mType = 1;
    shopcar.block = ^(BOOL isBack){
        if (isBack) {
            [self loadData];
        }
    };
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
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    
//    return typeView;
//    
//}

- (void)moreAction:(UIButton *)sender{

}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    
//    return 40;
//}
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

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
    if (mGoods1.mFocus) {
        [cell.mLeftCollect setBackgroundImage:[UIImage imageNamed:@"collection_real"] forState:0];

    }else{
        [cell.mLeftCollect setBackgroundImage:[UIImage imageNamed:@"collection_empty"] forState:0];

    }
    
    if ([mGoods1.mGoodsCampain isEqualToString:@"促销"]) {
        cell.mLeftTagImg.image = [UIImage imageNamed:@"market_ Promotion"];

    }else if ([mGoods1.mGoodsHot isEqualToString:@"热卖"]){
        cell.mLeftTagImg.image = [UIImage imageNamed:@"market_hot"];

    }else{
        cell.mLeftTagImg.hidden = YES;
    }
#pragma mark ----设置商品
    /**
     *  设置商品
     */
    cell.mLeftAdd.mGood = mGoods1;
    cell.mRightAdd.mGood = mGoods2;
    cell.mLeftDetailBtn.mGood = mGoods1;
    cell.mRightDetailBtn.mGood = mGoods2;
    /**
     *  设置商品
     */
    
    cell.mLeftCollect.tag = mGoods1.mGoodsId;
    
    cell.mRightName.text = mGoods2.mGoodsName;
    cell.mRightContent.text = mGoods2.mGoodsDetail;
    cell.mRightNum.text = [NSString stringWithFormat:@"月销：%d",mGoods2.mSalesNum];
    cell.mRightPrice.text = [NSString stringWithFormat:@"¥%.2f",mGoods2.mGoodsPrice];
    [cell.mRightImg sd_setImageWithURL:[NSURL URLWithString:mGoods2.mGoodsImg] placeholderImage:[UIImage imageNamed:@"DefaultImg"]];
    
    if (mGoods2.mFocus) {
        [cell.mRightCollect setBackgroundImage:[UIImage imageNamed:@"collection_real"] forState:0];

    }else{
        [cell.mRightCollect setBackgroundImage:[UIImage imageNamed:@"collection_empty"] forState:0];

    }
    
    if ([mGoods2.mGoodsCampain isEqualToString:@"促销"]) {
        cell.mRightTagImg.image = [UIImage imageNamed:@"market_ Promotion"];


    }else if ([mGoods2.mGoodsHot isEqualToString:@"热卖"]){
        cell.mRightTagImg.image = [UIImage imageNamed:@"market_hot"];
    }else{
        cell.mRightTagImg.hidden = YES;
    }
    cell.mRightCollect.tag = mGoods2.mGoodsId;

    return cell;
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
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
    mSearch.block = ^(NSString *content){
   
        mKeyWords = content;
        
        [self initSearch];
        
        
    };

    [self pushViewController:mSearch];
    
}


#pragma mark---- cell的点击代理方法

#pragma mark---- cell左边的收藏按钮点击代理方法
- (void)cellWithLeftBtnClick:(NSInteger)mTag{

    for (MGoods *goods in self.tempArray) {
        if ([[NSString stringWithFormat:@"%ld",(long)mTag] intValue] == goods.mGoodsId) {
            if (goods.mFocus) {
                mLeftType = 0;
            }else{
                mLeftType = 1;
            }
            
        }
    }
    
    [self showWithStatus:@"正在操作中..."];
    [[mUserInfo backNowUser] collectGoods:mShopId andGoodsId:[[NSString stringWithFormat:@"%ld",(long)mTag] intValue] andType:mLeftType block:^(mBaseData *resb, NSArray *mArr) {
        
        if (resb.mSucess) {
            for (MGoods *goods in self.tempArray) {
                if ([[NSString stringWithFormat:@"%ld",(long)mTag] intValue] == goods.mGoodsId) {

                    if (mLeftType == 1) {
                        goods.mFocus = YES;
                    }else{
                        goods.mFocus = NO;
                    }
                }
            }
            
            [self.tableView reloadData];
            [self showSuccessStatus:resb.mMessage];
        }else{
            [self showErrorStatus:resb.mMessage];
        }
        
    }];
    
    
}
#pragma mark---- cell右边的收藏按钮点击代理方法
- (void)cellWithRightBtnClick:(NSInteger)mTag{
    
    for (MGoods *goods in self.tempArray) {
        if ([[NSString stringWithFormat:@"%ld",(long)mTag] intValue] == goods.mGoodsId) {
            if (goods.mFocus) {
                mRightType = 0;
            }else{
                mRightType = 1;
            }
            
        }
    }
    [self showWithStatus:@"正在操作中..."];
    [[mUserInfo backNowUser] collectGoods:mShopId andGoodsId:[[NSString stringWithFormat:@"%ld",(long)mTag] intValue] andType:mRightType block:^(mBaseData *resb, NSArray *mArr) {
        
        if (resb.mSucess) {
            
            for (MGoods *goods in self.tempArray) {
                if ([[NSString stringWithFormat:@"%ld",(long)mTag] intValue] == goods.mGoodsId) {
                    if (mRightType == 1) {
                        goods.mFocus = YES;
                    }else{
                        goods.mFocus = NO;
                    }
                }
            }
            
            [self.tableView reloadData];
            [self showSuccessStatus:resb.mMessage];
        }else{
            [self showErrorStatus:resb.mMessage];
        }
        
    }];
    
}
#pragma mark---- cell左边的添加购物车按钮点击代理方法
- (void)cellWithLeftAddShopCar:(NSInteger)mTag andGoods:(MGoods *)mGoods{
    [self showWithStatus:@""];
    

    
    [[mUserInfo backNowUser] addGoodsToShopCar:mShopId andGoodsId:mGoods.mGoodsId andNum:1 block:^(mBaseData *resb) {
        if (resb.mSucess) {
            [self.mShopCarArr addObject:mGoods];
            mShopCarNum+=1;
            [self upDateShopCar];
            [self dismiss];
        }else{
            [self showErrorStatus:resb.mMessage];
        }
    }];
    

}
#pragma mark---- cell右边的添加购物车按钮点击代理方法
- (void)cellWithRightAddShopCar:(NSInteger)mTag andGoods:(MGoods *)mGoods{
    [self showWithStatus:@""];
    
    [[mUserInfo backNowUser] addGoodsToShopCar:mShopId andGoodsId:mGoods.mGoodsId andNum:1 block:^(mBaseData *resb) {
        if (resb.mSucess) {
            [self.mShopCarArr addObject:mGoods];
            mShopCarNum+=1;
            [self upDateShopCar];
            [self dismiss];
        }else{
            [self showErrorStatus:resb.mMessage];
        }
    }];
}
#pragma mark---- cell左边的商品详情按钮点击代理方法
- (void)cellWithLeftDetailClick:(NSInteger)mTag andGoods:(MGoods *)mGoods{
    mGoodsDetailViewController *goods = [[mGoodsDetailViewController alloc] initWithNibName:@"mGoodsDetailViewController" bundle:nil];
    goods.mSGoods = mGoods;
    goods.mShopId = mShopId;
    goods.mIsCollecte = mGoods.mFocus;
    [self pushViewController:goods];
}
#pragma mark---- cell右边的添加购物车按钮点击代理方法
- (void)cellWithRightDetailClick:(NSInteger)mTag andGoods:(MGoods *)mGoods{
    mGoodsDetailViewController *goods = [[mGoodsDetailViewController alloc] initWithNibName:@"mGoodsDetailViewController" bundle:nil];
    goods.mSGoods = mGoods;
    goods.mShopId = mShopId;
    goods.mIsCollecte = mGoods.mFocus;

    [self pushViewController:goods];
    
}

- (void)upDateShopCar{

    mShopCarBadge.hidden = NO;
    mShopCarBadge.text = [NSString stringWithFormat:@"%d",mShopCarNum];
}

@end
