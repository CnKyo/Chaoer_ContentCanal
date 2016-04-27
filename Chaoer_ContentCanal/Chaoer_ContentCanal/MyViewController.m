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

#import "myViewTableViewCell.h"

#import "homeNavView.h"

#import "msgViewController.h"

#import "paotuiViewController.h"

#import "orderTongjiViewController.h"

#import "mUserInfoViewController.h"

#import "hasCodeViewController.h"
#import "needCodeViewController.h"
#import "verifyBankViewController.h"

@interface MyViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,RSKImageCropViewControllerDelegate,RSKImageCropViewControllerDataSource,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>


@end

@implementation MyViewController{

    
    mPersonView *mHeaderView;
    
    UIImage *tempImage;
        
    NSArray *mArr1;
    NSArray *mArr2;
    
    homeNavView *mNavView;
    
    

}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];

    [self headerBeganRefresh];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Title = self.mPageName = @"管家";
    self.hiddenBackBtn = YES;
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    self.navBar.hidden = YES;
    
    
    [self initView];
}

- (void)initData{
    
    NSDictionary *mStyle = @{@"font":[UIFont systemFontOfSize:13],@"color": [UIColor colorWithRed:0.96 green:0.30 blue:0.29 alpha:1.00]};
    NSDictionary *mStyle2 = @{@"font":[UIFont systemFontOfSize:13],@"color": [UIColor colorWithRed:0.25 green:0.75 blue:0.42 alpha:1.00]};
    
    mHeaderView.mBalance.attributedText = [[NSString stringWithFormat:@"<font>余额</font> <color>%.2f元</color>",[mUserInfo backNowUser].mMoney] attributedStringWithStyleBook:mStyle];
    mHeaderView.mScore.attributedText = [[NSString stringWithFormat:@"<font>积分</font> <color>%d分</color>",[mUserInfo backNowUser].mCredit] attributedStringWithStyleBook:mStyle2];
    
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",[HTTPrequest returnNowURL],[mUserInfo backNowUser].mUserImgUrl];
    
    
    NSLog(@"头像地址是：%@",url);
    
    [mHeaderView.mHeaderImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"icon_headerdefault"]];
    mHeaderView.mName.text = [mUserInfo backNowUser].mNickName;
    mHeaderView.mJob.text = [mUserInfo backNowUser].mIdentity;
    mHeaderView.mPhone.text = [mUserInfo backNowUser].mPhone;

    
    [self.tempArray removeAllObjects];
    
    
    UIImage *img1 = [UIImage imageNamed:@"icon_verify"];
    UIImage *img2 = [UIImage imageNamed:@"icon_getorder"];
    UIImage *img3 = [UIImage imageNamed:@"icon_activity"];
    UIImage *img4 = [UIImage imageNamed:@"icon_order"];
    UIImage *img5 = [UIImage imageNamed:@"icon_rent"];
    UIImage *img6 = [UIImage imageNamed:@"add_hourse"];

    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@"实名认证" forKey:@"name"];
    [dic setObject:img1 forKey:@"img"];
    [dic setObject:NumberWithInt(1) forKey:@"ppp"];
    [dic setObject:NumberWithInt(1) forKey:@"hidden"];

    
    NSMutableDictionary *dic2 = [NSMutableDictionary new];
    [dic2 setObject:@"我的跑腿" forKey:@"name"];
    [dic2 setObject:img2 forKey:@"img"];
    [dic2 setObject:NumberWithInt(2) forKey:@"ppp"];
    [dic2 setObject:NumberWithInt(1) forKey:@"hidden"];

    
    mArr1 = @[dic,dic2];
    
    
    NSMutableDictionary *dic3 = [NSMutableDictionary new];
    [dic3 setObject:@"活动中心" forKey:@"name"];
    [dic3 setObject:img3 forKey:@"img"];
    [dic3 setObject:NumberWithInt(3) forKey:@"ppp"];
    [dic3 setObject:NumberWithInt(2) forKey:@"hidden"];


    NSMutableDictionary *dic4 = [NSMutableDictionary new];
    [dic4 setObject:@"我的订单" forKey:@"name"];
    [dic4 setObject:img4 forKey:@"img"];
    [dic4 setObject:NumberWithInt(4) forKey:@"ppp"];
    [dic4 setObject:NumberWithInt(2) forKey:@"hidden"];

    NSMutableDictionary *dic5 = [NSMutableDictionary new];
    [dic5 setObject:@"出租房" forKey:@"name"];
    [dic5 setObject:img5 forKey:@"img"];
    [dic5 setObject:NumberWithInt(5) forKey:@"ppp"];
    [dic5 setObject:NumberWithInt(2) forKey:@"hidden"];

    
    NSMutableDictionary *dic6 = [NSMutableDictionary new];
    [dic6 setObject:@"房屋添加" forKey:@"name"];
    [dic6 setObject:img6 forKey:@"img"];
    [dic6 setObject:NumberWithInt(6) forKey:@"ppp"];
    [dic6 setObject:NumberWithInt(2) forKey:@"hidden"];
    
    mArr2 = @[dic3,dic4,dic5,dic6];
    
    [self.tempArray addObject:mArr1];
    [self.tempArray addObject:mArr2];
    
    [self.tableView  reloadData];
    
}

