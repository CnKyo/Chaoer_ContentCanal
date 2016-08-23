//
//  communityOrderViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/24.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "communityOrderViewController.h"
#import "communityOrderTableViewCell.h"

#import "communityOrderDetailViewController.h"
#import "comFirmOrderViewController.h"

#pragma mark -------关联购物车view
#import "mShopCarHeaderSection.h"

#import "WKOrderCell.h"
#import "WKOrderBottomView.h"
#import "WKOrderHeadView.h"
#import "goPayViewController.h"
#import "mMarketRateViewController.h"

#define SMGoodsModelPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"goods.archive"]

typedef NS_ENUM(NSInteger, QHLViewState){
    
    QHLViewStateNormal = 0,
    QHLViewStateEdited
    
};

@interface communityOrderViewController ()<UITableViewDelegate,UITableViewDataSource,WKSegmentControlDelagate,WKHeaderViewDelegate,WKOrderCellDelegate,WKOrderBottomDelegate,cellWithBtnClickDelegate>


@property (nonatomic, strong) WKOrderBottomView *mBottomView;

@property (nonatomic, assign) QHLViewState state;

/**
 *  保存编辑状态下 选中的按钮数组
 */
@property (nonatomic, strong) NSMutableArray *btnsArray;

/**
 *  存储编辑状态下保存选中时存储对应的沙盒中的数据的数组
 */
@property (nonatomic, strong) NSMutableArray *documentArray;


/**
 *  选中商品数量
 */
@property (nonatomic, assign) NSInteger count;

/**
 *  选中商品金额
 */
@property (nonatomic, assign) NSInteger money;


@property(nonatomic, strong) NSMutableArray *deleteArr;//删除数据的数组

@property (nonatomic, strong) NSMutableArray *mTempArr;

@end

@implementation communityOrderViewController
{
    
    WKSegmentControl    *mSegmentView;
    int mType;
    
    NSMutableArray *mJsonArr;
}
- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    
    [super viewDidLoad];
    
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.Title = self.mPageName = @"我的订单";
    
    self.deleteArr = [NSMutableArray new];
    self.mTempArr = [NSMutableArray new];
    mJsonArr = [NSMutableArray new];
    self.state = QHLViewStateNormal;

    mType = 10;
    [self initView];
