//
//  communityViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/12.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "communityViewController.h"
#import "CurentLocation.h"

#import "communityTableViewCell.h"
#import "mCommunityNavView.h"

#import "mCommunityMyViewController.h"

#import "mMarketDetailViewController.h"

#import "mNavAddressViewController.h"
#import "homeHotViewController.h"
@interface communityViewController ()<UITableViewDelegate,UITableViewDataSource,AMapLocationManagerDelegate,WKBanerSelectedDelegate,MMApBlockCoordinate>
@property (nonatomic,strong)    NSMutableArray  *mBanerArr;

@property (nonatomic,strong)    NSMutableArray  *mSubArr;
@property (nonatomic,strong)    NSMutableArray *mShopArr;
@property (nonatomic,strong)    NSMutableArray *mShopHotArr;


@end

@implementation communityViewController
{
    mCommunityNavView *mNavView;
    
    AMapLocationManager *mLocation;

    mCommunityNavView *mSubView;
    DCPicScrollView  *mScrollerView;

    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    self.hiddenTabBar = YES;

    [super viewDidLoad];

    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.Title = self.mPageName = @"社区生活";
    self.navBar.hidden = YES;
    self.mBanerArr = [NSMutableArray new];
    self.mSubArr = [NSMutableArray new];
    self.mShopArr = [NSMutableArray new];
    self.mShopHotArr = [NSMutableArray new];
    [self initLocation];

    
    
    
    [self initView];

}
- (void)initView{
    
    mNavView = [mCommunityNavView shareView];
    mNavView.frame = CGRectMake(0, 0, DEVICE_Width, 64);
    [mNavView.mBackBtn addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [mNavView.mAddressBtn addTarget:self action:@selector(addressAction:) forControlEvents:UIControlEventTouchUpInside];
    [mNavView.mMyBtn addTarget:self action:@selector(myAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:mNavView];
    
    
    [self loadTableView:CGRectMake(0, 0, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    
    
    
    self.haveHeader = YES;
    
    
    UINib   *nib = [UINib nibWithNibName:@"communityCell1" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell1"];
    
    nib = [UINib nibWithNibName:@"communityCell2" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];
    
    nib = [UINib nibWithNibName:@"communityCell3" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell3"];
    
    
}
- (void)leftAction:(UIButton *)sender{

    [self popViewController];
}
- (void)addressAction:(UIButton *)sender{
    
    MLLog(@"选择地址");
    
    mNavAddressViewController *address = [[mNavAddressViewController alloc] initWithNibName:@"mNavAddressViewController" bundle:nil];
    
    address.block = ^(NSString *Lat,NSString *Lng,NSString *mId){
        MLLog(@"纬度：%@经度：%@id：%@",Lat,Lng,mId);
        
        mNavView.mAddress.text = [NSString stringWithFormat:@"当前位置:%@",mId];
        self.mLat = Lat;
        self.mLng = Lng;
        [self headerBeganRefresh];
    };
    
    [self pushViewController:address];
    
}
- (void)myAction:(UIButton *)sender{
    
    MLLog(@"我的");
    
    mCommunityMyViewController *my = [mCommunityMyViewController new];
    [self pushViewController:my];
}
#pragma mark----加载地址
- (void)initLocation{
  
    [CurentLocation sharedManager].delegate = self;
    [[CurentLocation sharedManager] getUSerLocation];

    mLocation = [[AMapLocationManager alloc] init];
    mLocation.delegate = self;
    [mLocation setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    mLocation.locationTimeout = 3;
    mLocation.reGeocodeTimeout = 3;
    [mLocation requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error)
        {
            NSString *eee =@"定位失败！请点击这里重新选择地址！";
            mNavView.mAddress.text = eee;
            MLLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);

        }
        if (regeocode)
        {
            MLLog(@"reGeocode:%@", regeocode);
            mNavView.mAddress.text = [NSString stringWithFormat:@"当前位置：%@\n%@%@",regeocode.formattedAddress,regeocode.street,regeocode.number];
   
            MLLog(@"location:%@", location);
            _mLat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
            _mLng = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
        }
    }];

    

    
}

- (void)headerBeganRefresh{

    self.page = 1;
    
    [self.mBanerArr removeAllObjects];
    [self.mSubArr removeAllObjects];
    [self.mShopArr removeAllObjects];
    [self.mShopHotArr removeAllObjects];
  
    
    if (!_mLat) {
        [self headerEndRefresh];

        [self showErrorStatus:@"定位失败，请重新选择社区!"];
        [self addressAction:nil];
        
        return;
    }
    
    [[mUserInfo backNowUser] getMarketHome:self.page andLat:_mLat andLng:_mLng block:^(mBaseData *resb, NSArray *mBanerArr, NSArray *mShopArr,NSArray *mHotArr) {
        
        
        [self headerEndRefresh];
        [self removeEmptyView];
        if (resb.mSucess) {
            
            [self.mBanerArr addObjectsFromArray:mBanerArr];
            [self.mShopArr addObjectsFromArray:mShopArr];
            [self.mShopHotArr addObjectsFromArray:mHotArr];
            [self.tableView reloadData];
            
        }else{
            [self addEmptyView:nil];
            [self showErrorStatus:resb.mMessage];
            [self popViewController];
        }
        
    }];

    
}
#pragma mark -----加载热卖商品
/**
 *  加载热卖商品
 */
- (void)loadHotData{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark----maplitdelegate
- (void)MMapreturnLatAndLng:(NSDictionary *)mCoordinate{
    
    MLLog(@"定位成功之后返回的东东：%@",mCoordinate);
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
 
    if (self.mShopHotArr.count<=0) {
        return 2;
    }else{
        return 3;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.5;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.mShopHotArr.count <= 0) {
        if (section == 0) {
            return 1;
        }else{
            return self.mShopArr.count;
        }
    }else{
        if (section == 0) {
            return 1;
        }else if (section == 1){
            return 1;
        }else{
            return self.mShopArr.count;
        }
    }
 
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.mShopHotArr.count <= 0) {
        if (indexPath.section == 0) {
            return 120;
        }else{
            
            GMarketList *mShopList = self.mShopArr[indexPath.row];
            
            if (mShopList.mActivityArr.count <= 0) {
                return 100;
                
            }else if (mShopList.mActivityArr.count == 1){
                return 135;
                
            }else{
                NSString *reuseCellId = nil;
                
                reuseCellId = @"cell3";
                communityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
                
                
                GMarketList *mShopList = self.mShopArr[indexPath.row];
                [cell setMShopList:mShopList];
                
                
                
                return cell.mCellH;
                
            }
            
        }

    }else{
        if (indexPath.section == 0) {
            return 120;
        }else if (indexPath.section == 1){
            return 210;
        }else{
            
            GMarketList *mShopList = self.mShopArr[indexPath.row];
            
            if (mShopList.mActivityArr.count <= 0) {
                return 100;
                
            }else if (mShopList.mActivityArr.count == 1){
                return 135;
                
            }else{
                NSString *reuseCellId = nil;
                
                reuseCellId = @"cell3";
                communityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
                
                
                GMarketList *mShopList = self.mShopArr[indexPath.row];
                [cell setMShopList:mShopList];
                
                
                
                return cell.mCellH;
                
            }
            
        }

    }
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    if (self.mShopHotArr.count <= 0) {
        if (indexPath.section == 0) {
            reuseCellId = @"cell1";
            
            communityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.delegate = self;
            [cell setMDataSourceArr:self.mBanerArr];
            
            return cell;
            
        }else{
            
            reuseCellId = @"cell3";
            communityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            
            GMarketList *mShopList = self.mShopArr[indexPath.row];
            [cell setMShopList:mShopList];
            
            
            
            return cell;
        }

    }else{
        if (indexPath.section == 0) {
            reuseCellId = @"cell1";
            
            communityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.delegate = self;
            [cell setMDataSourceArr:self.mBanerArr];
            
            return cell;
            
        }else if (indexPath.section == 1){
            reuseCellId = @"cell2";
            
            communityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.delegate = self;
            [cell setMScrollerSourceArr:self.mShopHotArr];
            return cell;
            
        }else{
            
            reuseCellId = @"cell3";
            communityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            
            GMarketList *mShopList = self.mShopArr[indexPath.row];
            [cell setMShopList:mShopList];
            
            
            
            return cell;
        }

    }
    
   
    
}
#pragma mark----cellbaner的代理方法
- (void)cellDidSelectedBanerIndex:(NSInteger)mIndex{

//    MBaner *banar = self.mBanerArr[mIndex];
//    
//    WebVC *w = [WebVC new];
//    w.mName = banar.mName;
//    w.mUrl = [NSString stringWithFormat:@"%@",banar.mContentUrl];
//    [self pushViewController:w];

}
#pragma mark----滚动的代理方法
- (void)cellWithScrollerViewSelectedIndex:(NSInteger)mIndex{
    MLLog(@"点击了%ld个",(long)mIndex);
    GHot *mHot = self.mShopHotArr[mIndex];
    homeHotViewController *hhh = [[homeHotViewController alloc] initWithNibName:@"homeHotViewController" bundle:nil];
    hhh.mGoodId = mHot.mId;
    hhh.mLat = _mLat;
    hhh.mLng = _mLng;
    [self pushViewController:hhh];
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GMarketList *mShopList = self.mShopArr[indexPath.row];

    mMarketDetailViewController *market = [[mMarketDetailViewController alloc] initWithNibName:@"mMarketDetailViewController" bundle:nil];
    market.mShopList = GMarketList.new;
    market.mShopList = mShopList;
    market.mShopId = mShopList.mId;
    
    [self pushViewController:market];
    
}



@end
