//
//  makeServiceViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/23.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "makeServiceViewController.h"
#import "serviceDetailView.h"
#import "makeFixOrderDetailViewController.h"

@interface makeServiceViewController ()

@end

@implementation makeServiceViewController
{
    UIScrollView *mScrollerVie;
    
    UIScrollView    *mSubScrollerView;
    
    serviceDetailView   *mView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.Title = self.mPageName = @"确认订单";
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
    
    
    mView = [serviceDetailView shareOrderView];
    mView.frame = CGRectMake(0, 0, DEVICE_Width, 568);
    
    mView.mServiceName.text = self.mOrder.mMerchantName;
    mView.mClass.text = self.mOrder.mClassificationName;
    mView.mAddress.text = self.mOrder.mBuyerAddress;
    mView.mPhone.text = self.mOrder.mPhone;
    mView.mServiceTime.text = self.mOrder.mAppointmentTime;
    mView.mMoney.text = @"保证金";
    
    float x = 2.8;
    mView.mRaitView.numberOfStars = 5;
    mView.mRaitView.scorePercent = x/10;
    mView.mRaitView.allowIncompleteStar = YES;
    mView.mRaitView.hasAnimation = YES;
    [mView.mOkBtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
    [mScrollerVie addSubview:mView];
    
    mScrollerVie.contentSize = CGSizeMake(DEVICE_Width, 568);
    
    mSubScrollerView = [UIScrollView new];
    mSubScrollerView.frame = CGRectMake(0, 0, mView.mContentView.mwidth, mView.mContentView.mheight);
    mSubScrollerView.backgroundColor = [UIColor clearColor];
    [mView.mContentView addSubview:mSubScrollerView];
    
    NSString *sss = self.mOrder.mNote;
    
    UILabel *mContent = [UILabel new];
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

- (void)okAction:(UIButton *)sender{

    [SVProgressHUD showWithStatus:@"正在提交..." maskType:SVProgressHUDMaskTypeClear];

    
    [mUserInfo getOrderPaySuccess:self.mId andOrderId:self.mOrderId block:^(mBaseData *resb) {
        if (resb.mSucess) {
            [SVProgressHUD showSuccessWithStatus:resb.mMessage];

            [self dismissViewController_3];
            
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
- (void)leftBtnTouched:(id)sender{

    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
