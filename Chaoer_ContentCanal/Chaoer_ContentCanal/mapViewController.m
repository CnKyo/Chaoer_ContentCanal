//
//  mapViewController.m
//  O2O_Communication_seller
//
//  Created by 密码为空！ on 15/9/24.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "mapViewController.h"
#import <QMapKit/QMapKit.h>

@interface mapViewController ()<QMapViewDelegate,CLLocationManagerDelegate>

@end

@implementation mapViewController
{
    QMapView *MapView;
    QPinAnnotationView * _annotationView;

}

- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    self.Title = self.mPageName = @"地图";
    [self initView];
    // Do any additional setup after loading the view.
    
}
- (void)initView{
    MapView = [[QMapView alloc] initWithFrame:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height)];
    MapView.delegate = self;
    [MapView setZoomLevel:15.5 animated:YES];
    CLLocationCoordinate2D to;
    to.latitude = 29.5544557997;
    to.longitude =  106.550986009;
    [MapView setCenterCoordinate:CLLocationCoordinate2DMake(to.latitude, to.longitude)];

    /* Red .*/
    QPointAnnotation *red = [[QPointAnnotation alloc] init];
    red.coordinate = CLLocationCoordinate2DMake(to.latitude, to.longitude);
    red.title    = @"Red";
    red.subtitle = [NSString stringWithFormat:@"{%f, %f}", red.coordinate.latitude, red.coordinate.longitude];
    [MapView addAnnotation:red];
    
    [self.view addSubview:MapView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
