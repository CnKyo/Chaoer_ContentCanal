//
//  ShoppingCarViewController.m
//  ZDCar
//
//  Created by yangxuran on 16/7/22.
//  Copyright © 2016年 boc. All rights reserved.
//

#import "ShoppingCarViewController.h"
#import "ShopCarTableViewCell.h"
#import "CustomHeaderView.h"
#import "BottomView.h"
#import "ShopCarModel.h"
#import "ShopModel.h"
#import "ZLShopCarNav.h"

#import "shopCarHeaderAndFooterView.h"
#import "comFirmOrderViewController.h"
#import "mCommunityMyViewController.h"

#define kWidth self.view.frame.size.width
#define kHeight self.view.frame.size.height

@interface ShoppingCarViewController ()<UITableViewDelegate,UITableViewDataSource,ShopCarTableViewCellDelegate, CustomHeaderViewDelegate, BottomViewDelegate, UIAlertViewDelegate>
/**
 *  tableview
 */
@property (nonatomic, strong)UITableView * mTableView;
/**
 *  数据源
 */
@property (nonatomic, strong)NSMutableArray * mDataArr;
/**
 *  底部view
 */
@property (nonatomic, strong)BottomView * mBottomView;
@property (nonatomic, strong)BottomModel * bottomModel;
/**
 *  选择的数组
 */
@property (nonatomic, strong)NSMutableArray * mTotalSelectedAry;
/**
 *  右边的按钮
 */
@property (nonatomic, strong)UIButton * mRightTopBtn;
@property (nonatomic, assign)BOOL isEditing;
//测试
@property (nonatomic, copy)NSMutableString * testString;
@end

static NSString * indentifier = @"shopCarCell";
@implementation ShoppingCarViewController
{
    ZLShopCarNav *mNav;
    
    shopCarHeaderAndFooterView *mEmptyView;
    
    NSMutableArray *mJsonArr;


}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"购物车";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mTableView];
    mJsonArr = [NSMutableArray new];

    BottomView * bottomView = [[BottomView alloc] initWithFrame:CGRectMake(0, kHeight - 50, kWidth, 50)];
    bottomView.delegate = self;
    self.mBottomView = bottomView;
    [self.view addSubview:self.mBottomView];
    self.bottomModel = [[BottomModel alloc] init];
    
    [self loadNav];
    [self initData];
    [self initEmptyView];
}
#pragma mark----加载导航条
- (void)loadNav{

    mNav = [ZLShopCarNav shareView];
    mNav.frame = CGRectMake(0, 0, DEVICE_Width, 64);
    self.mRightTopBtn = mNav.mEditBrn;

    [mNav.mBackBrn addTarget:self action:@selector(mBackAction:) forControlEvents:UIControlEventTouchUpInside];
    [mNav.mEditBrn addTarget:self action:@selector(editBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mNav];
}
#pragma mark----加载数据
- (void)initData{
    self.mDataArr = [NSMutableArray array];
    
    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeClear];
    [[mUserInfo backNowUser] getMyShopCarList:^(mBaseData *resb, NSArray *mArr) {
        [self.mDataArr removeAllObjects];
        if (resb.mSucess) {
            [SVProgressHUD dismiss];
            if (mArr.count <= 0) {
                [self showEmptyView];
                
            }else{
                [self.mDataArr addObjectsFromArray:mArr];
                [self dissmissEmptyView];
                
            }
            [self.mTableView reloadData];
        }else{
            [self showEmptyView];
        }
    }];

    
    
}

#pragma mark----懒加载tableview
-(UITableView *)mTableView{
    if (_mTableView == nil) {
        _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 114) style:UITableViewStyleGrouped];
        _mTableView.dataSource = self;
        _mTableView.delegate = self;
        _mTableView.rowHeight = 100;
        [_mTableView registerNib:[UINib nibWithNibName:@"ShopCarTableViewCell" bundle:nil] forCellReuseIdentifier:indentifier];
    }
    return _mTableView;
}


