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

#import "mServiceCell.h"
@interface serviceViewController ()<AMapLocationManagerDelegate>

@end

@implementation serviceViewController
{
    mServiceAddressView *mView;
    UIScrollView *mScrollerView;
    AMapLocationManager *mLocation;

    NSMutableArray *mTTArr;
    
    mAddressView *mAdView;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.Title = self.mPageName = @"便民服务";
    
    mTTArr = [NSMutableArray new];
    
    mAdView = [mAddressView shareView];
    [self.view addSubview:mAdView];
    
    [mAdView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(@0);
        make.top.equalTo(self.view).offset(@64);
        make.height.offset(@50);
    }];
    

    mScrollerView = [UIScrollView new];
    mScrollerView.backgroundColor = [UIColor whiteColor];
    mScrollerView.frame = CGRectMake(0, 114, DEVICE_Width, DEVICE_Height-114);
    [self.view addSubview:mScrollerView];

    [self loadLocation];

    [self initView];

}
- (void)loadLocation{

    
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
- (void)initView{
    
    NSArray *imgArr = @[[UIImage imageNamed:@"life_58tongcheng"],[UIImage imageNamed:@"life_ganji"],[UIImage imageNamed:@"life_baidunuomi"],[UIImage imageNamed:@"life_meituan"],[UIImage imageNamed:@"life_chihewanle"],[UIImage imageNamed:@"life_didichuxing"],[UIImage imageNamed:@"life_xiecheng"],[UIImage imageNamed:@"life_yidao"],[UIImage imageNamed:@"life_jingdongjingxuan"],[UIImage imageNamed:@"life_suningyigou"],[UIImage imageNamed:@"life_weipinhui"],[UIImage imageNamed:@"topup"]];
    NSArray *marr = @[@"58同城",@"赶集网",@"百度糯米",@"美团外卖",@"吃喝玩乐",@"滴滴出行",@"携程网",@"易到",@"京东精选",@"苏宁易购",@"唯品会",@"手机充值"];
    [mTTArr addObjectsFromArray:marr];

    float x = 0;
    float y = 0;
    
    float btnWidth = DEVICE_Width/4;
    
    for (int i = 0; i<marr.count; i++) {
        mView = [mServiceAddressView shareSmallSubView];
        
        mView.layer.masksToBounds = YES;
        mView.layer.borderColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:0.45].CGColor;
        mView.layer.borderWidth = 0.5;
        mView.frame = CGRectMake(x, y, btnWidth, 80);

        mView.mSmallImg.image = imgArr[i];
        mView.mSmallT.text = marr[i];
        [mView.mSmallBtn addTarget:self action:@selector(mCusBtnAction:) forControlEvents:UIControlEventTouchUpInside];

        mView.mSmallBtn.tag = i;
        
        float left;
        if (DEVICE_Width<=320) {
            left = -60;
        }else{
            left = -60;
        };
        
        
        
        [mScrollerView addSubview:mView];
        
        x += btnWidth;
        
        if (x >= DEVICE_Width) {
            x = 0;
            y += 80;
        }
        
        
    }

}

#pragma mark----按钮的点击事件
- (void)mCusBtnAction:(UIButton *)sender{
    MLLog(@"第%ld个",(long)sender.tag);
    
    NSString *mTT = mTTArr[sender.tag];
    
    NSArray *url = @[@"http://m.58.com/",@"http://3g.ganji.com/",@"http://life.m.baidu.com/",@"http://i.meituan.com/",@"http://m.dianping.com/",@"http://imgcache.qq.com/qqshow/app/didi/proxy.html",@"http://m.ctrip.com/html5/",@"http://3g.yongche.com/touch/",@"http://wqs.jd.com",@"http://m.suning.com/",@"http://m.vip.com/"];
    if (sender.tag == 11) {
        phoneUpTopViewController *ppp = [[phoneUpTopViewController alloc] initWithNibName:@"phoneUpTopViewController" bundle:nil];
        [self pushViewController:ppp];
    }else{
        WebVC *w = [WebVC new];
        w.mName = mTT;
        w.mUrl = url[sender.tag];
        [self pushViewController:w];
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