#pragma mark----构造主页面
- (void)initView{

    mNavView = [homeNavView sharePersonNav];
    mNavView.frame = CGRectMake(0, 0, DEVICE_Width, 64);
    
    
    mNavView.mBadge.hidden = YES;
    
    [mNavView.mSetupBtn addTarget:self action:@selector(mSetupAction:) forControlEvents:UIControlEventTouchUpInside];
    [mNavView.mMsgBtn addTarget:self action:@selector(mMsgAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mNavView];

    
    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-114) delegate:self dataSource:self];
   self.tableView.allowsSelection = YES;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.93 alpha:1.00];
    [self.view addSubview:self.tableView];

    self.haveHeader = YES;
    [self.tableView headerBeginRefreshing];
    
    UINib   *nib = [UINib nibWithNibName:@"myViewTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    mHeaderView = [mPersonView shareView];
    mHeaderView.frame = CGRectMake(0, 0, DEVICE_Width, 162);
    [mHeaderView.mHeaderBtn addTarget:self action:@selector(mHeaderAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView setTableHeaderView:mHeaderView];

    

}
- (void)headerBeganRefresh{

    
    [[mUserInfo backNowUser] getNowUserInfo:^(mBaseData *resb, mUserInfo *user) {
        [self headerEndRefresh];
        if (resb.mSucess) {
            [self initData];
        }else{
            
        }
    }];
}

#pragma mark----设置事件
- (void)mSetupAction:(UIButton *)sender{
    mSetupViewController *mmm = [[mSetupViewController alloc] initWithNibName:@"mSetupViewController" bundle:nil];
    [self pushViewController:mmm];
}
#pragma mark----信息事件
- (void)mMsgAction:(UIButton *)sender{
    [LCProgressHUD showInfoMsg:@"正在建设中..."];
    return;
    NSLog(@"消息");
    msgViewController *mmm = [[msgViewController alloc] initWithNibName:@"msgViewController" bundle:nil];
    [self pushViewController:mmm];
}
#pragma mark----头像事件
- (void)mHeaderAction:(UIButton *)sender{

    mUserInfoViewController *mmm = [[mUserInfoViewController alloc] initWithNibName:@"mUserInfoViewController" bundle:nil];
    [self pushViewController:mmm];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return self.tempArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray *t = self.tempArray[section];
    return t.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *line= [UIView  new];
    line.frame = CGRectMake(0, 0, DEVICE_Width, 8);
    line.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.93 alpha:1.00];
    line.layer.masksToBounds = YES;
    line.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00].CGColor;
    line.layer.borderWidth = 0.5;
    return line;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 10;

    }else{
        return 5;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *rrr = self.tempArray[indexPath.section];
    NSDictionary *dic = rrr[indexPath.row];
    NSString *reuseCellId = @"cell";
    
    
    myViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    cell.mTitle.text = [dic objectForKey:@"name"];
    cell.mImg.image = [dic objectForKey:@"img"];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if ([mUserInfo backNowUser].mIsRegist) {
                cell.mDetail.hidden = YES;
            }else{
                cell.mDetail.hidden = NO;
            }
        
        }
    }
    else {
        if ([[dic objectForKey:@"hidden"] intValue]  == 1) {
    
            cell.mDetail.hidden = NO;
       
            
        }else{
            cell.mDetail.hidden = YES;
        }

    }
    
    return cell;
    

    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *rrr = self.tempArray[indexPath.section];
    NSDictionary *dic = rrr[indexPath.row];
    int  i = [[dic objectForKey:@"ppp"] intValue];
    
    switch (i) {
        case 1:
        {
            if ([mUserInfo backNowUser].mIsRegist) {
                hasCodeViewController *hhh = [hasCodeViewController new];
                [self pushViewController:hhh];
            }else if([mUserInfo backNowUser].mIsBundle == 1){
                
                verifyBankViewController *vvv = [[verifyBankViewController alloc] initWithNibName:@"verifyBankViewController" bundle:nil];
                [self pushViewController:vvv];
                
                
                
            }else{
                needCodeViewController *nnn = [[needCodeViewController alloc] initWithNibName:@"needCodeViewController" bundle:nil];
                nnn.Type = 1;

                [self pushViewController:nnn];
            }


        }
            break;
        case 2:
        {
            NSLog(@"我的跑腿");
//            paotuiViewController *ppp = [[paotuiViewController alloc] initWithNibName:@"paotuiViewController" bundle:nil];
//            ppp.mType = 2;
//            [self pushViewController:ppp];
            [LCProgressHUD showInfoMsg:@"正在建设中..."];

        }
            break;
        case 3:
        {
//            activityCenterViewController *mmm = [[activityCenterViewController alloc] initWithNibName:@"activityCenterViewController" bundle:nil];
//            [self pushViewController:mmm];
            [LCProgressHUD showInfoMsg:@"正在建设中..."];

            
        }
            break;
        case 4:
        {

//            myOrderViewController *mmm = [[myOrderViewController alloc] initWithNibName:@"myOrderViewController" bundle:nil];
//            [self pushViewController:mmm];

            
            orderTongjiViewController *oo = [[orderTongjiViewController alloc] initWithNibName:@"orderTongjiViewController" bundle:nil];
            
            [self pushViewController:oo];
            
        }
            break;
        case 5:
        {
            [LCProgressHUD showInfoMsg:@"正在建设中..."];

        }
            break;
        case 6:
        {
            needCodeViewController *nnn = [[needCodeViewController alloc] initWithNibName:@"needCodeViewController" bundle:nil];
            nnn.Type = 3;
            [self pushViewController:nnn];
        }
            break;

        default:
            break;
    }


    
    
}

@end
