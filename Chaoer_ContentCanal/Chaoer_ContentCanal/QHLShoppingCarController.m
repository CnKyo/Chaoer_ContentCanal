//
//  QHLShoppingCarController.m
//  shoppingCar
//
//  Created by Apple on 16/1/12.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "QHLShoppingCarController.h"

#import "QHLShop.h"
#import "QHLGoods.h"
#import "QHLButton.h"

//#import "QHLTableViewCell.h"
#import "QHLHeaderView.h"

#import "UIView+QHLExtension.h"
#import "QHLSettleMentView.h"
#import "QHLHiddenView.h"

#import "homeNavView.h"
#import "mShopCarHeaderSection.h"
#import "comFirmOrderViewController.h"
#import "shopCarHeaderAndFooterView.h"

#import "QHLShopCarCell.h"
#define SMGoodsModelPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"goods.archive"]

typedef NS_ENUM(NSInteger, QHLViewState){
    
    QHLViewStateNormal = 0,
    QHLViewStateEdited
    
};

@interface QHLShoppingCarController ()<QHLHeaderViewDelegate, QHLSettleMentViewDelegate, QHLHiddenViewDelegate, UITableViewDelegate,UITableViewDataSource,WKTableViewCellDelegate>

@property (nonatomic, strong) NSMutableArray *shoppingCar;
@property (nonatomic, weak) QHLSettleMentView *settleMentView;
@property (nonatomic, weak) QHLHiddenView *hiddenView;

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
 *  存储在沙盒中的数据数组
 */
@property (nonatomic, strong) NSMutableArray *mtempArray;

/**
 *  选中商品数量
 */
@property (nonatomic, assign) NSInteger count;

/**
 *  选中商品金额
 */
@property (nonatomic, assign) NSInteger money;


@property(nonatomic, strong) NSMutableArray *deleteArr;//删除数据的数组
@property(nonatomic, strong) NSMutableArray *markArr;//标记数据的数组
@property(nonatomic, strong) NSMutableArray *selectedRows;


@end

@implementation QHLShoppingCarController{

    homeNavView *mNavView;
    
    shopCarHeaderAndFooterView *mEmptyView;
}
#pragma mark - viewDidLoad 方法
- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    
    [super viewDidLoad];
    
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.Title = self.mPageName = @"购物车";
    self.rightBtnTitle = @"删除";
    self.shoppingCar = [NSMutableArray new];
    self.markArr = [NSMutableArray new];
    self.deleteArr = [NSMutableArray new];
    self.selectedRows = [NSMutableArray new];
    
    [self initView];
    //添加hiddenView
    [self setUpHiddenView];
 
    self.state = QHLViewStateNormal;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self setUpNavigationRightItem];
    
    //添加settle accounts view
    [self setUpSettleAccountView];
    
    [self initEmptyView];
}
- (void)initView{

//    mNavView = [homeNavView shareChatNav];
//    mNavView.mCustomTitle.text = @"购物车";
//    [self.view addSubview:mNavView];
//    [mNavView makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.equalTo(self.view).offset(@0);
//        make.height.offset(@64);
//    }];
    
    
    [self loadTableView:CGRectMake(0, 0, DEVICE_Width, DEVICE_Height-124) delegate:self dataSource:self];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    self.tableView.showsVerticalScrollIndicator = NO;
    /*=========================至关重要============================*/
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    self.tableView.editing = NO;
    
    
    self.haveHeader = YES;
    
    
    UINib   *nib = [UINib nibWithNibName:@"QHLShopCarCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

}
#pragma mark - 加载空视图
- (void)initEmptyView{

    mEmptyView = [shopCarHeaderAndFooterView shareHeaderView];
    mEmptyView.alpha = 0;
    [self.view addSubview:mEmptyView];
    
    [mEmptyView makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view).offset(@0);
        make.width.offset(DEVICE_Width);
        make.top.equalTo(self.view).offset(@64);
    }];
}
- (void)showEmptyView{
    [UIView animateWithDuration:0.2 animations:^{
        mEmptyView.alpha = 1;
    }];
}
- (void)dissmissEmptyView{
    [UIView animateWithDuration:0.2 animations:^{
        mEmptyView.alpha = 0;
    }];
}

