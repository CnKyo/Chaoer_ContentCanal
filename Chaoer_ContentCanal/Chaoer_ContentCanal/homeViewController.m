//
//  homeViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/10.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "homeViewController.h"


#import "DCPicScrollView.h"
#import "DCWebImageManager.h"

#import "homeTableViewCell.h"

#import "mCustomHomeView.h"
#import "mFixViewController.h"
#import "payViewController.h"
#import "communityViewController.h"
#import "serviceViewController.h"
#import "mFeedBackViewController.h"
#import "dataModel.h"

#import "homeNavView.h"

#define Height (DEVICE_Width*0.67)

@interface homeViewController ()<UITableViewDelegate,UITableViewDataSource,AMapLocationManagerDelegate>

@end

@implementation homeViewController
{
    
    UIView  *mHeaderView;
    
    DCPicScrollView  *mScrollerView;
    
    NSMutableArray  *mTempArr;
    
    
    
    mCustomHomeView *mCustomBtn;
    
    homeNavView *mNavView;
    
    AMapLocationManager *mLocation;

    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self.tableView headerBeginRefreshing];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.Title = self.mPageName = @"首页";
//    self.navBar.alpha = 0;
    self.hiddenBackBtn = YES;
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.navBar.hidden = YES;

    mTempArr = [NSMutableArray new];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(callBack)name:@"back"object:nil];
    
    if ([mUserInfo backNowUser].isNeedLogin || [mUserInfo isNeedLogin]) {
        [self gotoLoginVC];
        return;
        
    }
    

    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)callBack{
    
    NSLog(@"this is Notification.");
    
    [self initview];
    
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"监听的变化-------%f",scrollView.contentOffset.y);
//    
//    [UIView animateWithDuration:1 animations:^{
//        
//        if (scrollView.contentOffset.y>=100) {
//            
//            CGRect mRRR = self.tableView.frame;
//            mRRR.origin.y = 64;
//            mRRR.size.height = DEVICE_Height-114;
//            self.tableView.frame = mRRR;
//            
//        }else{
//            CGRect mRRR = self.tableView.frame;
//            mRRR.origin.y = 0;
//            mRRR.size.height = DEVICE_Height-50;
//            self.tableView.frame = mRRR;
//        }
//
//    }];
//    
//}

- (void)initview{
    
    mNavView = [homeNavView shareView];
    mNavView.frame = CGRectMake(0, 0, DEVICE_Width, 64);
    [self.view addSubview:mNavView];
    
    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-114) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.tableView];
    self.haveHeader = YES;
    [self.tableView headerBeginRefreshing];
    UINib   *nib = [UINib nibWithNibName:@"homeTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self loadAddress];
    
}
- (void)loadAddress{
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
            mNavView.mAddress.text = eee;
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
            mNavView.mAddress.text = [NSString stringWithFormat:@"%@%@%@",regeocode.formattedAddress,regeocode.street,regeocode.number];
            
        }
    }];

}
- (void)headerBeganRefresh{
    [mTempArr removeAllObjects];
//    [SVProgressHUD showWithStatus:@"正在加载..." maskType:SVProgressHUDMaskTypeClear];
    [GiFHUD show];
    [mUserInfo getBaner:^(mBaseData *resb, NSArray *mBaner) {
        [GiFHUD dismiss];
        [self headerEndRefresh];
        if (mBaner) {
            [SVProgressHUD showSuccessWithStatus:@"加载成功！"];
            [mTempArr addObjectsFromArray:mBaner];
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:@"网络请求错误！"];
        }
        [self loadScrollerView];
        
    }];
}

