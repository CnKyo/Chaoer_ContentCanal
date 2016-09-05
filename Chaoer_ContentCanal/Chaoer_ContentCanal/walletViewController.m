//
//  walletViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/4/5.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "walletViewController.h"
#import "walletView.h"
#import "myRedBagViewController.h"

#import "valleteHistoryViewController.h"

#import "phoneUpTopViewController.h"

#import "cashViewController.h"
#import "needCodeViewController.h"
#import "verifyBankViewController.h"

#import "valletCell1.h"
#import "ScanViewController.h"
#import "transferViewController.h"
#import "mPayFeeBarCodeView.h"
#import "WJAdsView.h"
#import "AppDelegate.h"

@interface walletViewController ()<valletHeaderScanDelegate,UITableViewDelegate,UITableViewDataSource,cellWithBtnActionDelegate,WJAdsViewDelegate,UIApplicationDelegate,UIActionSheetDelegate>

@end

@implementation walletViewController
{
    walletView *mView;
    
    walletView *mHeaderView;
    
    mPayFeeBarCodeView *mBarCodeView;
    
    NSString *mBarCodeStr;
    

}
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.Title = self.mPageName = @"钱包";
    self.hiddenBackBtn = YES;
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    self.navBar.hidden = YES;
    mBarCodeStr = nil;
    [self initView];
    [self initBarCodeView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUserInfoChange:) name:MyUserInfoChangedNotification object:nil];
}

-(void)handleUserInfoChange:(NSNotification *)note
{
    [self.tableView reloadData];
}


- (void)initView{
    
    mHeaderView = [walletView shareHeaderView];
    mHeaderView.frame = CGRectMake(0, 0, DEVICE_Width, 64);
    mHeaderView.delegate = self;
    [self.view addSubview:mHeaderView];

    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-114) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.haveHeader = YES;
    UINib   *nib = [UINib nibWithNibName:@"valletCell1" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    nib = [UINib nibWithNibName:@"valletCell2" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];

    nib = [UINib nibWithNibName:@"valletCell3" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell3"];

    
}
#pragma mark0----扫描按钮
- (void)valletHeaderScanAction{
    ScanViewController *mmm = [ScanViewController new];
    self.navigationController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mmm animated:YES];
}
- (void)headerBeganRefresh{

    [[mUserInfo backNowUser] getWallete:[mUserInfo backNowUser].mUserId block:^(mBaseData *resb) {
        [self headerEndRefresh];
        if (resb.mSucess) {
            [mUserInfo backNowUser].mUserId = [[resb.mData objectForKey:@"user_id"] intValue];
            [mUserInfo backNowUser].mMoney = [[resb.mData objectForKey:@"money"] floatValue];
            [mUserInfo backNowUser].mCredit = [[resb.mData objectForKey:@"score"] intValue];
            [mUserInfo backNowUser].mSignDay =[[resb.mData objectForKey:@"signDays"] intValue];
            int isSign = [[resb.mData objectForKey:@"is_SignIn"] boolValue];
            
            [mUserInfo backNowUser].mIsSign = isSign?1:0;
            [self.tableView reloadData];
        }else{
            [self showErrorStatus:resb.mMessage];
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
    
    if (alertView.tag == 12) {
        if( buttonIndex == 1)
        {
            
            verifyBankViewController *vvv = [[verifyBankViewController alloc] initWithNibName:@"verifyBankViewController" bundle:nil];
            [self pushViewController:vvv];
            
            
        }
    }else{
        if( buttonIndex == 1)
        {
            needCodeViewController *nnn = [[needCodeViewController alloc] initWithNibName:@"needCodeViewController" bundle:nil];
            nnn.Type = 1;
            
            [self pushViewController:nnn];
            
            
        }
    }
    
  
}

- (void)AlertViewShow:(NSString *)alerViewTitle alertViewMsg:(NSString *)msg alertViewCancelBtnTiele:(NSString *)cancelTitle alertTag:(int)tag{
    
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:alerViewTitle message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:@"去绑定", nil];
    al.delegate = self;
    al.tag = tag;
    [al show];
}





#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 278;
    }else if (indexPath.row == 1){
        return 120;
    }else{
        return 200;
    }
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = nil;
    if (indexPath.row == 0) {
        reuseCellId = @"cell";
    }else if (indexPath.row == 1){
        reuseCellId = @"cell2";
    }else{
        reuseCellId = @"cell3";
    }
    
    
    valletCell1 *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell setMTopFourBtnArr:@[@"充值",@"转账",@"提现",@"收款"]];
    
    
    [cell setMFBalance:[mUserInfo backNowUser].mMoney];
    [cell setMFScore:[mUserInfo backNowUser].mCredit];
    [cell setMFDays:[mUserInfo backNowUser].mSignDay];
    cell.delegate = self;
    
    return cell;
    
    
    
}

