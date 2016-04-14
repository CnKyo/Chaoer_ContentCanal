//
//  serviceViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "serviceViewController.h"
#import "mServiceAddressView.h"

#import "phoneUpTopViewController.h"

#import "cashViewController.h"
@interface serviceViewController ()<CircleLHQdelegate,AMapLocationManagerDelegate>

@end

@implementation serviceViewController
{
    mServiceAddressView *mView;
    UIScrollView *mScrollerView;
    AMapLocationManager *mLocation;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.Title = self.mPageName = @"便民服务";
    
    [self initView];
    
}
- (void)initView{

    UIImageView *iii = [UIImageView new];
    iii.image = [UIImage imageNamed:@"mBaseBgkImg"];
    iii.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height);
    [self.view addSubview:iii];
    
    mScrollerView = [UIScrollView new];
    mScrollerView.backgroundColor = [UIColor clearColor];
    mScrollerView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-50);
    [self.view addSubview:mScrollerView];
    

    
    mView = [mServiceAddressView shareView];
    mView.frame = CGRectMake(0, 0, DEVICE_Width, mScrollerView.mheight);
    [mScrollerView addSubview:mView];
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 568);
    
    mView.mHeader.layer.masksToBounds = YES;
    mView.mHeader.layer.cornerRadius = mView.mHeader.mwidth/2;
    
    NSString *url = [NSString stringWithFormat:@"%@%@",[HTTPrequest returnNowURL],[mUserInfo backNowUser].mUserImgUrl];
    
    
    [mView.mHeader sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"icon_headerdefault"]];
    
//
//    CircleLHQView *LHQView = [[CircleLHQView alloc] initWithFrame:CGRectMake(10, 130, DEVICE_Width-20, 300) andImage:nil];
//    [LHQView addSubViewWithSubView:nil andTitle:@[@"提现",@"买票",@"帐号充值",@"敬请期待",@"手机充值"] andSize:CGSizeMake(60, 60) andcenterImage:nil];
//    LHQView.delegate = self;
//    [self.view addSubview:LHQView];
//    
//    LHQView.clickSomeOne=^(NSInteger index){
//
//    };
    mView.mName.text = [mUserInfo backNowUser].mNickName;
    [mView.mBtn1 addTarget:self action:@selector(btn1Action:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mBtn2 addTarget:self action:@selector(btn2Action:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mBtn3 addTarget:self action:@selector(btn3Action:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mBtn4 addTarget:self action:@selector(btn4Action:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mBtn5 addTarget:self action:@selector(btn5Action:) forControlEvents:UIControlEventTouchUpInside];

    mLocation = [[AMapLocationManager alloc] init];
    mLocation.delegate = self;
    [mLocation setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    mLocation.locationTimeout = 3;
    mLocation.reGeocodeTimeout = 3;
    [SVProgressHUD showWithStatus:@"正在定位中..." maskType:SVProgressHUDMaskTypeClear];
    [mLocation requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error)
        {
            NSString *eee =@"定位失败！请检查网络和定位设置！";
            [SVProgressHUD showErrorWithStatus:eee];
            mView.mAddress.text = eee;

            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            //            if (error.code == AMapLocatingErrorLocateFailed)
            //            {
            //                return;
            //            }
        }
        
        NSLog(@"location:%@", location);
        
        if (regeocode)
        {
            [SVProgressHUD showErrorWithStatus:@"定位成功！"];
            
            NSLog(@"reGeocode:%@", regeocode);
            mView.mAddress.text = [NSString stringWithFormat:@"%@%@%@",regeocode.formattedAddress,regeocode.street,regeocode.number];
        }
    }];

    
    
}
- (void)btn1Action:(UIButton *)sender{
    mBalanceViewController *ppp = [[mBalanceViewController alloc] initWithNibName:@"mBalanceViewController" bundle:nil];
    [self pushViewController:ppp];
}
- (void)btn2Action:(UIButton *)sender{
}
- (void)btn3Action:(UIButton *)sender{
    phoneUpTopViewController *ppp = [[phoneUpTopViewController alloc] initWithNibName:@"phoneUpTopViewController" bundle:nil];
    [self pushViewController:ppp];
}
- (void)btn4Action:(UIButton *)sender{
    cashViewController *ccc = [[cashViewController alloc] initWithNibName:@"cashViewController" bundle:nil];
    [self pushViewController:ccc];
}
- (void)btn5Action:(UIButton *)sender{
}
- (void)didSelectedBtnIndex:(NSInteger)index{
    NSLog(@"%ld被点击了",(long)index);
    
    switch (index) {
        case 2:
        {
            mBalanceViewController *ppp = [[mBalanceViewController alloc] initWithNibName:@"mBalanceViewController" bundle:nil];
            [self pushViewController:ppp];
        }
            break;
        case 4:
        {
            phoneUpTopViewController *ppp = [[phoneUpTopViewController alloc] initWithNibName:@"phoneUpTopViewController" bundle:nil];
            [self pushViewController:ppp];
        }
            break;
            
        default:
            break;
    }
    
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

@end
