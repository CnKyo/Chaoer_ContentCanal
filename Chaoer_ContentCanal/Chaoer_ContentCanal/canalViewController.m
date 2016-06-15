//
//  canalViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "canalViewController.h"
#import "canPayView.h"

#import "mBalanceViewController.h"
#import "utilityView.h"
#import "verifyBankViewController.h"
#import "hasCodeViewController.h"


#import "canelHistoryViewController.h"
@interface canalViewController ()<UITextFieldDelegate>

@end

@implementation canalViewController

{
    
    UIScrollView *mScrollerView;
    canPayView *mCanView;
    
    
    NSMutableDictionary *mParas;
    
    BOOL isSelected;
    utilityView *mView;
    
    utilityView *mEmptyView;

    GCanalList *mCList;

    
    int mNowSelected;
    
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
    [self loadData];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];///视图消失键盘位置取消调整
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];///关闭自定义工具栏
    
}

- (void)loadData{

    
    mCanView.mBalance.text = [NSString stringWithFormat:@"账户余额:%.2f元",[mUserInfo backNowUser].mMoney];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",[HTTPrequest currentResourceUrl],[mUserInfo backNowUser].mUserImgUrl];
    
    
    [mCanView.mLogoImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"icon_headerdefault"]];
    
    [SVProgressHUD showWithStatus:@"正在验证..." maskType:SVProgressHUDMaskTypeClear];
    [[mUserInfo backNowUser] getCanalMsg:^(mBaseData *resb, GCanalList *mList) {
    
        [self.tempArray removeAllObjects];
        if (resb.mSucess) {
            [SVProgressHUD dismiss];

            mCList = GCanalList.new;
            mCList = mList;
            
            [self.tempArray addObjectsFromArray:mList.mList];
            
            [self updatePage];
            
        }else{
        
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
            [self updatePage];

        }
        
    }];
}
- (void)initEmptyView{
    
    mEmptyView = [utilityView shareEmpty];
    mEmptyView.frame = CGRectMake(0, 0, DEVICE_Width, DEVICE_Height);
    
    [mScrollerView addSubview:mEmptyView];
    
    
}
- (void)updatePage{

    if (self.tempArray.count<=0) {
        [self initEmptyView];
        
//        [self AlertViewShow:@"您还没有绑定小区或实名认证！" alertViewMsg:@"通过认证之后才能缴费哦！" alertViewCancelBtnTiele:@"取消" alertTag:10];
        return;
    }
    [self initView];

    if (self.tempArray.count >= 1) {
        
         GCanal *mC = self.tempArray[0];
        
        [mCanView.mChioceCanalBtn setTitle:mC.mPaymentUnit forState:0];
        
        NSDictionary *mStyle = @{@"font":[UIFont systemFontOfSize:13],@"color": [UIColor redColor]};
        
        mCanView.mWillBalance.attributedText = [[NSString stringWithFormat:@"<font>本月应交物管费:</font><color>¥%.2f元</color>",mC.mPayableMoney] attributedStringWithStyleBook:mStyle];
        mCanView.mTime.text = [NSString stringWithFormat:@"请在%@之前缴纳完！",mC.mDeadline];
        mCanView.mNumTx.text = mC.mPaymentAccount;
        mCanView.mNameTx.text = mC.mUserName;
        mCanView.mMoneyTx.text = [NSString stringWithFormat:@"%.2f",mC.mPayableMoney];
        if (mC.mMoney <= 0.0) {
            mCanView.mBalance.text = [NSString stringWithFormat:@"账户余额:%.2f元",[mUserInfo backNowUser].mMoney];

        }else{
            mCanView.mBalance.text = [NSString stringWithFormat:@"账户余额:%.2f元",mC.mMoney];

        }
        

        
    }
    
    
    
    
    
}
- (void)loadActionView{
 
    NSMutableArray *Arrtemp = [NSMutableArray new];
    
    [Arrtemp removeAllObjects];
    
    for (GCanal *mC in self.tempArray) {
        [Arrtemp addObject:mC.mPaymentUnit];
    }
    
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择小区物管" style:MHSheetStyleWeiChat itemTitles:Arrtemp];
    actionSheet.delegate = self;
    actionSheet.cancleTitle = @"取消选择";
    
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        mNowSelected = [[NSString stringWithFormat:@"%ld",index] intValue];
        GCanal *mC = self.tempArray[index];
        
        mCanView.mJaintou.image = [UIImage imageNamed:@"jiantou_down"];

        [mParas removeObjectForKey:NumberWithInt([mUserInfo backNowUser].mUserId)];
        [mParas removeObjectForKey:mCanView.mMoneyTx.text];
        [mParas removeObjectForKey:mC.mPaymentAccount];
        [mParas removeObjectForKey:NumberWithInt(mC.mCommunityId)];

        [mCanView.mChioceCanalBtn setTitle:mC.mPaymentUnit forState:0];
        
        NSDictionary *mStyle = @{@"font":[UIFont systemFontOfSize:13],@"color": [UIColor redColor]};

        mCanView.mWillBalance.attributedText = [[NSString stringWithFormat:@"<font>本月应交物管费:</font><color>¥%.2f元</color>",mC.mPayableMoney] attributedStringWithStyleBook:mStyle];
        mCanView.mTime.text = [NSString stringWithFormat:@"请在%@之前缴纳完！",mC.mDeadline];
        mCanView.mNumTx.text = mC.mPaymentAccount;
        mCanView.mNameTx.text = mC.mUserName;
        mCanView.mMoneyTx.text = [NSString stringWithFormat:@"%.2f",mC.mPayableMoney];

        if (mC.mMoney <= 0.0) {
            mCanView.mBalance.text = [NSString stringWithFormat:@"账户余额:%.2f元",[mUserInfo backNowUser].mMoney];
            
        }else{
            mCanView.mBalance.text = [NSString stringWithFormat:@"账户余额:%.2f元",mC.mMoney];
            
        }
        
        isSelected = YES;
        
        [mParas setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];
        [mParas setObject:mC.mPaymentAccount forKey:@"paymentAccount"];
        [mParas setObject:mC.mId forKey:@"id"];
        
    }];

}