#pragma mark - 懒加载
- (NSMutableArray *)tempArray {
    if (!_mtempArray) {
        
        _mtempArray = [NSKeyedUnarchiver unarchiveObjectWithFile:SMGoodsModelPath];
        
    }
    return _mtempArray;
}

- (NSMutableArray *)documentArray {
    if (!_documentArray) {
        _documentArray = [NSMutableArray array];
    }
    return _documentArray;
}

- (NSMutableArray *)btnsArray {
    if (!_btnsArray) {
        _btnsArray = [NSMutableArray array];
    }
    return _btnsArray;
}

//- (NSMutableArray *)shoppingCar {
//    if (!_shoppingCar) {
//        
//        _shoppingCar = [QHLShop shop];
//    }
//    return _shoppingCar;
//}
- (void)headerBeganRefresh{

    [self showWithStatus:@"加载中..."];
    [[mUserInfo backNowUser] getMyShopCarList:^(mBaseData *resb, NSArray *mArr) {
        [self dismiss];
        [self removeEmptyView];
        [self.shoppingCar removeAllObjects];
        [self headerEndRefresh];
         if (resb.mSucess) {
            
            if (mArr.count <= 0) {
                [self addEmptyView:nil];
            }else{
                [self.shoppingCar addObjectsFromArray:mArr];
                [self.tableView reloadData];
            }
            
        }else{
            [self addEmptyView:nil];
        }
    }];
    
}
#pragma mark -添加settle accounts view
- (void)setUpSettleAccountView {

    
    QHLSettleMentView *settleMentView = [[QHLSettleMentView alloc] initWithFrame:CGRectMake(0, DEVICE_Height-60, DEVICE_Width, 60)];
    settleMentView.backgroundColor = [UIColor whiteColor];
    settleMentView.settleMentViewDelegate = self;
    settleMentView.count = self.count;
    
    self.settleMentView = settleMentView;
    
    [self.view addSubview:settleMentView];
}
#pragma mark - 代理方法
- (void)mGoPayClick{
    MLLog(@"去结算:%@",self.deleteArr);
    comFirmOrderViewController *comfir = [[comFirmOrderViewController alloc] initWithNibName:@"comFirmOrderViewController" bundle:nil];
    [self pushViewController:comfir];

}
#pragma mark - settleMentView delegate
- (void)settleMentView:(QHLSettleMentView *)settleMentView didClickButton:(BOOL)allSelBtnSelectState {
    BOOL selected = !allSelBtnSelectState;
    [self.deleteArr removeAllObjects];
    if (self.state == QHLViewStateNormal) { //判断当前的state状态
        
        if (selected) { //全选按钮 选中
            self.hiddenRightBtn = NO;
            for (GShopCarList *shop in self.shoppingCar) {
                for (GShopCarGoods *good in shop.mGoodsArr) {
                    
                    if (!good.mSelected) {  //判断cell中的按钮是否选中
                        self.count ++;
                        
                        //计算金额
                        self.money += good.mGoodsPrice ;
                        
                        [self.deleteArr addObject:[NSString stringWithFormat:@"%.2f",good.mGoodsPrice]];
                        
                    }
                }
            }
                  
            
        }else {  //全选按钮不选中
            self.hiddenRightBtn = YES;
            for (GShopCarList *shop in self.shoppingCar) {
                for (GShopCarGoods *good in shop.mGoodsArr) {
                    self.count --;
                    
                    self.money -= good.mGoodsPrice ;
                }
            }
        }
        
        self.settleMentView.count = self.count;
        
        //计算金额
        self.settleMentView.money = self.money;
    }
    
    
    //遍历 改变tableView中的所有按钮状态
    for (GShopCarList *shop in self.shoppingCar) {
        
        shop.mSelected = selected;
        for (GShopCarGoods *good in shop.mGoodsArr) {
            good.mSelected = selected;
        }
    }
    [self.tableView reloadData];
    
    settleMentView.btnSelected = selected;
    
}
- (void)rightBtnTouched:(id)sender{

   

}
#pragma mark - 添加隐藏的view
- (void)setUpHiddenView {
    CGFloat hiddenViewX = 0;
    CGFloat hiddenViewW = self.view.width;
    CGFloat hiddenViewH = 44;
    CGFloat hiddenViewY = [UIScreen mainScreen].bounds.size.height - hiddenViewH - self.tabBarController.tabBar.height;
    
    QHLHiddenView *hiddenView = [[QHLHiddenView alloc] initWithFrame:CGRectMake(hiddenViewX, hiddenViewY, hiddenViewW, hiddenViewH)];
    hiddenView.hiddenViewDelegate = self;
    
    self.hiddenView = hiddenView;
    //设为隐藏
    hiddenView.hidden = YES;
    
    [self.navigationController.view addSubview:hiddenView];

}