//    [self initBottomView];
}
- (void)initView{
    
    
    mSegmentView = [WKSegmentControl initWithSegmentControlFrame:CGRectMake(0, 64, DEVICE_Width, 40) andTitleWithBtn:@[@"未付款", @"进行中",@"待评价"] andBackgroudColor:[UIColor whiteColor] andBtnSelectedColor:M_CO andBtnTitleColor:M_TextColor1 andUndeLineColor:M_CO andBtnTitleFont:[UIFont systemFontOfSize:15] andInterval:20 delegate:self andIsHiddenLine:NO andType:1];
    
    [self.view addSubview:mSegmentView];
    
    [self loadTableView:CGRectMake(0, 40, DEVICE_Width, DEVICE_Height-104) delegate:self dataSource:self];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    /*=========================至关重要============================*/
    self.tableView.allowsMultipleSelectionDuringEditing = YES;

    self.haveHeader = YES;
    self.haveFooter = YES;
    
    
    UINib   *nib = [UINib nibWithNibName:@"communityOrderTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    

}


- (void)headerBeganRefresh{
    self.page = 1;
    [self showWithStatus:@"正在加载..."];
    [[mUserInfo backNowUser] getMyMarketOrderList:mType andPage:self.page block:^(mBaseData *resb, NSArray *mArr) {
        [self headerEndRefresh];
        [self dismiss];
        [self removeEmptyView];
        [self.mTempArr removeAllObjects];
        
        if (resb.mSucess) {
            
            if (mArr.count <= 0) {
                [self addEmptyView:nil];
            }else{
            
                [self.mTempArr addObjectsFromArray:mArr];
            }
            [self.tableView reloadData];
        }else{
            [self addEmptyView:nil];
            [self showErrorStatus:resb.mMessage];
            [self.tableView reloadData];

        }
    }];
    
}

- (void)footetBeganRefresh{

    self.page ++;
    [self showWithStatus:@"正在加载..."];
    [[mUserInfo backNowUser] getMyMarketOrderList:mType andPage:self.page block:^(mBaseData *resb, NSArray *mArr) {
        [self footetEndRefresh];
        [self dismiss];
        [self removeEmptyView];
        
        if (resb.mSucess) {
            
            if (mArr.count <= 0) {
                [self addEmptyView:nil];
            }else{
                
                [self.mTempArr addObjectsFromArray:mArr];
            }
            [self.tableView reloadData];
        }else{
            [self addEmptyView:nil];
            [self showErrorStatus:resb.mMessage];
            [self.tableView reloadData];

        }
    }];
}
#pragma mark -添加Bottomview
- (void)initBottomView{

    self.mBottomView = [[WKOrderBottomView alloc] initWithFrame:CGRectMake(0, DEVICE_Height-60, DEVICE_Width, 60)];
    self.mBottomView.backgroundColor = [UIColor whiteColor];
    self.mBottomView.bottomDelegate = self;
    self.mBottomView.mNum = self.count;
    [self.view addSubview:self.mBottomView];
    
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
//    if (mType == 10) {

//        return self.mTempArr.count;
//    }else{
        return 1;
//    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (mType == 10) {
//        GMyMarketOrderList *shop = self.mTempArr[section];
//        return shop.mGoodsArr.count;
//    }else{
//        return 5;
//    }
    

    return self.mTempArr.count;

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    GMyMarketOrderList *shop = self.mTempArr[indexPath.row];

        //创建cell
    communityOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setMShop:shop];
    
    cell.delegate = self;
    cell.mShop = [GMyMarketOrderList new];
    cell.mShop = shop;
    
    cell.mdobtn.mShop = shop;
    cell.mCancelBtn.mShop = shop;
    
    return cell;

    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    GMyMarketOrderList *shop = self.mTempArr[indexPath.row];
    
    communityOrderDetailViewController *order = [[communityOrderDetailViewController alloc] initWithNibName:@"communityOrderDetailViewController" bundle:nil];
    order.mShop = [GMyMarketOrderList new];
    order.mShop = shop;
    [self pushViewController:order];
    
}
#pragma mark----分类按钮点击事件
- (void)WKDidSelectedIndex:(NSInteger)mIndex{
    MLLog(@"点击了%lu",(unsigned long)mIndex);
    
    
    mType = [[NSString stringWithFormat:@"%ld",(long)mIndex+10] intValue];
    
    if (mType == 12) {
        mType = 13;
    }
    
    [self.tableView reloadData];
    //    [self.tableView headerBeginRefreshing];
    
//    if (mType == 10) {
//        self.mBottomView.hidden = NO;
//        mRR.size.height = DEVICE_Height-164;
//        self.tableView.frame = mRR;
//    }else{
//        self.mBottomView.hidden = YES;
//        mRR.size.height = DEVICE_Height-104;
//        self.tableView.frame = mRR;
//    }
    [self headerBeganRefresh];
}

