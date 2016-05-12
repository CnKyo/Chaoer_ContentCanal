//
//  mSenderViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/6.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mSenderViewController.h"


#import "senderDetailViewController.h"

#import "evolutionViewController.h"

#import "pptTableViewCell.h"
#import "pptHeaderView.h"


#import "pptChartsViewController.h"


#import "bolterViewController.h"

#import "pptReleaseView.h"

#import "releasePPtViewController.h"

@interface mSenderViewController ()<UITableViewDelegate,UITableViewDataSource,AMapLocationManagerDelegate,WKSegmentControlDelagate>

@property (nonatomic,strong)    NSMutableArray  *mBanerArr;


@end

@implementation mSenderViewController
{
    AMapLocationManager *mLocation;
    
    int     mType;
    /**
     *  tableViewHeader
     */
    pptHeaderView *mHeaderView;
    /**
     *  section
     */
    WKSegmentControl    *mSegmentView;

    DCPicScrollView  *mScrollerView;
    /**
     *  发布view
     */
    pptReleaseView *mReleaseView;

}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self hiddenReleaseView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.Title = self.mPageName = @"跑跑腿";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.rightBtnTitle = @"筛选";
    

    mType =0;
    self.mBanerArr = [NSMutableArray new];
    [self initView];
    [self initReleaseView];
}

- (void)initView{

    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.haveHeader = YES;
    [self.tableView headerBeginRefreshing];

    UINib   *nib = [UINib nibWithNibName:@"pptTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    


}
- (void)initAddress{
    
    
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
            mHeaderView.mAddress.text = eee;
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
        }
        
        NSLog(@"location:%@", location);
        
        if (regeocode)
        {
            [WJStatusBarHUD showSuccessImageName:nil text:@"定位成功"];
            
            NSLog(@"reGeocode:%@", regeocode);
            mHeaderView.mAddress.text = [NSString stringWithFormat:@"%@%@%@",regeocode.formattedAddress,regeocode.street,regeocode.number];
            
        }
    }];
    
   
}

- (void)loadData{
    [self.mBanerArr removeAllObjects];
    [mUserInfo getBaner:^(mBaseData *resb, NSArray *mBaner) {
        [self removeEmptyView];
        if (resb.mSucess) {
            
            [self.mBanerArr addObjectsFromArray:mBaner];
            [self loadScrollerView];

        }else{
            [self addEmptyView:nil];
        }
        
    }];

}

- (void)headerBeganRefresh{
    [self headerEndRefresh];
    [self loadData];

    [self initAddress];
    
}
- (void)loadScrollerView{
    [mHeaderView removeFromSuperview];
    
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
    mScrollerView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, DEVICE_Width, 100) WithImageUrls:arrtemp];
    
    //显示顺序和数组顺序一致
    //设置标题显示文本数组
    
    //占位图片,你可以在下载图片失败处修改占位图片
    mScrollerView.placeImage = [UIImage imageNamed:@"place.png"];
    
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
    
        mHeaderView = [pptHeaderView shareView];
        
        mHeaderView.frame = CGRectMake(0, 0, DEVICE_Width, 270);
        [mHeaderView.mBanerView addSubview:mScrollerView];

    [mHeaderView.mPPTMy addTarget:self action:@selector(pptMyAction:) forControlEvents:UIControlEventTouchUpInside];
    [mHeaderView.mPPTseniorityBtn addTarget:self action:@selector(pptseniorityAction:) forControlEvents:UIControlEventTouchUpInside];
    [mHeaderView.mPPTHistoryBtn addTarget:self action:@selector(pptHistoryAction:) forControlEvents:UIControlEventTouchUpInside];
    [mHeaderView.mPPTReleaseBtn addTarget:self action:@selector(pptReleaseAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView setTableHeaderView:mHeaderView];
    
}


#pragma mark----我的
- (void)pptMyAction:(UIButton *)sender{

}
#pragma mark----榜单
- (void)pptseniorityAction:(UIButton *)sender{
    pptChartsViewController *ppt = [[pptChartsViewController alloc] initWithNibName:@"pptChartsViewController" bundle:nil];
    [self pushViewController:ppt];
    
    
}
#pragma mark----纪录
- (void)pptHistoryAction:(UIButton *)sender{
    
}
#pragma mark----发布
- (void)pptReleaseAction:(UIButton *)sender{
    [self showReleaseView];
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

     mSegmentView = [WKSegmentControl initWithSegmentControlFrame:CGRectMake(0, 165, DEVICE_Width, 40) andTitleWithBtn:@[@"收商品买送", @"事情办理",@"送东西"] andBackgroudColor:[UIColor whiteColor] andBtnSelectedColor:M_CO andBtnTitleColor:M_TextColor1 andUndeLineColor:M_CO andBtnTitleFont:[UIFont systemFontOfSize:15] andInterval:20 delegate:self andIsHiddenLine:NO];
    return mSegmentView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 40;
}

- (void)WKDidSelectedIndex:(NSInteger)mIndex{
    NSLog(@"点击了%lu",(unsigned long)mIndex);
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    
    pptTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)rightBtnTouched:(id)sender{

    bolterViewController *bbb =[[bolterViewController alloc] initWithNibName:@"bolterViewController" bundle:nil];
    [self pushViewController:bbb];
}

#pragma mark----发布view
- (void)initReleaseView{

    mReleaseView = [pptReleaseView shareView];
    mReleaseView.frame = CGRectMake(0, DEVICE_Height, self.view.frame.size.width, DEVICE_Height);
    
    mReleaseView.mBgkView.backgroundColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:0.75];
    
    [mReleaseView.mBuyBtn btnClick:^{
        NSLog(@"买东西");
        releasePPtViewController *rrr = [[releasePPtViewController alloc] initWithNibName:@"releasePPtViewController" bundle:nil];
        rrr.mType = 1;
        [self pushViewController:rrr];
    
    }];
    
    [mReleaseView.mDoBtn btnClick:^{
        NSLog(@"办事情");
        releasePPtViewController *rrr = [[releasePPtViewController alloc] initWithNibName:@"releasePPtViewController" bundle:nil];
        rrr.mType = 2;
        [self pushViewController:rrr];
    }];
    
    [mReleaseView.mSendBtn btnClick:^{
        NSLog(@"送东西");
        releasePPtViewController *rrr = [[releasePPtViewController alloc] initWithNibName:@"releasePPtViewController" bundle:nil];
        rrr.mType = 3;
        [self pushViewController:rrr];
    }];
    
    [mReleaseView.mCloseBtn btnClick:^{
        NSLog(@"关闭"); 
        [self hiddenReleaseView];
    
    }];
    [self.view addSubview:mReleaseView];
 
    
    UITapGestureRecognizer *mClose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mCloseAction)];
    [mReleaseView addGestureRecognizer:mClose];
    
}

#pragma mark----关闭发布view
- (void)mCloseAction{

    [self hiddenReleaseView];
}
#pragma mark----显示发布view
- (void)showReleaseView{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect mARR = mReleaseView.frame;
        mARR.origin.y = 0;
        mReleaseView.frame = mARR;
        
    }];
    

}
#pragma mark----隐藏发布view
- (void)hiddenReleaseView{
    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect mARR = mReleaseView.frame;
        mARR.origin.y = DEVICE_Height;
        mReleaseView.frame = mARR;
        
    }];
}





@end
