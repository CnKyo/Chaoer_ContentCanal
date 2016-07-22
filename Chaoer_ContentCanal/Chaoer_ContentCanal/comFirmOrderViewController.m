//
//  comFirmOrderViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/28.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "comFirmOrderViewController.h"
#import "comfirmOrderView.h"

#import "goPayViewController.h"

#import "noteOrmessageViewController.h"

#import "billViewController.h"

#import "mComfirmHeaderAndFooter.h"
#import "mComfirmOrderCell.h"
#import "mSelectSenTypeViewController.h"


#import "mComfirmHederAndFooterSection.h"
@interface comFirmOrderViewController ()<UITableViewDelegate,UITableViewDataSource,WKComfirDelegate,mFooterSwitchDelegate,mSectionDelegate>

@end

@implementation comFirmOrderViewController
{


    UIScrollView *mScrollerView;
    
    comfirmOrderView *mMainView;
    comfirmOrderView *mFooterView;
    
    mComfirmHeaderAndFooter *mTableHeaderView;
    mComfirmHeaderAndFooter *mTableFooterView;
    
    
    /**
     *  headerSection
     */
    mComfirmHederAndFooterSection *mHeaderSection;
    /**
     *  footerSection
     */
    mComfirmHederAndFooterSection *mFooterSection;
    
    
    
}
@synthesize mShopCarList;
- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    
    [super viewDidLoad];
    
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.Title = self.mPageName = @"确认订单";

    [self initMainView];
    
}

- (void)initMainView{

    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-114) delegate:self dataSource:self];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;

    UINib   *nib = [UINib nibWithNibName:@"mComFirmCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    mTableHeaderView = [mComfirmHeaderAndFooter initHeaderView];
    mTableHeaderView.frame = CGRectMake(0, 0, DEVICE_Width, 80);
    [self.tableView setTableHeaderView:mTableHeaderView];
    
    mTableFooterView = [mComfirmHeaderAndFooter initFooterView];
    mTableFooterView.frame = CGRectMake(0, 0, DEVICE_Width, 120);
    mTableFooterView.delegate = self;
    [self.tableView setTableFooterView:mTableFooterView];
    
    
    
    mFooterView = [comfirmOrderView sharePayView];
    [mFooterView.mGoPayBtn addTarget:self action:@selector(mGoPayAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:mFooterView];
    
    [mFooterView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).offset(@0);
        make.height.offset(@50);
    }];
    
    [self upDatePage];
}
- (void)mFooterSwitchChanged:(BOOL)mChange{

    if (mChange) {
        MLLog(@"开");
    }else{
        MLLog(@"关");
    }
    
    
    
}
- (void)initView{
    
    mMainView = [comfirmOrderView shareView];
    
    [mMainView.mSelecteLabel addTarget:self action:@selector(mLabelAction:) forControlEvents:UIControlEventTouchUpInside];
    [mMainView.mReciptBtn addTarget:self action:@selector(mRecipAction:) forControlEvents:UIControlEventTouchUpInside];
    [mScrollerView addSubview:mMainView];
    [mMainView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(mScrollerView).offset(@0);
        make.height.offset(@600);
        make.width.offset(DEVICE_Width);
    }];
    
    mFooterView = [comfirmOrderView sharePayView];
    [mFooterView.mGoPayBtn addTarget:self action:@selector(mGoPayAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mFooterView];
    
    [mFooterView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).offset(@0);
        make.height.offset(@50);
    }];
    
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 600);
    
}



