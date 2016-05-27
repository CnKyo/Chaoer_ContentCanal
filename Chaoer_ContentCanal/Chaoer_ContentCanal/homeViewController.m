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

#import "mGeneralSubView.h"

#import "mSenderViewController.h"

#import "communityStatusViewController.h"
#import "mConversationViewController.h"

#import "mServiceClassViewController.h"


#import "needCodeViewController.h"
#import "verifyBankViewController.h"

#import "CurentLocation.h"

#define Height (DEVICE_Width*0.67)

@interface homeViewController ()<UITableViewDelegate,UITableViewDataSource,AMapLocationManagerDelegate,MMApBlockCoordinate>

@property (nonatomic,strong)    NSMutableArray  *mBanerArr;

@property(nonatomic,strong) CLLocationManager *locaManager;

@end

@implementation homeViewController
{
    
    UIView  *mHeaderView;
    
    DCPicScrollView  *mScrollerView;
    
    
    mCustomHomeView *mCustomBtn;
    
    homeNavView *mNavView;
    
    AMapLocationManager *mLocation;

    mGeneralSubView *mSubView;
    
    /**
     *  纬度
     */
    NSString *mLat;
    /**
     *  经度
     */
    NSString *mLng;
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [CurentLocation sharedManager];
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
    self.mBanerArr = [NSMutableArray new];
    
    
    mLat = nil;
    mLng = nil;
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(callBack)name:@"back"object:nil];
    
    if ([mUserInfo backNowUser].isNeedLogin || [mUserInfo isNeedLogin]) {
        [self gotoLoginVC];
        return;
        
    }
    

    
}

- (void)appInit{

    [Ginfo getGinfo:^(mBaseData *resb) {
        if (resb.mSucess) {
            
        }else{
            
        }
    }];
    
    [self getRCC];
    
    
}
- (void)getRCC{
    NSString *mtt = nil;
    if ([mUserInfo backNowUser].mUserId) {
        mtt = [NSString stringWithFormat:@"%d",[mUserInfo backNowUser].mUserId];
    }else{
        mtt = [mUserInfo backNowUser].mOpenId;
        
    }
    NSString *url = [NSString stringWithFormat:@"%@%@",[HTTPrequest returnNowURL],[mUserInfo backNowUser].mUserImgUrl];
    
    [RCCInfo getToken:@"seller" andValue:mtt andUserName:[mUserInfo backNowUser].mNickName andPrtraitUri:url block:^(mBaseData *resb,RCCInfo *mrcc) {
        
        if (resb.mSucess) {
            [mUserInfo OpenRCConnect];
        }else{
            NSLog(@"获取RCC返回错误信息:%@",resb.mMessage);
        }
        
    }];
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)callBack{
    
    NSLog(@"this is Notification.");
    [self appInit];

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
    self.haveHeader = YES;
    [self.tableView headerBeginRefreshing];
    UINib   *nib = [UINib nibWithNibName:@"homeTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
}
- (void)loadAddress{
    
    [CurentLocation sharedManager].delegate = self;
    [[CurentLocation sharedManager] getUSerLocation];
    
    
    mLocation = [[AMapLocationManager alloc] init];
    mLocation.delegate = self;
    [mLocation setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    mLocation.locationTimeout = 3;
    mLocation.reGeocodeTimeout = 3;
//    [WJStatusBarHUD showLoading:@"正在定位中..."];
    [mLocation requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error)
        {
            NSString *eee =@"定位失败！请检查网络和定位设置！";
            [WJStatusBarHUD showErrorImageName:nil text:eee];

            mNavView.mAddress.text = eee;
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);

        }
        
        NSLog(@"location:%f", location.coordinate.latitude);
        
        mLat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
        mLng = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
        [self reloadRCCLocation];
        
        if (regeocode)
        {

            [WJStatusBarHUD showSuccessImageName:nil text:@"定位成功"];
            
            NSLog(@"reGeocode:%@", regeocode);
            mNavView.mAddress.text = [NSString stringWithFormat:@"%@%@%@",regeocode.formattedAddress,regeocode.street,regeocode.number];
        }
    }];

}

- (void)reloadRCCLocation{

    [mUserInfo reRCClocation:nil andLat:mLat andLong:mLng block:^(mBaseData *resb) {
        if (resb.mSucess) {
            
        }else if(resb.mState == 401002){
            [self getRCC];
        }else{
            NSLog(@"获取融云位置信息失败：%@",resb.mMessage);
        }
    }];
    
}

- (void)headerBeganRefresh{
    [self loadAddress];

    [self.mBanerArr removeAllObjects];
    [mUserInfo getBaner:^(mBaseData *resb, NSArray *mBaner) {
        [self headerEndRefresh];
        [self removeEmptyView];
        if (resb.mSucess) {

            
            [self.mBanerArr addObjectsFromArray:mBaner];
            [self.tableView reloadData];
            [self loadScrollerView];

        }else{
//            [SVProgressHUD showErrorWithStatus:resb.mMessage];
            [self addEmptyView:nil];
        }
        
    }];
}