#pragma mark----cell按钮点击的代理方法
- (void)cellWithHistoryBtnSelectedIndex:(NSInteger)mIndex{

    if (mIndex == 0) {
        valleteHistoryViewController *vvv = [[valleteHistoryViewController alloc] initWithNibName:@"valleteHistoryViewController" bundle:nil];
        vvv.mType = 1;
        [self pushViewController:vvv];
    }else if (mIndex == 1){
        valleteHistoryViewController *vvv = [[valleteHistoryViewController alloc] initWithNibName:@"valleteHistoryViewController" bundle:nil];
        vvv.mType = 2;
        [self pushViewController:vvv];

    }else if (mIndex == 2){
        myRedBagViewController *mmm = [[myRedBagViewController alloc] initWithNibName:@"myRedBagViewController" bundle:nil];
        [self pushViewController:mmm];
    }else{
        valleteHistoryViewController *vvv = [[valleteHistoryViewController alloc] initWithNibName:@"valleteHistoryViewController" bundle:nil];
        vvv.mType = 3;
        [self pushViewController:vvv];
        
    }
    
}
#pragma mark----顶部4个按钮
- (void)cellWithFourBtnSelectedIndex:(NSInteger)mIndex{
    
    if (mIndex == 2) {
        if ([mUserInfo backNowUser].mIsRegist == 0 ) {
            
            
            [self AlertViewShow:@"找不到银行卡！" alertViewMsg:@"需要绑定银行卡才！" alertViewCancelBtnTiele:@"取消" alertTag:12];
            
            return;
            
            
        }else{
            if (![mUserInfo backNowUser].mIsHousingAuthentication) {
                
                [self AlertViewShow:@"未实名认证！" alertViewMsg:@"实名认证之后才能提现！" alertViewCancelBtnTiele:@"取消" alertTag:13];
                
                return;
            }else{
                
                cashViewController *ccc = [[cashViewController alloc] initWithNibName:@"cashViewController" bundle:nil];
                [self pushViewController:ccc];
                
            }
            
        }

    }else if (mIndex == 0){
        mBalanceViewController *ppp = [[mBalanceViewController alloc] initWithNibName:@"mBalanceViewController" bundle:nil];
        [self pushViewController:ppp];

    }else if (mIndex == 1){
        transferViewController *ttt = [[transferViewController alloc] initWithNibName:@"transferViewController" bundle:nil];
        [self pushViewController:ttt];
    }else{
        [self showWithStatus:@"正在操作中..."];
        [[mUserInfo backNowUser] getPayFeeBarCode:^(mBaseData *resb, NSString *mBarCodeUrl) {
            if (resb.mSucess) {
                [self dismiss];
                mBarCodeStr = mBarCodeUrl;
                [self showAdsView];
            }else{
            
                [self showErrorStatus:resb.mMessage];
            }
        }];
    }
    

}
#pragma mark----详情规则按钮
- (void)cellWithRuleBtnAction{

}
#pragma mark----签到按钮
- (void)cellWithRegistBtnAction{

    
    if ([mUserInfo backNowUser].mIsSign) {
        [self showErrorStatus:@"今天您已经签过到了哦！"];
    }else{
    
        [self showWithStatus:@"正在签到..."];
        [[mUserInfo backNowUser] signDay:^(mBaseData *resb) {
            if (resb.mSucess) {
                [self showSuccessStatus:resb.mMessage];
                [self headerBeganRefresh];
                
            }else{
            
                [self showErrorStatus:resb.mMessage];
            }
        }];
    }
}

