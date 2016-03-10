//
//  wkOrderDetailViewController.m
//  O2O_JiazhengSeller
//
//  Created by 密码为空！ on 15/8/7.
//  Copyright (c) 2015年 zongyoutec.com. All rights reserved.
//

#import "wkOrderDetailViewController.h"
#import "wkOrderDetail.h"
#import <MapKit/MapKit.h>
#import <QMapKit/QMapKit.h>

@interface wkOrderDetailViewController ()<UITextFieldDelegate,QMapViewDelegate,CLLocationManagerDelegate>

@end

@implementation wkOrderDetailViewController
{
    UIScrollView *sss;

    wkOrderDetail *mOrderDetail;
    wkOrderDetail   *mBottomMapView;
    UIView *bottomView;
    
    /**
     *  底部按钮
     */
    UIView *mBottomBtnView;
    
    CGFloat wkAddressH;
    CGFloat wkContenH;
    
    QMapView *QQmapView;
    QPinAnnotationView * _annotationView;

    CLLocationManager      *_locationmanager;
    
    CLLocationCoordinate2D lcoord2d;
    

}
@synthesize mGoods,mType;
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    [self getData];
}
- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    self.hiddenlll = YES;

    self.mPageName = self.Title = @"订单详情";
    sss = [UIScrollView new];
    sss.backgroundColor = [UIColor clearColor];
    [self.view addSubview:sss];
    
    [sss makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(64);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.bottom.equalTo(self.view.bottom).with.offset(-65);
    }];
    [self getData];
    

}
- (void)getData{
    
    [SVProgressHUD showWithStatus:@"获取中" maskType:SVProgressHUDMaskTypeClear];

    if ( _wkorder ) {
        
        [_wkorder getDetail:^(SResBase *resb) {
            if (resb.msuccess) {
                [SVProgressHUD dismiss];

                [SVProgressHUD showSuccessWithStatus:resb.mmsg];
                [self initView];
                
            }
            else{
                [SVProgressHUD showErrorWithStatus:resb.mmsg];
                [self addKEmptyView:nil];
            }
        }];
        
    }
    else{
        SOrder *sorder = [SOrder new];
        
        sorder.mId = _wkArgs;
        [sorder getDetail:^(SResBase *resb) {
            if (resb.msuccess) {
                [SVProgressHUD dismiss];

                [SVProgressHUD showSuccessWithStatus:resb.mmsg];
                _wkorder = sorder;
                [self initView];
                
            }
            else{
                [SVProgressHUD showErrorWithStatus:resb.mmsg];
                [self addKEmptyView:nil];
            }
        }];
    }
    
}
- (void)initView{
    
    [mOrderDetail removeFromSuperview];
    [mBottomBtnView removeFromSuperview];
    
    [self initBottomBtn];
    
    mOrderDetail = [wkOrderDetail shareOrderDetail];
    [sss addSubview:mOrderDetail];
    
    [self initMapView];
    
    NSString *str = _wkorder.mAddress;
       /* zw...
    mOrderDetail.wkAddress.text = str;
    mOrderDetail.wkOrderid.text = _wkorder.mSn;
    [mOrderDetail.wkImg sd_setImageWithURL:[NSURL URLWithString:_wkorder.mServiceImg] placeholderImage:[UIImage imageNamed:@"img_def"]];
    mOrderDetail.wkOrderStatus.text = _wkorder.mOrderStatusStr;
    mOrderDetail.wkServiceName.text = [NSString stringWithFormat:@"服务名称：%@",_wkorder.mServiceName];
    mOrderDetail.wkPrice.text = [NSString stringWithFormat:@"¥%.2f元",_wkorder.mPayMoney];
    mOrderDetail.mServiceTime.text = _wkorder.mApptime;
    mOrderDetail.wkShichang.text = [Util mDuration:_wkorder.mDuration];
    mOrderDetail.wkUserName.text = _wkorder.mUserName;
    
    mOrderDetail.wkPhone.attributedText = [Util labelWithUnderline:_wkorder.mPhoneNum];
    
    [mOrderDetail.wkConnectBtn addTarget:self action:@selector(connectAction:) forControlEvents:UIControlEventTouchUpInside];
    */
    wkAddressH = [Util labelText:str fontSize:15 labelWidth:mOrderDetail.wkAddress.mwidth];
    wkContenH = 313+wkAddressH-18;
    if (wkContenH <= 313) {
        wkContenH = 313;
    }
    [mOrderDetail makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sss).with.offset(0);
        make.right.equalTo(sss).with.offset(0);
        make.top.equalTo(sss).with.offset(0);
        make.bottom.equalTo(bottomView.top).with.offset(0);
        make.width.equalTo(DEVICE_Width);
        make.height.offset(wkContenH);
        
    }];
    


    
}
- (void)initMapView{
    bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [sss addSubview:bottomView];
   
    [bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sss).with.offset(0);
        make.right.equalTo(sss).with.offset(0);
        make.top.equalTo(mOrderDetail.bottom).with.offset(0);
        make.bottom.equalTo(sss).with.offset(0);
        make.width.equalTo(DEVICE_Width);
        make.height.offset(@270);
    }];
    
    mBottomMapView = [wkOrderDetail shareMapView];

    [mBottomMapView.mapNavBtn addTarget:self action:@selector(navAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:mBottomMapView];

    [mBottomMapView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).with.offset(0);
        make.right.equalTo(bottomView).with.offset(0);
        make.top.equalTo(bottomView).with.offset(0);
        make.bottom.equalTo(bottomView).with.offset(0);

    }];
    
    QQmapView  = [[QMapView alloc] initWithFrame:mBottomMapView.mQQmapView.bounds];
    QQmapView.delegate = self;
    [QQmapView setZoomLevel:15.5 animated:YES];

    CLLocationCoordinate2D to;
    to.latitude =  _wkorder.mLat;
    to.longitude =  _wkorder.mLongit;
    [QQmapView setCenterCoordinate:CLLocationCoordinate2DMake(to.latitude, to.longitude)];
    /* Red .*/
    QPointAnnotation *red = [[QPointAnnotation alloc] init];
    red.coordinate = CLLocationCoordinate2DMake(to.latitude, to.longitude);
    red.title    = @"Red";
    red.subtitle = [NSString stringWithFormat:@"{%f, %f}", red.coordinate.latitude, red.coordinate.longitude];
    [QQmapView addAnnotation:red];

    [mBottomMapView.mQQmapView addSubview:QQmapView];
 
    
}
#pragma mark----底部按钮
- (void)initBottomBtn{

    mBottomBtnView = [UIView new];
//    mBottomView.hidden = YES;
    mBottomBtnView.frame = CGRectMake(0, self.view.frame.size.height-66, DEVICE_Width, 65);
    mBottomBtnView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mBottomBtnView];
    
    UIButton *btn = [UIButton new];
    
    btn.frame = CGRectMake(10, 10, DEVICE_Width-20, 45);
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 4;
    btn.backgroundColor = M_CO;
    /* zw
    if ( _wkorder.misCanFinishService ) {
        btn.userInteractionEnabled = YES;
        [btn addTarget:self action:@selector(reFuseAndAccept:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:[UIImage imageNamed:@"3-1"] forState:0];

    }else{
        btn.userInteractionEnabled = NO;
        [btn setBackgroundImage:[UIImage imageNamed:@"3"] forState:0];
    }
     */
    [btn setTitle:@"服务完成" forState:0];
    [mBottomBtnView addSubview:btn];
}
#pragma mark----按钮点击事件
- (void)reFuseAndAccept:(UIButton *)sender{
    MLLog(@"开始服务");
    [_wkorder startSrv:^(SResBase *resb) {
        if (resb.msuccess) {
            [SVProgressHUD showSuccessWithStatus:resb.mmsg];
            [self getData];
        }else{
            [SVProgressHUD showErrorWithStatus:resb.mmsg];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark----拨打号码
- (void)connectAction:(UIButton *)sender{
    MLLog(@"拨打");
    /*zw
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",_wkorder.mPhoneNum];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
     */
}

#pragma mark----导航
- (void)navAction:(UIButton *)sender{
    //跳转到高德地图
    NSString* ampurl = [NSString stringWithFormat:@"iosamap://navi?sourceApplication=testapp&backScheme=%@&lat=%.7f&lon=%.7f&dev=0&style=0",[Util getAppSchemes],_wkorder.mLat,_wkorder.mLongit];
    
    if( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:ampurl]] )
    {//
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ampurl]];
    }
    else
    {//ioS map
        
        CLLocationCoordinate2D to;
        to.latitude =  _wkorder.mLat;
        to.longitude =  _wkorder.mLongit;
        
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:to addressDictionary:nil] ];
        toLocation.name = _wkorder.mAddress;
        [MKMapItem openMapsWithItems:[NSArray arrayWithObjects:currentLocation, toLocation, nil]
                       launchOptions:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeDriving, [NSNumber numberWithBool:YES], nil]
                                                                 forKeys:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeKey, MKLaunchOptionsShowsTrafficKey, nil]]];
    }

}

