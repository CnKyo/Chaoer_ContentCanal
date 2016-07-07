//
//  makeFixOrderDetailViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/24.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "makeFixOrderDetailViewController.h"
#import "makeServiceDetailView.h"

#import "mFixOrderFooter.h"
#import "mFixOrderDetailTableViewCell.h"

#import "goPayViewController.h"
@interface makeFixOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@end

@implementation makeFixOrderDetailViewController
{
    
    mFixOrderFooter *mFooterView;
    
    UIButton *mBottomBtn;

}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    [self headerBeganRefresh];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Title = self.mPageName = @"维修订单详情";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    [self initView];
}
- (void)initView{
    
    
    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-114) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.haveHeader = YES;
    
    
    UINib   *nib = [UINib nibWithNibName:@"mFixOrderDetailTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    


}


- (void)headerBeganRefresh{
    [self upDateUserInfo];
    [SVProgressHUD showWithStatus:@"正在加载中..." maskType:SVProgressHUDMaskTypeClear];
    MLLog(@"id是：%@",self.mFixOrder.mOrderID);
    [[mUserInfo backNowUser] getOrderDetail:self.mFixOrder.mOrderID block:^(mBaseData *resb, GFixOrder *mFixOrder) {
        [self headerEndRefresh];
        if (resb.mSucess) {
            [SVProgressHUD dismiss];
            
            self.mFixOrder = mFixOrder;
            [self loadBottom];

            [self.tableView reloadData];
            
        }else{
        
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
            [self popViewController];
        }
        
    }];
}

- (void)upDateUserInfo{

    [[mUserInfo backNowUser] getNowUserInfo:^(mBaseData *resb, mUserInfo *user) {
        
        
        if (resb.mSucess) {
        }else{
        }
    }];

}

- (void)loadBottom{
    if (mBottomBtn == nil) {
        mBottomBtn = [UIButton new];
        mBottomBtn.frame = CGRectMake(10, DEVICE_Height-60, DEVICE_Width-20, 40);
        [mBottomBtn addTarget:self action:@selector(mFinishAction:) forControlEvents:UIControlEventTouchUpInside];
        
        mBottomBtn.layer.masksToBounds = YES;
        mBottomBtn.layer.cornerRadius = 3;
 
        [self.view addSubview:mBottomBtn];
    }
    
    if (self.mFixOrder.mStatus == 5) {
        [mBottomBtn setTitle:@"完成服务" forState:0];
        mBottomBtn.backgroundColor = M_CO;
        
        mBottomBtn.userInteractionEnabled = YES;
    }else if (self.mFixOrder.mStatus == 6){
        [mBottomBtn setTitle:@"服务已完成" forState:0];
        mBottomBtn.backgroundColor = [UIColor lightGrayColor];
        
        mBottomBtn.userInteractionEnabled = NO;
    }else{
        
        [mBottomBtn setTitle:@"服务进行中" forState:0];
        mBottomBtn.backgroundColor = [UIColor lightGrayColor];
        
        mBottomBtn.userInteractionEnabled = NO;
    }
    
    for (UIView *vvv in self.tableView.tableFooterView.subviews) {
        [vvv removeFromSuperview];
    }
    
    mFooterView = [mFixOrderFooter shareView];
    mFooterView.frame = CGRectMake(0, 0, DEVICE_Width, 60);
    //    mContent.text = self.mFixOrder.mDescription;
    
    CGFloat mH = [Util labelText:self.mFixOrder.mDescription fontSize:14 labelWidth:mFooterView.mNote.mwidth];
    
    CGRect mRR = mFooterView.frame;
    mRR.size.height = 60+mH;
    mFooterView.frame = mRR;
    [self.tableView setTableFooterView:mFooterView];
        
    
    
}
- (void)mFinishAction:(UIButton *)sender{

    
//    if ([mUserInfo backNowUser].mMoney < self.mFixOrder.mOrderPrice) {
//        [self AlertViewShow:@"余额不足，支付失败！" alertViewMsg:@"是否要去充值？" alertViewCancelBtnTiele:@"取消" alertTag:100];
//        return;
//    }
    
    
    goPayViewController *pay = [[goPayViewController alloc] initWithNibName:@"goPayViewController" bundle:nil];
    pay.mMoney = self.mFixOrder.mOrderPrice;
    pay.mType = 2;
    pay.mOrderCode = self.mFixOrder.mOrderCode;
    [self pushViewController:pay];
    
//    [SVProgressHUD showWithStatus:@"正在确认..." maskType:SVProgressHUDMaskTypeClear];
//    
//    [[mUserInfo backNowUser] finishFixOrder:self.mFixOrder.mOrderID andPayType:@"6" andRate:@"好评" block:^(mBaseData *resb) {
//        if (resb.mSucess) {
//            [SVProgressHUD showSuccessWithStatus:resb.mMessage];
//            
//            [self popViewController];
//            
//        }else{
//        
//            [SVProgressHUD showErrorWithStatus:resb.mMessage];
//        }
//    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 465;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    
    mFixOrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    cell.mServiceName.text = [NSString stringWithFormat:@"维修师傅：%@",self.mFixOrder.mMerchantName];
    cell.mServicePhone.text = [NSString stringWithFormat:@"师傅电话：%@",self.mFixOrder.tel];

    cell.mOrderName.text = [NSString stringWithFormat:@"订单类型：%@",self.mFixOrder.mClassificationName2];;
    cell.mAddress.text = [NSString stringWithFormat:@"%@",self.mFixOrder.mAddress];
    cell.mOrderTime.text = [NSString stringWithFormat:@"服务时间：%@",self.mFixOrder.mOrderServiceTime];
    cell.mMoney.text = [NSString stringWithFormat:@"%.2f元",self.mFixOrder.mOrderPrice];
    cell.mOrderCode.text = [NSString stringWithFormat:@"订单编号：%@",self.mFixOrder.mOrderCode];
    
    
    [cell.mConnectBtn addTarget:self action:@selector(mConnectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.mFixOrder.mStatus == 5) {
        cell.mStatus.text = @"完成服务";
        cell.mOrderStatusImg.image = [UIImage imageNamed:@"service_finish"];
        
    }else if (self.mFixOrder.mStatus == 6){
        cell.mStatus.text = @"服务已完成";
        cell.mOrderStatusImg.image = [UIImage imageNamed:@"service_finish"];
    }else{
        cell.mStatus.text = @"服务进行中";
        cell.mOrderStatusImg.image = [UIImage imageNamed:@"service_ing"];
    }
    
    
    return cell;
    
}

- (void)mConnectAction:(UIButton *)sender{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.mFixOrder.tel];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        if( buttonIndex == 1)
        {
            
            mBalanceViewController *ppp = [[mBalanceViewController alloc] initWithNibName:@"mBalanceViewController" bundle:nil];
            
            [self pushViewController:ppp];
            
            
        }
    }
}

- (void)AlertViewShow:(NSString *)alerViewTitle alertViewMsg:(NSString *)msg alertViewCancelBtnTiele:(NSString *)cancelTitle alertTag:(int)tag{
    
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:alerViewTitle message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:@"确定", nil];
    al.delegate = self;
    al.tag = tag;
    [al show];
}
@end
