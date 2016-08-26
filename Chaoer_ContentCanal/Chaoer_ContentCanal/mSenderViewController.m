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

#import "communityTableViewCell.h"

@interface mSenderViewController ()<UITableViewDelegate,UITableViewDataSource,AMapLocationManagerDelegate,WKSegmentControlDelagate,MMApBlockCoordinate,WKBanerSelectedDelegate,WKCellWithBanerAndBtnClickDelegate>

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

    [self hiddenReleaseView];
    [self headerBeganRefresh];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.Title = self.mPageName = @"跑跑腿";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.rightBtnTitle = @"筛选";
    self.hiddenRightBtn = YES;

    mType =0;
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
            [self showErrorStatus:resb.mMessage];
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
    
    nib = [UINib nibWithNibName:@"pptTableViewCell1" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];
    
     mSegmentView = [WKSegmentControl initWithSegmentControlFrame:CGRectMake(0, 165, DEVICE_Width, 40) andTitleWithBtn:@[@"全部",@"商品买送", @"事情办理",@"送东西"] andBackgroudColor:[UIColor whiteColor] andBtnSelectedColor:M_CO andBtnTitleColor:M_TextColor1 andUndeLineColor:M_CO andBtnTitleFont:[UIFont systemFontOfSize:15] andInterval:20 delegate:self andIsHiddenLine:NO andType:1];

}

