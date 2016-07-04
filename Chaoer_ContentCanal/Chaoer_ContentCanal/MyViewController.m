//
//  MyViewController.m
//  O2O_XiCheSeller
//
//  Created by 密码为空！ on 15/6/18.
//  Copyright (c) 2015年 zongyoutec.com. All rights reserved.
//

#import "MyViewController.h"

#import "mPersonView.h"

#import "UIImage+ImageEffects.h"

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

#import "orderTongjiViewController.h"

#import "mUserInfoViewController.h"

#import "hasCodeViewController.h"
#import "needCodeViewController.h"
#import "verifyBankViewController.h"
#import "barCodeViewController.h"

#import "otherLoginViewController.h"

#import "openPPTViewController.h"

#import "depositViewController.h"

@interface MyViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,RSKImageCropViewControllerDelegate,RSKImageCropViewControllerDataSource,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>


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
    self.navigationController.navigationBar.barTintColor=M_CO;

    
    [self initView];
}

- (void)initData{
    
    NSDictionary *mStyle = @{@"font":[UIFont systemFontOfSize:13],@"color": [UIColor colorWithRed:0.96 green:0.30 blue:0.29 alpha:1.00]};
    NSDictionary *mStyle2 = @{@"font":[UIFont systemFontOfSize:13],@"color": [UIColor colorWithRed:0.25 green:0.75 blue:0.42 alpha:1.00]};
    
    mHeaderView.mBalance.attributedText = [[NSString stringWithFormat:@"<font>余额</font> <color>%.2f元</color>",[mUserInfo backNowUser].mMoney] attributedStringWithStyleBook:mStyle];
    mHeaderView.mScore.attributedText = [[NSString stringWithFormat:@"<font>积分</font> <color>%d分</color>",[mUserInfo backNowUser].mCredit] attributedStringWithStyleBook:mStyle2];
    
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",[HTTPrequest currentResourceUrl],[mUserInfo backNowUser].mUserImgUrl];
    UIImage *mHead = nil;
    
    if ([mUserInfo backNowUser].mUserImgUrl == nil || [[mUserInfo backNowUser].mUserImgUrl isEqualToString:@""] || [mUserInfo backNowUser].mUserImgUrl.length == 0) {
        mHead = [UIImage imageNamed:@"rbgk"];
    }else{
        mHead = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    }
    
    UIImage *mLastImg = [mHead applyLightEffect];
    
    MLLog(@"头像地址是：%@",url);
    mHeaderView.mBgkImg.image = mLastImg;
    [mHeaderView.mHeaderImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"icon_headerdefault"]];
    mHeaderView.mName.text = [mUserInfo backNowUser].mNickName;
    mHeaderView.mJob.text = [mUserInfo backNowUser].mIdentity;
    mHeaderView.mPhone.text = [mUserInfo backNowUser].mPhone;

    
    [self.tempArray removeAllObjects];
    
    
    UIImage *img1 = [UIImage imageNamed:@"icon_verify"];
    UIImage *img2 = [UIImage imageNamed:@"icon_getorder"];
    UIImage *img3 = [UIImage imageNamed:@"bar_code"];
    UIImage *img4 = [UIImage imageNamed:@"icon_activity"];
    UIImage *img5 = [UIImage imageNamed:@"icon_order"];
    UIImage *img6 = [UIImage imageNamed:@"icon_rent"];
    UIImage *img7 = [UIImage imageNamed:@"add_hourse"];


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
    
    NSMutableDictionary *dic3 = [NSMutableDictionary new];
    [dic3 setObject:@"我的二维码名片" forKey:@"name"];
    [dic3 setObject:img3 forKey:@"img"];
    [dic3 setObject:NumberWithInt(3) forKey:@"ppp"];
    [dic3 setObject:NumberWithInt(2) forKey:@"hidden"];
    
    mArr1 = @[dic,dic2,dic3];
    
    
    NSMutableDictionary *dic4 = [NSMutableDictionary new];
    [dic4 setObject:@"活动中心" forKey:@"name"];
    [dic4 setObject:img4 forKey:@"img"];
    [dic4 setObject:NumberWithInt(4) forKey:@"ppp"];
    [dic4 setObject:NumberWithInt(2) forKey:@"hidden"];


    NSMutableDictionary *dic5 = [NSMutableDictionary new];
    [dic5 setObject:@"我的订单" forKey:@"name"];
    [dic5 setObject:img5 forKey:@"img"];
    [dic5 setObject:NumberWithInt(5) forKey:@"ppp"];
    [dic5 setObject:NumberWithInt(2) forKey:@"hidden"];

    NSMutableDictionary *dic6 = [NSMutableDictionary new];
    [dic6 setObject:@"出租房" forKey:@"name"];
    [dic6 setObject:img6 forKey:@"img"];
    [dic6 setObject:NumberWithInt(6) forKey:@"ppp"];
    [dic6 setObject:NumberWithInt(2) forKey:@"hidden"];

    
    NSMutableDictionary *dic7 = [NSMutableDictionary new];
    [dic7 setObject:@"房屋添加" forKey:@"name"];
    [dic7 setObject:img7 forKey:@"img"];
    [dic7 setObject:NumberWithInt(7) forKey:@"ppp"];
    [dic7 setObject:NumberWithInt(2) forKey:@"hidden"];
    
    mArr2 = @[dic4,dic5,dic6,dic7];
    
    [self.tempArray addObject:mArr1];
    [self.tempArray addObject:mArr2];
    
    [self.tableView  reloadData];
    
}

