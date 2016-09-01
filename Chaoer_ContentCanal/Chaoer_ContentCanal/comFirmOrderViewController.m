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

#import "mComfirmHeaderAndFooter.h"
#import "mComfirmOrderCell.h"
#import "mSelectSenTypeViewController.h"


#import "mComfirmHederAndFooterSection.h"

#import "feedbackViewController.h"
#import "pptMyAddressViewController.h"

#import "mCoupViewController.h"

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
    
    
    int isCoup;
    /**
     *  是否有配送费
     */
    BOOL mIsDeliver;
}
@synthesize mShopCarList;
- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    
    [super viewDidLoad];
    
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.Title = self.mPageName = @"确认订单";
    isCoup = 0;
    mIsDeliver = NO;
    [self initMainView];
    
}

- (void)initMainView{


    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-114) delegate:self dataSource:self];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;

    UINib   *nib = [UINib nibWithNibName:@"mComFirmCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    mTableHeaderView = [mComfirmHeaderAndFooter initHeaderView];
    mTableHeaderView.frame = CGRectMake(0, 0, DEVICE_Width, 80);
    [mTableHeaderView.mAddressBtn addTarget:self action:@selector(AddressAction:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *add = nil;
    if (mShopCarList.mAddress.length <= 0) {
        add = @"请选择收货地址";
    }else{
        add = [NSString stringWithFormat:@"%@-%@\n%@",mShopCarList.mName,mShopCarList.mPhone,mShopCarList.mAddress];
    }
    
    mTableHeaderView.mAddress.text = add;
    [self.tableView setTableHeaderView:mTableHeaderView];
    
    mTableFooterView = [mComfirmHeaderAndFooter initFooterView];
    mTableFooterView.frame = CGRectMake(0, 0, DEVICE_Width, 120);
    mTableFooterView.delegate = self;
    mTableFooterView.mTotalMoney.text = [NSString stringWithFormat:@"商品总金额：¥%.2f",mShopCarList.mTotlePay];

    float mS = 0;
    
    if (mIsDeliver) {
        mS = mShopCarList.mSendPrice;
    }else{
        mS = 0;
    }
    
    mTableFooterView.mSendPrice.text = [NSString stringWithFormat:@"¥%.2f",mS];
    [self.tableView setTableFooterView:mTableFooterView];
    
    
    
    mFooterView = [comfirmOrderView sharePayView];
    [mFooterView.mGoPayBtn addTarget:self action:@selector(mGoPayAction:) forControlEvents:UIControlEventTouchUpInside];
    mFooterView.mPayMoney.text = [NSString stringWithFormat:@"还需支付：¥%.2f",mShopCarList.mTotlePay];

    
    [self.view addSubview:mFooterView];
    
    [mFooterView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).offset(@0);
        make.height.offset(@50);
    }];
    
}
- (void)AddressAction:(UIButton *)sender{
    pptMyAddressViewController *ppt = [[pptMyAddressViewController alloc] initWithNibName:@"pptMyAddressViewController" bundle:nil];
    ppt.mType = 1;
    ppt.block = ^(NSString *content ,NSString *mId,NSString *mName){
        mShopCarList.mAddress = content;
        mShopCarList.mPhone = mId;
        mShopCarList.mArriveName = mName;
        [self upDatePage];
    };
    [self pushViewController:ppt];

}
- (void)mFooterSwitchChanged:(BOOL)mChange{
    if (isCoup == 1) {
        [self showErrorStatus:@"您已使用优惠卷，不能再使用积分了哟！"];
        return;
    }else{
        if (mChange) {
            MLLog(@"开");
            mShopCarList.mIsUseScore = 1;
        }else{
            MLLog(@"关");
            mShopCarList.mIsUseScore = 0;
        }
    }
    
    
    
    
}

