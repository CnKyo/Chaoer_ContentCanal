//
//  mNavAddressViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/2.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mNavAddressViewController.h"

#import "mNavAddressCell.h"

#import "CurentLocation.h"

@interface mNavAddressViewController ()<UITableViewDelegate,UITableViewDataSource,AMapLocationManagerDelegate,MMApBlockCoordinate>

@end

@implementation mNavAddressViewController
{
    AMapLocationManager *mLocation;

    NSString *mLat;
    NSString *mLng;
    NSString *mDetailAddress;
}
- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.mPageName = self.Title = @"选择地址";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    
    mLat = mLng = mDetailAddress = nil;
    
    [self initView];
}


- (void)initView{

    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
//    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    
    
    
    self.haveHeader = YES;
    
    
    UINib   *nib = [UINib nibWithNibName:@"mNavAddressCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];


    
}
#pragma mark----加载地址
- (void)headerBeganRefresh{
    
    [CurentLocation sharedManager].delegate = self;
    [[CurentLocation sharedManager] getUSerLocation];
    
    mLocation = [[AMapLocationManager alloc] init];
    mLocation.delegate = self;
    [mLocation setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    mLocation.locationTimeout = 3;
    mLocation.reGeocodeTimeout = 3;
    [SVProgressHUD showWithStatus:@"正在定位中..." maskType:SVProgressHUDMaskTypeClear];
    [mLocation requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error)
        {
            NSString *eee =@"定位失败！请点击这里重新选择地址！";
            [SVProgressHUD showErrorWithStatus:eee];
            mDetailAddress = eee;
            MLLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
        }
        
        
        
        if (regeocode)
        {
            [SVProgressHUD showErrorWithStatus:@"定位成功！"];
            MLLog(@"location:%@", location);
            mLat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
            mLng = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
            MLLog(@"reGeocode:%@", regeocode);
            
            mDetailAddress = [NSString stringWithFormat:@"%@%@%@",regeocode.formattedAddress,regeocode.street,regeocode.number];
            
        }
        [self.tableView reloadData];
    }];
    

}
- (void)MMapreturnLatAndLng:(NSDictionary *)mCoordinate{

    MLLog(@"返回的东东？:%@",mCoordinate);
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
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else{
        return 40;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        UIView *v1 = [UIView new];
        v1.frame = CGRectMake(0, 0, DEVICE_Width, 10);
        v1.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
        return v1;
    }else{
        UIView *v1 = [UIView new];
        v1.frame = CGRectMake(0, 0, DEVICE_Width, 40);
        v1.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
        
        UILabel *lll = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, DEVICE_Width, 20)];
        lll.textColor = M_CO;
        lll.text = @"我的社区";
        lll.font = [UIFont systemFontOfSize:15];
        [v1 addSubview:lll];
        
        return v1;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 1;
    }else{
        return 5;
    }
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    reuseCellId = @"cell";

    if (indexPath.section == 0) {
        
        mNavAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
       
        if (mDetailAddress.length == 0) {
            cell.mAddress.text = @"定位失败，请检查网络和定位是否开启！";
        }else{
        
            cell.mAddress.text = mDetailAddress;
        }
        
        return cell;
        
    }else{
        
        
        mNavAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.mLocationImg.hidden = YES;
        cell.mAddressLeft.constant = -15;
        
        return cell;
    }
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 0) {
        if (mLat.length == 0) {
            [self headerBeganRefresh];
        }else{
        
            self.block(mLat,mLng,@"10");
            [self popViewController];
            
        }
    }else{
        self.block(mLat,mLng,@"10");
        [self popViewController];

    }
    
}
@end
