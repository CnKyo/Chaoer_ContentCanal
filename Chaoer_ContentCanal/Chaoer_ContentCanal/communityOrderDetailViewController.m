//
//  communityOrderDetailViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/29.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "communityOrderDetailViewController.h"

#import "communityOrderDetailCell.h"

#import "orderStatusViewController.h"

#import "mMarketRateViewController.h"

#import "mOrderDetailBottomView.h"
#import "goPayViewController.h"

@interface communityOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource,orderBottomViewBtnclick>

@end

@implementation communityOrderDetailViewController
{

    
    mOrderDetailBottomView *mHeaderSection;
    mOrderDetailBottomView *mBottomView;
    
    GMyMarketOrderInfo *mOrderInfo;
}
- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    
    [super viewDidLoad];
    
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.Title = self.mPageName = @"订单详情";
    
    [self initView];
}
- (void)initView{

    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-114) delegate:self dataSource:self];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    
    
    
    self.haveHeader = YES;
    
    
    UINib   *nib = [UINib nibWithNibName:@"communityOrderDetailCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell1"];
    
    nib = [UINib nibWithNibName:@"communityOrderDetailCell2" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];
    
    mBottomView = [mOrderDetailBottomView shareView];
    mBottomView.delegate = self;
    [self.view addSubview:mBottomView];
    
    [mBottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(@0);
        make.bottom.equalTo(self.view).offset(@0);
        make.height.offset(@50);
    }];

}
- (void)upDatePage{
    mBottomView.mOrderInfo = [GMyMarketOrderInfo new];
    mBottomView.mOrderInfo = mOrderInfo;
    mBottomView.mTotal.text = [NSString stringWithFormat:@"合计：¥%.2f元",mOrderInfo.mCommodityPrice];
    
    NSString *mTT = nil;
    
    if (mOrderInfo.mState == 10) {
        mTT = @"去支付";
    }else if(mOrderInfo.mState == 11){
        mTT = @"进行中";

    }else if(mOrderInfo.mState == 12){
        mTT = @"确认完成";

    }else{
        
        if (mOrderInfo.mIsComment == 1) {
            mTT = @"已评价";
            
            mBottomView.mCheckBtn.enabled = NO;
            [mBottomView.mCheckBtn setTitle:mTT forState:0];
  
        }else{
            mTT = @"待评价";
            
            mBottomView.mCheckBtn.enabled = YES;
            [mBottomView.mCheckBtn setTitle:mTT forState:0];
        }


    }
    
    [mBottomView.mCheckBtn setTitle:mTT forState:0];
}
#pragma mark ---- 地步按钮的相应事件
- (void)mBottomViewWithBtnClick:(GMyMarketOrderInfo *)mBottomOrderInfo{
    
    if (mBottomOrderInfo.mState == 10) {
        MLLog(@"去支付");
        goPayViewController *goPay = [[goPayViewController alloc] initWithNibName:@"goPayViewController" bundle:nil];
        goPay.mMoney = mBottomOrderInfo.mCommodityPrice;
        goPay.mOrderCode = mBottomOrderInfo.mOrderCode;
        goPay.mType = 3;
        [self pushViewController:goPay];


    }else if(mBottomOrderInfo.mState == 11){
        MLLog(@"进行中");

    }else if(mBottomOrderInfo.mState == 12){
        MLLog(@"确认完成");
        
    }else{
        MLLog(@"去评价");
        mMarketRateViewController *mmm = [[mMarketRateViewController alloc] initWithNibName:@"mMarketRateViewController" bundle:nil];
        mmm.mName = mOrderInfo.mShopName;
        mmm.mShopImg = mOrderInfo.mShopLogo;
        mmm.mTotlaPrice = mOrderInfo.mCommodityPrice;
        mmm.mShopId = mOrderInfo.mShopId;
        mmm.mOrderCode = mOrderInfo.mOrderCode;
        
        [self pushViewController:mmm];
    }
}
- (void)headerBeganRefresh{
    [self showWithStatus:@"加载中..."];
    
    [[mUserInfo backNowUser] getMyMarketOrderDetail:self.mShop.mOrderCode andOrderType:self.mShop.mType block:^(mBaseData *resb, GMyMarketOrderInfo *mOrder) {
        
        
        [self headerEndRefresh];
        [self removeEmptyView];
        if (resb.mSucess) {
            [self dismiss];
            mOrderInfo = [GMyMarketOrderInfo new];
            mOrderInfo = mOrder;
            [self upDatePage];
            [self.tableView reloadData];
        }else{
            [self addEmptyView:nil];
            [self showErrorStatus:resb.mMessage];
            [self performSelector:@selector(leftBtnTouched:) withObject:nil afterDelay:0.35];
        }
        
    }];
    
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
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0.5;
    }else{
        return 100;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }else{

        mHeaderSection = [mOrderDetailBottomView shareSectionView];
        
        [mHeaderSection.mStoreImg sd_setImageWithURL:[NSURL URLWithString:mOrderInfo.mShopLogo] placeholderImage:[UIImage imageNamed:@"img_default"]];
        mHeaderSection.mName.text = mOrderInfo.mShopName;
        
        return mHeaderSection;
    }
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 1;
    }else{
        return mOrderInfo.mGoodsArr.count;
    }
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        return 340;
    }else{
        GMyOrderGoodsA *mGoods = mOrderInfo.mGoodsArr[indexPath.row];
        
        NSString *reuseCellId = nil;
        
        reuseCellId = @"cell2";
        
        communityOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        
        
        return 145+[Util labelText:mGoods.mGoodsComment fontSize:13 labelWidth:cell.mGoodsDetail.mwidth]-16;
    }
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    if (indexPath.section == 0) {
        reuseCellId = @"cell1";
        
        communityOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.mCheckBtn addTarget:self action:@selector(mCaheckAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell setMOrderInfo:mOrderInfo];
        return cell;
        
    }else{
        
        GMyOrderGoodsA *mGoods = mOrderInfo.mGoodsArr[indexPath.row];
        
        reuseCellId = @"cell2";
        
        communityOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setMGoodInfo:mGoods];
        
        return cell;
    }
    
    
}

- (void)mCaheckAction:(UIButton *)sender{
    
    
    if (mOrderInfo.mState == 10) {
        
    }else if(mOrderInfo.mState == 11){
        orderStatusViewController *orderS = [[orderStatusViewController alloc] initWithNibName:@"orderStatusViewController" bundle:nil];
        [self pushViewController:orderS];

    }else if (mOrderInfo.mState == 12){
        orderStatusViewController *orderS = [[orderStatusViewController alloc] initWithNibName:@"orderStatusViewController" bundle:nil];
        [self pushViewController:orderS];

    }else{
        orderStatusViewController *orderS = [[orderStatusViewController alloc] initWithNibName:@"orderStatusViewController" bundle:nil];
        [self pushViewController:orderS];

    }

    
}
@end
