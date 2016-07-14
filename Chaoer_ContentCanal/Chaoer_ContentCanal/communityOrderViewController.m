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

#import "QHLGoods.h"
#import "QHLShop.h"

#define SMGoodsModelPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"goods.archive"]

typedef NS_ENUM(NSInteger, QHLViewState){
    
    QHLViewStateNormal = 0,
    QHLViewStateEdited
    
};

@interface communityOrderViewController ()<UITableViewDelegate,UITableViewDataSource,WKSegmentControlDelagate,WKHeaderViewDelegate,WKOrderCellDelegate,WKOrderBottomDelegate>


@property (nonatomic, strong) NSMutableArray *shoppingCar;
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

@implementation communityOrderViewController
{
    
    WKSegmentControl    *mSegmentView;
    int mType;
}
- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    
    [super viewDidLoad];
    
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.Title = self.mPageName = @"我的订单";
    
    self.markArr = [NSMutableArray new];
    self.deleteArr = [NSMutableArray new];
    self.selectedRows = [NSMutableArray new];
    
    self.state = QHLViewStateNormal;

    mType = 1;
    [self initView];
    [self initBottomView];
}
- (void)initView{
    
    
    mSegmentView = [WKSegmentControl initWithSegmentControlFrame:CGRectMake(0, 64, DEVICE_Width, 40) andTitleWithBtn:@[@"未付款", @"进行中",@"已完成",@"待评价"] andBackgroudColor:[UIColor whiteColor] andBtnSelectedColor:M_CO andBtnTitleColor:M_TextColor1 andUndeLineColor:M_CO andBtnTitleFont:[UIFont systemFontOfSize:15] andInterval:20 delegate:self andIsHiddenLine:NO andType:1];
    
    [self.view addSubview:mSegmentView];
    
    [self loadTableView:CGRectMake(0, 40, DEVICE_Width, DEVICE_Height-164) delegate:self dataSource:self];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    /*=========================至关重要============================*/
    self.tableView.allowsMultipleSelectionDuringEditing = YES;

    self.haveHeader = YES;
    
    
    UINib   *nib = [UINib nibWithNibName:@"communityOrderTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    

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

- (NSMutableArray *)shoppingCar {
    if (!_shoppingCar) {
        
        _shoppingCar = [QHLShop shop];
    }
    return _shoppingCar;
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
    if (mType == 1) {

        return self.shoppingCar.count;
    }else{
        return 1;
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (mType == 1) {
        QHLShop *shop = self.shoppingCar[section];
        return shop.goods.count;
    }else{
        return 5;
    }
    

    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (mType == 1) {
        //获取模型
        QHLShop *shop = self.shoppingCar[indexPath.section];
        QHLGoods *goods = shop.goods[indexPath.row];
        //创建cell
        WKOrderCell *cell = [WKOrderCell cellWithTableView:tableView];
        cell.goods = goods;
        cell.mImgView.image = [UIImage imageNamed:@"ppt_my_msg"];
        cell.indexPath = indexPath;
        //cell代理
        cell.WKCellDelegate = self;
        return cell;

    }else{
       
        //创建cell
        communityOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        return cell;


    }
   
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    communityOrderDetailViewController *order = [[communityOrderDetailViewController alloc] initWithNibName:@"communityOrderDetailViewController" bundle:nil];
    [self pushViewController:order];
}
#pragma mark----分类按钮点击事件
- (void)WKDidSelectedIndex:(NSInteger)mIndex{
    MLLog(@"点击了%lu",(unsigned long)mIndex);
    
    CGRect mRR = self.tableView.frame;
    
    mType = [[NSString stringWithFormat:@"%ld",(long)mIndex+1] intValue];
    [self.tableView reloadData];
    //    [self.tableView headerBeginRefreshing];
    
    if (mType == 1) {
        self.mBottomView.hidden = NO;
        mRR.size.height = DEVICE_Height-164;
        self.tableView.frame = mRR;
    }else{
        self.mBottomView.hidden = YES;
        mRR.size.height = DEVICE_Height-104;
        self.tableView.frame = mRR;
    }
    
}

#pragma mark - 创建表头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (mType == 1) {
        WKOrderHeadView *headerView = [WKOrderHeadView headerWithTableView:tableView];
        //获取模型
        QHLShop *shop = self.shoppingCar[section];
        headerView.shop = shop;
        headerView.mStoreImg.image = [UIImage imageNamed:@"ppt_my_msg"];
        headerView.section = section;
        //headerView代理
        headerView.WKHeaderViewDelegate = self;
        return headerView;

    }else{
        return nil;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (mType == 1) {
        mShopCarHeaderSection *mFooter = [mShopCarHeaderSection shareFooterView];
        
        return mFooter;
    }else{
        return nil;
    }
    

}
#pragma mark - 设置cell侧滑按钮
#pragma mark -- tableviewDelegate
//是否可以编辑  默认的时YES
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//选择编辑的方式,按照选择的方式对表进行处理
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    QHLShop *shop = self.shoppingCar[indexPath.section];

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除数据
        [shop.goods removeObjectAtIndex:indexPath.row];
        
        
        if (!shop.goods.count) {   //判断 shoppingCar数组中的shop对象的goods数组 是否为空  为空的话移除shop  不为空的话 移除good
            [self.shoppingCar removeObjectAtIndex:indexPath.section];
        }
        [tableView reloadData];
        
        if (self.state == QHLViewStateEdited) { //在编辑界面下删除cell时  同时删除沙盒中读取到的数组中对应的元素
            //根据indexPath获取到QHLShop对象
            QHLShop *shops = self.tempArray[indexPath.section];
            
            //移除该对象goods数组中的下标为indexPath.row的元素
            [shops.goods removeObject:shops.goods[indexPath.row]];
            
            if (!shops.goods.count) { //判断沙盒存储的数组中的shop对象的goods数组 是否为空  为空的话移除
                [self.tempArray removeObject:shops];
            }
        }
        
        for (QHLGoods *good in shop.goods) {
            if (!good.selected) {
                shop.selected = NO;
                [self setButtonSelectState:NO];
                [tableView reloadData];
                return;
            }
        }
        
        shop.selected = YES;
        if (self.state == QHLViewStateEdited) {
            //根据indexPath获取到QHLShop对象
            QHLShop *shops = self.tempArray[indexPath.section];
            [self handleObjectInArrays:shop documentsObject:shops selectedState:YES];
        }
        [tableView reloadData];
        
        for (QHLShop *shop in self.shoppingCar) {
            if (!shop.selected) {
                [self setButtonSelectState:NO];
                return;
            }
        }
        [self setButtonSelectState:YES];
        [tableView reloadData];

    }
    
}

