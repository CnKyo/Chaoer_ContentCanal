//
//  mScanViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/22.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mScanViewController.h"
#import "LBXScanView.h"
#import "LBXScanResult.h"
#import "LBXScanWrapper.h"
@interface mScanViewController ()

@end

@implementation mScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor blackColor];
    self.navigationItem.title=@"二维码";
    
    //设置扫描样式  还有其它样式可以见github
    self.style=[self qqLBXScanViewStyle];
    
    
    //设置右边
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,70,30)];
    [rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [rightButton setTitle:@"相册" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(myAction)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;

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
#pragma mark

//设置样式
- (LBXScanViewStyle *)qqLBXScanViewStyle
{
    //设置扫码区域参数设置
    
    //创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;
    
    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    
    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;
    
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    
    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    
    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"qrcode_scan_light_green"];
    
    return style;
}

//获得扫码的结果
- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{
    
    if (array.count < 1)
    {
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //经测试，可以同时识别2个二维码，不能同时识别二维码和条形码
    for (LBXScanResult *result in array) {
        
        NSLog(@"scanResult:%@",result.strScanned);
    }
    
    LBXScanResult *scanResult = array[0];
    
    NSString*strResult = scanResult.strScanned;
    
    self.scanImage = scanResult.imgScanned;
    
    if (!strResult) {
        
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //震动提醒
    [LBXScanWrapper systemVibrate];
    //声音提醒
    [LBXScanWrapper systemSound];
    
    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"扫码的内容为:%@",strResult]];
    [self reStartDevice];

//    [MBProgressHUD showSuccess:[NSString stringWithFormat:@"扫码的内容为:%@",strResult] ToView:nil];
}

- (void)popAlertMsgWithScanResult:(NSString*)strResult
{
    if (!strResult) {
        strResult = @"识别失败";
    }
    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"扫码的内容为:%@",strResult]];

//    [MBProgressHUD showAutoMessage:[NSString stringWithFormat:@"扫码的内容为:%@",strResult]];
    
    //若想续约扫可以调用 //点击完，继续扫码
    [self reStartDevice];
}


-(void)myAction
{
    if ([LBXScanWrapper isGetPhotoPermission])
        [self openLocalPhoto];
    else
    {
        [self showError:@"      请到设置->隐私中开启本程序相册权限     "];
    }
}

@end
