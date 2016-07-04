//
//  pptMyViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/13.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "pptMyViewController.h"

#import "BlockButton.h"

#import "pptMyHeaderView.h"

#import "pptMyCell.h"

#import "pptChoulaoViewController.h"
#import "pptMyInfoViewController.h"
#import "pptMyAddressViewController.h"
#import "pptMyRateViewController.h"
#import "pptMyMsgViewController.h"

#import "myTagViewController.h"
@interface pptMyViewController ()<UITableViewDelegate,UITableViewDataSource
>

@end

@implementation pptMyViewController
{


    pptMyHeaderView *mHeaderView;
    
    GPPTer *mPPTUser;
    
    UIButton *mPhoneBtn;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.Title = self.mPageName = @"我的";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.hiddenRightBtn = YES;
    NSArray *mArrar = @[@"基本信息",@"酬金记录",@"我的地址",@"常见问题"];
    NSArray *mImgar = @[[UIImage imageNamed:@"ppt_my_info"],[UIImage imageNamed:@"ppt_my_choujin"],[UIImage imageNamed:@"ppt_my_address"],[UIImage imageNamed:@"ppt_my_faq"]];
    
    [self.tempArray addObject:mArrar];
    [self.tempArray addObject:mImgar];
    
    
    
    [self initView];


}
- (void)initView{
    
    
    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.haveHeader = YES;
    
    UINib   *nib = [UINib nibWithNibName:@"pptMyCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    mHeaderView = [pptMyHeaderView shareViuew];
    mHeaderView.frame = CGRectMake(0, 0, DEVICE_Width, 260);
    
    [mHeaderView.mMyTagBtn addTarget:self action:@selector(tagAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [mHeaderView.mMyMsgBtn addTarget:self action:@selector(msgAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [mHeaderView.mMyRateBtn addTarget:self action:@selector(rateAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *mBottomView = [UIView new];
    mBottomView.frame = CGRectMake(0, DEVICE_Height-60, DEVICE_Width, 60);
    mBottomView.backgroundColor = [UIColor whiteColor];
    
    mBottomView.layer.masksToBounds = YES;
    mBottomView.layer.borderColor = [UIColor colorWithRed:0.82 green:0.82 blue:0.82 alpha:1.00].CGColor;
    mBottomView.layer.borderWidth = 0.5;
    
   
    mPhoneBtn = [UIButton new];
    mPhoneBtn.frame = CGRectMake(0, 10, DEVICE_Width, 40);
    mPhoneBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    mPhoneBtn.backgroundColor = [UIColor clearColor];
    [mPhoneBtn setTitle:[NSString stringWithFormat:@"客服电话:%@",[GPPTer backPPTUser].mPhone] forState:0];
    [mPhoneBtn addTarget:self action:@selector(mPhoneAction:) forControlEvents:UIControlEventTouchUpInside];
    [mPhoneBtn setTitleColor:M_CO forState:0];

    [mBottomView addSubview:mPhoneBtn];
    [self.tableView setTableHeaderView:mHeaderView];
    [self.tableView setTableFooterView:mBottomView];
    
}
- (void)mPhoneAction:(UIButton *)sender{
    
    if ([GPPTer backPPTUser].mPhone.length == 0) {
        [self showErrorStatus:@"客服电话有误！"];
        return;
    }
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[GPPTer backPPTUser].mPhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}
- (void)headerBeganRefresh{

    [GPPTer getPPTerInfo:[mUserInfo backNowUser].mUserId block:^(mBaseData *resb, GPPTer *mUser) {

        
        [self headerEndRefresh];
        
        if (resb.mSucess) {
            [mPhoneBtn setTitle:[NSString stringWithFormat:@"客服电话:%@",[GPPTer backPPTUser].mPhone] forState:0];

            [self upLoadPage];
            
        }else{
        
            [self showErrorStatus:resb.mMessage];
            [self popViewController];
        }
        
    }];
    
}
- (void)upLoadPage{

    mHeaderView.mLevel.text = [NSString stringWithFormat:@"%@",[GPPTer backPPTUser].mLevel];
    mHeaderView.mMoney.text = [NSString stringWithFormat:@"%@¥",[GPPTer backPPTUser].mTotleMoney];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",[HTTPrequest currentResourceUrl],[GPPTer backPPTUser].mHeaderImg];

    [mHeaderView.mHeaderImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"icon_headerdefault"]];

    mHeaderView.mName.text = [GPPTer backPPTUser].mName;
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark----标签
- (void)tagAction:(UIButton *)sender{
    myTagViewController *ppp = [[myTagViewController alloc] initWithNibName:@"myTagViewController" bundle:nil];
    [self pushViewController:ppp];
}
#pragma mark----消息
- (void)msgAction:(UIButton *)sender{
    pptMyMsgViewController *ppp = [[pptMyMsgViewController alloc] initWithNibName:@"pptMyMsgViewController" bundle:nil];
    [self pushViewController:ppp];
}
#pragma mark----评价
- (void)rateAction:(UIButton *)sender{
    pptMyRateViewController *ppp = [[pptMyRateViewController alloc] initWithNibName:@"pptMyRateViewController" bundle:nil];
    [self pushViewController:ppp];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    
    pptMyCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    cell.mTitle.text = self.tempArray[0][indexPath.row];
    cell.mImg.image = self.tempArray[1][indexPath.row];
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        pptMyInfoViewController *ppt = [[pptMyInfoViewController alloc] initWithNibName:@"pptMyInfoViewController" bundle:nil];
        [self pushViewController:ppt];
    }else if (indexPath.row == 1){
    
        pptChoulaoViewController *ppt = [[pptChoulaoViewController alloc] initWithNibName:@"pptChoulaoViewController" bundle:nil];
        [self pushViewController:ppt];
    }else if (indexPath.row == 2){
    
        pptMyAddressViewController *ppt = [[pptMyAddressViewController alloc] initWithNibName:@"pptMyAddressViewController" bundle:nil];
        ppt.mType = 2;
        [self pushViewController:ppt];
    }else{
    
        
        WebVC* vc = [[WebVC alloc]init];
        vc.mName = @"常见问题";
        vc.mUrl = [GPPTer backPPTUser].mFAQUrl;
        [self pushViewController:vc];

        
    }
    
    
    
}

- (void)rightBtnTouched:(id)sender{

    [self AlertViewShow:@"确定注销！" alertViewMsg:@"注销身份之后将不可撤销，如要申请需再次提交资料！" alertViewCancelBtnTiele:@"取消" alertTag:10];
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if( buttonIndex == 1)
    {
        [self showWithStatus:@"正在操作..."];
        [[GPPTer backPPTUser] cancelPPTIdentify:^(mBaseData *resb) {
            if (resb.mSucess) {
                [self showSuccessStatus:resb.mMessage];
                [self popViewController];
            }else{
                [self showErrorStatus:resb.mMessage];
            }
        }];
    }
}
- (void)AlertViewShow:(NSString *)alerViewTitle alertViewMsg:(NSString *)msg alertViewCancelBtnTiele:(NSString *)cancelTitle alertTag:(int)tag{
    
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:alerViewTitle message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:@"确定", nil];
    al.delegate = self;
    al.tag = tag;
    [al show];
}


@end
