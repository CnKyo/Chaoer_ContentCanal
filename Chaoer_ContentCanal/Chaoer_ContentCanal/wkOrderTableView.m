//
//  wkOrderTableView.m
//  O2O_JiazhengSeller
//
//  Created by 密码为空！ on 15/8/7.
//  Copyright (c) 2015年 zongyoutec.com. All rights reserved.
//

#import "wkOrderTableView.h"
#import "wkOrderCell.h"
#import "wkOrderDetailViewController.h"
#import "tongjiViewController.h"
#import <MapKit/MapKit.h>

#import "mapViewController.h"
#import "orderDetail.h"
#import "AppDelegate.h"
#import "orderCellNew.h"

#import "NavC.h"

@interface wkOrderTableView ()<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate,UITabBarControllerDelegate>

@end

@implementation wkOrderTableView
{

    UITableView *mTableView;
    
    CGFloat cellH;

    SOrderPack  *Model;


}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if( [GInfo shareClient].mForceUpgrade )
    {
        [self doupdateAPP];
    }
    else
    {
        if( 1 == buttonIndex )
        {
            [self doupdateAPP];
        }
    }
}
-(void)doupdateAPP
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[GInfo shareClient].mAppDownUrl]];
}

-(void)checkAPPUpdate
{
    
    if( [GInfo shareClient].mAppDownUrl )
    {
        NSString* msg = [GInfo shareClient].mUpgradeInfo;
        if( [GInfo shareClient].mForceUpgrade )
        {
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"版本更新" message:msg delegate:self cancelButtonTitle:@"升级" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"版本更新" message:msg delegate:self cancelButtonTitle:@"暂不更新" otherButtonTitles:@"立即更新", nil];
            [alert show];
        }
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    
    
    
    if ([SUser isNeedLogin]) {
        [self gotoLoginVC];
        return;
    }
    else{
        [mTableView headerBeginRefreshing];
    }
    [super viewWillAppear:animated];




//    [mTableView headerBeginRefreshing];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.Title = self.mPageName = @"新订单";
    self.hiddenBackBtn = YES;
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initView];

    [[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(callBack:)name:@"notify"object:nil];
    
//    [self checkAPPUpdate];//修改登陆方式
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkAPPUpdate) name:@"checkappupdate" object:nil];
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)callBack:(NSNotification *)nif{
    NSDictionary *dic = nif.object;
 [((AppDelegate *)[UIApplication sharedApplication].delegate) dealPush:dic bopenwith:YES];
}
- (void)initView{

    
    mTableView = [UITableView new];
    
    self.tableView = mTableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1];
    
    UINib *nib = [UINib nibWithNibName:@"orderCellNew" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    self.haveFooter = YES;
    self.haveHeader = YES;
    [self.tableView headerBeginRefreshing];
    
    [self.view addSubview:mTableView];
    
    
    [mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(64);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.bottom.equalTo(self.view.bottom).offset(-50);
    }];
    
}

#pragma mark ----顶部刷新数据
- (void)headerBeganRefresh{
    
    self.page=1;
    
    [[SUser currentUser] getMyOrders:self.page status:2 date:nil keywords:nil block:^(SResBase *resb,SOrderPack *retobj) {
        
        [self headerEndRefresh];
        [self.tempArray removeAllObjects];
        if (resb.msuccess) {
            
            [self.tempArray addObjectsFromArray:retobj.mOrders];

            Model = retobj;
            
        }
        else{
            [SVProgressHUD showErrorWithStatus:resb.mmsg];
        }
        
        if( self.tempArray.count == 0 )
        {
            [self addEmptyViewWithImg:nil];
        }
        else
        {
            [self removeEmptyView];
        }
        [self.tableView reloadData];
    }];

    
}
#pragma mark----地步刷新
-(void)footetBeganRefresh
{
    self.page++;

     [[SUser currentUser] getMyOrders:self.page status:2 date:nil keywords:nil block:^(SResBase *resb, SOrderPack *retobj) {
        [self footetEndRefresh];
        if (resb.msuccess) {
            Model = retobj;

            [self.tempArray addObjectsFromArray:retobj.mOrders];
            
            
        }
        else{
            [SVProgressHUD showErrorWithStatus:resb.mmsg];
        }
        
        if( self.tempArray.count == 0 )
        {
            [self addEmptyViewWithImg:nil];
        }
        else
        {
            [self removeEmptyView];
        }
    }];
    
    [self.tableView reloadData];
    
}