#pragma mark - hiddenView delegate
- (void)hiddenView:(QHLHiddenView *)hiddenView didClicHiddenViewBtn:(QHLHiddenViewButtonState)buttonType {
    if (buttonType == QHLHiddenViewButtonStateShared) {
        NSLog(@"分享");
    } else if (buttonType == QHLHiddenViewButtonStateAttention) {
        NSLog(@"移入关注");
    } else if (buttonType == QHLHiddenViewButtonStateDelete) {
        NSLog(@"删除");
        
        //修改self.shoppingCar
        [self enumerateObjectsUsForinWithDataArray:self.btnsArray modelArray:self.shoppingCar];
        
        if (!self.shoppingCar.count) {
            self.hiddenView.allSelBtnSelected = NO;
        }
        
        [self.tableView reloadData];
        
        //修改保存沙盒数据的数值中对应的数据
        [self enumerateObjectsUsForinWithDataArray:self.documentArray modelArray:self.tempArray];
        
    }
}
/**
 *  @param dataArray  dataArray 保存要删除的对象的数组
 *  @param modelArray modelArray 模型数组 要从该数组中删除数据
 */
- (void)enumerateObjectsUsForinWithDataArray:(NSMutableArray *)dataArray modelArray:(NSMutableArray *)modelArray {
    for (id obj in dataArray) {
        
        for (GShopCarList *shops in modelArray) {
            
            for (GShopCarGoods *goods in shops.mGoodsArr) {
                
                if ([goods isEqual:obj]) {
                    
                    [shops.mGoodsArr removeObject:goods];
                    break;
                    
                }
            }
        }
    }
    
    //遍历删除 shops
    for (id obj in dataArray) {
        
        for (GShopCarList *shops in modelArray) {
            
            if ([shops isEqual:obj]) {
                
                [modelArray removeObject:shops];
                break;
            }
        }
    }
}

- (void)hiddenView:(QHLHiddenView *)hiddenView didClickAllSelBtn:(BOOL)allSelBtnSelectState {
    BOOL selected = !allSelBtnSelectState;
    
    hiddenView.allSelBtnSelected = selected;
    
    for (GShopCarList *shop in self.shoppingCar) {
        shop.mSelected = selected;
        
        //选中的cell添加到btns数组中
        NSUInteger SectionIndex = [self.shoppingCar indexOfObject:shop];
        
        GShopCarGoods *shops = self.tempArray[SectionIndex];
        
        [self handleObjectInArrays:shop documentsObject:shops selectedState:selected];
        
        for (GShopCarGoods *good in shop.mGoodsArr) {
            good.mSelected = selected;
            
            NSUInteger rowIndex = [shop.mGoodsArr indexOfObject:good];
            
            GShopCarGoods *goods = [self.tempArray[SectionIndex] goods][rowIndex];
            
            [self handleObjectInArrays:good documentsObject:goods selectedState:selected];
        }
    }
    
    [self.tableView reloadData];
}


