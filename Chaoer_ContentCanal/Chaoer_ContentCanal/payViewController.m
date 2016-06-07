//
//  payViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "payViewController.h"

#import "canalViewController.h"
#import "wpgViewController.h"

#import "payFeeViewController.h"
#import "needCodeViewController.h"
#import "verifyBankViewController.h"
@interface payViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate>

@end

@implementation payViewController
{
    mAddressView *mAdView;
    
    MAMapView *mAmapView;
    
    AMapLocationManager *mLocation;

    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.mCanalBtn.selected = NO;
    self.mParkBtn.selected = NO;
    self.mThreeBtn.selected = NO;
}
- (void)viewDidLoad {
    self.hiddenTabBar = YES;

    [super viewDidLoad];

    self.Title = self.mPageName = @"缴费功能";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    
    self.mCanalBagdge.layer.masksToBounds = self.mThreeBadge.layer.masksToBounds = self.mParkBadge.layer.masksToBounds = YES;
    self.mCanalBagdge.layer.cornerRadius = self.mThreeBadge.layer.cornerRadius = self.mParkBadge.layer.cornerRadius = self.mThreeBadge.mwidth/2;
  
    [self initView];
    [self loadHidden];
}

- (void)initView{

    mAdView = [mAddressView shareView];
    [self.view addSubview:mAdView];
    [mAdView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0);
        make.top.equalTo(self
                         .view).offset(64);
        make.height.offset(50);
    }];
    
    mAmapView = [[MAMapView alloc] initWithFrame:CGRectMake(DEVICE_Width, DEVICE_Height, 0, 0)];
    mAmapView.delegate = self;
    mAmapView.showsUserLocation = YES;
    [self.view addSubview:mAmapView];
    
    
    mLocation = [[AMapLocationManager alloc] init];
    mLocation.delegate = self;
    [mLocation setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    mLocation.locationTimeout = 3;
    mLocation.reGeocodeTimeout = 3;
    [WJStatusBarHUD showLoading:@"正在定位中..."];
    [mLocation requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error)
        {
            NSString *eee =@"定位失败！请检查网络和定位设置！";
            [WJStatusBarHUD showErrorImageName:nil text:eee];
            mAdView.mAddress.text = eee;
            MLLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
//            if (error.code == AMapLocatingErrorLocateFailed)
//            {
//                return;
//            }
        }
        
        MLLog(@"location:%@", location);
        
        if (regeocode)
        {
            [WJStatusBarHUD showSuccessImageName:nil text:@"定位成功"];

            MLLog(@"reGeocode:%@", regeocode);
            mAdView.mAddress.text = [NSString stringWithFormat:@"%@%@%@",regeocode.formattedAddress,regeocode.street,regeocode.number];

        }
    }];
    
}

- (void)loadHidden{
    self.mCanalBagdge.hidden = YES;
    self.mThreeBadge.hidden = YES;
    self.mParkBadge.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  物管费
 *
 *  @param sender
 */
- (IBAction)mCanalAction:(id)sender {
    if (![mUserInfo backNowUser].mIsHousingAuthentication) {
        [self AlertViewShow:@"未实名认证！" alertViewMsg:@"通过认证即可使用更多功能？" alertViewCancelBtnTiele:@"取消" alertTag:10];
        return;
    }
    
    UIButton *bbb = sender;
    bbb.selected = !bbb.selected;
    canalViewController *ccc= [canalViewController new];
    
    ccc.mTitel= @"缴费－物管费";
    [self pushViewController:ccc];
 

    
}
/**
 *  水电气费
 *
 *  @param sender
 */
- (IBAction)mThreeAction:(id)sender {
    
    if (![mUserInfo backNowUser].mIsHousingAuthentication) {
        [self AlertViewShow:@"未实名认证！" alertViewMsg:@"通过认证即可使用更多功能？" alertViewCancelBtnTiele:@"取消" alertTag:10];
        return;
    }
    
    UIButton *bbb = sender;
    bbb.selected = !bbb.selected;

    payFeeViewController *ccc= [[payFeeViewController alloc] initWithNibName:@"payFeeViewController" bundle:nil];
    
    ccc.mTitel= @"水电气费";
    [self pushViewController:ccc];
    

}
/**
 *  停车费
 *
 *  @param sender
 */
- (IBAction)mParkAction:(id)sender {
    [LCProgressHUD showInfoMsg:@"即将到来，敬请期待！"];
    return;
//    UIButton *bbb = sender;
//    bbb.selected = !bbb.selected;
//    canalViewController *ccc= [canalViewController new];
//    ccc.mTitel= @"缴费－停车费";
//
//    [self pushViewController:ccc];


}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark----高德地图代理方法
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        MLLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if( buttonIndex == 1)
    {
       
        needCodeViewController *nnn = [[needCodeViewController alloc] initWithNibName:@"needCodeViewController" bundle:nil];
        nnn.Type = 1;
        
        [self pushViewController:nnn];
        
        
        
        
    }
}

- (void)AlertViewShow:(NSString *)alerViewTitle alertViewMsg:(NSString *)msg alertViewCancelBtnTiele:(NSString *)cancelTitle alertTag:(int)tag{
    
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:alerViewTitle message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:@"去认证", nil];
    al.delegate = self;
    al.tag = tag;
    [al show];
}

@end
