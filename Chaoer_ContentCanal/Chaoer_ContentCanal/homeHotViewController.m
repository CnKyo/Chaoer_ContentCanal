//
//  homeHotViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/25.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "homeHotViewController.h"
#import "communityTableViewCell.h"
#import "mMarketDetailViewController.h"

@interface homeHotViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation homeHotViewController

- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    
    [super viewDidLoad];
    
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.Title = self.mPageName = @"热卖";

    [self initView];
    
}
- (void)initView{
    
    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    
    
    
    self.haveHeader = YES;
    self.haveFooter = YES;
    
    
    UINib   *nib = [UINib nibWithNibName:@"communityCell3" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell3"];
    
    
}
- (void)headerBeganRefresh{

    self.page = 1;
    
    [[mUserInfo backNowUser] getMarketHomeHot:self.page andGoodsId:_mGoodId andLat:_mLat andLng:_mLng block:^(mBaseData *resb, NSArray *mArr) {
    
        [self headerEndRefresh];
        [self removeEmptyView];
        [self.tempArray removeAllObjects];
        
        if (resb.mSucess) {
            if (mArr.count <= 0) {
                [self addEmptyView:nil];
            }else{
                [self.tempArray addObjectsFromArray:mArr];
            }
            [self.tableView reloadData];
        }else{
        
            [self showErrorStatus:resb.mMessage];
            [self addEmptyView:nil];
        }
        
    }];
    
}
- (void)footetBeganRefresh{

    self.page++;
    [[mUserInfo backNowUser] getMarketHomeHot:self.page andGoodsId:_mGoodId andLat:_mLat andLng:_mLng block:^(mBaseData *resb, NSArray *mArr) {
        
        [self footetEndRefresh];
        [self removeEmptyView];
        
        if (resb.mSucess) {
            if (mArr.count <= 0) {
                [self addEmptyView:nil];
            }else{
                [self.tempArray addObjectsFromArray:mArr];
            }
            [self.tableView reloadData];
        }else{
            
            [self showErrorStatus:resb.mMessage];
            [self addEmptyView:nil];
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.5;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
 
    return self.tempArray.count;
    
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    GMarketList *mShopList = self.tempArray[indexPath.row];
    
    if (mShopList.mActivityArr.count <= 0) {
        return 100;
        
    }else if (mShopList.mActivityArr.count == 1){
        return 135;
        
    }else{
        
        NSString *reuseCellId = nil;
        
        
        reuseCellId = @"cell3";
        communityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        
        GMarketList *mShopList = self.tempArray[indexPath.row];
        
        
        [cell setMShopList:mShopList];

        return cell.mCellH;
    }
    
    
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    
    reuseCellId = @"cell3";
    communityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    
    GMarketList *mShopList = self.tempArray[indexPath.row];
    
    
    [cell setMShopList:mShopList];
    
    
    return cell;
  
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GMarketList *mShopList = self.tempArray[indexPath.row];
    
    mMarketDetailViewController *market = [[mMarketDetailViewController alloc] initWithNibName:@"mMarketDetailViewController" bundle:nil];
    market.mShopList = GMarketList.new;
    market.mShopList = mShopList;
    market.mShopId = mShopList.mShopId;
    
    [self pushViewController:market];
    
}

@end
