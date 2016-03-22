//
//  ShopVC.m
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/10/29.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "ShopVC.h"
#import "BillVC.h"
#import "ServiceManageVC.h"
#import "WebVC.h"
#import "APIClient.h"

@interface ShopVC (){

//    SShop *shop;
}

@end

@implementation ShopVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self getData];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.leftBtn.hidden = YES;
    self.Title = self.mPageName = @"店铺";
    
}

- (void)getData{

    [SVProgressHUD showWithStatus:@"加载中.." maskType:SVProgressHUDMaskTypeClear];
    
    
//    [SShop getShopInfo:^(SResBase *info, SShop *retobj) {
//        
//        if (info.msuccess) {
//            [SVProgressHUD dismiss];
//            
//            shop = retobj;
//            
//            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//            [defaults setObject:retobj.mName forKey:@"shopname"];
//            [defaults synchronize];
//            
//            self.mShopName = retobj.mName;
//            _mYue.text = [NSString stringWithFormat:@"¥%.2f",retobj.mBalance];
//            _mNum.text = [NSString stringWithFormat:@"%d",retobj.mOrderNum];
//            _mPrice.text = [NSString stringWithFormat:@"¥%.2f",retobj.mTurnover];
//            
//            
//        }else{
//            
//            [SVProgressHUD showErrorWithStatus:info.mmsg];
//        }
//    }];
    

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

- (IBAction)goJYClick:(id)sender {
    
    WebVC *w = [WebVC new];
    w.mName = @"经营分析";
//    w.mUrl = [NSString stringWithFormat:@"%@/order.statistics?token=%@&userId=%d",[APIClient APiWithUrl:@"api" andOtherUrl:nil],[APIClient getmToken],[SUser currentUser].mUserId];
    MLLog(@"经营分析：%@",w.mUrl);
    [self pushViewController:w];
}

- (IBAction)goBillClick:(id)sender {
    
    BillVC *bill = [[BillVC alloc] init];
    bill.itblock = ^(BOOL flag){
    
        if (flag) {
            [self getData];
        }
    };
//    bill.mShop = shop;
    [self pushViewController:bill];
}

- (IBAction)goDpdzClick:(id)sender {
    
    [SVProgressHUD showErrorWithStatus:@"暂未开通"];
}

- (IBAction)MenuClick:(id)sender {
    
    UIButton *button = sender;
    
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ServiceManageVC *viewController = [storyboard instantiateViewControllerWithIdentifier:@"ServiceManageVC"];
    if (button.tag == 10)
    {//商品管理
        viewController.type = 1;
    }else
    {//服务管理
        viewController.type = 2;
    }
    [self pushViewController:viewController];
}
@end