#pragma mark -- <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.mDataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    GShopCarList *shop = self.mDataArr[section];
    return shop.mGoodsArr.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    GShopCarList *shop = self.mDataArr[section];

    
    CustomHeaderView * view = [[CustomHeaderView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 40)];
    view.tag = section + 2000;
    view.delegate = self;

    [view setModel:shop];
    return view;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    GShopCarList *model = self.mDataArr[indexPath.section];
    GShopCarGoods *good = model.mGoodsArr[indexPath.row];
    if (model.mGoodsArr.count != 1) {
        
        for (GShopCarList *mShop in self.mDataArr) {
            for (GShopCarGoods *mGoods in mShop.mGoodsArr) {
                if (mGoods.mGoodsId == good.mGoodsId) {
                    [SVProgressHUD showWithStatus:@"正在操作..."];
                    [[mUserInfo backNowUser] deleteShopCarGoods:[NSString stringWithFormat:@"%d",good.mId] block:^(mBaseData *resb) {
                        if (resb.mSucess) {
                            [SVProgressHUD dismiss];
                            
                            [model.mGoodsArr removeObject:good];
                            [self.mTableView reloadData];
                        }else{
                            [SVProgressHUD showErrorWithStatus:resb.mMessage];
                        }
                    }];

                }
            }
   
            
        }
        
        

    }else{
        
        for (GShopCarList *mShop in self.mDataArr) {
            for (GShopCarGoods *mGoods in mShop.mGoodsArr) {
                if (mGoods.mGoodsId == good.mGoodsId) {
                    [SVProgressHUD showWithStatus:@"正在操作..."];
                    [[mUserInfo backNowUser] deleteShopCarGoods:[NSString stringWithFormat:@"%d",good.mId] block:^(mBaseData *resb) {
                        if (resb.mSucess) {
                            [SVProgressHUD dismiss];
                            
                            [self.mDataArr removeObjectAtIndex:indexPath.section];
                            [self.mTableView reloadData];
                            [self initData];

                        }else{
                            [SVProgressHUD showErrorWithStatus:resb.mMessage];
                        }
                    }];
                    
                }
            }
        
            
        }

        
    }
    [self GetTotalBill];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //获取模型
    GShopCarList *shop = self.mDataArr[indexPath.section];
    GShopCarGoods *goods = shop.mGoodsArr[indexPath.row];
    
    ShopCarTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:indentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    [cell setModel:goods];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"点击进入商品详情页面");

}



#pragma mark --- cell代理方法(cell 左侧按钮)
- (void)clickedWichLeftBtn:(UITableViewCell *)cell{
    NSIndexPath * indexpath = [self.mTableView indexPathForCell:cell];
    GShopCarList * shopCarModel = self.mDataArr[indexpath.section];//当前选中的商品对应的店铺的模型
    GShopCarGoods * model = shopCarModel.mGoodsArr[indexpath.row];
    model.mSelected = !model.mSelected;
    NSInteger totalCount = 0;
    for (int i = 0; i < shopCarModel.mGoodsArr.count; i++) {
        GShopCarGoods * shopModel = shopCarModel.mGoodsArr[i];
        if (shopModel.mSelected) {
            totalCount++;
        }
    }
    GShopCarList * sectionModel = self.mDataArr[indexpath.section];
    sectionModel.mSelected = (totalCount == shopCarModel.mGoodsArr.count);
    
    [self checkShopState];
}

#pragma mark----修改数量
- (void)changeTheShopCount:(UITableViewCell *)cell count:(NSInteger )count{
    NSIndexPath * indexpath = [self.mTableView indexPathForCell:cell];
    NSLog(@"%zd-----%zd", indexpath.section, indexpath.row);
    GShopCarList * shopCarModel = self.mDataArr[indexpath.section];//当前选中的商品对应的店铺的模型
    GShopCarGoods * model = shopCarModel.mGoodsArr[indexpath.row];
    model.mQuantity = (int)count;
    //    [self checkShopState];错误
    [self GetTotalBill];
}

#pragma mark --- CustomHeaderViewDelegate顶部sectionview代理方法
- (void)clickedWhichHeaderView:(NSInteger)index{
    NSInteger sectionIndex = index - 2000;
    GShopCarList * model = self.mDataArr[sectionIndex];
    model.mSelected = !model.mSelected;
    NSMutableArray * tempAry = [self.mDataArr[sectionIndex] mGoodsArr];
    for (int i = 0; i < tempAry.count; i++) {
        GShopCarGoods * shopModel = tempAry[i];
        shopModel.mSelected = model.mSelected;
    }
    [self checkShopState];
}

