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
#import "pptHistoryViewController.h"

#import "pptMyViewController.h"

#import "pptOrderDetailViewController.h"


#import "mGeneralSubView.h"

#import "CurentLocation.h"
#import "openPPTViewController.h"

#import "depositViewController.h"
@interface mSenderViewController ()<UITableViewDelegate,UITableViewDataSource,AMapLocationManagerDelegate,WKSegmentControlDelagate,MMApBlockCoordinate>

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
    
    /**
     *  子视图
     */
    mGeneralSubView *mSubView;
    
 

}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self initAddress];

    [self hiddenReleaseView];
    self.haveHeader = YES;

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.Title = self.mPageName = @"跑跑腿";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.rightBtnTitle = @"筛选";
    self.hiddenRightBtn = YES;

    mType =1;
    self.mBanerArr = [NSMutableArray new];
    

    [self initView];
    [self initReleaseView];
}


- (void)upDateUserStatus{

    
    if (self.mLat == nil || self.mLat.length == 0 || [self.mLat isEqualToString:@""]) {
        return;
    }
    if (self.mLng == nil || self.mLng.length == 0 || [self.mLng isEqualToString:@""]) {
        return;
    }
    if ([mUserInfo backNowUser].mLegworkUserId == 0) {
        return;
    }
    [[mUserInfo backNowUser] ipDataPPTUserStatus:_mLat andLng:_mLng block:^(mBaseData *resb) {
        
        if (resb.mSucess) {
            
        }else{
        
        }
        
    }];
    
}

- (void)initView{

    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.haveHeader = YES;
    self.haveFooter = YES;
    

    UINib   *nib = [UINib nibWithNibName:@"pptTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
     mSegmentView = [WKSegmentControl initWithSegmentControlFrame:CGRectMake(0, 165, DEVICE_Width, 40) andTitleWithBtn:@[@"商品买送", @"事情办理",@"送东西"] andBackgroudColor:[UIColor whiteColor] andBtnSelectedColor:M_CO andBtnTitleColor:M_TextColor1 andUndeLineColor:M_CO andBtnTitleFont:[UIFont systemFontOfSize:15] andInterval:20 delegate:self andIsHiddenLine:NO andType:1];

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
            [self showErrorStatus:@"需要打开定位才能查询附近的订单！"];
            MLLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
        }
        if (location) {
            MLLog(@"location:%@", location);
            self.mLat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
            self.mLng = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
            
            [self upDateUserStatus];
        }

        
        if (regeocode)
        {
            [WJStatusBarHUD showSuccessImageName:nil text:@"定位成功"];
            
            MLLog(@"reGeocode:%@", regeocode);
            mHeaderView.mAddress.text = [NSString stringWithFormat:@"%@%@%@",regeocode.formattedAddress,regeocode.street,regeocode.number];
            
        }
    }];
    
   
}

