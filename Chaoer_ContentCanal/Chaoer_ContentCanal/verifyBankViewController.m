//
//  verifyBankViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/26.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "verifyBankViewController.h"
#import "needCodeView.h"
#import "MHActionSheet.h"
@interface verifyBankViewController ()

@end

@implementation verifyBankViewController
{
    UIScrollView *mScrollerView;
    
    
    NSMutableArray *mArray;
    
    needCodeView    *mView;
    
    int mType;
    
    
    NSString    *mProvince;
    
    NSString    *mCity;
    
    NSString    *mBankName;
    
    NSString *mPoint;

    NSString *mBankCode;

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
    self.view.backgroundColor = [UIColor colorWithRed:0.89 green:0.90 blue:0.90 alpha:1.00];
    self.Title = self.mPageName = @"绑定银行卡";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    
    mType = 1;
    
    mArray = [NSMutableArray new];
    
    [self initview];
}
- (void)initview{
    
    UIImageView *iii = [UIImageView new];
    
    iii.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64);
    iii.image = [UIImage imageNamed:@"mBaseBgkImg"];
    [self.view addSubview:iii];
    
    mScrollerView = [UIScrollView new];
    mScrollerView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64);
    mScrollerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mScrollerView];
    
    
    mView = [needCodeView shareVerifyBankView];
    mView.frame = CGRectMake(0, 0, DEVICE_Width, 568);
    
    
    [mView.mBankBtn addTarget:self action:@selector(bankNameAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mProvinceBtn addTarget:self action:@selector(provinceAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mChoiseCityBtn addTarget:self action:@selector(cityAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mBankPointBtn addTarget:self action:@selector(pointAction:) forControlEvents:UIControlEventTouchUpInside];
    
     [mView.mVerifyBtn addTarget:self action:@selector(verifyAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [mScrollerView addSubview:mView];
    
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 568);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadData{

    
    [SVProgressHUD showWithStatus:@"正在加载中..." maskType:SVProgressHUDMaskTypeClear];
    
    
    if (mType == 1) {
        [mUserInfo getbank:^(mBaseData *resb, NSArray *marr) {
            
            [SVProgressHUD dismiss];
            [self.tempArray removeAllObjects];
            if (resb.mSucess) {
                [SVProgressHUD showSuccessWithStatus:resb.mMessage];
                
                [self.tempArray addObjectsFromArray:marr];
                [self loadMHActionSheetView];
                
            }else{
                [SVProgressHUD showErrorWithStatus:resb.mMessage];
            }
            
            
        }];
    }else {
    
        [mUserInfo getBankOfCity:mCity andProvince:mProvince andBankName:mBankName andType:mType block:^(mBaseData *resb, NSArray *marr) {
            
            [SVProgressHUD dismiss];
            [self.tempArray removeAllObjects];
            [mArray removeAllObjects];
            if (resb.mSucess) {
                [SVProgressHUD showSuccessWithStatus:resb.mMessage];
                
                if (mType == 4) {
                    [mArray addObjectsFromArray:marr];
                }else{
                    [self.tempArray addObjectsFromArray:marr];
                }
                
                
                [self loadMHActionSheetView];
                
            }else{
                [SVProgressHUD showErrorWithStatus:resb.mMessage];
            }
        }];
        
    }
    


    
}

- (void)loadMHActionSheetView{
    
    NSString *mTt = nil;
    
    if (mType == 1) {
        mTt = @"选择银行";
    }else if (mType == 2)
    {
        mTt = @"选择开户省份";
    }else if (mType == 3)
    {
        mTt = @"选择开户城市";
    }else if (mType == 4)
    {
        mTt = @"选择开户网点";
        
        [self.tempArray removeAllObjects];
        for (NSDictionary *dic in mArray) {
            [self.tempArray addObject:[dic objectForKey:@"name"]];
        }
        
    }
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:mTt style:MHSheetStyleWeiChat itemTitles:self.tempArray];
    actionSheet.cancleTitle = @"取消选择";
    
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        NSString *text = nil;
        
        if (mType == 1) {
            text = self.tempArray[index];
            mView.mBankLb.text = text;
            mBankName = text;
            mType = 2;


        }else if (mType == 2){
        
            text = self.tempArray[index];
            mView.mProvinceLb.text = text;
            mProvince = text;
            mType = 3;


        }else if (mType == 3){
            
            text = self.tempArray[index];
            mView.mChoiseCity.text = text;
            mCity = text;
            mType = 4;

            
        }else if (mType == 4){
            
            
            NSDictionary *dic = mArray[index];
            
            text = [dic objectForKey:@"name"];
            mView.mBankPointLb.text = text;
            mPoint = text;
            mBankCode = [dic objectForKey:@"bankCode"];
            
        }
        
    }];
}

- (void)bankNameAction:(UIButton *)sender{
    if (mView.mBankName.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入姓名"];
        [mView.mBankName becomeFirstResponder];
        return;
    }
    if (mView.mBankIdentify.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入身份证"];
        [mView.mBankIdentify becomeFirstResponder];
        return;
    }
    mType = 1;
    [self loadData];
    
    
}
- (void)provinceAction:(UIButton *)sender{
    if (mType == 1) {
        [SVProgressHUD showErrorWithStatus:@"请选择开户行！"];
        return;
    }
    mType = 2;
    [self loadData];
    
}
- (void)cityAction:(UIButton *)sender{
    if (mType == 2 || mType == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择开户省份！"];
        return;
    }
    mType = 3;
    
    [self loadData];
    
    
    
}
- (void)pointAction:(UIButton *)sender{
    if (mType == 3 || mType == 2 || mType == 1) {
        [SVProgressHUD showErrorWithStatus:@"请选择开户城市！"];
        return;
    }
    mType = 4;
    
    [self loadData];
    
    
    
}

- (void)verifyAction:(UIButton *)sneder{
    if (mView.mBankName.text.length == 0) {
        [mView.mBankName becomeFirstResponder];
        [self showErrorStatus:@"请输入您的真实姓名"];
        return;
    }
    if (mView.mBankIdentify.text.length == 0) {
        [mView.mBankIdentify becomeFirstResponder];
        [self showErrorStatus:@"身份证不能为空"];
        return;
    }
    if (mView.mBanCardTx.text.length == 0) {
        [self showErrorStatus:@"银行卡不能为空"];
        [mView.mBanCardTx becomeFirstResponder];

        return;
    }
    if (![Util checkIdentityCardNo:mView.mBankIdentify.text]) {
        [mView.mBankIdentify becomeFirstResponder];
        [self showErrorStatus:@"请输入合法的身份证号码"];
        return;
    }
    if (![Util checkBankCard:mView.mBanCardTx.text]) {
        [mView.mBanCardTx becomeFirstResponder];
        [self showErrorStatus:@"请输入合法的银行卡号"];
        return;
    }
    
    
    [SVProgressHUD showWithStatus:@"正在认证中..." maskType:SVProgressHUDMaskTypeClear];
    
    [mUserInfo geBankCode:mView.mBankName.text andUserId:[mUserInfo backNowUser].mUserId andIdentify:mView.mBankIdentify.text andBankName:mBankName andProvince:mProvince andCity:mCity andPoint:mPoint andBankCard:mView.mBanCardTx.text andBankCode:mBankCode block:^(mBaseData *resb) {
        
        if (resb.mSucess) {
            [SVProgressHUD showSuccessWithStatus:resb.mMessage];
            
            [self popViewController];
 
        }else{
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
            
        }
    }];

    
    
    
    
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

    if (self.mType == 11) {
        [self popViewController_2];

    }
    
    else {
   
        [self popViewController];
        
    }
    
}
@end