#pragma mark --  BottomViewDelegate地步view代理方法
-  (void)clickedBottomSelecteAll{//全选方法
    
    self.bottomModel.isSelecteAll = !self.bottomModel.isSelecteAll;
    for (int i = 0; i < self.mDataArr.count; i++) {
        GShopCarList * model = self.mDataArr[i];
        model.mSelected = self.bottomModel.isSelecteAll;
        for (int j = 0; j < model.mGoodsArr.count; j++) {
            GShopCarGoods *shopModel = model.mGoodsArr[j];
            shopModel.mSelected = self.bottomModel.isSelecteAll;
        }
    }
    self.mBottomView.model = self.bottomModel;
    [self GetTotalBill];//求和
    [self.mTableView reloadData];
}
#pragma mark --  BottomViewDelegate底部view代理方法（去结算/删除)
- (void)clickedBottomJieSuan{
    
    [mJsonArr removeAllObjects];
    
    if (self.bottomModel.isEdit) {
        if (self.bottomModel.totalCount == 0) {

            [SVProgressHUD showErrorWithStatus:@"请选择要删除的商品!"];
        }else{
            MLLog(@"要删除的数据模型是%@", _mTotalSelectedAry);
            [self warnMessage:[NSString stringWithFormat:@"确定要删除吗！"]];
        }
    }else{
        if (self.bottomModel.totalCount == 0) {

            [SVProgressHUD showErrorWithStatus:@"请选择要结算的商品!"];

        }else{
            MLLog(@"要传给下一个订单详情页面的数据模型是%@", _mTotalSelectedAry);
            
            if (_mTotalSelectedAry.count <= 0) {
                [SVProgressHUD showErrorWithStatus:@"您还未选择商品！"];
                return;
            }
            
            for (GShopCarGoods *mGoods in self.mTotalSelectedAry) {
                
                [mJsonArr addObject:@{@"quantity":NumberWithInt(mGoods.mQuantity),@"shoppingCartId":NumberWithInt(mGoods.mId)}];

                
            }
            
            [SVProgressHUD showWithStatus:@"正在结算..."];
            [[mUserInfo backNowUser] shopcarGoPay:mJsonArr block:^(mBaseData *resb,GPayShopCar *mShopCarList) {
                if (resb.mSucess) {
                    [SVProgressHUD dismiss];
                    
                    comFirmOrderViewController *comfir = [[comFirmOrderViewController alloc] initWithNibName:@"comFirmOrderViewController" bundle:nil];
                    comfir.mShopCarList = nil;
                    comfir.mShopCarList = [GPayShopCar new];
                    
                    comfir.mShopCarList = mShopCarList;
                    [self.navigationController pushViewController:comfir animated:YES];
                }else{
                    [SVProgressHUD showErrorWithStatus:resb.mMessage];
                }
                
            }];

            
        }
    }
}