- (void)mLabelAction:(UIButton *)sender{
    
    noteOrmessageViewController *nnn = [[noteOrmessageViewController alloc] initWithNibName:@"noteOrmessageViewController" bundle:nil];
    [self pushViewController:nnn];
}
- (void)mGoPayAction:(UIButton *)sender{
    
    if (mShopCarList.mAddress.length <= 0) {
        [self showErrorStatus:@"亲，您还没选择收货地址呐～～"];
        return;
    }
    
    NSMutableArray *mParaData = [NSMutableArray new];
    
    
    for (GGShopArr *mShop in mShopCarList.mShopArr) {
        NSMutableDictionary *para = [NSMutableDictionary new];

        [para setObject:NumberWithInt(mShop.mShopId) forKey:@"shopId"];
        [para setObject:mShop.mSendId forKey:@"distributionMode"];
        if (mShop.mMessage.length != 0) {
            [para setObject:mShop.mMessage forKey:@"remarks"];
        }
        if (mShop.mCoupName.length != 0) {
            [para setObject:NumberWithInt(mShop.mCoupId) forKey:@"couponId"];
        }
        
        NSString *mTagIds = @"";

        for (int i =0;i<mShop.mGoodsArr.count;i++) {
            
            GGPayN *mgoods = mShop.mGoodsArr[i];
            
            
            if (i == mShop.mGoodsArr.count-1) {
                mTagIds = [mTagIds stringByAppendingString:[NSString stringWithFormat:@"%d", mgoods.mId]];
            }else{
                mTagIds = [mTagIds stringByAppendingString:[NSString stringWithFormat:@"%d,", mgoods.mId]];
            }

        }
        [para setObject:mTagIds forKey:@"shoppingCartId"];

        
        [mParaData addObject:para];
    }
    
    [self showWithStatus:@"正在结算..."];
    [[mUserInfo backNowUser] payFeeOrder:mParaData andUseSore:mShopCarList.mIsUseScore andAddress:mShopCarList.mAddress andPhone:mShopCarList.mPhone andIsCoup:isCoup andArriveName:mShopCarList.mArriveName block:^(mBaseData *resb) {
        [self dismiss];
        if (resb.mSucess) {
            goPayViewController *goPay = [[goPayViewController alloc] initWithNibName:@"goPayViewController" bundle:nil];
            goPay.mMoney = [[resb.mData objectForKey:@"payableAmount"] floatValue];
            goPay.mOrderCode = [resb.mData objectForKey:@"orderIds"];
            goPay.mType = 1;
            [self pushViewController:goPay];
        }else{
            [self showErrorStatus:resb.mMessage];
        }
    }];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)upDatePage{
 
    mFooterView.mPayMoney.text = [NSString stringWithFormat:@"还需支付(含配送费)：¥%.2f",mShopCarList.mTotlePay];
    mTableHeaderView.mAddress.text = [NSString stringWithFormat:@"%@-%@\n%@",mShopCarList.mName,mShopCarList.mPhone,mShopCarList.mAddress];
    mTableFooterView.mTotalMoney.text = [NSString stringWithFormat:@"商品总金额(含配送费)：¥%.2f",mShopCarList.mTotlePay];
    
    
    float mS = 0;
    
    if (mIsDeliver) {
        mS = mShopCarList.mSendPrice;
    }else{
        mS = 0;
    }
    
    mTableFooterView.mSendPrice.text = [NSString stringWithFormat:@"¥%.2f",mS];

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
    NSDictionary *mStyle1 = @{@"color": [UIColor redColor]};

    GGShopArr *mShop = mShopCarList.mShopArr[section];
    
    float mPP = 0.0;
    
    for (GGPayN *mGoods in mShop.mGoodsArr) {
        mPP += mGoods.mSPrice;
    }
    mPP  = mPP - mShop.mCoupPrice;
    
    if (mPP <= 0) {
        mPP = 0.0;
    }
    
    mFooterSection = [mComfirmHederAndFooterSection shareFooter];
    mFooterSection.mSection = section;
    
    if (mShop.mDescript.length == 0) {
        mShop.mDescript = @"暂无优惠";
    }
    
    mFooterSection.mMoney.attributedText = [[NSString stringWithFormat:@"优惠金额:<color>%@</color>   总金额:<color>¥%.2f</color> ",mShop.mDescript,mPP-mShopCarList.mJianPrice] attributedStringWithStyleBook:mStyle1];

    [mFooterSection.mSenderType setTitle:mShop.mSendName forState:0];
    
    NSString *mNote = nil;
    NSString *mCoupp = nil;
    if (mShop.mMessage.length == 0) {
        mNote = @"请输入备注：";
    }else{
        mNote = [NSString stringWithFormat:@"备注：%@",mShop.mMessage];
    }
    
    if (mShop.mCoupName.length == 0) {
        mCoupp = @"选择优惠券";
    }else{
        mCoupp = mShop.mCoupName;
    }
    
    mFooterSection.mMsg.text = mNote;
    
    [mFooterSection.mCoup setTitle:mCoupp forState:0];
    
    
    mFooterSection.delegate = self;
    return mFooterSection;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    GGShopArr *mShop = mShopCarList.mShopArr[section];
    
    mHeaderSection = [mComfirmHederAndFooterSection shareHeader];
    mHeaderSection.mSection = section;
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
- (void)sectionWithMessage:(NSInteger)mIndexPath{
    GGShopArr *mShop = mShopCarList.mShopArr[mIndexPath];
    
    UIStoryboard *secondStroyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    feedbackViewController *f =[secondStroyBoard instantiateViewControllerWithIdentifier:@"xxx"];
    f.mType = 2;
    f.block = ^(NSString *content){
        mShop.mMessage = content;
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:f animated:YES];

    
    
}
#pragma mark ---- 优惠券
- (void)sectionWithCoup:(NSInteger)mIndexPath{
    
    
    if (mShopCarList.mIsUseScore == 1) {
        [self showErrorStatus:@"您已使用积分，不能再使用优惠卷了哟！"];
        return;
    }else{
        GGShopArr *mShop = mShopCarList.mShopArr[mIndexPath];
        
        mCoupViewController *coup = [mCoupViewController new];
        coup.mSType = 2;
        coup.block = ^(NSString *content,NSString *mid,NSString *mPrice){
            mShop.mCoupName = content;
            mShop.mCoupId = [mid intValue];
            mShop.mCoupPrice = [mPrice floatValue];
            if (mid.length == 0) {
                isCoup = 0;
            }else{
                isCoup = 1;
            }
            float mp = 0.0;
            
            mp = mShopCarList.mTotlePay - mShop.mCoupPrice;
            
            if (mp <= 0) {
                mp = 0;
            }
            
            mShopCarList.mTotlePay = mp;
            [self upDatePage];
            [self.tableView reloadData];
        };
        [self pushViewController:coup];

    }
    
    
}
#pragma mark ---- 配送方式
- (void)sectionWithSendType:(NSInteger)mIndexPath{
    GGShopArr *mShop = mShopCarList.mShopArr[mIndexPath];
    
    mSelectSenTypeViewController *mmm = [[mSelectSenTypeViewController alloc] initWithNibName:@"mSelectSenTypeViewController" bundle:nil];
    
    mmm.block = ^(NSString *content,NSString *mid,BOOL mHaveDevelFee){
        mShop.mSendName = content;
        mShop.mSendId = mid;
        /**
         *  如果不加判断会造成配送费不断累加的bug
         */
        if (mHaveDevelFee) {
            
            if (mIsDeliver != mHaveDevelFee) {
                mShopCarList.mTotlePay += mShop.mSendPrice;
                mIsDeliver = YES;
            }else{

            }
    
            
        }else{
            if (mIsDeliver == mHaveDevelFee) {
                mIsDeliver = NO;
            }else{
                mShopCarList.mTotlePay -= mShop.mSendPrice;
                mIsDeliver = NO;
            }
            
            
        }
        [self upDatePage];
        [self.tableView reloadData];
    };
    [self pushViewController:mmm];
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

- (void)leftBtnTouched:(id)sender{

//    [self popViewController_2];
    [self popViewController];
}
@end
