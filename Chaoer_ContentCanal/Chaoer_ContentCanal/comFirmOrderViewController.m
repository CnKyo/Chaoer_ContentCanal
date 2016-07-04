//
//  comFirmOrderViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/28.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "comFirmOrderViewController.h"
#import "comfirmOrderView.h"

#import "goPayViewController.h"

#import "noteOrmessageViewController.h"

#import "billViewController.h"
@interface comFirmOrderViewController ()

@end

@implementation comFirmOrderViewController
{


    UIScrollView *mScrollerView;
    
    comfirmOrderView *mMainView;
    comfirmOrderView *mFooterView;
    
}
- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    
    [super viewDidLoad];
    
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.Title = self.mPageName = @"确认订单";

    mScrollerView = [UIScrollView new];
    
    mScrollerView.backgroundColor = [UIColor colorWithRed:0.95 green:0.94 blue:0.91 alpha:1.00];
    [self.view addSubview:mScrollerView];
    
    [mScrollerView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(@0);
        make.bottom.equalTo(self.view).offset(@50);
        make.top.equalTo(self.view).offset(@64);
    }];
    
    [self initView];
    
}


- (void)initView{
    
    mMainView = [comfirmOrderView shareView];
    
    [mMainView.mSelecteLabel addTarget:self action:@selector(mLabelAction:) forControlEvents:UIControlEventTouchUpInside];
    [mMainView.mReciptBtn addTarget:self action:@selector(mRecipAction:) forControlEvents:UIControlEventTouchUpInside];
    [mScrollerView addSubview:mMainView];
    [mMainView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(mScrollerView).offset(@0);
        make.height.offset(@600);
        make.width.offset(DEVICE_Width);
    }];
    
    mFooterView = [comfirmOrderView sharePayView];
    [mFooterView.mGoPayBtn addTarget:self action:@selector(mGoPayAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mFooterView];
    
    [mFooterView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).offset(@0);
        make.height.offset(@50);
    }];
    
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 600);
    
}

- (void)mRecipAction:(UIButton *)sender{
    billViewController *bbb = [[billViewController alloc] initWithNibName:@"billViewController" bundle:nil];
    [self pushViewController:bbb];

}
- (void)mLabelAction:(UIButton *)sender{
    
    noteOrmessageViewController *nnn = [[noteOrmessageViewController alloc] initWithNibName:@"noteOrmessageViewController" bundle:nil];
    [self pushViewController:nnn];
}
- (void)mGoPayAction:(UIButton *)sender{
    goPayViewController *goPay = [[goPayViewController alloc] initWithNibName:@"goPayViewController" bundle:nil];
    [self pushViewController:goPay];
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