//选择你要对表进行处理的方式  默认是删除方式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  UITableViewCellEditingStyleDelete ;
}

//修改删除按钮的文字
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QHLShop *shop = self.shoppingCar[indexPath.section];
    
    //删除
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //删除数据
        [shop.goods removeObjectAtIndex:indexPath.row];
        
        
        if (!shop.goods.count) {   //判断 shoppingCar数组中的shop对象的goods数组 是否为空  为空的话移除shop  不为空的话 移除good
            [self.shoppingCar removeObjectAtIndex:indexPath.section];
        }
        [tableView reloadData];
        
        if (self.state == QHLViewStateEdited) { //在编辑界面下删除cell时  同时删除沙盒中读取到的数组中对应的元素
            //根据indexPath获取到QHLShop对象
            QHLShop *shops = self.tempArray[indexPath.section];
            
            //移除该对象goods数组中的下标为indexPath.row的元素
            [shops.goods removeObject:shops.goods[indexPath.row]];
            
            if (!shops.goods.count) { //判断沙盒存储的数组中的shop对象的goods数组 是否为空  为空的话移除
                [self.tempArray removeObject:shops];
            }
        }
        
        for (QHLGoods *good in shop.goods) {
            if (!good.selected) {
                shop.selected = NO;
                [self setButtonSelectState:NO];
                [tableView reloadData];
                return;
            }
        }
        
        shop.selected = YES;
        if (self.state == QHLViewStateEdited) {
            //根据indexPath获取到QHLShop对象
            QHLShop *shops = self.tempArray[indexPath.section];
            [self handleObjectInArrays:shop documentsObject:shops selectedState:YES];
        }
        [tableView reloadData];
        
        for (QHLShop *shop in self.shoppingCar) {
            if (!shop.selected) {
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
    if (mType == 1) {
        return 65;
    }else{
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    if (mType == 1) {
        return 50;
    }else{
        
        return 0;
    }
    
}
#pragma mark - 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    if (mType == 1) {
        return 85;
    }else{
        return 150;
    }
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
            for (QHLShop *shop in self.shoppingCar) {
                for (QHLGoods *good in shop.goods) {
                    
                    if (!good.selected) {  //判断cell中的按钮是否选中
                        self.count ++;
                        
                        //计算金额
                        self.money += [good.price integerValue];
                        
                        [self.deleteArr addObject:good.price];
                        
                    }
                }
            }
            
            
        }else {  //全选按钮不选中
            self.hiddenRightBtn = YES;
            for (QHLShop *shop in self.shoppingCar) {
                for (QHLGoods *good in shop.goods) {
                    self.count --;
                    
                    self.money -= [good.price integerValue];
                }
            }
        }
        
        self.mBottomView.mNum = self.count;
        
        //计算金额
        self.mBottomView.mMoney = self.money;
    }
    
    
    //遍历 改变tableView中的所有按钮状态
    for (QHLShop *shop in self.shoppingCar) {
        
        shop.selected = selected;
        for (QHLGoods *good in shop.goods) {
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
    QHLShop *shop = self.shoppingCar[mSection];
    
    //设置表头view的按钮状态
    shop.selected = selected;
    
    if (self.state == QHLViewStateNormal) {
        
        if (selected) {
            for (QHLGoods *good in shop.goods) {
                //判断表头所在的cell组中  cell中的按钮 是否选中,当不选中的情况下 执行下面代码
                if (!good.selected) {
                    self.count ++;
                    //添加金额
                    self.money += [good.price integerValue];
                }
            }
        } else { //这边不用做判断,表头视图中的cell中的按钮 都是选中状态
            for (QHLGoods *good in shop.goods) {
                self.count --;
                //添加金额
                self.money -= [good.price integerValue];
            }
        }
        
        self.mBottomView.mNum = self.count;
        self.mBottomView.mMoney = self.money;
        
    } else {  //edit 状态
        QHLShop *shops = self.tempArray[mSection];
        
        [self handleObjectInArrays:shop documentsObject:shops selectedState:selected];
        
        NSInteger count = shop.goods.count;
        for (int i = 0; i < count; i++) {
            
            [self handleObjectInArrays:shop.goods[i] documentsObject:shops.goods[i] selectedState:selected];
            
        }
    }
    
    //设置表头所在组cell的按钮状态
    for (QHLGoods *good in shop.goods) {
        good.selected = selected;
    }
    [self.tableView reloadData];
    
    
    //设置全选按钮的选中状态
    for (QHLShop *shop in self.shoppingCar) {
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
    QHLShop *shop = self.shoppingCar[indexPath.section];
    QHLGoods *good = shop.goods[indexPath.row];
    
    //设置按钮所在的cell的按钮的选中状态
    good.selected = selected;
    
    if (self.state == QHLViewStateNormal) { //判断当前view的state
        
        if (selected) {
            self.count ++;
            
            //添加金额
            self.money += [good.price integerValue];
            
        }else {
            self.count --;
            
            //减去金额
            self.money -= [good.price integerValue];
        }
        
        self.mBottomView.mNum = self.count;
        self.mBottomView.mMoney = self.money;
        
    } else { //edit 状态
        
        //获取沙盒数组中的模型
        QHLShop *shops = self.tempArray[indexPath.section];
        QHLGoods *goods = shops.goods[indexPath.row];
        
        [self handleObjectInArrays:good documentsObject:goods selectedState:selected];
        
    }
    
    
    
    //设置按钮cell所在的表头视图的按钮状态
    for (QHLGoods *goods in shop.goods) {
        
        if (!goods.selected) {
            
            shop.selected = NO;
            [self.tableView reloadData];
            
            if (self.state == QHLViewStateNormal) {
                
                self.mBottomView.btnSelected = NO; //全选按钮设置为未选中状态
                
            } else {
                
                //获取沙盒数组中的模型
                QHLShop *shops = self.tempArray[indexPath.section];
                
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
        QHLShop *shops = self.tempArray[indexPath.section];
        
        [self.btnsArray addObject:shop];
        [self.documentArray addObject:shops];
    }
    
    [self.tableView reloadData];
    
    //根据表透视图的按钮状态设置全选按钮的状态
    for (QHLShop *shop in self.shoppingCar) {
        if (!shop.selected) {
            
            [self setButtonSelectState:NO];
            
            return;
        }
    }
    
    [self setButtonSelectState:YES];

}
@end
