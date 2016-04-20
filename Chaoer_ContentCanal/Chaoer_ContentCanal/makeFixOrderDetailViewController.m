//
//  makeFixOrderDetailViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/24.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "makeFixOrderDetailViewController.h"
#import "makeServiceDetailView.h"
@interface makeFixOrderDetailViewController ()

@end

@implementation makeFixOrderDetailViewController
{
    UIScrollView *mScrollerVie;
    
    UIScrollView    *mSubScrollerView;
    
    makeServiceDetailView   *mView;
    
    UILabel *mContent;

}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Title = self.mPageName = @"维修订单详情";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    [self initView];
}
- (void)initView{
    
    UIImageView *iii = [UIImageView new];
    iii.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64);
    iii.image = [UIImage imageNamed:@"mBaseBgkImg"];
    [self.view addSubview:iii];
    
    mScrollerVie = [UIScrollView new];
    mScrollerVie.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64);
    mScrollerVie.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mScrollerVie];
    
    
    mView = [makeServiceDetailView shareOrderDetailView];
    mView.frame = CGRectMake(0, 0, DEVICE_Width, 568);
    
    float x = 2.8;
    mView.mRaitView.numberOfStars = 5;
    mView.mRaitView.scorePercent = x/10;
    mView.mRaitView.allowIncompleteStar = YES;
    mView.mRaitView.hasAnimation = YES;
    
    
    mView.mBalance.image = [UIImage imageNamed:@"sex_selected"];
    
    [mView.mOkBtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
    [mScrollerVie addSubview:mView];
    
    mScrollerVie.contentSize = CGSizeMake(DEVICE_Width, 568);
    
    mSubScrollerView = [UIScrollView new];
    mSubScrollerView.frame = CGRectMake(0, 0, mView.mContentView.mwidth, mView.mContentView.mheight);
    mSubScrollerView.backgroundColor = [UIColor clearColor];
    [mView.mContentView addSubview:mSubScrollerView];
    
    NSString *sss = self.mFixOrder.mDescription;
    
    mContent = [UILabel new];
    mContent.frame = CGRectMake(5, 5, mView.mContentView.mwidth-10, 20);
    mContent.textAlignment = NSTextAlignmentLeft;
    mContent.font = [UIFont systemFontOfSize:12];
    mContent.textColor = [UIColor colorWithRed:0.39 green:0.39 blue:0.39 alpha:1.00];
    mContent.numberOfLines = 0;
    mContent.text = sss;
    
    CGFloat mh = [Util labelText:sss fontSize:12 labelWidth:mView.mContentView.mwidth-10];
    
    CGRect mRRR = mContent.frame;
    mRRR.size.height = mh+20;
    mContent.frame = mRRR;
    [mSubScrollerView addSubview:mContent];
    mSubScrollerView.contentSize = CGSizeMake(mView.mContentView.mwidth, mh+20);
    
    
    
}

- (void)loadData{

    [SVProgressHUD showWithStatus:@"正在加载中..." maskType:SVProgressHUDMaskTypeClear];
    NSLog(@"id是：%@",self.mFixOrder.mOrderID);
    [[mUserInfo backNowUser] getOrderDetail:self.mFixOrder.mOrderID block:^(mBaseData *resb, GFixOrder *mFixOrder) {
        
        if (resb.mSucess) {
            
            [SVProgressHUD showSuccessWithStatus:resb.mMessage];
            
            self.mFixOrder = mFixOrder;
            [self updatePage];
            
            
            
        }else{
        
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
            [self popViewController];
        }
        
    }];
}

- (void)updatePage{

    
    mView.mServiceName.text = self.mFixOrder.mMerchantName;
    mView.mServiceClass.text = self.mFixOrder.mClassificationName2;
    mView.mAddress.text = self.mFixOrder.mAddress;
    mView.mPhone.text = self.mFixOrder.tel;
    mView.mServiceTime.text = self.mFixOrder.serviceTime;
    mView.mServicePrice.text = [NSString stringWithFormat:@"%.2f元",self.mFixOrder.mOrderPrice];
    mContent.text = self.mFixOrder.mDescription;
    
    if (self.mFixOrder.mStatus == 5) {

        [mView.mOkBtn setTitle:@"完成服务" forState:0];
        mView.mOkBtn.backgroundColor = M_CO;
        
        mView.mOkBtn.userInteractionEnabled = YES;
    }else if (self.mFixOrder.mStatus == 6){

        [mView.mOkBtn setTitle:@"服务已完成" forState:0];
        mView.mOkBtn.backgroundColor = [UIColor lightGrayColor];
        
        mView.mOkBtn.userInteractionEnabled = NO;
    }else{
    
        [mView.mOkBtn setTitle:@"服务进行中" forState:0];
        mView.mOkBtn.backgroundColor = [UIColor lightGrayColor];
        
        mView.mOkBtn.userInteractionEnabled = NO;
    }
    
    
}

- (void)okAction:(UIButton *)sender{
    
//    self.tabBarController.selectedIndex = 1;
//    
//    [self popViewController:4];
    
    [SVProgressHUD showWithStatus:@"正在确认..." maskType:SVProgressHUDMaskTypeClear];
    
    [[mUserInfo backNowUser] finishFixOrder:self.mFixOrder.mOrderID andPayType:@"6" andRate:@"好评" block:^(mBaseData *resb) {
        if (resb.mSucess) {
            [SVProgressHUD showSuccessWithStatus:resb.mMessage];
            
            [self popViewController];
            
        }else{
        
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
        }
    }];
    
    
    
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
