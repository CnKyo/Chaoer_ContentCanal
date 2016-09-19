//
//  mCommunityMyViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/24.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mCommunityMyViewController.h"
#import "mCommunityHeaderView.h"

#import "mCommunityMyViewCell.h"
#import "UIImage+ImageEffects.h"

#import "communityOrderViewController.h"
#import "mCoupViewController.h"
#import "mMarketDetailViewController.h"
#import "ShoppingCarViewController.h"

#import "mGoodsDetailViewController.h"
#import "DryCleanVC.h"

@interface mCommunityMyViewController ()<UITableViewDelegate,UITableViewDataSource,WKSegmentControlDelagate,WKGoodsCellDelegate>

@end

@implementation mCommunityMyViewController
{

    mCommunityHeaderView *mHeaderView;
    WKSegmentControl    *mSegmentView;
    int mType;
    
    int mLeftType;
    int mRightType;

}
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    [self headerBeganRefresh];
}
- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    
    [super viewDidLoad];
    
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.Title = self.mPageName = @"我的";
    mType = 0;
    mLeftType  = mRightType = 0;

    [self initView];


}
- (void)initView{
    
    
    
    [self loadTableView:CGRectMake(0, 0, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    
    
    
    self.haveHeader = YES;
    self.haveFooter = YES;
    
    
    UINib   *nib = [UINib nibWithNibName:@"mCommunityMyViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    
    nib = [UINib nibWithNibName:@"mCommunityCollectCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];

    
    mHeaderView = [mCommunityHeaderView shareView];
    mHeaderView.frame = CGRectMake(0, 0, DEVICE_Width, 130);
    
    mHeaderView.mName.text = [mUserInfo backNowUser].mNickName;
    NSString *url = [NSString stringWithFormat:@"%@%@",[HTTPrequest currentResourceUrl],[mUserInfo backNowUser].mUserImgUrl];
    
    MLLog(@"头像地址是：%@",url);
    mHeaderView.mBigHeader.image = [UIImage imageNamed:@"mHeader_bgk.jpg"];
    [mHeaderView.mSmallHeader sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"icon_headerdefault"]];

    
    [mHeaderView.mShopCar addTarget:self action:@selector(mShopCar:) forControlEvents:UIControlEventTouchUpInside];
    [mHeaderView.mOrder addTarget:self action:@selector(mOrder:) forControlEvents:UIControlEventTouchUpInside];
    [mHeaderView.mCoup addTarget:self action:@selector(mCoup:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView setTableHeaderView:mHeaderView];
    
    mSegmentView = [WKSegmentControl initWithSegmentControlFrame:CGRectMake(0, 165, DEVICE_Width, 40) andTitleWithBtn:@[@"收藏的商品", @"收藏的店铺"] andBackgroudColor:[UIColor whiteColor] andBtnSelectedColor:M_CO andBtnTitleColor:M_TextColor1 andUndeLineColor:M_CO andBtnTitleFont:[UIFont systemFontOfSize:15] andInterval:20 delegate:self andIsHiddenLine:NO andType:1];
}
- (void)headerBeganRefresh{
    
    self.page = 1;
    
    if (mType == 0) {
        
        [[mUserInfo backNowUser] getMyCollectGoods:self.page block:^(mBaseData *resb, NSArray *mArr) {
            
            [self headerEndRefresh];
            [self.tempArray removeAllObjects];
            [self removeEmptyView];
            if (resb.mSucess) {
             
                [self.tempArray addObjectsFromArray:mArr];
                
                [self.tableView reloadData];

            }else{
                
                [self  showErrorStatus:resb.mMessage];
                [self addEmptyView:nil];
            }

        }];
        
    }else{
        [[mUserInfo backNowUser] getMyStoreCollection:self.page block:^(mBaseData *resb, NSArray *mArr) {
            
            [self headerEndRefresh];
            [self.tempArray removeAllObjects];
            [self removeEmptyView];
            if (resb.mSucess) {
                
                [self.tempArray addObjectsFromArray:mArr];
                [self.tableView reloadData];
                
            }else{
                
                [self  showErrorStatus:resb.mMessage];
                [self addEmptyView:nil];
            }
            
        }];

    }
    
  
}
- (void)footetBeganRefresh{
    self.page ++;
    
    if (mType == 0) {
        [[mUserInfo backNowUser] getMyCollectGoods:self.page block:^(mBaseData *resb, NSArray *mArr) {
            
            [self footetEndRefresh];
            [self removeEmptyView];

            if (resb.mSucess) {
                if (mArr.count <= 0) {
                    [self addEmptyView:nil];
                    return ;
                }else{
                    [self.tempArray addObjectsFromArray:mArr];
                    [self.tableView reloadData];
                }
            }else{
                
                [self  showErrorStatus:resb.mMessage];
                [self addEmptyView:nil];
            }
            
        }];

    }else{
        [[mUserInfo backNowUser] getMyStoreCollection:self.page block:^(mBaseData *resb, NSArray *mArr) {
            
            [self footetEndRefresh];
            [self removeEmptyView];
            if (resb.mSucess) {
                if (mArr.count <= 0) {
                    [self addEmptyView:nil];
                    return ;
                }else{
                    [self.tempArray addObjectsFromArray:mArr];
                    [self.tableView reloadData];
                }
            }else{
                
                [self  showErrorStatus:resb.mMessage];
                [self addEmptyView:nil];
            }
            
        }];

    }
    
}
#pragma mark----购物车
- (void)mShopCar:(UIButton *)sender{

    
    ShoppingCarViewController *shopCar = [ShoppingCarViewController new];
    shopCar.mType = 2;
    [self pushViewController:shopCar];
}
#pragma mark----订单
- (void)mOrder:(UIButton *)sender{
    communityOrderViewController *order = [communityOrderViewController new];
    [self pushViewController:order];
}
#pragma mark----优惠卷
- (void)mCoup:(UIButton *)sender{
 
    mCoupViewController *coup = [mCoupViewController new];
    coup.mSType = 1;
    [self pushViewController:coup];
    
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
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    return mSegmentView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (mType == 0) {

        return self.tempArray.count%2==0?self.tempArray.count/2:self.tempArray.count/2+1;
    }else{
        return self.tempArray.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (mType == 0) {
        
        return 200;
    }else{
        return 80;
        
    }
    
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellId = nil;
    
    if (mType == 0) {
        cellId = @"cell2";
        mCommunityMyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.delegate = self;
        
        GCollectGoods *mGoods1 = self.tempArray[indexPath.row*2];
        GCollectGoods *mGoods2;
        if ((indexPath.row+1)*2>self.tempArray.count) {
            cell.mRightView.hidden = YES;
        }else{
            mGoods2 = [self.tempArray objectAtIndex:indexPath.row*2+1];
            cell.mRightView.hidden = NO;
        }
        cell.mLeftDetailBtn.tag = mGoods1.mGoodsId;
        cell.mLeftName.text = mGoods1.mGoodsName;
        cell.mLeftContent.text = mGoods1.mGoodsDetail;
        cell.mLeftNum.text = [NSString stringWithFormat:@"月销：%d",mGoods1.mSalesNum];
        cell.mLeftPrice.text = [NSString stringWithFormat:@"¥%.2f",mGoods1.mGoodsPrice];
        [cell.mLeftImg sd_setImageWithURL:[NSURL URLWithString:mGoods1.mGoodsImg] placeholderImage:[UIImage imageNamed:@"DefaultImg"]];
        if (mGoods1.mIsCollect == 0) {
            [cell.mLeftCollect setBackgroundImage:[UIImage imageNamed:@"collection_empty"] forState:0];
            mLeftType = 1;
        }else{
            [cell.mLeftCollect setBackgroundImage:[UIImage imageNamed:@"collection_real"] forState:0];
            mLeftType = 0;
        }
        
        if ([mGoods1.mCampain isEqualToString:@"促销"]) {
            cell.mLeftTagImg.image = [UIImage imageNamed:@"market_ Promotion"];
            
        }else if ([mGoods1.mGoodsHot isEqualToString:@"热卖"]){
            cell.mLeftTagImg.image = [UIImage imageNamed:@"market_hot"];
            
        }else{
            cell.mLeftTagImg.hidden = YES;
        }        /**
         *  设置收藏与添加购物车与详情
         */
        cell.mLeftCollect.tag = mGoods1.mGoodsId;
        
        cell.mLeftAdd.tag = mGoods1.mGoodsId;
        cell.mLeftShopId = mGoods1.mShopId;
        /**
         *  设置收藏与添加购物车与详情
         */
        cell.mRightDetailBtn.tag = mGoods2.mGoodsId;

        cell.mRightName.text = mGoods2.mGoodsName;
        cell.mRightContent.text = mGoods2.mGoodsDetail;
        cell.mRightNum.text = [NSString stringWithFormat:@"月销：%d",mGoods2.mSalesNum];
        cell.mRightPrice.text = [NSString stringWithFormat:@"¥%.2f",mGoods2.mGoodsPrice];
        [cell.mRightImg sd_setImageWithURL:[NSURL URLWithString:mGoods2.mGoodsImg] placeholderImage:[UIImage imageNamed:@"DefaultImg"]];
        
    
        if (mGoods2.mIsCollect == 0) {
            [cell.mRightCollect setBackgroundImage:[UIImage imageNamed:@"collection_empty"] forState:0];
            mRightType = 1;
        }else{
            [cell.mRightCollect setBackgroundImage:[UIImage imageNamed:@"collection_real"] forState:0];
            mRightType = 0;
        }
        if ([mGoods2.mCampain isEqualToString:@"促销"]) {
            cell.mRightTagImg.image = [UIImage imageNamed:@"market_ Promotion"];
            
            
        }else if ([mGoods2.mGoodsHot isEqualToString:@"热卖"]){
            cell.mRightTagImg.image = [UIImage imageNamed:@"market_hot"];
        }else{
            cell.mRightTagImg.hidden = YES;
        }
        /**
         *  设置收藏与添加购物车与详情
         */
        cell.mRightCollect.tag = mGoods2.mGoodsId;

        cell.mRightAdd.tag = mGoods2.mGoodsId;
        cell.mRightShopId = mGoods2.mShopId;
        /**
         *  设置收藏与添加购物车与详情
         */
        return cell;

    }else{
        NSDictionary *mStyle = @{@"color":[UIColor colorWithRed:0.91 green:0.13 blue:0.13 alpha:0.75]};

        cellId = @"cell";

        mCommunityMyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        
        GMarketList *mShopN = self.tempArray[indexPath.row];
        cell.mIndexPaths = indexPath;
        cell.mName.text = mShopN.mShopName;
        
        cell.delegate = self;
        
        
        cell.mCollectNum.attributedText = [[NSString stringWithFormat:@"营业时间：<color>%@-%@</color>",mShopN.mOpenTime,mShopN.mCloseTime] attributedStringWithStyleBook:mStyle];
        [cell.mImg sd_setImageWithURL:[NSURL URLWithString:mShopN.mShopLogo] placeholderImage:[UIImage imageNamed:@"img_default"]];
        cell.mCollectBtn.mShop = mShopN;
        
//        if (!mShopN.mIsFocus) {
        
            [cell.mCollectBtn setBackgroundImage:[UIImage imageNamed:@"my_ collect"] forState:0];
//        }else{
//            [cell.mCollectBtn setBackgroundImage:[UIImage imageNamed:@"my_ uncollect"] forState:0];
//        }
    
        return cell;

    }

    
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (mType == 1) {
    
        GMarketList *mShopN = self.tempArray[indexPath.row];
        
        if (mShopN.mType == 3) {
            DryCleanVC *vvv= [DryCleanVC new];
            vvv.shopId = mShopN.mShopId;
            [self pushViewController:vvv];
            
        } else {
            mMarketDetailViewController *market = [[mMarketDetailViewController alloc] initWithNibName:@"mMarketDetailViewController" bundle:nil];
            market.mShopList = GMarketList.new;
            market.mShopList = mShopN;
            market.mShopId = mShopN.mShopId;
            
            [self pushViewController:market];
        }
    }
    
}

- (void)WKDidSelectedIndex:(NSInteger)mIndex{
    MLLog(@"点击了%lu",(unsigned long)mIndex);
    
    mType = [[NSString stringWithFormat:@"%ld",(long)mIndex] intValue];
    [self headerBeganRefresh];
}

#pragma mark---- cell的点击代理方法
- (void)cellWithLeftBtnClick:(NSInteger)mTag andId:(int)mShopId{
    
    [self showWithStatus:@"正在操作中..."];
    [[mUserInfo backNowUser] collectGoods:mShopId andGoodsId:[[NSString stringWithFormat:@"%ld",(long)mTag] intValue] andType:mLeftType block:^(mBaseData *resb, NSArray *mArr) {
        
        if (resb.mSucess) {
            [self dismiss];
            for (GCollectGoods *goods in self.tempArray) {
                if ([[NSString stringWithFormat:@"%ld",(long)mTag] intValue] == goods.mGoodsId) {
                    goods.mIsCollect = mLeftType;
                    
                 
       

                }
            }
            
            [self headerBeganRefresh];
        }else{
            [self showErrorStatus:resb.mMessage];
        }
        
    }];
    
    
}
- (void)cellWithRightBtnClick:(NSInteger)mTag andId:(int)mShopId{

    [self showWithStatus:@"正在操作中..."];
    [[mUserInfo backNowUser] collectGoods:mShopId andGoodsId:[[NSString stringWithFormat:@"%ld",(long)mTag] intValue] andType:mRightType block:^(mBaseData *resb, NSArray *mArr) {
        
        if (resb.mSucess) {
            [self dismiss];
            for (GCollectGoods *goods in self.tempArray) {
                if ([[NSString stringWithFormat:@"%ld",(long)mTag] intValue] == goods.mGoodsId) {
                    goods.mIsCollect = mRightType;
                  
                }
            }
            
            [self headerBeganRefresh];
        }else{
            [self showErrorStatus:resb.mMessage];
        }
        
    }];
    
}
- (void)cellWithFocusShopClick:(NSIndexPath *)mIndexPath andShop:(GMarketList *)mShop{

    NSMutableArray *mARR = [NSMutableArray new];
    [mARR removeAllObjects];
    [mARR addObjectsFromArray:self.tempArray];
    
//    int type = mShop.mIsFocus?0:1;
    
    [self showWithStatus:@"正在操作中..."];
    [[mUserInfo backNowUser] collectShop:mShop.mShopId andType:0 block:^(mBaseData *resb) {
        
        if (resb.mSucess) {
            [self dismiss];
            [self.tempArray removeAllObjects];
//            for (GCollectionSHop *ms in self.tempArray) {
//                if (mShop.mShopId == ms.mShopId) {
//                    
//                    ms.mIsFocus = type;
//       
//                    [self.tableView reloadData];
//                }
//            }
            
            [mARR removeObjectAtIndex:mIndexPath.row];
            [self.tempArray addObjectsFromArray:mARR];
            [self.tableView deleteRowsAtIndexPaths:@[mIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView reloadData];


            
        }else{
            
            [self showErrorStatus:resb.mMessage];
        }
    }];
    
   
    
}



#pragma mark----设置cell收藏与添加购物车与详情

- (void)collectLeftAddshopCar:(NSInteger)mgoodsId andShopId:(int)mShopId{
    [self showWithStatus:@""];
    
    [[mUserInfo backNowUser] addGoodsToShopCar:mShopId andGoodsId:[[NSString stringWithFormat:@"%ld",(long)mgoodsId] intValue] andNum:1 block:^(mBaseData *resb) {
        if (resb.mSucess) {
            [self showSuccessStatus:resb.mMessage];
        }else{
            [self showErrorStatus:resb.mMessage];
        }
    }];

}
- (void)collectRightAddshopCar:(NSInteger)mgoodsId andShopId:(int)mShopId{
    [self showWithStatus:@""];
    
    [[mUserInfo backNowUser] addGoodsToShopCar:mShopId andGoodsId:[[NSString stringWithFormat:@"%ld",(long)mgoodsId] intValue] andNum:1 block:^(mBaseData *resb) {
        if (resb.mSucess) {
            [self showSuccessStatus:resb.mMessage];
        }else{
            [self showErrorStatus:resb.mMessage];
        }
    }];

}

- (void)collectLeftDetail:(NSInteger)mgoodsId andShopId:(int)mShopId{
    mGoodsDetailViewController *goods = [[mGoodsDetailViewController alloc] initWithNibName:@"mGoodsDetailViewController" bundle:nil];
    goods.mSGoods = [MGoods new];
    goods.mSGoods.mGoodsId = [[NSString stringWithFormat:@"%ld",(long)mgoodsId] intValue] ;
    goods.mShopId = mShopId;
    [self pushViewController:goods];

}
- (void)collectRightDetail:(NSInteger)mgoodsId andShopId:(int)mShopId{
    mGoodsDetailViewController *goods = [[mGoodsDetailViewController alloc] initWithNibName:@"mGoodsDetailViewController" bundle:nil];
    goods.mSGoods = [MGoods new];
    goods.mSGoods.mGoodsId = [[NSString stringWithFormat:@"%ld",(long)mgoodsId] intValue] ;
    goods.mShopId = mShopId;
    [self pushViewController:goods];
    
}
@end