#pragma mark----构造主页面
- (void)initView{

    [self loadTableView:CGRectMake(0, 0, DEVICE_Width, DEVICE_Height-50) delegate:self dataSource:self];
   self.tableView.allowsSelection = YES;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.93 alpha:1.00];

    self.haveHeader = YES;
    UINib   *nib = [UINib nibWithNibName:@"myViewTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    
    UIView *hhh = [UIView new];
    hhh.frame = CGRectMake(0, 0, DEVICE_Width, 226);
    
//    mNavView = [homeNavView sharePersonNav];
//    mNavView.frame = CGRectMake(0, 0, DEVICE_Width, 64);
//    
//    mNavView.mBadge.hidden = YES;
//    mNavView.mSetupBtn.hidden = YES;
//    [mNavView.mSetupBtn addTarget:self action:@selector(mSetupAction:) forControlEvents:UIControlEventTouchUpInside];
//    [mNavView.mMsgBtn addTarget:self action:@selector(mMsgAction:) forControlEvents:UIControlEventTouchUpInside];
//    [hhh addSubview:mNavView];
    
    mHeaderView = [mPersonView shareView];
    mHeaderView.frame = CGRectMake(0, 0, DEVICE_Width, 226);
    [mHeaderView.mHeaderBtn addTarget:self action:@selector(mHeaderAction:) forControlEvents:UIControlEventTouchUpInside];
    mHeaderView.mRightBtn.hidden = YES;
    [mHeaderView.mRightBtn addTarget:self action:@selector(mMsgAction:) forControlEvents:UIControlEventTouchUpInside];

    [hhh addSubview:mHeaderView];
    [self.tableView setTableHeaderView:hhh];

    UIView *mFooter = [UIView new];
    mFooter.frame = CGRectMake(0, 10, DEVICE_Width, 60);
    mFooter.backgroundColor = [UIColor clearColor];
    
    UIButton *mLogout = [UIButton new];
    mLogout.frame = CGRectMake(15, 10, DEVICE_Width-30, 40);
    mLogout.backgroundColor = M_CO;
    mLogout.layer.masksToBounds = YES;
    mLogout.layer.cornerRadius = 3;
    [mLogout setTitle:@"退出" forState:0];
    [mLogout setTitleColor:[UIColor whiteColor] forState:0];
    [mLogout addTarget:self action:@selector(logoutAction:) forControlEvents:UIControlEventTouchUpInside];
    [mFooter addSubview:mLogout];
    [self.tableView setTableFooterView:mFooter];
    
    [self initData];
}