- (void)loadHeaderView{
    
    for (UIButton *btn in mHeaderView.subviews) {
        [btn removeFromSuperview];
    }
    
    
    mHeaderView = [UIView new];
    mHeaderView.frame = CGRectMake(0, 0, DEVICE_Width, 500);
    mHeaderView.backgroundColor = [UIColor whiteColor];

    UIView  *bgkView = [UIView new];
    bgkView.frame = CGRectMake(0, mScrollerView.mbottom, DEVICE_Width, 10);
    bgkView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
    [mHeaderView addSubview:bgkView];
    
    
    UIImage *imag1 = [UIImage imageNamed:@"home_staff"];
    UIImage *imag2 = [UIImage imageNamed:@"home_fix"];

    UIImage *imag3 = [UIImage imageNamed:@"home_community"];

    UIImage *imag4 = [UIImage imageNamed:@"home_service"];

    UIImage *imag5 = [UIImage imageNamed:@"home_conversition"];

    UIImage *imag6 = [UIImage imageNamed:@"home_feedback"];

    NSArray *imgArr = @[imag1,imag2,imag3,imag4,imag5,imag6];
    
    NSArray *marr = @[@"快捷缴费",@"物业保修",@"社区生活",@"便民服务",@"邻里交流",@"投诉建议"];
    
    float x = 0;
    float y = bgkView.mbottom+10;

    float btnWidth = DEVICE_Width/3;
    
    for (int i = 0; i<marr.count; i++) {
        
        UIButton    *btn = [UIButton new];
        btn.frame = CGRectMake(x, y, btnWidth, 110);
        [btn setImage:imgArr[i] forState:0];
        [btn setTitle:marr[i] forState:0];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:[UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1] forState:0];
        btn.imageEdgeInsets  = UIEdgeInsetsMake(-20, 24, 0, 0);
        float left;
        if (DEVICE_Width<=320) {
            left = -60;
        }else{
            left = -80;
        };
        btn.titleEdgeInsets = UIEdgeInsetsMake(90, left, 20, 0);

        [btn setBackgroundColor:[UIColor whiteColor] forUIControlState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor lightGrayColor] forUIControlState:UIControlStateSelected];
        
        btn.tag = i;
        [btn addTarget:self action:@selector(mCusBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [mHeaderView addSubview:btn];
        
        x += btnWidth+10;
        
        if (x >= DEVICE_Width) {
            x = 0;
            y += 110;
        }
        
        
    }
    
    CGRect  mRect = mHeaderView.frame;
    mRect.size.height = y;
    mHeaderView.frame = mRect;
    
    [self.tableView setTableHeaderView:mHeaderView];
    
}
#pragma mark----按钮的点击事件
- (void)mCusBtnAction:(UIButton *)sender{
    NSLog(@"第%ld个",(long)sender.tag);
    
    switch (sender.tag) {
        case 0:
        {
            payViewController   *ppp = [[payViewController alloc] initWithNibName:@"payViewController" bundle:nil];
            [self pushViewController:ppp];
        }
            break;
        case 1:
        {
            mFixViewController   *ppp = [[mFixViewController alloc] initWithNibName:@"mFixViewController" bundle:nil];
            [self pushViewController:ppp];
        }
            break;
        case 2:
        {
            communityViewController   *ppp = [communityViewController new];
            [self pushViewController:ppp];
//            [self showErrorStatus:@"正在建设中..."];
        }
            break;
        case 3:
        {
            serviceViewController *sss = [[serviceViewController alloc] initWithNibName:@"serviceViewController" bundle:nil];
            [self pushViewController:sss];
        }
            break;
        case 4:
        {
            [self showErrorStatus:@"正在建设中..."];
        }
            break;
        case 5:
        {
            mFeedBackViewController *sss = [[mFeedBackViewController alloc] initWithNibName:@"mFeedBackViewController" bundle:nil];
            [self pushViewController:sss];
        }
            break;
        default:
            break;
    }
}
- (void)loadScrollerView{

    for ( UIButton * btn in mHeaderView.subviews) {
        [btn removeFromSuperview];
    }
    
    NSMutableArray *arr2 = [[NSMutableArray alloc] init];
    
    
    for (int i = 1; i < 6; i++) {
        [arr2 addObject:[NSString stringWithFormat:@"%d.jpg",i*111]];
    };
    
    
    //网络加载
    
    
    NSMutableArray *arrtemp = [NSMutableArray new];
    
    for (MBaner *banar in mTempArr) {
        [arrtemp addObject:banar.mImgUrl];
    }
    
    NSLog(@"%@",arrtemp);
    //显示顺序和数组顺序一致
    //设置图片url数组,和滚动视图位置
    mScrollerView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, DEVICE_Width, 150) WithImageUrls:arrtemp];
    
    //显示顺序和数组顺序一致
    //设置标题显示文本数组
    
    //占位图片,你可以在下载图片失败处修改占位图片
    mScrollerView.placeImage = [UIImage imageNamed:@"place.png"];
    
    //图片被点击事件,当前第几张图片被点击了,和数组顺序一致
    
    [mScrollerView setImageViewDidTapAtIndex:^(NSInteger index) {
        printf("第%zd张图片\n",index);
        MBaner *banar = mTempArr[index];
        
        WebVC *w = [WebVC new];
        w.mName = @"banar";
        w.mUrl = [NSString stringWithFormat:@"http://%@",banar.mContentUrl];
        [self pushViewController:w];

        
    }];
    
    //default is 2.0f,如果小于0.5不自动播放
    mScrollerView.AutoScrollDelay = 2.5f;
    //    picView.textColor = [UIColor redColor];
    
    
    //下载失败重复下载次数,默认不重复,
    [[DCWebImageManager shareManager] setDownloadImageRepeatCount:1];
    
    //图片下载失败会调用该block(如果设置了重复下载次数,则会在重复下载完后,假如还没下载成功,就会调用该block)
    //error错误信息
    //url下载失败的imageurl
    [[DCWebImageManager shareManager] setDownLoadImageError:^(NSError *error, NSString *url) {
        NSLog(@"%@",error);
    }];
    
    [self loadHeaderView];
    [mHeaderView addSubview:mScrollerView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 5;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 101;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";

    homeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];


    return cell;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


@end