- (void)headerBeganRefresh{
    [CurentLocation sharedManager].delegate = self;
    [[CurentLocation sharedManager] getUSerLocation];

    self.page = 1;
    
    [[mUserInfo backNowUser] getPPTNeaerbyOrder:mType andMlat:self.mLat andLng:self.mLng andPage:self.page andNum:20 block:^(mBaseData *resb, NSArray *mArr) {
        
        [self headerEndRefresh];
        [self.tempArray removeAllObjects];

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
    [self.mBanerArr removeAllObjects];
    [[mUserInfo backNowUser] getPPTbaner:^(mBaseData *resb, NSArray *mBaner) {
        [self headerEndRefresh];

        if (resb.mSucess) {
            
            [self.mBanerArr addObjectsFromArray:mBaner];
            [self.tableView reloadData];
            
        }else{
            [self addEmptyView:nil];
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
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return  1;
    }else{
        return self.tempArray.count;
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return nil;
    }else {
        return mSegmentView;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return 0;
    }else{
        return 40;
    }
    
    
}

- (void)WKDidSelectedIndex:(NSInteger)mIndex{
    MLLog(@"点击了%lu",(unsigned long)mIndex);
    
    mType = [[NSString stringWithFormat:@"%ld",(long)mIndex] intValue];
  
    [self headerBeganRefresh];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 250;
    }
    else{
        return 80;
    }
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId =nil;

    if (indexPath.section == 0) {
        reuseCellId =  @"cell2";
        pptTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.delegate = self;
        [cell setMBanerArr:self.mBanerArr];
        [cell setMMainBtnArr:@[@"跑腿榜",@"发布",@"我的跑单",@"我的"]];

        return cell;

    }else{
        reuseCellId = @"cell";
        pptTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.delegate = self;
        [cell setMOrder:self.tempArray[indexPath.row]];
        return cell;

    }
    
    
    
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
    if (mType == 0) {
        ppp.mType = mPPtOrder.mType;
    }else{
        ppp.mType = mType;
    }
    
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
        rrr.mLat = self.mLat;
        rrr.mLng = self.mLng;
        
        [self pushViewController:rrr];
    
    }];
    
    [mReleaseView.mDoBtn btnClick:^{
        MLLog(@"办事情");
        releasePPtViewController *rrr = [[releasePPtViewController alloc] initWithNibName:@"releasePPtViewController" bundle:nil];
        rrr.mType = 2;
        rrr.mSubType = 2;
        rrr.mLat = self.mLat;
        rrr.mLng = self.mLng;
        [self pushViewController:rrr];
    }];
    
    [mReleaseView.mSendBtn btnClick:^{
        
        MLLog(@"送东西");
        releasePPtViewController *rrr = [[releasePPtViewController alloc] initWithNibName:@"releasePPtViewController" bundle:nil];
        rrr.mType = 3;
        rrr.mSubType = 3;
        rrr.mLat = self.mLat;
        rrr.mLng = self.mLng;
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
            ddd.mType = 2;
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

#pragma mark----cellbaner的代理方法
- (void)cellDidSelectedBanerIndex:(NSInteger)mIndex{
    
    MBaner *banar = self.mBanerArr[mIndex];
    if (banar.mContentUrl.length != 0) {
        WebVC *w = [WebVC new];
        w.mName = banar.mName;
        w.mUrl = [NSString stringWithFormat:@"%@",banar.mContentUrl];
        [self pushViewController:w];
    }
    
    
}
#pragma mark----cell按钮代理方法
- (void)WKCellWithBanerClicked:(NSInteger)mIndex{
    MLLog(@"第%zd张图片\n",mIndex);
    
    MBaner *banar = self.mBanerArr[mIndex];
    if (banar.mContentUrl.length != 0) {
        WebVC *w = [WebVC new];
        w.mName = banar.mName;
        w.mUrl = [NSString stringWithFormat:@"%@",banar.mContentUrl];
        [self pushViewController:w];
    }
    
}

- (void)WKCellWithMainBtnClicked:(NSInteger)mIndex{
    switch (mIndex) {
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

- (void)WKCellWithDoneBtnAction:(NSIndexPath *)mIndexPath{
    
    GPPTOrder *mOrder = self.tempArray[mIndexPath.row];
    
    if (mOrder.mProcessStatus == 0) {
        if (self.mLng ==nil || self.mLng.length == 0 || [self.mLng isEqualToString:@""]) {
            [self showErrorStatus:@"必须打开定位才能操作哦！"];
            return;
        }
        if (self.mLat ==nil || self.mLat.length == 0 || [self.mLat isEqualToString:@""]) {
            [self showErrorStatus:@"必须打开定位才能操作哦！"];
            return;
        }
        
        [self showWithStatus:@"正在操作..."];
        
        [[mUserInfo backNowUser] cancelOrder:[mUserInfo backNowUser].mUserId andOrderCode:mOrder.mOrderCode andOrderType:mType andLat:self.mLat andLng:self.mLng block:^(mBaseData *resb) {
            
            if (resb.mSucess) {
                
                [self showSuccessStatus:resb.mMessage];
                [self headerBeganRefresh];
            }else{
                
                [self showErrorStatus:resb.mMessage];
            }
            
        }];
    }else{
        if ([mUserInfo backNowUser].mUserId == [mOrder.mUserId intValue]) {
            
            
            if (self.mLng ==nil || self.mLng.length == 0 || [self.mLng isEqualToString:@""]) {
                [self showErrorStatus:@"必须打开定位才能操作哦！"];
                return;
            }
            if (self.mLat ==nil || self.mLat.length == 0 || [self.mLat isEqualToString:@""]) {
                [self showErrorStatus:@"必须打开定位才能操作哦！"];
                return;
            }
            
            [self showWithStatus:@"正在操作..."];
            
            [[mUserInfo backNowUser] cancelOrder:[mUserInfo backNowUser].mUserId andOrderCode:mOrder.mOrderCode andOrderType:mType andLat:self.mLat andLng:self.mLng block:^(mBaseData *resb) {
                
                if (resb.mSucess) {
                    
                    [self showSuccessStatus:resb.mMessage];
                    [self headerBeganRefresh];
                }else{
                    
                    [self showErrorStatus:resb.mMessage];
                }
                
            }];
            
        }else{
            
            if (self.mLng ==nil || self.mLng.length == 0 || [self.mLng isEqualToString:@""]) {
                [self showErrorStatus:@"必须打开定位才能接单哦！"];
                return;
            }
            if (self.mLat ==nil || self.mLat.length == 0 || [self.mLat isEqualToString:@""]) {
                [self showErrorStatus:@"必须打开定位才能接单哦！"];
                return;
            }
            
            [self showWithStatus:@"正在操作..."];
            [[mUserInfo backNowUser] getPPTOrder:[mUserInfo backNowUser].mLegworkUserId andOrderCode:mOrder.mOrderCode andOrderType:[NSString stringWithFormat:@"%d",mOrder.mType] andLat:self.mLat andLng:self.mLng block:^(mBaseData *resb) {
                
                if (resb.mSucess) {
                    
                    [self showSuccessStatus:resb.mMessage];
                    [self headerBeganRefresh];
                }else{
                    
                    [self showErrorStatus:resb.mMessage];
                }
                
            }];
        
        }
        
    }

}
@end
