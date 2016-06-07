//
//  payFeeViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/18.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "payFeeViewController.h"
#import "utilityView.h"
#import "canPayView.h"

#import "mGoPayViewController.h"

@interface payFeeViewController ()

@end

@implementation payFeeViewController
{
    canPayView *mHeaderView;

    utilityView *mView;
    
    UIScrollView *mScrollerView;

    int mType;
    
    NSString *mProvinceID;
    NSString *mCityID;
    NSString *mPayId;
    NSString *mUnitId;
    NSString *mProductId;

    
#pragma  mark----传递的参数
    NSString *mTT;
    NSString *mPayTypeStr;
    
    
    NSMutableDictionary *mParas;
    
    BOOL mIsChoice;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /**
     IQKeyboardManager为自定义收起键盘
     **/
    [[IQKeyboardManager sharedManager] setEnable:YES];///视图开始加载键盘位置开启调整
    [[IQKeyboardManager sharedManager]setEnableAutoToolbar:YES];///是否启用自定义工具栏
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;///启用手势
    //    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];///视图消失键盘位置取消调整
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];///关闭自定义工具栏
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.Title = self.mPageName = @"水电气费";
    self.hiddenTabBar = YES;
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    
    mType = 1;
    
    mParas = [NSMutableDictionary new];
    
    [self initView];
    
}
- (void)initView{
    
    
    mScrollerView = [UIScrollView new];
    mScrollerView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-50);
    mScrollerView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.97 alpha:1.00];
    [self.view addSubview:mScrollerView];
    
    mHeaderView = [canPayView shareHeaderView];
    mHeaderView.frame = CGRectMake(0, 0, DEVICE_Width, 50);
    [mHeaderView.mChongzhi addTarget:self action:@selector(mTopupAction:) forControlEvents:UIControlEventTouchUpInside];
    mHeaderView.mYue.text = [NSString stringWithFormat:@"账户余额：%.2f元",[mUserInfo backNowUser].mMoney];
    
    [mScrollerView addSubview:mHeaderView];

    
    mView = [utilityView shareView];
    mView.frame = CGRectMake(0, 50, mScrollerView.mwidth, 568);
    
    [mView.mProvinceBtn addTarget:self action:@selector(mProvinceAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mCityBtn addTarget:self action:@selector(mCityAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mPayType addTarget:self action:@selector(mPayTypeAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mUnitBtn addTarget:self action:@selector(mUnitAction:) forControlEvents:UIControlEventTouchUpInside];

    
    
    [mView.mInquireBtn addTarget:self action:@selector(mPayFeeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [mScrollerView addSubview:mView];
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 618);
    
    
    
}

/**
 *  充值
 *
 *  @param sender
 */
- (void)mTopupAction:(UIButton *)sender{
    MLLog(@"充值");
    mBalanceViewController *bbb = [[mBalanceViewController alloc] initWithNibName:@"mBalanceViewController" bundle:nil];
    [self pushViewController:bbb];
}

- (void)loadData{
    [SVProgressHUD showWithStatus:@"正在查询..." maskType:SVProgressHUDMaskTypeClear];
    if (mType == 1) {
        
        NSMutableDictionary *para = [NSMutableDictionary new];
        [para setObject:JH_KEY forKey:@"key"];
        
        [[mUserInfo backNowUser] FindPublic:mType andPara:para block:^(mJHBaseData *resb, NSArray *mArr) {
            
            [self.tempArray removeAllObjects];
            if (resb.mSucess) {
                [SVProgressHUD showSuccessWithStatus:resb.mMessage];
                [self.tempArray addObjectsFromArray:mArr];
                [self loadActionView];
            }else{
                [SVProgressHUD showErrorWithStatus:resb.mMessage];
            }
        }];
    }else if(mType == 2){
        
        NSMutableDictionary *para = [NSMutableDictionary new];
        [para setObject:JH_KEY forKey:@"key"];
        [para setObject:mProvinceID forKey:@"provid"];
        
        [[mUserInfo backNowUser] FindPublic:mType andPara:para block:^(mJHBaseData *resb, NSArray *mArr) {
            
            [self.tempArray removeAllObjects];
            if (resb.mSucess) {
                [SVProgressHUD showSuccessWithStatus:resb.mMessage];
                [self.tempArray addObjectsFromArray:mArr];
                [self loadActionView];
            }else{
                [SVProgressHUD showErrorWithStatus:resb.mMessage];
            }
        }];
    }else if(mType == 3){
        
        NSMutableDictionary *para = [NSMutableDictionary new];
        [para setObject:JH_KEY forKey:@"key"];
        [para setObject:mProvinceID forKey:@"provid"];
        [para setObject:mCityID forKey:@"cityid"];
        
        [[mUserInfo backNowUser] FindPublic:mType andPara:para block:^(mJHBaseData *resb, NSArray *mArr) {
            
            [self.tempArray removeAllObjects];
            if (resb.mSucess) {
                [SVProgressHUD showSuccessWithStatus:resb.mMessage];
                [self.tempArray addObjectsFromArray:mArr];
                [self loadActionView];
            }else{
                [SVProgressHUD showErrorWithStatus:resb.mMessage];
            }
        }];
    }else if(mType == 4){
        
        NSMutableDictionary *para = [NSMutableDictionary new];
        [para setObject:JH_KEY forKey:@"key"];
        [para setObject:mProvinceID forKey:@"provid"];
        [para setObject:mCityID forKey:@"cityid"];
        [para setObject:mPayId forKey:@"type"];

        [[mUserInfo backNowUser] FindPublic:mType andPara:para block:^(mJHBaseData *resb, NSArray *mArr) {
            
            [self.tempArray removeAllObjects];
            if (resb.mSucess) {
                [SVProgressHUD showSuccessWithStatus:resb.mMessage];
                [self.tempArray addObjectsFromArray:mArr];
                [self loadActionView];
            }else{
                [SVProgressHUD showErrorWithStatus:resb.mMessage];
            }
        }];
    }else if(mType == 5){
        [SVProgressHUD dismiss];
        NSMutableDictionary *para = [NSMutableDictionary new];
        [para setObject:JH_KEY forKey:@"key"];
        [para setObject:mProvinceID forKey:@"provid"];
        [para setObject:mCityID forKey:@"cityid"];
        [para setObject:mPayId forKey:@"type"];
        [para setObject:mUnitId forKey:@"code"];

        [[mUserInfo backNowUser] FindPublic:mType andPara:para block:^(mJHBaseData *resb, NSArray *mArr) {
            
            [self.tempArray removeAllObjects];
            if (resb.mSucess) {
                [SVProgressHUD showSuccessWithStatus:resb.mMessage];
                [self.tempArray addObjectsFromArray:mArr];
                mProductId = [resb.mData objectForKey:@"productId"];
                
                [mParas setObject:[resb.mData objectForKey:@"productId"] forKey:@"productId"];
                [mParas setObject:[resb.mData objectForKey:@"productId"] forKey:@"productName"];
                mIsChoice = NO;
            }else{
                [LCProgressHUD showInfoMsg:resb.mMessage];
                mIsChoice = YES;
            }
        }];
    }
    

}

- (void)loadActionView{
    
    
    NSMutableArray  *Arrtemp = [NSMutableArray new];
    
    [Arrtemp removeAllObjects];

    NSString *mTt = nil;
    if (mType == 1) {
        mTt = @"选择省份";
        
        for (JHPayData *mPayData in self.tempArray) {
            [Arrtemp addObject:mPayData.mProvinceName];
        }
    }else if (mType == 2){
        
        mTt = @"选择市区";
        
        for (JHPayData *mPayData in self.tempArray) {
            [Arrtemp addObject:mPayData.mCityName];
        }
        
    }else if(mType == 3){
        mTt = @"选择缴费类型";
        for (JHPayData *mPayData in self.tempArray) {
            [Arrtemp addObject:mPayData.mPayProjectName];
        }
    }else{
        mTt = @"选择楼缴费单位";
        for (JHPayData *mPayData in self.tempArray) {
            [Arrtemp addObject:mPayData.mPayUnitName];
        }
    }
    
    

    
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:mTt style:MHSheetStyleWeiChat itemTitles:Arrtemp];
    actionSheet.cancleTitle = @"取消选择";
    
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        
        if (mType == 1) {
            
            JHPayData *mPayData = self.tempArray[index];
            [mView.mProvinceBtn setTitle:mPayData.mProvinceName forState:0];
            
            mType = 2;
            
            mProvinceID = mPayData.mProvinceId;
            
            [mParas setObject:mPayData.mProvinceId forKey:@"provinceId"];
            [mParas setObject:mPayData.mProvinceName forKey:@"provinceName"];
            
        }else if (mType == 2)
        {
            JHPayData *mPayData = self.tempArray[index];
            [mView.mCityBtn setTitle:mPayData.mCityName forState:0];
            
            mType = 3;
            
            mProvinceID = mPayData.mProvinceId;
            mCityID = mPayData.mCityId;
            [mParas setObject:mPayData.mCityId forKey:@"cityId"];
            [mParas setObject:mPayData.mCityName forKey:@"cityName"];
        }
        else if (mType == 3)
        {
            JHPayData *mPayData = self.tempArray[index];
            [mView.mPayType setTitle:mPayData.mPayProjectName forState:0];
            
            mType = 4;
            
            mTT = mPayData.mPayProjectName;
            
            mProvinceID = mPayData.mProvinceId;
            mCityID = mPayData.mCityId;
            mPayId = mPayData.mPayProjectId;
            [mParas setObject:mPayData.mPayProjectId forKey:@"projectId"];
            [mParas setObject:mPayData.mPayProjectName forKey:@"projectName"];
            
            if ([mPayData.mPayProjectName isEqualToString:@"水费"] ) {
                mPayTypeStr = @"001";
            }else if ([mPayData.mPayProjectName isEqualToString:@"电费"]){
                mPayTypeStr = @"002";

            }else{
                mPayTypeStr = @"003";

            }
            
        }
        else if (mType == 4)
        {
            JHPayData *mPayData = self.tempArray[index];
            [mView.mUnitBtn setTitle:mPayData.mPayUnitName forState:0];
            
            mType = 5;
            mProvinceID = mPayData.mProvinceId;
            mCityID = mPayData.mCityId;
            mPayId = mPayData.mPayProjectId;
            mUnitId = mPayData.mPayUnitId;
            [mParas setObject:mPayData.mPayUnitId forKey:@"unitId"];
            [mParas setObject:mPayData.mPayUnitName forKey:@"unitName"];
            [self loadData];
        }
    }];

    
}