- (void)mRecipAction:(UIButton *)sender{
    billViewController *bbb = [[billViewController alloc] initWithNibName:@"billViewController" bundle:nil];
    [self pushViewController:bbb];

}
- (void)mLabelAction:(UIButton *)sender{
    
    noteOrmessageViewController *nnn = [[noteOrmessageViewController alloc] initWithNibName:@"noteOrmessageViewController" bundle:nil];
    [self pushViewController:nnn];
}
- (void)mGoPayAction:(UIButton *)sender{
    goPayViewController *goPay = [[goPayViewController alloc] initWithNibName:@"goPayViewController" bundle:nil];
    [self pushViewController:goPay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)upDatePage{
 
    mFooterView.mPayMoney.text = [NSString stringWithFormat:@"还需支付：¥%.2f",mShopCarList.mTotlePay];
    
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    GGShopArr *mShop = mShopCarList.mShopArr[section];
    
    float mPP = 0.0;
    
    for (GGPayN *mGoods in mShop.mGoodsArr) {
        mPP += mGoods.mSPrice;
    }
    
    mFooterSection = [mComfirmHederAndFooterSection shareFooter];
    mFooterSection.mMoney.text = [NSString stringWithFormat:@"总金额:¥%.2f",mPP];
    mFooterSection.delegate = self;
    return mFooterSection;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    GGShopArr *mShop = mShopCarList.mShopArr[section];
    
    mHeaderSection = [mComfirmHederAndFooterSection shareHeader];
    [mHeaderSection.mShopImg sd_setImageWithURL:[NSURL URLWithString:mShop.mShopImg] placeholderImage:[UIImage imageNamed:@"img_default"]];
    mHeaderSection.mShopName.text = mShop.mShopName;
    mHeaderSection.delegate = self;
    return mHeaderSection;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 170;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 50;
}
#pragma mark ---- 留言
- (void)sectionWithMessage:(NSIndexPath *)mIndexPath{
    GGShopArr *mShop = mShopCarList.mShopArr[mIndexPath.section];
    
    GGPayN *mGoods = mShop.mGoodsArr[mIndexPath.row];
}
#pragma mark ---- 优惠券
- (void)sectionWithCoup:(NSIndexPath *)mIndexPath{
    GGShopArr *mShop = mShopCarList.mShopArr[mIndexPath.section];
    
    GGPayN *mGoods = mShop.mGoodsArr[mIndexPath.row];
}
#pragma mark ---- 配送方式
- (void)sectionWithSendType:(NSIndexPath *)mIndexPath{
    GGShopArr *mShop = mShopCarList.mShopArr[mIndexPath.section];
    
    GGPayN *mGoods = mShop.mGoodsArr[mIndexPath.row];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return mShopCarList.mShopArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    GGShopArr *mShop = mShopCarList.mShopArr[section];
    return mShop.mGoodsArr.count;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
    
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    
    reuseCellId = @"cell";
    
    
    GGShopArr *mShop = mShopCarList.mShopArr[indexPath.section];

    GGPayN *mGoods = mShop.mGoodsArr[indexPath.row];
    
    mComfirmOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.cellDelegate = self;
    cell.indexPath = indexPath;
    
    cell.mProductNum.text = [NSString stringWithFormat:@"共%d件商品",mGoods.mNum];
    
    cell.mGoodsPrice.text = [NSString stringWithFormat:@"¥%.2f",mGoods.mPrice];
    [cell.mImg1 sd_setImageWithURL:[NSURL URLWithString:mGoods.mGoodsImg] placeholderImage:[UIImage imageNamed:@"img_default"]];
    cell.mGoodsName.text = mGoods.mGoodsName;
    return cell;
    

    
}
#pragma mark ----留言
- (void)cellDidMessageNote:(mComfirmOrderCell *)cell andIndex:(NSIndexPath *)mIndex{
    MLLog(@"exsiting---%@",mIndex);
    GGShopArr *mShop = mShopCarList.mShopArr[mIndex.section];
    
    GGPayN *mGoods = mShop.mGoodsArr[mIndex.row];
}
#pragma mark ----选择优惠券
- (void)cellDidSelectedCoup:(mComfirmOrderCell *)cell andIndex:(NSIndexPath *)mIndex{
    MLLog(@"exsiting---%@",mIndex);
    GGShopArr *mShop = mShopCarList.mShopArr[mIndex.section];
    
    GGPayN *mGoods = mShop.mGoodsArr[mIndex.row];
}
#pragma mark ----选择配送方式
- (void)cellDidChioceSendType:(mComfirmOrderCell *)cell andIndex:(NSIndexPath *)mIndex{
    MLLog(@"exsiting---%@",mIndex);
    GGShopArr *mShop = mShopCarList.mShopArr[mIndex.section];
    
    GGPayN *mGoods = mShop.mGoodsArr[mIndex.row];
    mSelectSenTypeViewController *mmm = [[mSelectSenTypeViewController alloc] initWithNibName:@"mSelectSenTypeViewController" bundle:nil];
    [self pushViewController:mmm];
    
}
- (void)cellDidCheckImage:(mComfirmOrderCell *)cell andIndex:(NSIndexPath *)mIndex{
    MLLog(@"exsiting---%@",mIndex);
}
@end