#pragma mark QMapViewDelegate
-(QAnnotationView *)mapView:(QMapView *)mapView viewForAnnotation:(id<QAnnotation>)annotation
{
    _annotationView = (QPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"ID"];
    if(!_annotationView)
    {
        _annotationView = [[QPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"ID"];
    }
    //实现自定义标注
    _annotationView.image = [UIImage imageNamed:@"map_annotation"];
    
    _annotationView.canShowCallout = YES;
    
    return _annotationView;
}
- (void)mapView:(QMapView *)mapView annotationView:(QAnnotationView *)view didChangeDragState:(QAnnotationViewDragState)newState
   fromOldState:(QAnnotationViewDragState)oldState
{
    if( QAnnotationViewDragStateEnding == newState )
    {//拖动了
    }
}

- (void)mapView:(QMapView *)mapView annotationView:(QAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
}


-(void)mapView:(QMapView *)mapView didUpdateUserLocation:(QUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    mapView.showsUserLocation = NO;
    
    //刷新位置
    CLLocationCoordinate2D to;
    to.latitude =  _wkorder.mLat;
    to.longitude =  _wkorder.mLongit;
    
    if( _wkorder.mLat != 0.0f && _wkorder.mLongit != 0.0f)
        [mapView setCenterCoordinate:to zoomLevel:15.0f animated:YES];
    else
        [mapView setCenterCoordinate:userLocation.location.coordinate zoomLevel:15.0f animated:YES];
    
    
    [mapView setCenterCoordinate:CLLocationCoordinate2DMake(to.latitude, to.longitude)];
    
}
-(void)mapView:(QMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    if( error.code == 1 )
    {
        [SVProgressHUD showErrorWithStatus:@"定位权限失败"];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"定位失败:%@",error.description]];
    }
}

- (QOverlayView *)mapView:(QMapView *)mapView viewForOverlay:(id <QOverlay>)overlay
{
    if ([overlay isKindOfClass:[QPolygon class]])
    {
        QPolygonView *polygonView = [[QPolygonView alloc] initWithPolygon:overlay];
        polygonView.lineWidth   = 1;
        polygonView.strokeColor = [UIColor colorWithRed:0.949 green:0.373 blue:0.565 alpha:1.000];
        polygonView.fillColor   = [UIColor colorWithRed:0.949 green:0.373 blue:0.565 alpha:0.630];
        
        
        return polygonView;
    }
    return nil;
}

@end
