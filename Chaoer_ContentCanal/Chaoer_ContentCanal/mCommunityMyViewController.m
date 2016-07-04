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
@interface mCommunityMyViewController ()<UITableViewDelegate,UITableViewDataSource,WKSegmentControlDelagate>

@end

@implementation mCommunityMyViewController
{

    mCommunityHeaderView *mHeaderView;
    WKSegmentControl    *mSegmentView;
    int mType;

}

- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    
    [super viewDidLoad];
    
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.Title = self.mPageName = @"我的";
    mType = 1;
    [self initView];


}
- (void)initView{
    
    
    
    [self loadTableView:CGRectMake(0, 0, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    
    
    
    self.haveHeader = YES;
    
    
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
#pragma mark----购物车
- (void)mShopCar:(UIButton *)sender{
    shopCarViewController *shopCar = [[shopCarViewController alloc] initWithNibName:@"shopCarViewController" bundle:nil];
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
    
    return 5;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (mType == 1) {
        
        return 200;
    }else{
        return 80;
        
    }
    
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellId = nil;
    
    if (mType == 1) {
        cellId = @"cell2";
    }else{

        cellId = @"cell";

    }
    
    mCommunityMyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.mLeftTagImg.hidden = cell.mRightTagImg.hidden = YES;
    
    return cell;
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)WKDidSelectedIndex:(NSInteger)mIndex{
    MLLog(@"点击了%lu",(unsigned long)mIndex);
    
    mType = [[NSString stringWithFormat:@"%ld",(long)mIndex+1] intValue];
    [self.tableView reloadData];
//    [self.tableView headerBeginRefreshing];
    
}
@end