- (void)loadData{
    [self.mBanerArr removeAllObjects];
    [[mUserInfo backNowUser] getPPTbaner:^(mBaseData *resb, NSArray *mBaner) {
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
    [self loadData];
    [CurentLocation sharedManager].delegate = self;
    [[CurentLocation sharedManager] getUSerLocation];
    self.page = 1;
    
    [[mUserInfo backNowUser] getPPTNeaerbyOrder:mType andMlat:self.mLat andLng:self.mLng andPage:self.page andNum:20 block:^(mBaseData *resb, NSArray *mArr) {
        
        [self headerEndRefresh];
        [self.tempArray removeAllObjects];
        [self.tableView reloadData];

        [self removeEmptyView];
        if (resb.mSucess) {
            
            if (mArr.count<=0) {
                [self addEmptyView:nil];
            }
            
            [self.tempArray addObjectsFromArray:mArr];
            [self.tableView reloadData];
            
        }else{
            [self addEmptyView:nil];
            [self showErrorStatus:resb.mMessage];
        }
    }];
    
    
}

- (void)footetBeganRefresh{
    
    self.page ++;
    
    [[mUserInfo backNowUser] getPPTNeaerbyOrder:mType andMlat:self.mLat andLng:self.mLng andPage:self.page andNum:20 block:^(mBaseData *resb, NSArray *mArr) {
        
        [self footetEndRefresh];
        [self removeEmptyView];
        if (resb.mSucess) {
            
            if (mArr.count<=0) {
                [self addEmptyView:nil];
            }
            
            [self.tempArray addObjectsFromArray:mArr];
            [self.tableView reloadData];
            
        }else{
            [self addEmptyView:nil];
            [self showErrorStatus:resb.mMessage];
        }
    }];
    
    
    
    
    
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
    for (GPPTBaner *banar in self.mBanerArr) {
        [arrtemp addObject:banar.mImgUrl];
    }
    
    MLLog(@"%@",arrtemp);
    //显示顺序和数组顺序一致
    //设置图片url数组,和滚动视图位置
    mScrollerView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, DEVICE_Width, 100) WithImageUrls:arrtemp];
    
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
        MLLog(@"%@",error);
    }];
    
    mHeaderView = [pptHeaderView shareView];
    
    mHeaderView.frame = CGRectMake(0, 0, DEVICE_Width, 270);
    [mHeaderView.mBanerView addSubview:mScrollerView];

        
    for (UIView *view in mHeaderView.mSubView.subviews) {
        [view removeFromSuperview];
    }
    
    
    NSArray *mTT= @[@"跑腿榜",@"发布",@"我的跑单",@"我的"];
    
    
    
    NSArray *mII = @[[UIImage imageNamed:@"ppt_seniority"],[UIImage imageNamed:@"ppt_release"],[UIImage imageNamed:@"ppt_history"],[UIImage imageNamed:@"ppt_my"]];
    
    CGFloat mmW = mHeaderView.mwidth/4;
    
    for (int i = 0; i<mTT.count; i++) {
        
        mSubView = [mGeneralSubView shareSubView];
        
        mSubView.mName.text = mTT[i];
        mSubView.mImg.image = mII[i];
        mSubView.mBtn.tag = i;
        [mSubView.mBtn addTarget:self action:@selector(mBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [mHeaderView.mSubView addSubview:mSubView];
        
        
        [mSubView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(mHeaderView.mSubView).offset(@0);
            make.left.equalTo(mHeaderView.mSubView).offset(i*mmW);
            make.width.height.offset(mmW);
            
        }];
        
    }
    
    
    
    [self.tableView setTableHeaderView:mHeaderView];
    
}
#pragma mark----按钮的点击事件
- (void)mBtnAction:(UIButton *)sender{

    switch (sender.tag) {
        case 0:
        {
#pragma mark----榜单

            pptChartsViewController *ppt = [[pptChartsViewController alloc] initWithNibName:@"pptChartsViewController" bundle:nil];
            [self pushViewController:ppt];
        }
            break;
        case 1:
        {
#pragma mark----发布

            [self showReleaseView];

        }
            break;
        case 2:
        {
#pragma mark----纪录

            pptHistoryViewController *ppt = [[pptHistoryViewController alloc]initWithNibName:@"pptHistoryViewController" bundle:nil];
            ppt.mType = 1;
            ppt.mLng = self.mLng;
            ppt.mLat = self.mLat;
            [self pushViewController:ppt];
        }
            break;
        case 3:
        {
#pragma mark----我的
            int m_leg = [mUserInfo backNowUser].mIs_leg;
            
            if ( m_leg == 0) {
                
                [self AlertViewShow:@"您还未开通跑跑腿功能，是否立即开通？" alertViewMsg:@"开通成功即可使用跑跑腿功能" alertViewCancelBtnTiele:@"取消" alertTag:10];
                
                return;
                
            }else if (m_leg == 1){
                [self showErrorStatus:@"您已注销!"];
                [self AlertViewShow:@"您还未支付押金！" alertViewMsg:@"支付押金即可使用跑跑腿功能" alertViewCancelBtnTiele:@"取消" alertTag:11];
                
                return;
                
                
            }
            else if (m_leg == 2){
                [self showErrorStatus:@"正在审核中!"];
                return;
                
            }else if (m_leg == 3){
                [self showErrorStatus:@"您已被系统禁用!"];
                
                return;
                
            }else if (m_leg == 4){
                [self showErrorStatus:@"您已注销!"];
                return;
                
            }
            else{
            
                pptMyViewController *ppt = [[pptMyViewController alloc] initWithNibName:@"pptMyViewController" bundle:nil];
                [self pushViewController:ppt];
                
            }

      
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
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.tempArray.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{


    return mSegmentView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 40;
}

- (void)WKDidSelectedIndex:(NSInteger)mIndex{
    MLLog(@"点击了%lu",(unsigned long)mIndex);
    
    mType = [[NSString stringWithFormat:@"%ld",(long)mIndex+1] intValue];
    [self headerBeganRefresh];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    
    GPPTOrder *mOrder = self.tempArray[indexPath.row];
    
    pptTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
   
    [cell.mDoneBtn removeTarget:self action:@selector(mCancelOrderAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.mDoneBtn removeTarget:self action:@selector(getOrderAction:) forControlEvents:UIControlEventTouchUpInside];

    
    
    if (mOrder.mProcessStatus == 0) {
        [cell.mDoneBtn setTitle:@"取消订单" forState:0];

        cell.mDoneBtn.backgroundColor = [UIColor lightGrayColor];
        cell.mDoneBtn.enabled = NO;
    }else{
        if ([mUserInfo backNowUser].mUserId == [mOrder.mUserId intValue]) {
            
            
            [cell.mDoneBtn setTitle:@"取消订单" forState:0];
            cell.mDoneBtn.titleLabel.font = [UIFont systemFontOfSize:14];

            [cell.mDoneBtn addTarget:self action:@selector(mCancelOrderAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.mDoneBtn.backgroundColor = M_CO;
            cell.mDoneBtn.tag = 10;
            
        }else{
            
            if ([mUserInfo backNowUser].mIs_leg != 5) {
                [cell.mDoneBtn setTitle:@"接单" forState:0];

                cell.mDoneBtn.backgroundColor = [UIColor lightGrayColor];
                cell.mDoneBtn.enabled = NO;
            }else{
                [cell.mDoneBtn setTitle:@"接单" forState:0];
                cell.mDoneBtn.backgroundColor = M_CO;
                cell.mDoneBtn.enabled = YES;
                [cell.mDoneBtn addTarget:self action:@selector(getOrderAction:) forControlEvents:UIControlEventTouchUpInside];
                cell.mDoneBtn.tag = 20;
            }
        }

    }
    
    
    [cell.mHeader sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[HTTPrequest currentResourceUrl],mOrder.mPortrait]] placeholderImage:[UIImage imageNamed:@"img_default"]];

    
    
    if (mType == 3) {
        cell.mTitle.text = mOrder.mGoodsName;
        cell.mDistance.text = [NSString stringWithFormat:@"%@元",mOrder.mGoodsPrice];

    }else if(mType ==2){
        cell.mTitle.text = mOrder.mContext;
        cell.mDistance.text = [NSString stringWithFormat:@"%@/%@m",mOrder.mAdress,mOrder.mDistance];

    }else{
        cell.mTitle.text = mOrder.mContext;
        cell.mDistance.text = [NSString stringWithFormat:@"%@分钟/%@m",mOrder.mArrivedTime,mOrder.mDistance];
    }
    cell.mDoneBtn.mOrder = mOrder;


    
    cell.mMoney.text = [NSString stringWithFormat:@"酬金：%@元",mOrder.mLegworkMoney];
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GPPTOrder *mPPtOrder = self.tempArray[indexPath.row];

    if (mPPtOrder.mProcessStatus == 0) {
        [self showErrorStatus:@"订单已被取消，无法查看！"];
    
        return;
    }
    
    pptOrderDetailViewController *ppp = [[pptOrderDetailViewController alloc] initWithNibName:@"pptOrderDetailViewController" bundle:nil];
    ppp.mOrderType = 1;
    ppp.mType = mType;
    ppp.mOrder = GPPTOrder.new;
    ppp.mOrder = mPPtOrder;
    
    ppp.mLng = self.mLng;
    ppp.mLat = self.mLat;
    
    [self pushViewController:ppp];
}

- (void)rightBtnTouched:(id)sender{

    bolterViewController *bbb =[[bolterViewController alloc] initWithNibName:@"bolterViewController" bundle:nil];
    bbb.mType = 2;
    [self pushViewController:bbb];
}

#pragma mark----发布view
- (void)initReleaseView{

    mReleaseView = [pptReleaseView shareView];
    mReleaseView.frame = CGRectMake(0, DEVICE_Height, self.view.frame.size.width, DEVICE_Height);
    
    mReleaseView.mBgkView.backgroundColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:0.75];
    
    [mReleaseView.mBuyBtn btnClick:^{
        MLLog(@"买东西");
        
              
        releasePPtViewController *rrr = [[releasePPtViewController alloc] initWithNibName:@"releasePPtViewController" bundle:nil];
        rrr.mType = 1;
        rrr.mSubType = 1;
        [self pushViewController:rrr];
    
    }];
    
    [mReleaseView.mDoBtn btnClick:^{
        MLLog(@"办事情");
        releasePPtViewController *rrr = [[releasePPtViewController alloc] initWithNibName:@"releasePPtViewController" bundle:nil];
        rrr.mType = 2;
        rrr.mSubType = 2;
        [self pushViewController:rrr];
    }];
    
    [mReleaseView.mSendBtn btnClick:^{
        
        MLLog(@"送东西");
        releasePPtViewController *rrr = [[releasePPtViewController alloc] initWithNibName:@"releasePPtViewController" bundle:nil];
        rrr.mType = 3;
        rrr.mSubType = 3;
        [self pushViewController:rrr];
    }];
    
    [mReleaseView.mCloseBtn btnClick:^{
        MLLog(@"关闭");
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



#pragma mark----接单
- (void)getOrderAction:(mOrderButton *)sender{
    
    if (sender.tag == 20 ) {
        if (self.mLng ==nil || self.mLng.length == 0 || [self.mLng isEqualToString:@""]) {
            [self showErrorStatus:@"必须打开定位才能接单哦！"];
            return;
        }
        if (self.mLat ==nil || self.mLat.length == 0 || [self.mLat isEqualToString:@""]) {
            [self showErrorStatus:@"必须打开定位才能接单哦！"];
            return;
        }
        
        [self showWithStatus:@"正在操作..."];
        [[mUserInfo backNowUser] getPPTOrder:[mUserInfo backNowUser].mLegworkUserId andOrderCode:sender.mOrder.mOrderCode andOrderType:[NSString stringWithFormat:@"%d",mType] andLat:self.mLat andLng:self.mLng block:^(mBaseData *resb) {
            
            if (resb.mSucess) {
                
                [self showSuccessStatus:resb.mMessage];
                [self headerBeganRefresh];
            }else{
                
                [self showErrorStatus:resb.mMessage];
            }
            
        }];

    }
 
    
}

- (void)mCancelOrderAction:(mOrderButton *)sender{

    if (sender.tag == 10) {
        if (self.mLng ==nil || self.mLng.length == 0 || [self.mLng isEqualToString:@""]) {
            [self showErrorStatus:@"必须打开定位才能操作哦！"];
            return;
        }
        if (self.mLat ==nil || self.mLat.length == 0 || [self.mLat isEqualToString:@""]) {
            [self showErrorStatus:@"必须打开定位才能操作哦！"];
            return;
        }
        
        [self showWithStatus:@"正在操作..."];
        
        [[mUserInfo backNowUser] cancelOrder:[mUserInfo backNowUser].mUserId andOrderCode:sender.mOrder.mOrderCode andOrderType:mType andLat:self.mLat andLng:self.mLng block:^(mBaseData *resb) {
            
            if (resb.mSucess) {
                
                [self showSuccessStatus:resb.mMessage];
                [self headerBeganRefresh];
            }else{
                
                [self showErrorStatus:resb.mMessage];
            }
            
        }];

    }
    

    
}
#pragma mark----maplitdelegate
- (void)MMapreturnLatAndLng:(NSDictionary *)mCoordinate{
    
    MLLog(@"定位成功之后返回的东东：%@",mCoordinate);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 10) {
        if (buttonIndex == 1) {

            openPPTViewController *ppp = [[openPPTViewController alloc] initWithNibName:@"openPPTViewController" bundle:nil];
            [self pushViewController:ppp];
            
        }
    }else{
        if( buttonIndex == 1)
        {
            
    
            depositViewController *ddd = [[depositViewController alloc] initWithNibName:@"depositViewController" bundle:nil];
            [self pushViewController:ddd];
            
            
        }
    }
    
    
}

- (void)AlertViewShow:(NSString *)alerViewTitle alertViewMsg:(NSString *)msg alertViewCancelBtnTiele:(NSString *)cancelTitle alertTag:(int)tag{
    
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:alerViewTitle message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:@"确定", nil];
    al.delegate = self;
    al.tag = tag;
    [al show];
}
@end