#pragma mark -- 公共方法
//选中商品或者选中店铺都会走这个公共方法。在这里判断选中的店铺数量还不是和数据源数组数量相等。一样的话就全选，否则相反。
- (void)checkShopState{
    NSInteger totalSelected = 0;
    for (int i = 0; i < self.mDataArr.count; i++) {
        GShopCarList * model = self.mDataArr[i];
        if (model.mSelected) {
            totalSelected++;
        }
    }
    if (totalSelected == self.mDataArr.count) {
        self.bottomModel.isSelecteAll = YES;
    }else{
        self.bottomModel.isSelecteAll = NO;
    }
    self.mBottomView.model = self.bottomModel;
    
    [self GetTotalBill];//求和
    [self.mTableView reloadData];
    
}
#pragma mark --  BottomViewDelegate地步view代理方法//求得总共费用
- (void)GetTotalBill{
    self.mTotalSelectedAry  = [NSMutableArray array];
    float totalMoney = 0.00;
    NSMutableString * compentStr = [[NSMutableString alloc] init];
    for (int i = 0; i < self.mDataArr.count; i++) {
        GShopCarList * model = self.mDataArr[i];
        
        if (model.mIsCanOrder) {
            for (int j = 0; j < model.mGoodsArr.count; j++) {
                GShopCarGoods *shopModel = model.mGoodsArr[j];
                if (shopModel.mSelected) {
                    
                    //保存model。如果是结算，传递选中商品，确认订单页面展示。如果是删除，根据此数组，拿到商品ID，用来删除。
                    [_mTotalSelectedAry addObject:shopModel];
                    [compentStr appendString:shopModel.mGoodsName];
                    totalMoney += shopModel.mGoodsPrice * shopModel.mQuantity;
                }
            }

        }else{
            [SVProgressHUD showErrorWithStatus:@"商家休息中，暂无法下单!"];

        }
        
        
    }
    if (self.mDataArr.count == 0) {
        self.bottomModel.isSelecteAll = NO;
        self.bottomModel.isEdit = NO;
        [self.mRightTopBtn setTitle:@"编辑"forState:UIControlStateNormal];
        self.mBottomView.model = self.bottomModel;
        self.mBottomView.hidden = YES;
        [self showEmptyView];
    }else{
        self.mBottomView.hidden = NO;
        [self dissmissEmptyView];
    }
    self.testString = compentStr;//保存，测试用。
    self.bottomModel.totalMoney = totalMoney;
    self.bottomModel.totalCount = _mTotalSelectedAry.count;
    self.mBottomView.model = self.bottomModel;
}

- (void)warnMessage:(NSString *)string{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:string delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        //删除事件。多个删除直接重新请求数据！
        NSString *mTagIds = @"";
        
        for ( GShopCarList *shop in self.mDataArr) {
            if (shop.mSelected) {
                for (int i =0;i < shop.mGoodsArr.count;i++) {
                    GShopCarGoods *good = shop.mGoodsArr[i];
                    if (good.mSelected) {
                        
                        
                        mTagIds = [mTagIds stringByAppendingString:[NSString stringWithFormat:@"%d,",good.mId]];
                        
                        
                    }
                }
            }
            
        }
        if (mTagIds.length != 0) {
            [SVProgressHUD showWithStatus:@"正在操作..."];
            [[mUserInfo backNowUser] deleteShopCarGoods:mTagIds block:^(mBaseData *resb) {
                if (resb.mSucess) {
                    [SVProgressHUD dismiss];
                    [self.mDataArr removeAllObjects];
                    [self.mTableView reloadData];
                    [self initData];
                }else{
                    [SVProgressHUD showErrorWithStatus:resb.mMessage];
                }
            }];
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"没有选择任何商品！"];
        }

    }
}



#pragma mark --- NavgationItemBtnClicked
- (void)editBtnClicked{
    self.isEditing = !self.isEditing;
    [self.mRightTopBtn setTitle:self.isEditing ? @"完成" : @"编辑" forState:UIControlStateNormal];
    self.bottomModel.isEdit = self.isEditing;
    self.mBottomView.model = self.bottomModel;
}

- (void)mBackAction:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    if (self.block) {
        self.block(YES);
    }

}
#pragma mark - 加载空视图
- (void)initEmptyView{
    
    mEmptyView = [shopCarHeaderAndFooterView shareHeaderView];
    mEmptyView.alpha = 0;
    [mEmptyView.mGoShopBtn addTarget:self action:@selector(GoShopAction:) forControlEvents:UIControlEventTouchUpInside];
    [mEmptyView.mMyBtn addTarget:self action:@selector(GoMyCollectionAction:) forControlEvents:UIControlEventTouchUpInside];
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
#pragma mark----去逛逛
- (void)GoShopAction:(UIButton *)sender{
    if (_mType == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
        NSMutableArray* vcs = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
        if( vcs.count > 2 )
        {
            [vcs removeLastObject];
            [vcs removeLastObject];
            [self.navigationController setViewControllers:vcs   animated:YES];
        }
    }
    
}
#pragma mark----我的收藏
- (void)GoMyCollectionAction:(UIButton *)sender{
    if (_mType == 1) {
        mCommunityMyViewController *my = [mCommunityMyViewController new];
        [self.navigationController pushViewController:my animated:YES];
        
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