#pragma 设置rightItem
- (void)setUpNavigationRightItem {
    QHLButton *editBtn = [[QHLButton alloc] init];
    //设置相关属性
    editBtn.size = CGSizeMake(40, 40);
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setTitle:@"完成" forState:UIControlStateSelected];
    [editBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //创建navigationBar右侧Item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
    
    //右侧item点击事件
    [editBtn addTarget:self action:@selector(editBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 编辑按钮点击事件
- (void)editBtnDidClick:(QHLButton *)editBtn {
    editBtn.selected = !editBtn.selected;
    self.settleMentView.hidden = !self.settleMentView.hidden;
    self.hiddenView.hidden = !self.hiddenView.hidden;
    
    if (editBtn.isSelected) { //编辑时
        self.state = QHLViewStateEdited; //设置当前状态为编辑状态
        
        //写入沙盒中
        [NSKeyedArchiver archiveRootObject:self.shoppingCar toFile:SMGoodsModelPath];
        
        //遍历 改变tableView中的所有按钮状态
        for (GShopCarList *shop in self.shoppingCar) {
            
            //设置表头视图中的按钮状态
            shop.mSelected = NO;
            for (GShopCarGoods *good in shop.mGoodsArr) {
                
                //设置cell中按钮的选中状态
                good.mSelected = NO;
                
            }
        }
        [self.tableView reloadData];

    } else { //编辑完成
        //设置当前状态为正常状态
        self.state = QHLViewStateNormal;
        self.hiddenView.allSelBtnSelected = NO; //设置 隐藏界面的全选按钮为不选中状态
        
        self.shoppingCar = self.tempArray;
        [self.tableView reloadData];
        
        self.btnsArray = nil;
        self.documentArray = nil;
        self.tempArray = nil;
        
        if (!self.shoppingCar.count) {
            self.settleMentView.btnSelected = NO;
            return;
        }
        
        //遍历self.shoppingCar
        self.money = 0;
        self.count = 0;
        
        for (GShopCarList *shop in self.shoppingCar) {
            
            for (GShopCarGoods *good in shop.mGoodsArr) {
                
                if (good.mSelected) {
                    
                    self.count ++;
                    self.money += good.mGoodsPrice;
                    
                }
            }
        }
        
        self.settleMentView.count = self.count;
        self.settleMentView.money = self.money;
        
        
        
        //self.shoppingCar 不为空的话 做下面循环遍历
        for (GShopCarList *shop in self.shoppingCar) {
            
            //定义一个bool值 遍历结束后  NO:表示该组cell中有cell的btn都是选中的   YES:表示该组cell中有cell的btn是未选中的
            BOOL cellsState = NO;
            
            //设置按钮cell所在的表头视图的按钮状态
            for (GShopCarGoods *goods in shop.mGoodsArr) {
                
                if (!goods.mSelected) {
                    
                    shop.mSelected = NO;
                    
                    [self.tableView reloadData];
                    
                    self.settleMentView.btnSelected = NO; //全选按钮设置为未选中状态
                    
                    cellsState = YES;
                    
                    break;
                }
            }
            
            if (!cellsState) {
                //能执行到此处,就说明该组cell的按钮 都是选中状态
                shop.mSelected = YES;
                
                [self.tableView reloadData];
            }
        }
        
        //根据表透视图的按钮状态设置全选按钮的状态
        for (GShopCarList *shop in self.shoppingCar) {
            if (!shop.mSelected) {
                
                self.settleMentView.btnSelected = NO;
                
                return;
            }
        }
        self.settleMentView.btnSelected = YES;
        
    }
}

#pragma mark - Table view data source & delegate
#pragma mark - 设置组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.shoppingCar.count;
}

#pragma mark - 设置每组表格数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GShopCarList *shop = self.shoppingCar[section];
    return shop.mGoodsArr.count;
}

#pragma mark - 创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取模型
    GShopCarList *shop = self.shoppingCar[indexPath.section];
    GShopCarGoods *goods = shop.mGoodsArr[indexPath.row];
    
    //创建cell
    QHLShopCarCell *cell = [QHLShopCarCell cellWithTableView:tableView];
    cell.mGoods = goods;
    cell.mProLogo.image = [UIImage imageNamed:@"ppt_my_msg"];
    cell.indexPath = indexPath;
    //cell代理
    cell.cellDelegate = self;
    return cell;
}