#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 25)];
    headerView.backgroundColor = [UIColor colorWithRed:0.976 green:0.976 blue:0.976 alpha:1];
    UILabel *headerLb = [UILabel new];
    headerLb.font = [UIFont systemFontOfSize:16];
    headerLb.textColor = [UIColor blackColor];
    headerLb.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview: headerLb];
    [headerLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView.left).offset(15);
        make.right.equalTo(headerView).offset(-15);
        make.top.equalTo(headerView).offset(10);
        make.bottom.equalTo(headerView).offset(-15);
        
    }];
    [headerLb hyb_setAttributedText:[NSString stringWithFormat:@"共计<style color=#FF2D4B>%d</style><style color=#262626>单,金额¥</style><style color=#FF2D4B>%.2f</style><style color=#262626>元</style>",Model.mCount,Model.mAmount]];
    return headerView;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tempArray.count;
}
//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return UITableViewAutomaticDimension;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 141;

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    orderCellNew *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.model = self.tempArray[indexPath.row];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SOrder *sorder = self.tempArray[indexPath.row];
    orderDetail* vc = [[orderDetail alloc]initWithNibName:@"orderDetail" bundle:nil];
    vc.mtagOrder = sorder;
    [self pushViewController:vc];
}


#pragma mark----服务
- (void)serviceAction:(UIButton *)sender{
    wkOrderCell *cell = (wkOrderCell*)[sender findSuperViewWithClass:[wkOrderCell class]];
    NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
    cell.model = self.tempArray[indexpath.row];

    [cell.model startSrv:^(SResBase *resb) {
        if (resb.msuccess) {
            [SVProgressHUD showSuccessWithStatus:resb.mmsg];
            [self.tableView reloadData];
//            [self.tableView beginUpdates];
//            [self.tableView deleteRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
//            [self.tableView endUpdates];
        }else{
            [SVProgressHUD showErrorWithStatus:resb.mmsg];
        }
    }];
    
}
#pragma mark----导航按钮
- (void)navAction:(UIButton *)sender{
    wkOrderCell *cell = (wkOrderCell*)[sender findSuperViewWithClass:[wkOrderCell class]];
    NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
    cell.model = self.tempArray[indexpath.row];
    //跳转到高德地图
    NSString* ampurl = [NSString stringWithFormat:@"iosamap://navi?sourceApplication=testapp&backScheme=zyseller&lat=%.7f&lon=%.7f&dev=0&style=0",cell.model.mLat,cell.model.mLongit];
    
    if( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:ampurl]] )
    {//
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ampurl]];
    }
    else
    {//ioS map
        
        CLLocationCoordinate2D to;
        to.latitude =  cell.model.mLat;
        to.longitude =  cell.model.mLongit;
        
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:to addressDictionary:nil] ];
        toLocation.name = cell.model.mAddress;
        [MKMapItem openMapsWithItems:[NSArray arrayWithObjects:currentLocation, toLocation, nil]
                       launchOptions:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeDriving, [NSNumber numberWithBool:YES], nil]
                                                                 forKeys:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeKey, MKLaunchOptionsShowsTrafficKey, nil]]];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)rightBtnTouched:(id)sender{
//    mapViewController *m = [mapViewController new];
//    [self pushViewController:m];
    
    CLLocationCoordinate2D to;
    to.latitude = 29.5544557997;
    to.longitude =  106.550986009;

//    //跳转到高德地图
//    NSString* ampurl = [NSString stringWithFormat:@"iosamap://navi?sourceApplication=testapp&backScheme=zyseller&lat=%.7f&lon=%.7f&dev=0&style=0",to.latitude,to.longitude];
//    
//    if( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:ampurl]] )
//    {//
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ampurl]];
//    }
//    else
//    {//ioS map
    
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:to addressDictionary:nil] ];
        toLocation.name = @"重庆市渝中区两路口";
        [MKMapItem openMapsWithItems:[NSArray arrayWithObjects:currentLocation, toLocation, nil]
                       launchOptions:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeDriving, [NSNumber numberWithBool:YES], nil]
                                                                 forKeys:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeKey, MKLaunchOptionsShowsTrafficKey, nil]]];
//    }

}
@end
