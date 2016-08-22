//
//  wpgViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "wpgViewController.h"

#import "wpgTableViewCell.h"

#import "canPayView.h"


#import "canalViewController.h"
#import "needCodeViewController.h"
#import "verifyBankViewController.h"
#import "payFeeViewController.h"
@interface wpgViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation wpgViewController
{
    
    canPayView *mHeaderView;
    
    NSArray *mImg;
}
- (void)viewDidLoad {

    [super viewDidLoad];

    
    self.Title = self.mPageName = @"缴费-水电气费";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.hiddenRightBtn = YES;
    self.rightBtnTitle = @"纪录查询";
    CGRect  mrr = self.navBar.rightBtn.frame;
    mrr.size.width = 100;
    mrr.origin.x = DEVICE_Width-80;
    self.navBar.rightBtn.frame = mrr;

    [self initView];
}

- (void)initView{
    
    mImg = @[[UIImage imageNamed:@"quik_canal"],[UIImage imageNamed:@"quik_power"]];
    
    [self.tempArray addObject:@"物管费"];
    [self.tempArray addObject:@"水电气费"];
    
    
    mHeaderView = [canPayView shareHeaderView];
    
    mHeaderView.frame = CGRectMake(0, 64, DEVICE_Width, 50);
    
    mHeaderView.mYue.text = [NSString stringWithFormat:@"账户余额：¥%.2f元",[mUserInfo backNowUser].mMoney];
    [mHeaderView.mChongzhi addTarget:self action:@selector(mTopupAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mHeaderView];

    
    [self loadTableView:CGRectMake(0, 50, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    UINib   *nib = [UINib nibWithNibName:@"wpgTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    
    [self.tableView reloadData];

    
    
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
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 61;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    wpgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    cell.mName.text = self.tempArray[indexPath.row];
    cell.mLogo.image = mImg[indexPath.row];
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        if (![mUserInfo backNowUser].mIsHousingAuthentication) {
            [self AlertViewShow:@"未实名认证！" alertViewMsg:@"通过认证即可使用更多功能？" alertViewCancelBtnTiele:@"取消" alertTag:10];
            return;
        }
        
   
        canalViewController *ccc= [canalViewController new];
        
        ccc.mTitel= @"缴费－物管费";
        [self pushViewController:ccc];
        

    }else{

        if (![mUserInfo backNowUser].mIsHousingAuthentication) {
            [self AlertViewShow:@"未实名认证！" alertViewMsg:@"通过认证即可使用更多功能？" alertViewCancelBtnTiele:@"取消" alertTag:10];
            return;
        }
        
        payFeeViewController *ccc= [[payFeeViewController alloc] initWithNibName:@"payFeeViewController" bundle:nil];
        
        ccc.mTitel= @"水电气费";
        [self pushViewController:ccc];
    }
    
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
    
    if( buttonIndex == 1)
    {
        
        needCodeViewController *nnn = [[needCodeViewController alloc] initWithNibName:@"needCodeViewController" bundle:nil];
        nnn.Type = 1;
        
        [self pushViewController:nnn];
        
        
        
        
    }
}

- (void)AlertViewShow:(NSString *)alerViewTitle alertViewMsg:(NSString *)msg alertViewCancelBtnTiele:(NSString *)cancelTitle alertTag:(int)tag{
    
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:alerViewTitle message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:@"去认证", nil];
    al.delegate = self;
    al.tag = tag;
    [al show];
}
@end