#pragma mark - 创建表头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    QHLHeaderView *headerView = [QHLHeaderView headerWithTableView:tableView];
    //获取模型
    GShopCarList *shop = self.shoppingCar[section];
    headerView.shop = shop;
    headerView.imgView.image = [UIImage imageNamed:@"ppt_my_msg"];
    headerView.section = section;
    //headerView代理
    headerView.headerViewDelegate = self;
    return headerView;
   
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    mShopCarHeaderSection *mFooter = [mShopCarHeaderSection shareFooterView];
    GShopCarList *shop = self.shoppingCar[section];

    CGFloat price = 0.0;
    
    for (GShopCarGoods *mGoods in shop.mGoodsArr) {
        price += mGoods.mGoodsPrice;
    }
    NSDictionary *mStyle1 = @{@"color": [UIColor redColor]};
    mFooter.mTotalMoney.attributedText = [[NSString stringWithFormat:@"总金额:<color>¥%.2f</color>",price] attributedStringWithStyleBook:mStyle1];
    return mFooter;
}
#pragma mark - 设置cell侧滑按钮
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GShopCarList *shop = self.shoppingCar[indexPath.section];
    
    //删除
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //删除数据
        [shop.mGoodsArr removeObjectAtIndex:indexPath.row];
        
        
        if (!shop.mGoodsArr.count) {   //判断 shoppingCar数组中的shop对象的goods数组 是否为空  为空的话移除shop  不为空的话 移除good
            [self.shoppingCar removeObjectAtIndex:indexPath.section];
        }
        [tableView reloadData];
        
        if (self.state == QHLViewStateEdited) { //在编辑界面下删除cell时  同时删除沙盒中读取到的数组中对应的元素
            //根据indexPath获取到QHLShop对象
            GShopCarList *shops = self.tempArray[indexPath.section];
            
            //移除该对象goods数组中的下标为indexPath.row的元素
            [shops.mGoodsArr removeObject:shops.mGoodsArr[indexPath.row]];
            
            if (!shops.mGoodsArr.count) { //判断沙盒存储的数组中的shop对象的goods数组 是否为空  为空的话移除
                [self.tempArray removeObject:shops];
            }
        }
        
        for (GShopCarGoods *good in shop.mGoodsArr) {
            if (!good.mSelected) {
                shop.mSelected = NO;
                [self setButtonSelectState:NO];
                [tableView reloadData];
                return;
            }
        }
        
        shop.mSelected = YES;
        if (self.state == QHLViewStateEdited) {
            //根据indexPath获取到QHLShop对象
            GShopCarList *shops = self.tempArray[indexPath.section];
            [self handleObjectInArrays:shop documentsObject:shops selectedState:YES];
        }
        [tableView reloadData];
        
        for (GShopCarList *shop in self.shoppingCar) {
            if (!shop.mSelected) {
                [self setButtonSelectState:NO];
                return;
            }
        }
        [self setButtonSelectState:YES];
        
    }];
    
//    return @[deleteAction, readedAction, toTapAction];
    return @[deleteAction];

}

