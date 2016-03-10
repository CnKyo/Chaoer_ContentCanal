//
//  CZVC.m
//  O2O_Communication_seller
//
//  Created by zzl on 16/1/6.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "CZVC.h"
#import "PayView.h"
@interface CZVC ()

@end

@implementation CZVC

- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.mPageName = @"充值界面";
    self.Title = @"充值";
    
    self.mbt.layer.cornerRadius = 5;
    
}


- (IBAction)submit:(id)sender {
    
    if( _minputmoney.text.length == 0 )
    {
        [SVProgressHUD showErrorWithStatus:@"请先输入充值金额"];
        return;
    }
    
    PayView* vc = [[PayView alloc]initWithNibName:@"PayView" bundle:nil];
    vc.mPayMoney = [_minputmoney.text floatValue];
    [self pushViewController:vc];
    
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

@end