- (void)loadHeaderView{
    
    for (UIButton *btn in mHeaderView.subviews) {
        [btn removeFromSuperview];
    }
    
    
    mHeaderView = [UIView new];
    mHeaderView.frame = CGRectMake(0, 0, DEVICE_Width, 470);
    mHeaderView.backgroundColor = [UIColor whiteColor];

    UIView  *bgkView = [UIView new];
    bgkView.frame = CGRectMake(0, mScrollerView.mbottom, DEVICE_Width, 5);
    bgkView.backgroundColor = [UIColor colorWithRed:0.95 green:0.94 blue:0.91 alpha:1.00];
    [mHeaderView addSubview:bgkView];
    
    float x1 = 20;
    float y1 = bgkView.mbottom+10;
    float btnWidth1 = DEVICE_Width/2-20;

    UIImage *imag11 = [UIImage imageNamed:@"qiuk_pay"];
    UIImage *imag21 = [UIImage imageNamed:@"canal_fix"];
    NSArray *imgArr11 = @[imag11,imag21];
    NSArray *marr11 = @[@"快捷缴费",@"物业保修"];

    for (int i = 0; i<2; i++) {
        
        mSubView = [mGeneralSubView shareView];
        mSubView.frame =CGRectMake(x1, y1, btnWidth1, 110);
        mSubView.mImg.image = imgArr11[i];
        mSubView.mName.text = marr11[i];
        mSubView.mBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        mSubView.mBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [mSubView.mBtn setTitleColor:[UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1] forState:0];

        
        [mSubView.mBtn setBackgroundColor:[UIColor whiteColor] forUIControlState:UIControlStateNormal];
        [mSubView.mBtn setBackgroundColor:[UIColor lightGrayColor] forUIControlState:UIControlStateSelected];
        
        mSubView.mBtn.tag = i;
        [mSubView.mBtn addTarget:self action:@selector(mTwoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [mHeaderView addSubview:mSubView];
        x1 += btnWidth1+20;
        
        if (x1 >= DEVICE_Width) {
            x1 = 0;
            y1 += 110;
        }

    }
    
    UIView  *bgkView1 = [UIView new];
    bgkView1.frame = CGRectMake(0, y1, DEVICE_Width, 5);
    bgkView1.backgroundColor = [UIColor colorWithRed:0.95 green:0.94 blue:0.91 alpha:1.00];
    [mHeaderView addSubview:bgkView1];
    
    UIImage *imag1 = [UIImage imageNamed:@"community_life"];
    UIImage *imag2 = [UIImage imageNamed:@"person_service"];

    UIImage *imag3 = [UIImage imageNamed:@"neiborhud"];

    UIImage *imag4 = [UIImage imageNamed:@"feedback_sorpport"];

    UIImage *imag5 = [UIImage imageNamed:@"movie_ticket"];

    UIImage *imag6 = [UIImage imageNamed:@"community_status"];

    NSArray *imgArr = @[imag1,imag2,imag3,imag4,imag5,imag6];
    
    NSArray *marr = @[@"社区生活",@"便民服务",@"邻里圈",@"投诉建议",@"跑跑腿",@"社区动态",];
    
    float x = 0;
    float y = bgkView1.mbottom;

    float btnWidth = DEVICE_Width/3;
    
    for (int i = 0; i<marr.count; i++) {
        
        mSubView = [mGeneralSubView shareView];
        mSubView.frame = CGRectMake(x, y, btnWidth, 110);
        
        mSubView.layer.masksToBounds = YES;
        mSubView.layer.borderColor = [UIColor colorWithRed:0.95 green:0.94 blue:0.91 alpha:1.00].CGColor;
        mSubView.layer.borderWidth = 0.5;
        
        
        mSubView.mImg.image = imgArr[i];
        mSubView.mName.text = marr[i];
        
        mSubView.mBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        mSubView.mBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [mSubView.mBtn setTitleColor:[UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1] forState:0];

        [mSubView.mBtn setBackgroundColor:[UIColor whiteColor] forUIControlState:UIControlStateNormal];
        [mSubView.mBtn setBackgroundColor:[UIColor lightGrayColor] forUIControlState:UIControlStateSelected];
        
        mSubView.mBtn.tag = i;
        [mSubView.mBtn addTarget:self action:@selector(mSomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [mHeaderView addSubview:mSubView];
        
        x += btnWidth;
        
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
- (void)mTwoBtnAction:(UIButton *)sender{
    switch (sender.tag) {
        case 0:
        {
            payViewController   *ppp = [[payViewController alloc] initWithNibName:@"payViewController" bundle:nil];
            [self pushViewController:ppp];
        }
            break;
        case 1:
        {
            if (![mUserInfo backNowUser].mIsRegist) {
                [self AlertViewShow:@"未实名认证！" alertViewMsg:@"通过认证即可使用更多功能？" alertViewCancelBtnTiele:@"取消" alertTag:10];
                return;
            }

            mFixViewController   *ppp = [[mFixViewController alloc] initWithNibName:@"mFixViewController" bundle:nil];
            [self presentModalViewController:ppp];
        }
            break;
        default:
            break;
    }
}
#pragma mark----按钮的点击事件
- (void)mSomeBtnAction:(UIButton *)sender{
    NSLog(@"第%ld个",(long)sender.tag);
    
    switch (sender.tag) {
        case 0:
        {
            [LCProgressHUD showInfoMsg:@"正在建设中..."];
//
//            communityViewController   *ppp = [communityViewController new];
//            [self pushViewController:ppp];
        }
            break;
        case 1:
        {
            serviceViewController *sss = [[serviceViewController alloc] initWithNibName:@"serviceViewController" bundle:nil];
            [self pushViewController:sss];

        }
            break;
        case 2:
        {
            if (![mUserInfo backNowUser].mIsRegist) {
              
                [self AlertViewShow:@"未实名认证！" alertViewMsg:@"通过认证即可使用更多功能？" alertViewCancelBtnTiele:@"取消" alertTag:10];
                return;
            }
            
            mConversationViewController *ccc = [[mConversationViewController alloc] initWithNibName:@"mConversationViewController" bundle:nil];
            
            
            if (mLat) {
                ccc.mLat = mLat;
            }if (mLng) {
                ccc.mLng = mLng;
            }
            
            if ([mLat isEqualToString:@"0.000000"]) {
                ccc.mLat = nil;
            }if ([mLng isEqualToString:@"0.000000"]) {
                ccc.mLng = nil;
            }
            
            [self pushViewController:ccc];

        }
            break;
        case 3:
        {
            mFeedBackViewController *sss = [[mFeedBackViewController alloc] initWithNibName:@"mFeedBackViewController" bundle:nil];
            [self pushViewController:sss];
        }
            break;
        case 4:
        {
            
            mSenderViewController *mmm = [[mSenderViewController alloc] initWithNibName:@"mSenderViewController" bundle:nil];
            
            mmm.mLng = mLng;
            mmm.mLat = mLat;
            [self pushViewController:mmm];
//            [LCProgressHUD showInfoMsg:@"正在建设中..."];

            

        }
            break;
        case 5:
        {
            if (![mUserInfo backNowUser].mIsRegist) {
                
                [self AlertViewShow:@"未实名认证！" alertViewMsg:@"通过认证即可使用更多功能？" alertViewCancelBtnTiele:@"取消" alertTag:10];
                return;
            }

            communityStatusViewController *ccc = [[communityStatusViewController alloc] initWithNibName:@"communityStatusViewController" bundle:nil];
            [self pushViewController:ccc];
//            [LCProgressHUD showInfoMsg:@"正在建设中..."];


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
    [arrtemp removeAllObjects];
    for (MBaner *banar in self.mBanerArr) {
        [arrtemp addObject:banar.mImgUrl];
    }
    
    NSLog(@"%@",arrtemp);
    //显示顺序和数组顺序一致
    //设置图片url数组,和滚动视图位置
    mScrollerView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, DEVICE_Width, 120) WithImageUrls:arrtemp];
    
    //显示顺序和数组顺序一致
    //设置标题显示文本数组
    
    //占位图片,你可以在下载图片失败处修改占位图片
    mScrollerView.placeImage = [UIImage imageNamed:@"ic_default_rectangle-1"];
    
    //图片被点击事件,当前第几张图片被点击了,和数组顺序一致
    __weak __typeof(self)weakSelf = self;

    [mScrollerView setImageViewDidTapAtIndex:^(NSInteger index) {
        printf("第%zd张图片\n",index);
        return ;
        MBaner *banar = weakSelf.mBanerArr[index];
        
        WebVC *w = [WebVC new];
        w.mName = banar.mName;
        w.mUrl = [NSString stringWithFormat:@"http://%@",banar.mContentUrl];
        [weakSelf pushViewController:w];

        
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
    
    return 0;
    
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


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if( buttonIndex == 1)
    {
  
         if([mUserInfo backNowUser].mIsHousingAuthentication){
            
            verifyBankViewController *vvv = [[verifyBankViewController alloc] initWithNibName:@"verifyBankViewController" bundle:nil];
            [self pushViewController:vvv];
            
            
        }else{
            needCodeViewController *nnn = [[needCodeViewController alloc] initWithNibName:@"needCodeViewController" bundle:nil];
            nnn.Type = 1;
            
            [self pushViewController:nnn];
        }

        
        
    }
}

- (void)AlertViewShow:(NSString *)alerViewTitle alertViewMsg:(NSString *)msg alertViewCancelBtnTiele:(NSString *)cancelTitle alertTag:(int)tag{
    
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:alerViewTitle message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:@"去认证", nil];
    al.delegate = self;
    al.tag = tag;
    [al show];
}


#pragma mark----maplitdelegate
- (void)MMapreturnLatAndLng:(NSDictionary *)mCoordinate{

    NSLog(@"定位成功之后返回的东东：%@",mCoordinate);
}


@end