#pragma mark - 设置表头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}
#pragma mark - 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

#pragma mark - 设置tableView的类型
//- (instancetype)init {
//    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
//    }
//    return self;
//}

#pragma mark - cell的删除代理方法
- (void)cell:(QHLShopCarCell *)cell deleteBtnDidClicked:(BOOL)isSelected andIndexPath:(NSIndexPath *)indexPath{
    //获取模型
    GShopCarList *shop = self.shoppingCar[indexPath.section];
    
    if (!isSelected) {
               //删除数据
        [shop.mGoodsArr removeObjectAtIndex:indexPath.row];
        
        
        if (!shop.mGoodsArr.count) {   //判断 shoppingCar数组中的shop对象的goods数组 是否为空  为空的话移除shop  不为空的话 移除good
            [self.shoppingCar removeObjectAtIndex:indexPath.section];
        }
        [self.tableView reloadData];
        
        if (self.state == QHLViewStateEdited) { //在编辑界面下删除cell时  同时删除沙盒中读取到的数组中对应的元素
            //根据indexPath获取到QHLShop对象
            GShopCarList *shops = self.tempArray[indexPath.section];
            
            //移除该对象goods数组中的下标为indexPath.row的元素
            [shops.mGoodsArr removeObject:shops.mGoodsArr[indexPath.row]];
            
            if (!shops.mGoodsArr.count) { //判断沙盒存储的数组中的shop对象的goods数组 是否为空  为空的话移除
                [self.tempArray removeObject:shops];
            }
        }
        
        for (GShopCarGoods *good in shop.mGoodsArr) {
            if (!good.mSelected) {
                shop.mSelected = NO;
                [self setButtonSelectState:NO];
                [self.tableView reloadData];
                return;
            }
        }
        
        shop.mSelected = YES;
        if (self.state == QHLViewStateEdited) {
            //根据indexPath获取到QHLShop对象
            GShopCarList *shops = self.tempArray[indexPath.section];
            [self handleObjectInArrays:shop documentsObject:shops selectedState:YES];
        }
        [self.tableView reloadData];
        
        for (GShopCarList *shop in self.shoppingCar) {
            if (!shop.mSelected) {
                [self setButtonSelectState:NO];
                return;
            }
        }
        [self setButtonSelectState:YES];
        

    }
}
#pragma mark - cell的代理方法
- (void)cell:(QHLShopCarCell *)cell selBtnDidClickToChangeAllSelBtn:(BOOL)selBtnSelectState andIndexPath:(NSIndexPath *)indexPath{
    BOOL selected = !selBtnSelectState;
    
    //获取模型
    GShopCarList *shop = self.shoppingCar[indexPath.section];
    GShopCarGoods *good = shop.mGoodsArr[indexPath.row];
    
    //设置按钮所在的cell的按钮的选中状态
    good.mSelected = selected;
    
    if (self.state == QHLViewStateNormal) { //判断当前view的state
        
        if (selected) {
                self.count ++;
                
                //添加金额
                self.money += good.mGoodsPrice;
            
        }else {
                self.count --;
                
                //减去金额
                self.money -= good.mGoodsPrice;
        }
        
        self.settleMentView.count = self.count;
        self.settleMentView.money = self.money;
        
    } else { //edit 状态
        
        //获取沙盒数组中的模型
        GShopCarList *shops = self.tempArray[indexPath.section];
        GShopCarGoods *goods = shops.mGoodsArr[indexPath.row];
        
        [self handleObjectInArrays:good documentsObject:goods selectedState:selected];
        
    }
    
    
    
    //设置按钮cell所在的表头视图的按钮状态
    for (GShopCarGoods *goods in shop.mGoodsArr) {
        
        if (!goods.mSelected) {
            
            shop.mSelected = NO;
            [self.tableView reloadData];
            
            if (self.state == QHLViewStateNormal) {
                
                self.settleMentView.btnSelected = NO; //全选按钮设置为未选中状态
                
            } else {
                
                //获取沙盒数组中的模型
                GShopCarList *shops = self.tempArray[indexPath.section];
                
                [self.btnsArray removeObject:shop];
                [self.documentArray removeObject:shops];
                
                self.hiddenView.allSelBtnSelected = NO;  //全选按钮设置为未选中状态
            }
            
            return;
        }
    }
    
    //能执行到此处,就说明该组cell的按钮 都是选中状态
    shop.mSelected = YES;
    
    if (self.state == QHLViewStateEdited) {
        //获取沙盒数组中的模型
        GShopCarList *shops = self.tempArray[indexPath.section];
        
        [self.btnsArray addObject:shop];
        [self.documentArray addObject:shops];
    }
    
    [self.tableView reloadData];
    
    //根据表透视图的按钮状态设置全选按钮的状态
    for (GShopCarList *shop in self.shoppingCar) {
        if (!shop.mSelected) {
            
            [self setButtonSelectState:NO];
            
            return;
        }
    }

    [self setButtonSelectState:YES];
}
- (void)cell:(QHLShopCarCell *)cell AddBtnDidClicked:(BOOL)isSelected andIndexPath:(NSIndexPath *)indexPath{

    MLLog(@"加。。。");
    
    
    
}
- (void)cell:(QHLShopCarCell *)cell JianBtnDidClicked:(BOOL)isSelected andIndexPath:(NSIndexPath *)indexPath{
    MLLog(@"减。。。");
    
}
- (void)cell:(QHLShopCarCell *)cell JianBtnDidClicked:(BOOL)isSelected andIndexPath:(NSIndexPath *)indexPath andGoods:(GShopCarGoods *)mGood{

    //获取模型
    GShopCarList *shop = self.shoppingCar[indexPath.section];
    GShopCarGoods *goods = shop.mGoodsArr[indexPath.row];
    
    if (mGood.mGoodsId == goods.mGoodsId) {
        if (shop.mGoodsArr.count<=1) {   //判断 shoppingCar数组中的shop对象的goods数组 是否为空  为空的话移除shop  不为空的话 移除good
            [self.shoppingCar removeObjectAtIndex:indexPath.section];
        }else{
            if (mGood.mQuantity<=1) {
                [shop.mGoodsArr removeObjectAtIndex:indexPath.row];
                
            }else{
                goods.mQuantity-=1;
                goods.mGoodsPrice-=mGood.mGoodsPrice;
            }
            
        }
        
    }
    [self.tableView reloadData];
    

    
}

