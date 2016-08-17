//
//  OneViewTableTableViewController.m
//  HeaderViewAndPageView
//
//  Created by su on 16/8/8.
//  Copyright © 2016年 susu. All rights reserved.
//

#import "OneViewTableTableViewController.h"
#import "mFoodTableViewCell.h"
#import "mFoodHeaderView.h"
#import "mFoodDetailViewController.h"
#import "mFoodComfirmViewController.h"
#import "mFoodClearView.h"
#import "mFoodShopCarCell.h"
@interface OneViewTableTableViewController ()<UITableViewDataSource,UITableViewDelegate,WKFoodCellDelegate,WKFoodHeaderViewDelegate>

@property(nonatomic ,strong)UITableView * mLeftTableView;
@property(nonatomic ,strong)UITableView * mRightTableView;

/**
 *  购物车list
 */
@property(nonatomic ,strong)UITableView * mShopCarListView;
/**
 *  购物车背景view
 */
@property(nonatomic ,strong) UIView *mShopCarBgkView;

@end

@implementation OneViewTableTableViewController
{
    mFoodHeaderView *mBottomView;
    
    mFoodClearView *mClearView;
    int mNum;
    int mTTPrice;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    mNum = 0;
    _mLeftTableView = [UITableView new];
    _mLeftTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _mLeftTableView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    _mLeftTableView.delegate = self;
    _mLeftTableView.dataSource = self;
    _mLeftTableView.layer.masksToBounds = YES;
    _mLeftTableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _mLeftTableView.layer.borderWidth = 0.5;
    UINib   *nib2 = [UINib nibWithNibName:@"mFoodLeftCell" bundle:nil];
    [_mLeftTableView registerNib:nib2 forCellReuseIdentifier:@"cell1"];
    [self.view addSubview:_mLeftTableView];
    
    
    _mRightTableView = [UITableView new];
    _mRightTableView.delegate = self;
    _mRightTableView.dataSource = self;
    _mRightTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _mRightTableView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    _mRightTableView.showsVerticalScrollIndicator = NO;
    _mRightTableView.showsHorizontalScrollIndicator = NO;
    UINib   *nib = [UINib nibWithNibName:@"mFoodTableViewCell" bundle:nil];
    [_mRightTableView registerNib:nib forCellReuseIdentifier:@"cell2"];
    
    
    [self.view addSubview:_mRightTableView];
    
    mBottomView = [mFoodHeaderView shareBottomView];
    mBottomView.delegate = self;
    mBottomView.mNum.hidden = YES;
    [self.view addSubview:mBottomView];
    
    [_mLeftTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(@0);
        make.top.equalTo(self.view).offset(@0);
        make.right.equalTo(_mRightTableView.left).offset(@0);
        make.bottom.equalTo(mBottomView.top).offset(@0);
        make.width.offset(DEVICE_Width/3);
    }];
    
    [_mRightTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mLeftTableView.right).offset(@0);
        make.top.equalTo(self.view).offset(@0);
        make.right.equalTo(self.view).offset(@0);
        make.bottom.equalTo(mBottomView.top).offset(@0);
        make.width.offset(DEVICE_Width-DEVICE_Width/3);
    }];
    
    [mBottomView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_mLeftTableView.bottom).offset(@0);
        make.left.right.equalTo(self.view).offset(@0);
        make.bottom.equalTo(self.view).offset(-40);
        make.height.offset(@50);
    }];

    [self initShopCarView];
}
- (void)upDatePage{

    
    if (mNum <= 0) {
        mBottomView.mNum.hidden = YES;
        mBottomView.mGoPayBrn.enabled = NO;
    }else{
        mBottomView.mNum.hidden = NO;
        mBottomView.mGoPayBrn.enabled = YES;
        mBottomView.mNum.text = [NSString stringWithFormat:@"%d",mNum];

    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (tableView == self.mShopCarListView) {
        mClearView = [mFoodClearView shareView];
        [mClearView.mClearnBtn addTarget:self action:@selector(mClearAction:) forControlEvents:UIControlEventTouchUpInside];

        return mClearView;
    }else{
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (tableView == self.mShopCarListView) {
        return 40;
    }else{
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView == _mLeftTableView) {
        return 40;
    }else if(tableView == self.mShopCarListView){
        return 40;
    }else{
        return 100;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseCellId = nil;
    
    if (tableView == _mRightTableView) {
        
        reuseCellId = @"cell2";
        mFoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        cell.mIndexPath = indexPath;
        
        cell.delegate = self;
        
        return cell;
        
        
        
    }
    else if (tableView == self.mShopCarListView){
        reuseCellId = @"cell3";
        
        mFoodShopCarCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }
    else{
        reuseCellId = @"cell1";
        
        mFoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        
        
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == _mRightTableView) {
        mFoodDetailViewController *fff = [[mFoodDetailViewController alloc] initWithNibName:@"mFoodDetailViewController" bundle:nil];
        [self.navigationController pushViewController:fff animated:YES];
    }else{
    
        
    }
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

#pragma mark----cell减按钮和加按钮的代理方法
- (void)WKFoodCellWithAddBtnClickWithIndexPath:(NSIndexPath *)mIndexPath andTag:(NSInteger)mTag{
    
    mNum += 1;
    [self upDatePage];
    
}
- (void)WKFoodCellWithJianBtnClickWithIndexPath:(NSIndexPath *)mIndexPath andTag:(NSInteger)mTag{
    mNum -= 1;
    [self upDatePage];
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
        mSR.origin.y = DEVICE_Height/2-60;
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