- (void)logoutAction:(UIButton *)sender{

    [self AlertViewShow:@"退出登录" alertViewMsg:@"是否确定退出当前用户" alertViewCancelBtnTiele:@"取消" alertTag:10];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if (alertView.tag == 10) {
        if( buttonIndex == 1)
        {
            [mUserInfo logOut];
            [SVProgressHUD showSuccessWithStatus:@"退出成功"];
            [self gotoLoginVC];
        }
        
    }else if (alertView.tag == 12){
    
        if (buttonIndex == 1) {
            verifyBankViewController *vvv = [[verifyBankViewController alloc] initWithNibName:@"verifyBankViewController" bundle:nil];
            [self pushViewController:vvv];

        }
    }
    
    else{
        if( buttonIndex == 1)
        {
            needCodeViewController *nnn = [[needCodeViewController alloc] initWithNibName:@"needCodeViewController" bundle:nil];
            nnn.Type = 1;
            
            [self pushViewController:nnn];
            
            
            
        }
    }
    
   
}
- (void)AlertViewShow:(NSString *)alerViewTitle alertViewMsg:(NSString *)msg alertViewCancelBtnTiele:(NSString *)cancelTitle alertTag:(int)tag{
    
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:alerViewTitle message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:@"确定", nil];
    al.delegate = self;
    al.tag = tag;
    [al show];
}

