//
//  MyViewController.m
//  O2O_XiCheSeller
//
//  Created by 密码为空！ on 15/6/18.
//  Copyright (c) 2015年 zongyoutec.com. All rights reserved.
//

#import "MyViewController.h"

#import "mPersonView.h"


#import "mCodeNameViewController.h"

#import "activityCenterViewController.h"
#import "myRedBagViewController.h"
#import "myOrderViewController.h"
#import "mSetupViewController.h"
#import "RSKImageCropper.h"
#import "HTTPrequest.h"
#import "popMessageView.h"
@interface MyViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,RSKImageCropViewControllerDelegate,RSKImageCropViewControllerDataSource,UITextFieldDelegate>


@end

@implementation MyViewController{

    UIScrollView *mScrollerView;
    
    mPersonView *mHeaderView;
    
    mPersonView *mRightView;
    
    UIImage *tempImage;
    
    popMessageView *mMessageView;
    
    
    UIView *vvv;

}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    
    
    mMessageView.mFixBtn.selected = NO;
    mMessageView.mCommunityBtn.selected = NO;
    mMessageView.mStaffBtn.selected = NO;
    mRightView.mMessageBtn.selected = NO;
//    if ([mUserInfo isNeedLogin]) {
//        [self gotoLoginVC];
//    }
    [self loadData];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Title = self.mPageName = @"个人中心";
    self.hiddenBackBtn = YES;
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    self.navBar.hidden = NO;
    

    
    [self loadRightView];
    [self initView];
    [self initMessageView];
}
#pragma mark----初始化右边的按钮
- (void)loadRightView{

    mRightView = [mPersonView shareRightView];
    mRightView.frame = CGRectMake(DEVICE_Width-80, 16, 80, 50);
    
    [mRightView.mMessageBtn addTarget:self action:@selector(mRightAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:mRightView];
    
}
#pragma mark----消息按钮
- (void)mRightAction:(UIButton *)sender{
    NSLog(@"消息");
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self showMessageView];
    }else{
        [self hiddenMessageView];
    }
    
    
}

- (void)initMessageView{
    vvv = [UIView new];
    vvv.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height);
    vvv.backgroundColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:0.3];
    vvv.alpha = 0;
    [self.view addSubview:vvv];
    
    mMessageView = [popMessageView shareView];
    mMessageView.frame = CGRectMake(DEVICE_Width, 64, 110, 150);
    [mMessageView.mStaffBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [mMessageView.mCommunityBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [mMessageView.mFixBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:mMessageView];
    
    UITapGestureRecognizer *ttt = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tttAction)];
    [self.view addGestureRecognizer:ttt];
    
}
- (void)tttAction{
    [self hiddenMessageView];

}
- (void)btnAction:(UIButton *)sender{
    sender.selected = !sender.selected;

    switch (sender.tag) {
        case 1:{

        }
            break;
        case 2:{
            
        }
            break;
        case 3:{
            
        }
            break;
        default:
            break;
    }
    
    
}
- (void)showMessageView{
    [UIView animateWithDuration:0.3 animations:^{
        vvv.alpha = 1;
        mMessageView.alpha = 1;
        CGRect mRRR = mMessageView.frame;
        mRRR.origin.x = DEVICE_Width-110;
        mRRR.size.height = 150;
        mMessageView.frame = mRRR;
    }];
}
- (void)hiddenMessageView{
    mRightView.mMessageBtn.selected = NO;
    [UIView animateWithDuration:0.3 animations:^{
        vvv.alpha = 0;
        mMessageView.alpha = 0;
        CGRect mRRR = mMessageView.frame;
        mRRR.origin.x = DEVICE_Width;
        mRRR.size.height = 0;
        mMessageView.frame = mRRR;
    }];
}

#pragma mark----加载数据
- (void)loadData{
    NSString *url = [NSString stringWithFormat:@"%@%@",[HTTPrequest returnNowURL],[mUserInfo backNowUser].mUserImgUrl];
    
    
    [mHeaderView.mHeaderBtn sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    mHeaderView.mName.text = [mUserInfo backNowUser].mNickName;
    mHeaderView.mJob.text = [mUserInfo backNowUser].mIdentity;
    mHeaderView.mLevel.text = [NSString stringWithFormat:@"我的等级:%d级",[mUserInfo backNowUser].mGrade];
    mHeaderView.mScore.text = [NSString stringWithFormat:@"我的积分:%d",[mUserInfo backNowUser].mCredit];

}

#pragma mark----构造主页面
- (void)initView{

    mScrollerView = [UIScrollView new];
    mScrollerView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-114);
    mScrollerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mScrollerView];

    mHeaderView = [mPersonView shareView];
    mHeaderView.frame = CGRectMake(0, 0, DEVICE_Width, 250);
 
    [mScrollerView addSubview:mHeaderView];
    
    
    float x = 0;
    float y = mHeaderView.mbottom+10;
    
    float btnWidth = DEVICE_Width/3;
    
    UIImage *imag1 = [UIImage imageNamed:@"code"];
    UIImage *imag2 = [UIImage imageNamed:@"activity"];
    
    UIImage *imag3 = [UIImage imageNamed:@"redbag"];
    
    UIImage *imag4 = [UIImage imageNamed:@"rent"];
    
    UIImage *imag5 = [UIImage imageNamed:@"order-2"];
    
    UIImage *imag6 = [UIImage imageNamed:@"setup-2"];
    
    NSArray *imgArr = @[imag1,imag2,imag3,imag4,imag5,imag6];
    
    NSArray *mRR = @[@"实名认证",@"活动中心",@"我的红包",@"出租房",@"我的订单",@"设 置 "];
    
    for (int i = 0; i<mRR.count; i++) {
        
        mGeneralSubView *mSubView = [mGeneralSubView shareView];
        mSubView.frame = CGRectMake(x, y, btnWidth, 110);
        mSubView.mImg.image =imgArr[i];
        [mSubView.mName setText:mRR[i]];
        [mSubView.mBtn addTarget:self action:@selector(mCusBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        mSubView.mBtn.tag = i;
        [mScrollerView addSubview:mSubView];
        
        
        x += btnWidth;
        
        if (x >= DEVICE_Width) {
            x = 0;
            y += 110;
        }
        
        
    }
    
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, y);
    
}
#pragma mark----按钮点击事件
- (void)mCusBtnAction:(UIButton *)sender{
    NSLog(@"第%ld个",(long)sender.tag);
    
    switch (sender.tag) {
        case 0:
        {
            mCodeNameViewController *mmm = [[mCodeNameViewController alloc] initWithNibName:@"mCodeNameViewController" bundle:nil];
            [self pushViewController:mmm];
        
        }
            break;
        case 1:
        {
            activityCenterViewController *mmm = [[activityCenterViewController alloc] initWithNibName:@"activityCenterViewController" bundle:nil];
            [self pushViewController:mmm];
            
        }
            break;
        case 2:
        {
            myRedBagViewController *mmm = [[myRedBagViewController alloc] initWithNibName:@"myRedBagViewController" bundle:nil];
            [self pushViewController:mmm];
            
        }
            break;
            
        case 4:
        {
            myOrderViewController *mmm = [[myOrderViewController alloc] initWithNibName:@"myOrderViewController" bundle:nil];
            [self pushViewController:mmm];
            
        }
            break;
        case 5:
        {
            mSetupViewController *mmm = [[mSetupViewController alloc] initWithNibName:@"mSetupViewController" bundle:nil];
            [self pushViewController:mmm];
            
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

@end