- (void)cell:(QHLShopCarCell *)cell AddBtnDidClicked:(BOOL)isSelected andIndexPath:(NSIndexPath *)indexPath andGoods:(GShopCarGoods *)mGood{
    //获取模型
    GShopCarList *shop = self.shoppingCar[indexPath.section];
    GShopCarGoods *goods = shop.mGoodsArr[indexPath.row];
    
    if (mGood.mGoodsId == goods.mGoodsId) {
        goods.mQuantity+=1;
        goods.mGoodsPrice=goods.mGoodsPrice*goods.mQuantity;
    }
    [self.tableView reloadData];
}
#pragma mark - headerView的代理方法
- (void)headerView:(QHLHeaderView *)headerView selBtnDidClickToChangeAllSelBtn:(BOOL)selBtnSelectState andSection:(NSInteger)section {
    
    BOOL selected = !selBtnSelectState;
    
    //获取对应的模型
    GShopCarList *shop = self.shoppingCar[section];
    
    //设置表头view的按钮状态
    shop.mSelected = selected;
    
    if (self.state == QHLViewStateNormal) {
        
        if (selected) {
            for (GShopCarGoods *good in shop.mGoodsArr) {
                //判断表头所在的cell组中  cell中的按钮 是否选中,当不选中的情况下 执行下面代码
                if (!good.mSelected) {
                        self.count ++;
                        //添加金额
                        self.money += good.mGoodsPrice;
                }
            }
        } else { //这边不用做判断,表头视图中的cell中的按钮 都是选中状态
            for (GShopCarGoods *good in shop.mGoodsArr) {
                    self.count --;
                    //添加金额
                    self.money -= good.mGoodsPrice;
            }
        }
        
        self.settleMentView.count = self.count;
        self.settleMentView.money = self.money;
        
    } else {  //edit 状态
        GShopCarList *shops = self.tempArray[section];
        
        [self handleObjectInArrays:shop documentsObject:shops selectedState:selected];
        
        NSInteger count = shop.mGoodsArr.count;
        for (int i = 0; i < count; i++) {
            
            [self handleObjectInArrays:shop.mGoodsArr[i] documentsObject:shops.mGoodsArr[i] selectedState:selected];
            
        }
    }
    
    //设置表头所在组cell的按钮状态
    for (GShopCarGoods *good in shop.mGoodsArr) {
        good.mSelected = selected;
    }
    [self.tableView reloadData];
    
    
        //设置全选按钮的选中状态
    for (GShopCarList *shop in self.shoppingCar) {
        if (!shop.mSelected) {
            
            [self setButtonSelectState:NO];
            
            return;
        }
    }
    [self setButtonSelectState:YES];
}