- (void)initBarCodeView{

    mBarCodeView = [mPayFeeBarCodeView shareView];
    mBarCodeView.frame = self.view.bounds;
    mBarCodeView.alpha = 0;
    [mBarCodeView.mCloseBtn addTarget:self action:@selector(mCloseAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mBarCodeView];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [mBarCodeView addGestureRecognizer:tap];
}
- (void)showBarCode{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        mBarCodeView.alpha = 1;
        [mBarCodeView.mImg sd_setImageWithURL:[NSURL URLWithString:mBarCodeStr] placeholderImage:[UIImage imageNamed:@"img_default"]];
        
    }];
    

}

- (void)hiddenBarCode{
    [UIView animateWithDuration:0.25 animations:^{
        
        mBarCodeView.alpha = 0;
        
        
    }];
    
}
- (void)mCloseAction:(UIButton *)sender{

    [self hiddenBarCode];
}
- (void)tap{
    [self hiddenBarCode];

    
}
#pragma mark----加载弹框
- (void)showAdsView{
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.window.backgroundColor = [UIColor colorWithWhite:20
                                                   alpha:0.3];
    WJAdsView *adsView = [[WJAdsView alloc] initWithWindow:app.window];
    adsView.tag = 10;
    adsView.delegate = self;
    
    UIView *vvvv = [UIView new];
    vvvv.frame = CGRectMake(0, 0,adsView.mainContainView.frame.size.width, adsView.mainContainView.frame.size.height);
    
    UIImageView *iii = [UIImageView new];
    iii.frame = vvvv.bounds;
    [iii sd_setImageWithURL:[NSURL URLWithString:mBarCodeStr] placeholderImage:[UIImage imageNamed:@"img_default"]];
    [vvvv addSubview:iii];
    
    [self.view addSubview:adsView];
    adsView.containerSubviews = @[vvvv];
    [adsView showAnimated:YES];
}
- (void)hide{
    WJAdsView *adsView = (WJAdsView *)[self.view viewWithTag:10];
    [adsView hideAnimated:YES];
}
- (void)wjAdsViewDidAppear:(WJAdsView *)view{
    MLLog(@"视图出现");
}
- (void)wjAdsViewDidDisAppear:(WJAdsView *)view{
    MLLog(@"视图消失");
}

- (void)wjAdsViewTapMainContainView:(WJAdsView *)view currentSelectIndex:(long)selectIndex{
    MLLog(@"点击主内容视图:--%ld",selectIndex);
    
    UIActionSheet *acc = [[UIActionSheet alloc]initWithTitle:@"是否将图片保存到相册？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存到相册", nil];
    
    [acc showInView:self.view];

}
#pragma mark - IBActionSheet/UIActionSheet Delegate Method
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if (buttonIndex == 0) {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:mBarCodeStr]];
        

        UIImage *savedImage = [UIImage imageWithData:data];

        [self saveImageToPhotos:savedImage];
    }
    
}
//实现该方法
- (void)saveImageToPhotos:(UIImage*)savedImage
{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    //因为需要知道该操作的完成情况，即保存成功与否，所以此处需要一个回调方法image:didFinishSavingWithError:contextInfo:
}
//回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{

    
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
        [self showErrorStatus:msg];

    }else{
        msg = @"保存图片成功" ;
        [self showSuccessStatus:msg];

    }
    

}

@end