- (void)headerBeganRefresh{
    
    [[mUserInfo backNowUser] getNowUserInfo:^(mBaseData *resb, mUserInfo *user) {
        [self headerEndRefresh];
        
        [self DissMissEmptyView];
        
        if (resb.mSucess) {
            [self initData];
        }else{
            [self ShowEmptyViewWithTitle:resb.mMessage andImg:nil andIsHiddenBtn:NO andHaveTabBar:NO];
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
    //                [LCProgressHUD showInfoMsg:@"即将到来，敬请期待！"];

//    return;
    MLLog(@"消息");
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
            if ([mUserInfo backNowUser].mIsHousingAuthentication) {
                
                if ([mUserInfo backNowUser].mIsRegist) {
                    cell.mDetail.text = @"已认证";
                }else{
                    cell.mDetail.text = @"绑定银行卡";
                }
                
                

            }else{
                cell.mDetail.text = @"未认证";

            }

        
        }else if (indexPath.row == 1){
            int m_leg = [mUserInfo backNowUser].mIs_leg;
            
            if ( m_leg == 0) {
                cell.mDetail.text = @"立即申请";
            }else if (m_leg == 1){
                cell.mDetail.text = @"未支付押金";
            }
            else if (m_leg == 2){
                cell.mDetail.text = @"审核中";
            }else if (m_leg == 3){
                cell.mDetail.text = @"被系统禁用";
                
            }else if (m_leg == 4){
                
                cell.mDetail.text = @"您已注销!";
                
            }
            else if(m_leg == 6){
                cell.mDetail.text = @"申请失败，重新申请!";
            }
            else{
                cell.mDetail.hidden = YES;
                
            }
            

        }
        else {
            if ([[dic objectForKey:@"hidden"] intValue]  == 1) {
                
                cell.mDetail.hidden = NO;
                
                
            }else{
                cell.mDetail.hidden = YES;
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
            
            if (![mUserInfo backNowUser].mUserId) {
                otherLoginViewController *ooo = [[otherLoginViewController alloc] initWithNibName:@"otherLoginViewController" bundle:nil];
                            ooo.mType = 2;
                ooo.mOpenId = [mUserInfo backNowUser].mOpenId;
                [self pushViewController:ooo];

            }
            
            if ([mUserInfo backNowUser].mIsHousingAuthentication) {
                
                if ([mUserInfo backNowUser].mIsRegist) {
                    hasCodeViewController *hhh = [hasCodeViewController new];
                    [self pushViewController:hhh];
                }else{
                    verifyBankViewController *vvv = [[verifyBankViewController alloc] initWithNibName:@"verifyBankViewController" bundle:nil];
                    [self pushViewController:vvv];
                }
                
                
                
            }else{
                needCodeViewController *nnn = [[needCodeViewController alloc] initWithNibName:@"needCodeViewController" bundle:nil];
                nnn.Type = 1;
                
                [self pushViewController:nnn];
                
            }
            
           
        }
            break;
        case 2:
        {
            MLLog(@"我的跑腿");
            if (![mUserInfo backNowUser].mIsHousingAuthentication) {
                
                [self AlertViewShow:@"未实名认证！" alertViewMsg:@"通过认证即可使用更多功能？" alertViewCancelBtnTiele:@"取消" alertTag:11];
                return;
            }else{
                int m_leg = [mUserInfo backNowUser].mIs_leg;
                
                if ( m_leg == 0) {
                    openPPTViewController *ppp = [[openPPTViewController alloc] initWithNibName:@"openPPTViewController" bundle:nil];
                    [self pushViewController:ppp];
                    
                }else if (m_leg == 1){
                    depositViewController *ddd = [[depositViewController alloc] initWithNibName:@"depositViewController" bundle:nil];
                    [self pushViewController:ddd];
                    
                }
                else if (m_leg == 2){
                    [self showSuccessStatus:@"正在审核中，请耐心等待！"];
                }else if (m_leg == 3){
                    [self showErrorStatus:@"您已被系统禁用!"];
                    
                }else if (m_leg == 4){
                    [self showErrorStatus:@"您已注销!"];
                    
                
                }
                else if (m_leg == 6){
                    openPPTViewController *ppp = [[openPPTViewController alloc] initWithNibName:@"openPPTViewController" bundle:nil];
                    [self pushViewController:ppp];
                    
                }
                else{
                    [self showSuccessStatus:@"您已成为跑腿者，无需再次申请！"];
                    
                }

                
            }
  
           
        }
            break;
        case 3:
        {

            MLLog(@"我的二维码");
            [LCProgressHUD showInfoMsg:@"即将到来，敬请期待！"];

//            barCodeViewController * bbb = [[barCodeViewController alloc] initWithNibName:@"barCodeViewController" bundle:nil];
//            
//            [self pushViewController:bbb];

            
        }
            break;
        case 4:
        {

            [LCProgressHUD showInfoMsg:@"即将到来，敬请期待！"];
            //            activityCenterViewController *mmm = [[activityCenterViewController alloc] initWithNibName:@"activityCenterViewController" bundle:nil];
            //            [self pushViewController:mmm];
            
            
        }
            break;
        case 5:
        {
     
            
            if (![mUserInfo backNowUser].mIsHousingAuthentication) {
                [self AlertViewShow:@"未实名认证！" alertViewMsg:@"通过认证即可使用更多功能？" alertViewCancelBtnTiele:@"取消" alertTag:11];
                return;
            }
            
            orderTongjiViewController *oo = [[orderTongjiViewController alloc] initWithNibName:@"orderTongjiViewController" bundle:nil];
            
            [self pushViewController:oo];


        }
            break;
        case 6:
        {
            [LCProgressHUD showInfoMsg:@"即将到来，敬请期待！"];

            
        }
            break;
        case 7:
        {
            if (![mUserInfo backNowUser].mIsHousingAuthentication) {
                [self AlertViewShow:@"未实名认证！" alertViewMsg:@"通过认证即可使用更多功能？" alertViewCancelBtnTiele:@"取消" alertTag:11];
                return;
            }
            
            needCodeViewController *nnn = [[needCodeViewController alloc] initWithNibName:@"needCodeViewController" bundle:nil];
            nnn.Type = 3;
            [self pushViewController:nnn];
            
        }
            break;
        default:
            break;
    }


    
    
}

#pragma mark----导航条渐变
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGFloat offset_Y = scrollView.contentOffset.y;
//    CGFloat alpha = (offset_Y + 40)/300.0f;
//    self.navBar.hidden = NO;
//    self.navBar.alpha=alpha;
//    
//    CGRect mRR = self.tableView.frame;
//    
//    if (offset_Y == 40) {
//        mRR.origin.y = 64;
//        self.tableView.frame = mRR;
//    }
//    
//
 
    
}
@end