#pragma mark - 根据不同的选中状态来设置底部view的隐藏&显示
- (void)setButtonSelectState:(BOOL)selected {
    if (self.state == QHLViewStateNormal) { //根据状态来设置不同的全选按钮的选中
        self.settleMentView.btnSelected = selected;
    } else {
        self.hiddenView.allSelBtnSelected = selected;
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
//是否可以编辑  默认的时YES
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//选择你要对表进行处理的方式  默认是删除方式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  UITableViewCellEditingStyleDelete ;
}

//修改删除按钮的文字
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
//选择编辑的方式,按照选择的方式对表进行处理
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    GShopCarList *shop = self.shoppingCar[indexPath.section];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除数据
        [shop.mGoodsArr removeObjectAtIndex:indexPath.row];
        
        
        if (!shop.mGoodsArr.count) {   //判断 shoppingCar数组中的shop对象的goods数组 是否为空  为空的话移除shop  不为空的话 移除good
            [self.shoppingCar removeObjectAtIndex:indexPath.section];
        }
        [tableView reloadData];
        
        if (self.state == QHLViewStateEdited) { //在编辑界面下删除cell时  同时删除沙盒中读取到的数组中对应的元素
            //根据indexPath获取到QHLShop对象
            GShopCarList *shops = self.tempArray[indexPath.section];
            
            //移除该对象goods数组中的下标为indexPath.row的元素
            [shops.mGoodsArr removeObject:shops.mGoodsArr[indexPath.row]];
            
            if (!shops.mGoodsArr.count) { //判断沙盒存储的数组中的shop对象的goods数组 是否为空  为空的话移除
                [self.tempArray removeObject:shops];
            }
        }
        
        for (GShopCarGoods *good in shop.mGoodsArr) {
            if (!good.mSelected) {
                shop.mSelected = NO;
                [self setButtonSelectState:NO];
                [tableView reloadData];
                return;
            }
        }
        
        shop.mSelected = YES;
        if (self.state == QHLViewStateEdited) {
            //根据indexPath获取到QHLShop对象
            GShopCarList *shops = self.tempArray[indexPath.section];
            [self handleObjectInArrays:shop documentsObject:shops selectedState:YES];
        }
        [tableView reloadData];
        
        for (GShopCarList *shop in self.shoppingCar) {
            if (!shop.mSelected) {
                [self setButtonSelectState:NO];
                return;
            }
        }
        [self setButtonSelectState:YES];
        [tableView reloadData];
        
    }
    
}
@end