- (void)sheetViewHidden:(BOOL)mHidden{

    if (mHidden) {
        mCanView.mJaintou.image = [UIImage imageNamed:@"jiantou_down"];

    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.Title = self.mPageName = _mTitel;
    self.hiddenTabBar = YES;
    self.hiddenlll = YES;
    self.hiddenRightBtn = NO;
    self.rightBtnTitle = @"纪录查询";
    CGRect  mrr = self.navBar.rightBtn.frame;
    mrr.size.width = 100;
    mrr.origin.x = DEVICE_Width-80;
    self.navBar.rightBtn.frame = mrr;
    
    mNowSelected = 0;
    
    mScrollerView = [UIScrollView new];
    mScrollerView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-50);
    mScrollerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mScrollerView];

    
    mParas = [NSMutableDictionary new];
    
    isSelected = NO;
    
    
}
- (void)initView{
    
   
    
    mCanView = [canPayView shareView];
    mCanView.frame = CGRectMake(0, 0, mScrollerView.mwidth, 568);
    mCanView.mMoneyTx.delegate = mCanView.mNumTx.delegate = mCanView.mNameTx.delegate = self;
    mCanView.mMoneyTx.enabled = NO;
    [mCanView.mTopup addTarget:self action:@selector(mTopupAction:) forControlEvents:UIControlEventTouchUpInside];
    [mCanView.mBalanceBtn addTarget:self action:@selector(mBalanceAction:) forControlEvents:UIControlEventTouchUpInside];
    [mCanView.mChioceCanalBtn addTarget:self action:@selector(mCanalAction:) forControlEvents:UIControlEventTouchUpInside];

    
    [mScrollerView addSubview:mCanView];
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 568);
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
    
    
}
/**
 *  选择物管
 *
 *  @param sender <#sender description#>
 */
- (void)mCanalAction:(UIButton *)sender{
    
    
    
    [self loadActionView];

    mCanView.mJaintou.image = [UIImage imageNamed:@"jiantou_up"];
 
    
}
#pragma  mark -----键盘消失
- (void)tapAction{
    [mCanView.mMoneyTx resignFirstResponder];
    [mCanView.mNumTx resignFirstResponder];
    [mCanView.mNameTx resignFirstResponder];
    
    mCanView.mJaintou.image = [UIImage imageNamed:@"jiantou_down"];

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
/**
 *  缴费
 *
 *  @param sender
 */
- (void)mBalanceAction:(UIButton *)sender{
    MLLog(@"缴费");
    GCanal *mC = self.tempArray[mNowSelected];
    
    
    if ([mUserInfo backNowUser].mMoney < mC.mMoney) {
        [self showErrorStatus:@"余额不足请充值!"];
        return;
    }
    
    if (isSelected) {
        
        [mParas setObject:NumberWithFloat(mC.mPayableMoney) forKey:@"paymentAmount"];
    }else{
    
        [mParas setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];
        [mParas setObject:mC.mPaymentAccount forKey:@"paymentAccount"];
        [mParas setObject:mC.mId forKey:@"id"];
        [mParas setObject:NumberWithFloat(mC.mPayableMoney) forKey:@"paymentAmount"];

    }
    
    

    [SVProgressHUD showWithStatus:@"正在验证..." maskType:SVProgressHUDMaskTypeClear];
    [[mUserInfo backNowUser] payCanal:mParas block:^(mBaseData *resb) {
        
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
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if( buttonIndex == 0)
    {
        [self popViewController];
    }else{
        if ([mUserInfo backNowUser].mIsHousingAuthentication) {
            hasCodeViewController *hhh = [hasCodeViewController new];
            [self pushViewController:hhh];
        }
    }
}
- (void)AlertViewShow:(NSString *)alerViewTitle alertViewMsg:(NSString *)msg alertViewCancelBtnTiele:(NSString *)cancelTitle alertTag:(int)tag{
    
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:alerViewTitle message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:@"去认证", nil];
    al.delegate = self;
    al.tag = tag;
    [al show];
}

#pragma mark----记录查询
- (void)rightBtnTouched:(id)sender{

    canelHistoryViewController *ccc = [[canelHistoryViewController alloc] initWithNibName:@"canelHistoryViewController" bundle:nil];
    [self pushViewController:ccc];
    
}
@end