- (void)mProvinceAction:(UIButton *)sender{
    mType = 1;
    [self loadData];

    
}
- (void)mCityAction:(UIButton *)sender{
    if (mType == 1) {
        [SVProgressHUD showErrorWithStatus:@"请选择省份！"];
        return;
    }
    mType = 2;

    [self loadData];
}
- (void)mPayTypeAction:(UIButton *)sender{
    if (mType == 2 || mType == 1) {
        [SVProgressHUD showErrorWithStatus:@"请选择区县！"];
        return;
    }
    mType = 3;

    [self loadData];
}
- (void)mUnitAction:(UIButton *)sender{
    if (mType == 3 || mType == 2 || mType == 1) {
        [SVProgressHUD showErrorWithStatus:@"请选择缴费类型！"];
        return;
    }
    mType = 4;

    [self loadData];
}
- (void)mPayFeeAction:(UIButton *)sender{
    
    if (mIsChoice) {
        [SVProgressHUD showErrorWithStatus:@"您选择的缴费类型不可用！请重新选择！"];
        return;
    }
    if (mType == 4 || mType == 3 || mType == 2 || mType == 1) {
        [SVProgressHUD showErrorWithStatus:@"请选择缴费单位！"];
        return;
    }

    if (mView.mNumTx.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"户号不能为空！"];
        return;
    }
    
    mGoPayViewController *mmm = [[mGoPayViewController alloc] initWithNibName:@"mGoPayViewController" bundle:nil];
    mmm.mTitel = mTT;
    mmm.mPayType = mPayTypeStr;
    mmm.mHouseNum = mView.mNumTx.text;
    mmm.mName = mView.mNameTx.text;
    
    mmm.mPara = [NSMutableDictionary new];
    mmm.mPara = mParas;
    [self pushViewController:mmm];
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
