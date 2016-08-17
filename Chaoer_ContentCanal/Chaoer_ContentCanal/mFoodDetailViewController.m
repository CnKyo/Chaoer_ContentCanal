//
//  mFoodDetailViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mFoodDetailViewController.h"
#import "mFoodDetailCell.h"
#import "mDetailSectionView.h"
#import "mFoodDetailBottomShopCarView.h"
#import "mFoodHeaderView.h"
#import "mFoodClearView.h"

#import "mFoodComfirmViewController.h"
#import "mFoodShopCarCell.h"

@interface mFoodDetailViewController ()<UITableViewDelegate,UITableViewDataSource,WKFoodDetailDelegate,WKFoodHeaderViewDelegate>
/**
 *  购物车list
 */
@property(nonatomic ,strong)UITableView * mShopCarListView;
/**
 *  购物车背景view
 */
@property(nonatomic ,strong) UIView *mShopCarBgkView;
@end

@implementation mFoodDetailViewController
{
    mFoodClearView *mClearView;

    mDetailSectionView *mSectionView;
    
    mFoodDetailBottomShopCarView *mHeaderView;
    
    mFoodHeaderView *mBottomView;

    int mNum;
    
}
- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    
    [super viewDidLoad];
    mNum = 0;
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.Title = self.mPageName = @"商品详情";
    [self initView];
    [self initShopCarView];

}
- (void)initView{
    
    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-114) delegate:self dataSource:self];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    
    
    
//    self.haveHeader = YES;
    
    
    UINib   *nib = [UINib nibWithNibName:@"mFoodDetailCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    
    mHeaderView = [mFoodDetailBottomShopCarView shareHeadView];
    mHeaderView.frame = CGRectMake(0, 0, DEVICE_Width, 310);
    [self.tableView setTableHeaderView:mHeaderView];
    
    mBottomView = [mFoodHeaderView shareBottomView];
    mBottomView.delegate = self;
    mBottomView.mNum.hidden = YES;
    [self.view addSubview:mBottomView];
    
    [mBottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(@0);
        make.bottom.equalTo(self.view).offset(@0);
        make.height.offset(@50);
    }];
    
}
- (void)upDatePage{

    if (mNum <= 0) {
        mBottomView.mNum.hidden = YES;
    }else{
        mBottomView.mNum.hidden = NO;
        mBottomView.mNum.text = [NSString stringWithFormat:@"%d",mNum];

    }
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.mShopCarListView) {
        mClearView = [mFoodClearView shareView];
        [mClearView.mClearnBtn addTarget:self action:@selector(mClearAction:) forControlEvents:UIControlEventTouchUpInside];
        
        return mClearView;
    }else{
        mSectionView = [mDetailSectionView shareShopCarView];
        
        mSectionView.delegate = self;
        
        if (mNum <= 0) {
            
            [UIView animateWithDuration:0.25 animations:^{
                mSectionView.mJianBtn.alpha = 0;
                mSectionView.mNum.alpha = 0;
                mSectionView.mAddBtn.alpha = 0;
                mSectionView.mAddShopCarBtn.alpha = 1;
            }];
            
         
        }else{
            [UIView animateWithDuration:0.25 animations:^{
                mSectionView.mJianBtn.alpha = 1;
                mSectionView.mNum.alpha = 1;
                mSectionView.mAddBtn.alpha = 1;
                mSectionView.mAddShopCarBtn.alpha = 0;
                mSectionView.mNum.text = [NSString stringWithFormat:@"%d",mNum];
            }];

        }
        
        return mSectionView;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.mShopCarListView) {
        
        return 40;
    }else{
        return 160;
    }
    
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    

   
    if (tableView == self.mShopCarListView){
        reuseCellId = @"cell3";
        
        mFoodShopCarCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }
    else{
        reuseCellId = @"cell";
        
        mFoodDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        return cell;
    }

    
    
    
}
/**
 *  加入购物车代理方法
 */
- (void)WKFoodDetailAddShopCarAction{
    
    mNum+=1;
    [self.tableView reloadData];
    [self upDatePage];
}
/**
 *  加按钮方法
 */
- (void)WKFoodDetailAddAction{
    mNum+=1;
    [self.tableView reloadData];

    [self upDatePage];
}
/**
 *  减按钮方法
 */
- (void)WKFoodDetailJianAction{
    mNum-=1;
    [self.tableView reloadData];

    [self upDatePage];
}

#pragma mark----headerview和bottomview的代理方法
#pragma mark----去结算的代理方法
- (void)WKFoodViewBottomGoPayCilicked{
    mFoodComfirmViewController *fff = [[mFoodComfirmViewController alloc] initWithNibName:@"mFoodComfirmViewController" bundle:nil];
    [self.navigationController pushViewController:fff animated:YES];
}
#pragma mark----购物车的代理方法
- (void)WKFoodViewBottomShopCarCilicked{
    [self showShopList];
}
#pragma mark----展现购物车view
- (void)initShopCarView{
    
    self.mShopCarBgkView = [UIView new];
    self.mShopCarBgkView.frame = CGRectMake(0, -50, DEVICE_Width, DEVICE_Height-50);
    self.mShopCarBgkView.backgroundColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:0.75];
    self.mShopCarBgkView.alpha = 0;
    [self.view addSubview:self.mShopCarBgkView
     ];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.mShopCarBgkView addGestureRecognizer:tap];
    
    
    self.mShopCarListView = [UITableView new];
    
    self.mShopCarListView.frame = CGRectMake(0, self.mShopCarBgkView.mheight, DEVICE_Width, DEVICE_Height/2);
    
    self.mShopCarListView.delegate = self;
    self.mShopCarListView.dataSource = self;
    self.mShopCarListView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.mShopCarListView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    self.mShopCarListView.showsVerticalScrollIndicator = NO;
    self.mShopCarListView.showsHorizontalScrollIndicator = NO;
    UINib   *nib = [UINib nibWithNibName:@"mFoodShopCarCell" bundle:nil];
    [self.mShopCarListView registerNib:nib forCellReuseIdentifier:@"cell3"];
    self.mShopCarListView.alpha = 0;
    [self.mShopCarBgkView addSubview:self.mShopCarListView];
    
    
}

- (void)tapAction:(UITapGestureRecognizer *)sender{
    
    [self hiddenShopList];
}
- (void)showShopList{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.mShopCarBgkView.alpha = 1;
        self.mShopCarListView.alpha = 1;
        
        CGRect mSR = self.mShopCarListView.frame;
        mSR.origin.y = DEVICE_Height/2;
        self.mShopCarListView.frame = mSR;
    }];
}

- (void)hiddenShopList{
    [UIView animateWithDuration:0.25 animations:^{
        self.mShopCarBgkView.alpha = 0;
        self.mShopCarListView.alpha = 01;
        
        CGRect mSR = self.mShopCarListView.frame;
        mSR.origin.y = self.mShopCarBgkView.mheight;
        self.mShopCarListView.frame = mSR;
    }];
}
- (void)mClearAction:(UIButton *)sender{
    
    MLLog(@"清空购物车");
}

@end
