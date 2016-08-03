//
//  walletViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/4/5.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "walletViewController.h"
#import "walletView.h"

#import "LXCircleAnimationView.h"

#import "UILabel+FlickerNumber.h"
#import "myRedBagViewController.h"

#import "valleteHistoryViewController.h"

#import "phoneUpTopViewController.h"

#import "cashViewController.h"
#import "needCodeViewController.h"
#import "verifyBankViewController.h"

#import "valletCell1.h"
@interface walletViewController ()<valletHeaderScanDelegate,UITableViewDelegate,UITableViewDataSource,cellWithBtnActionDelegate>
@property (nonatomic, strong) LXCircleAnimationView *circleProgressView;
@property (nonatomic, strong) LXCircleAnimationView *circleProgressView2;
@property (nonatomic, strong) LXCircleAnimationView *circleProgressView3;
@end

@implementation walletViewController
{
    walletView *mView;
    
    walletView *mHeaderView;

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

    [self initView];
    
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

}
- (void)headerBeganRefresh{

    [[mUserInfo backNowUser] getWallete:[mUserInfo backNowUser].mUserId block:^(mBaseData *resb) {
        [self headerEndRefresh];
        if (resb.mSucess) {
            [mUserInfo backNowUser].mUserId = [[resb.mData objectForKey:@"user_id"] intValue];
            [mUserInfo backNowUser].mMoney = [[resb.mData objectForKey:@"money"] floatValue];
            [mUserInfo backNowUser].mCredit = [[resb.mData objectForKey:@"score"] intValue];

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
    [cell setMFDays:24];
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

    }else if (mIndex == 2){
    
    }else{
    
    }
    

}
#pragma mark----详情规则按钮
- (void)cellWithRuleBtnAction{

}
#pragma mark----签到按钮
- (void)cellWithRegistBtnAction{

}

@end
