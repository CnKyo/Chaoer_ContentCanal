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


#import "shopCarViewController.h"
#import "QHLShoppingCarController.h"
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
    

    NSString *url = [NSString stringWithFormat:@"%@%@",[HTTPrequest currentResourceUrl],[mUserInfo backNowUser].mUserImgUrl];
    UIImage *mHead = nil;
    
    if ([mUserInfo backNowUser].mUserImgUrl == nil || [[mUserInfo backNowUser].mUserImgUrl isEqualToString:@""] || [mUserInfo backNowUser].mUserImgUrl.length == 0) {
        mHead = [UIImage imageNamed:@"rbgk"];
    }else{
        mHead = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    }
    
    UIImage *mLastImg = [mHead applyLightEffect];
    
    MLLog(@"头像地址是：%@",url);
    mHeaderView.mBigHeader.image = mLastImg;
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
            
            [self headerEndRefresh];
            [self.tempArray removeAllObjects];
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
    
//    shopCarViewController *shopCar = [[shopCarViewController alloc] initWithNibName:@"shopCarViewController" bundle:nil];
//    [self pushViewController:shopCar];
    
    
    
    QHLShoppingCarController *shopCar = [QHLShoppingCarController new];
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
    
    return self.tempArray.count;
    
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
        
        MGoods *mGoods1 = self.tempArray[indexPath.row*2];
        MGoods *mGoods2;
        if ((indexPath.row+1)*2>self.tempArray.count) {
            cell.mRightView.hidden = YES;
        }else{
            mGoods2 = [self.tempArray objectAtIndex:indexPath.row*2+1];
            cell.mRightView.hidden = NO;
        }
  
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
        
        if (mGoods1.mGoodsHot != nil || mGoods1.mGoodsHot.length != 0) {
            cell.mLeftTagImg.image = [UIImage imageNamed:@"market_hot"];
        }else if (mGoods1.mGoodsCampain != nil || mGoods1.mGoodsCampain.length != 0){
            cell.mLeftTagImg.image = [UIImage imageNamed:@"market_ Promotion"];
        }else{
            cell.mLeftTagImg.hidden = YES;
        }
        
        cell.mLeftCollect.tag = mGoods1.mGoodsId;
        
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
        
        if (mGoods2.mGoodsHot != nil || mGoods2.mGoodsHot.length != 0) {
            cell.mRightTagImg.image = [UIImage imageNamed:@"market_hot"];
        }else if (mGoods2.mGoodsCampain != nil || mGoods2.mGoodsCampain.length != 0){
            cell.mRightTagImg.image = [UIImage imageNamed:@"market_ Promotion"];
        }else{
            cell.mRightTagImg.hidden = YES;
        }
        cell.mRightCollect.tag = mGoods2.mGoodsId;

      
        return cell;

    }else{
        cellId = @"cell";

        mCommunityMyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        GCollectionSHop *mShopN = self.tempArray[indexPath.row];
        
        cell.mLeftTagImg.hidden = cell.mRightTagImg.hidden = YES;

    
        return cell;

    }

    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)WKDidSelectedIndex:(NSInteger)mIndex{
    MLLog(@"点击了%lu",(unsigned long)mIndex);
    
    mType = [[NSString stringWithFormat:@"%ld",(long)mIndex] intValue];
    [self.tableView reloadData];
//    [self.tableView headerBeginRefreshing];
    
}

#pragma mark---- cell的点击代理方法
- (void)cellWithLeftBtnClick:(NSInteger)mTag andId:(int)mShopId{
    
    [self showWithStatus:@"正在操作中..."];
    [[mUserInfo backNowUser] collectGoods:mShopId andGoodsId:[[NSString stringWithFormat:@"%ld",(long)mTag] intValue] andType:mLeftType block:^(mBaseData *resb, NSArray *mArr) {
        [self dismiss];
        if (resb.mSucess) {
            
            for (MGoods *goods in self.tempArray) {
                if ([[NSString stringWithFormat:@"%ld",(long)mTag] intValue] == goods.mGoodsId) {
                    goods.mIsCollect = mLeftType;
                    
                }
            }
            
            [self.tableView reloadData];
            
        }else{
            [self showErrorStatus:resb.mMessage];
        }
        
    }];
    
    
}
- (void)cellWithRightBtnClick:(NSInteger)mTag andId:(int)mShopId{

    [self showWithStatus:@"正在操作中..."];
    [[mUserInfo backNowUser] collectGoods:mShopId andGoodsId:[[NSString stringWithFormat:@"%ld",(long)mTag] intValue] andType:mRightType block:^(mBaseData *resb, NSArray *mArr) {
        [self dismiss];
        if (resb.mSucess) {
            
            for (MGoods *goods in self.tempArray) {
                if ([[NSString stringWithFormat:@"%ld",(long)mTag] intValue] == goods.mGoodsId) {
                    goods.mIsCollect = mRightType;
                    
                }
            }
            
            [self.tableView reloadData];
            
        }else{
            [self showErrorStatus:resb.mMessage];
        }
        
    }];
    
}

@end