#pragma mark - 创建表头视图
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    if (mType == 10) {
//        WKOrderHeadView *headerView = [WKOrderHeadView headerWithTableView:tableView];
//        //获取模型
//        GMyMarketOrderList *shop = self.mTempArr[section];
//        headerView.shop = shop;
//        headerView.mStoreImg.image = [UIImage imageNamed:@"ppt_my_msg"];
//        headerView.section = section;
//        //headerView代理
//        headerView.WKHeaderViewDelegate = self;
//        return headerView;
//
//    }else{
//        return nil;
//    }
//    
//}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    
//    if (mType == 10) {
//        mShopCarHeaderSection *mFooter = [mShopCarHeaderSection shareFooterView];
//        
//        return mFooter;
//    }else{
//        return nil;
//    }
//    
//
//}
#pragma mark - 设置cell侧滑按钮
#pragma mark -- tableviewDelegate
//是否可以编辑  默认的时YES
//-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//    return YES;
//}

//选择编辑的方式,按照选择的方式对表进行处理
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    GMyMarketOrderList *shop = self.mTempArr[indexPath.section];
//
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        //删除数据
//        [shop.mGoodsArr removeObjectAtIndex:indexPath.row];
//        
//        
//        if (!shop.mGoodsArr.count) {   //判断 shoppingCar数组中的shop对象的goods数组 是否为空  为空的话移除shop  不为空的话 移除good
//            [self.mTempArr removeObjectAtIndex:indexPath.section];
//        }
//        [tableView reloadData];
//        
//        if (self.state == QHLViewStateEdited) { //在编辑界面下删除cell时  同时删除沙盒中读取到的数组中对应的元素
//            //根据indexPath获取到QHLShop对象
//            GMyMarketOrderList *shops = self.mTempArr[indexPath.section];
//            
//            //移除该对象goods数组中的下标为indexPath.row的元素
//            [shops.mGoodsArr removeObject:shops.mGoodsArr[indexPath.row]];
//            
//            if (!shops.mGoodsArr.count) { //判断沙盒存储的数组中的shop对象的goods数组 是否为空  为空的话移除
//                [self.mTempArr removeObject:shops];
//            }
//        }
//        
//        for (GMyOrderGoodsA *good in shop.mGoodsArr) {
//            if (!good.selected) {
//                shop.selected = NO;
//                [self setButtonSelectState:NO];
//                [tableView reloadData];
//                return;
//            }
//        }
//        
//        shop.selected = YES;
//        if (self.state == QHLViewStateEdited) {
//            //根据indexPath获取到QHLShop对象
//            GMyMarketOrderList *shops = self.mTempArr[indexPath.section];
//            [self handleObjectInArrays:shop documentsObject:shops selectedState:YES];
//        }
//        [tableView reloadData];
//        
//        for (GMyMarketOrderList *shop in self.mTempArr) {
//            if (!shop.selected) {
//                [self setButtonSelectState:NO];
//                return;
//            }
//        }
//        [self setButtonSelectState:YES];
//        [tableView reloadData];
//
//    }
//    
//}
//
////选择你要对表进行处理的方式  默认是删除方式
//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return  UITableViewCellEditingStyleDelete ;
//}
//
////修改删除按钮的文字
//-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return @"删除";
//}
//
//- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    GMyMarketOrderList *shop = self.mTempArr[indexPath.section];
//    
//    //删除
//    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        //删除数据
//        [shop.mGoodsArr removeObjectAtIndex:indexPath.row];
//        
//        
//        if (!shop.mGoodsArr.count) {   //判断 shoppingCar数组中的shop对象的goods数组 是否为空  为空的话移除shop  不为空的话 移除good
//            [self.mTempArr removeObjectAtIndex:indexPath.section];
//        }
//        [tableView reloadData];
//        
//        if (self.state == QHLViewStateEdited) { //在编辑界面下删除cell时  同时删除沙盒中读取到的数组中对应的元素
//            //根据indexPath获取到QHLShop对象
//            GMyMarketOrderList *shops = self.mTempArr[indexPath.section];
//            
//            //移除该对象goods数组中的下标为indexPath.row的元素
//            [shops.mGoodsArr removeObject:shops.mGoodsArr[indexPath.row]];
//            
//            if (!shops.mGoodsArr.count) { //判断沙盒存储的数组中的shop对象的goods数组 是否为空  为空的话移除
//                [self.mTempArr removeObject:shops];
//            }
//        }
//        
//        for (GMyOrderGoodsA *good in shop.mGoodsArr) {
//            if (!good.selected) {
//                shop.selected = NO;
//                [self setButtonSelectState:NO];
//                [tableView reloadData];
//                return;
//            }
//        }
//        
//        shop.selected = YES;
//        if (self.state == QHLViewStateEdited) {
//            //根据indexPath获取到QHLShop对象
//            GMyMarketOrderList *shops = self.mTempArr[indexPath.section];
//            [self handleObjectInArrays:shop documentsObject:shops selectedState:YES];
//        }
//        [tableView reloadData];
//        
//        for (GMyMarketOrderList *shop in self.mTempArr) {
//            if (!shop.selected) {
//                [self setButtonSelectState:NO];
//                return;
//            }
//        }
//        [self setButtonSelectState:YES];
//        
//    }];
//    
//    //    return @[deleteAction, readedAction, toTapAction];
//    return @[deleteAction];
//    
//}
//
//#pragma mark - 设置表头视图高度
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if (mType == 10) {
//        return 65;
//    }else{
//        return 0;
//    }
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//
//    if (mType == 10) {
//        return 50;
//    }else{
//        
//        return 0;
//    }
//    
//}
#pragma mark - 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    
//    if (mType == 10) {
//        return 85;
//    }else{
        return 150;
//    }
}

#pragma mark - 根据不同的选中状态来设置底部view的隐藏&显示
- (void)setButtonSelectState:(BOOL)selected {
    if (self.state == QHLViewStateNormal) { //根据状态来设置不同的全选按钮的选中
        self.mBottomView.btnSelected = selected;
    } else {
        MLLog(@"这是什么鬼？");
    }
}
#pragma mark - 根据不同的选中状态来对数组进行操作
- (void)handleObjectInArrays:(id)btnsObject documentsObject:(id)documentsObject selectedState:(BOOL)selected{
    
    if (selected) { //选中时
        [self.documentArray addObject:documentsObject];
        [self.btnsArray addObject:btnsObject];
    } else { //取消选中时
        [self.documentArray removeObject:documentsObject];
        [self.btnsArray removeObject:btnsObject];
    }
}
#pragma mark - 代理方法
- (void)mGoPayAction{
    MLLog(@"去结算:%@",self.deleteArr);
    comFirmOrderViewController *comfir = [[comFirmOrderViewController alloc] initWithNibName:@"comFirmOrderViewController" bundle:nil];
    [self pushViewController:comfir];
    
}
- (void)allSelectedWithView:(WKOrderBottomView *)mBottomView didSelected:(BOOL)mSelected{
    BOOL selected = !mSelected;
    [self.deleteArr removeAllObjects];
    if (self.state == QHLViewStateNormal) { //判断当前的state状态
        
        if (selected) { //全选按钮 选中
            self.hiddenRightBtn = NO;
            for (GMyMarketOrderList *shop in self.mTempArr) {
                for (GMyOrderGoodsA *good in shop.mGoodsArr) {
                    
                    if (!good.selected) {  //判断cell中的按钮是否选中
                        self.count ++;
                        
                        //计算金额
                        self.money += good.mUnitPrice;
                        
                        [self.deleteArr addObject:[NSString stringWithFormat:@"%.2f",good.mUnitPrice]];
                        
                    }
                }
            }
            
            
        }else {  //全选按钮不选中
            self.hiddenRightBtn = YES;
            for (GMyMarketOrderList *shop in self.mTempArr) {
                for (GMyOrderGoodsA *good in shop.mGoodsArr) {
                    self.count --;
                    
                    self.money -= good.mUnitPrice;
                }
            }
        }
        
        self.mBottomView.mNum = self.count;
        
        //计算金额
        self.mBottomView.mMoney = self.money;
    }
    
    
    //遍历 改变tableView中的所有按钮状态
    for (GMyMarketOrderList *shop in self.mTempArr) {
        
        shop.selected = selected;
        for (GMyOrderGoodsA *good in shop.mGoodsArr) {
            good.selected = selected;
        }
    }
    [self.tableView reloadData];
    
    mBottomView.btnSelected = selected;
}
#pragma mark - headerView的代理方法
- (void)headerWithView:(WKOrderHeadView *)mHeaderView andBtnSelected:(BOOL)mSelected andSection:(NSInteger)mSection{
    
    BOOL selected = !mSelected;
    
    //获取对应的模型
    GMyMarketOrderList *shop = self.mTempArr[mSection];
    
    //设置表头view的按钮状态
    shop.selected = selected;
    
    if (self.state == QHLViewStateNormal) {
        
        if (selected) {
            for (GMyOrderGoodsA *good in shop.mGoodsArr) {
                //判断表头所在的cell组中  cell中的按钮 是否选中,当不选中的情况下 执行下面代码
                if (!good.selected) {
                    self.count ++;
                    //添加金额
                    self.money += good.mUnitPrice;
                }
            }
        } else { //这边不用做判断,表头视图中的cell中的按钮 都是选中状态
            for (GMyOrderGoodsA *good in shop.mGoodsArr) {
                self.count --;
                //添加金额
                self.money -= good.mUnitPrice;
            }
        }
        
        self.mBottomView.mNum = self.count;
        self.mBottomView.mMoney = self.money;
        
    } else {  //edit 状态
        GMyMarketOrderList *shops = self.mTempArr[mSection];
        
        [self handleObjectInArrays:shop documentsObject:shops selectedState:selected];
        
        NSInteger count = shop.mGoodsArr.count;
        for (int i = 0; i < count; i++) {
            
            [self handleObjectInArrays:shop.mGoodsArr[i] documentsObject:shops.mGoodsArr[i] selectedState:selected];
            
        }
    }
    
    //设置表头所在组cell的按钮状态
    for (GMyOrderGoodsA *good in shop.mGoodsArr) {
        good.selected = selected;
    }
    [self.tableView reloadData];
    
    
    //设置全选按钮的选中状态
    for (GMyMarketOrderList *shop in self.mTempArr) {
        if (!shop.selected) {
            
            [self setButtonSelectState:NO];
            
            return;
        }
    }
    [self setButtonSelectState:YES];
}
#pragma mark - cell的代理方法
- (void)cell:(WKOrderCell *)cell cellDidSelected:(BOOL)selBtnSelectState andIndexPath:(NSIndexPath *)indexPath{
    BOOL selected = !selBtnSelectState;
    
    //获取模型
    GMyMarketOrderList *shop = self.mTempArr[indexPath.section];
    GMyOrderGoodsA *good = shop.mGoodsArr[indexPath.row];
    
    //设置按钮所在的cell的按钮的选中状态
    good.selected = selected;
    
    if (self.state == QHLViewStateNormal) { //判断当前view的state
        
        if (selected) {
            self.count ++;
            
            //添加金额
            self.money += good.mUnitPrice;
            
        }else {
            self.count --;
            
            //减去金额
            self.money -= good.mUnitPrice ;
        }
        
        self.mBottomView.mNum = self.count;
        self.mBottomView.mMoney = self.money;
        
    } else { //edit 状态
        
        //获取沙盒数组中的模型
        GMyMarketOrderList *shops = self.mTempArr[indexPath.section];
        GMyOrderGoodsA *goods = shops.mGoodsArr[indexPath.row];
        
        [self handleObjectInArrays:good documentsObject:goods selectedState:selected];
        
    }
    
    
    
    //设置按钮cell所在的表头视图的按钮状态
    for (GMyOrderGoodsA *goods in shop.mGoodsArr) {
        
        if (!goods.selected) {
            
            shop.selected = NO;
            [self.tableView reloadData];
            
            if (self.state == QHLViewStateNormal) {
                
                self.mBottomView.btnSelected = NO; //全选按钮设置为未选中状态
                
            } else {
                
                //获取沙盒数组中的模型
                GMyMarketOrderList *shops = self.mTempArr[indexPath.section];
                
                [self.btnsArray removeObject:shop];
                [self.documentArray removeObject:shops];
                
            }
            
            return;
        }
    }
    
    //能执行到此处,就说明该组cell的按钮 都是选中状态
    shop.selected = YES;
    
    if (self.state == QHLViewStateEdited) {
        //获取沙盒数组中的模型
        GMyMarketOrderList *shops = self.mTempArr[indexPath.section];
        
        [self.btnsArray addObject:shop];
        [self.documentArray addObject:shops];
    }
    
    [self.tableView reloadData];
    
    //根据表透视图的按钮状态设置全选按钮的状态
    for (GMyMarketOrderList *shop in self.mTempArr) {
        if (!shop.selected) {
            
            [self setButtonSelectState:NO];
            
            return;
        }
    }
    
    [self setButtonSelectState:YES];

}
#pragma mark ---- 支付按钮事件
- (void)cellWithBtnClickAction:(GMyMarketOrderList *)mShop{

    if (mShop.mState == 10) {
        
        goPayViewController *goPay = [[goPayViewController alloc] initWithNibName:@"goPayViewController" bundle:nil];
        goPay.mMoney = mShop.mCommodityPrice;
        goPay.mOrderCode = mShop.mOrderCode;
        goPay.mType = 3;
        [self pushViewController:goPay];
        
    
    }if (mShop.mState == 13) {
        mMarketRateViewController *mmm = [[mMarketRateViewController alloc] initWithNibName:@"mMarketRateViewController" bundle:nil];
        mmm.mName = mShop.mShopName;
        mmm.mShopImg = mShop.mShopLogo;
        mmm.mTotlaPrice = mShop.mCommodityPrice;
        mmm.mShopId = mShop.mShopId;
        mmm.mOrderCode = mShop.mOrderCode;
        
        [self pushViewController:mmm];
    }
    
}
#pragma mark ---- 取消按钮事件
/**
 *  取消按钮事件
 *
 *  @param mShop 带过来的对象
 */
- (void)cellWithCancelBtnClick:(GMyMarketOrderList *)mShop{
    [self showWithStatus:@"正在取消..."];
    [[mUserInfo backNowUser] cancelMarketOrder:mShop.mOrderCode andOrderType:mShop.mType block:^(mBaseData *resb) {
        if (resb.mSucess) {
            [self showSuccessStatus:@"取消成功"];
            
            [self headerBeganRefresh];
        }else{
        
            [self showErrorStatus:resb.mMessage];
        }
        
    }];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
        
        if( buttonIndex == 1)
        {
            
       
            
            
            
        }
        
    
    
}

- (void)AlertViewShow:(NSString *)alerViewTitle alertViewMsg:(NSString *)msg alertViewCancelBtnTiele:(NSString *)cancelTitle alertTag:(int)tag{
    
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:alerViewTitle message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:@"确定", nil];
    al.delegate = self;
    al.tag = tag;
    [al show];
}

@end
