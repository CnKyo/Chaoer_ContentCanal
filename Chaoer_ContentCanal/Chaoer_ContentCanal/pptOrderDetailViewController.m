//
//  pptOrderDetailViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "pptOrderDetailViewController.h"
#import "pptDetailCell.h"

#import "evolutionViewController.h"


#import "mCustomTxView.h"


@interface pptOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation pptOrderDetailViewController
{

    mCustomTxView *mPopView;
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

    self.Title = self.mPageName = @"跑单详情";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    
    self.rightBtnImage = [UIImage imageNamed:@"right_phone"];
    
    [self initView];
    [self initPopView];
    
    

}
- (void)initView{
    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;

    self.haveHeader = YES;
    
    UINib   *nib = [UINib nibWithNibName:@"pptDetailCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    nib = [UINib nibWithNibName:@"pptDetailCell2" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];
    nib = [UINib nibWithNibName:@"pptDetailCell3" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell3"];
    nib = [UINib nibWithNibName:@"pptDetailCell4" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell4"];
    nib = [UINib nibWithNibName:@"pptDetailCell5" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell5"];
}


- (void)headerBeganRefresh{

    
    if (self.mOrderType == 1) {
        [[mUserInfo backNowUser] getOrderDetail:self.mType andMorderID:[NSString stringWithFormat:@"%d",self.mOrder.mId] andOrderCode:self.mOrder.mOrderCode block:^(mBaseData *resb, GPPTOrder *mOrder) {
            
            [self headerEndRefresh];
            
            if (resb.mSucess) {
                
                self.mOrder = mOrder;
                [self.tableView reloadData];
                
            }else{
                [self showErrorStatus:resb.mMessage];
                [self performSelector:@selector(leftBtnTouched:) withObject:nil afterDelay:1.5];
            }
            
        }];
    }else{
        [[mUserInfo backNowUser] getOrderDetail:self.mType andMorderID:[NSString stringWithFormat:@"%d",self.mOrder.mId] andOrderCode:self.mOrder.mOrderCode block:^(mBaseData *resb, GPPTOrder *mOrder) {
            
            [self headerEndRefresh];
            
            if (resb.mSucess) {
                
                self.mOrder = mOrder;
                [self.tableView reloadData];
                
            }else{
                [self showErrorStatus:resb.mMessage];
                [self performSelector:@selector(leftBtnTouched:) withObject:nil afterDelay:1.5];
            }
            
        }];
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
    
    if (self.mOrderType == 1) {
        if (self.mType == 1) {
            return 700;
        }else{
            return 770;
        }
    }else{
        if (self.mType == 1) {
            return 770;
        }
        else{
            return 820;

        }
    }
    
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *reuseCellId = nil;
    if (self.mOrderType == 1) {
        if (self.mType == 1) {
            reuseCellId = @"cell";
            
        }else{
            reuseCellId = @"cell2";
            
        }
    }else{
        if (self.mType == 1) {
            reuseCellId = @"cell3";
            
        }else{
            reuseCellId = @"cell4";
        }

    }
    
    pptDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.mDoBtn removeTarget:self action:@selector(mCancelOrderAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.mDoBtn removeTarget:self action:@selector(getOrderAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.mDoBtn removeTarget:self action:@selector(finishOrderAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [cell.mDoBtn removeTarget:self action:@selector(rateOrderAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
    

    
    cell.mDoBtn.mOrder = self.mOrder;

    [cell.mHeaderImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[HTTPrequest currentResourceUrl],self.mOrder.mPortrait]] placeholderImage:[UIImage imageNamed:@"img_default"]];

    if (self.mOrderType == 1) {
     
        cell.mOrderDetailName.text = [NSString stringWithFormat:@"创建时间：%@",self.mOrder.mGenTime];
        cell.mTHXMoney.text = [NSString stringWithFormat:@"酬劳金额:%@",self.mOrder.mLegworkMoney];
        cell.mOrderNum.text = [NSString stringWithFormat:@"订单编号：%@",self.mOrder.mOrderCode];
        cell.mOrderName.text = self.mOrder.mContext;
        cell.mServiceName.text = [NSString stringWithFormat:@"姓名：%@",self.mOrder.mUserName];
        
        cell.mPhone.text = [NSString stringWithFormat:@"电话：%@",self.mOrder.mPhone];
        
        cell.mServiceTime.text = [NSString stringWithFormat:@"时间：%@分钟",self.mOrder.mArrivedTime];
        
        cell.mArriveAddress.text = [NSString stringWithFormat:@"地址：%@",self.mOrder.mAdress];
        
        cell.mSendMoney.text = [NSString stringWithFormat:@"酬金：%@元",self.mOrder.mLegworkMoney];
        
#pragma mark----判断是否能接单
        
        if (self.mOrder.mProcessStatus == 0) {
            cell.mDoBtn.backgroundColor = [UIColor lightGrayColor];
            cell.mDoBtn.enabled = NO;
        }else{
            if ([mUserInfo backNowUser].mUserId == [self.mOrder.mUserId intValue]) {
                
                [cell.mDoBtn setTitle:@"取消订单" forState:0];
                cell.mDoBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                if (cell.mDoBtn.allTargets.count == 0) {

                [cell.mDoBtn addTarget:self action:@selector(mCancelOrderAction:) forControlEvents:UIControlEventTouchUpInside];
                }
                
                cell.mDoBtn.tag = 10;

            }else{
                if ([mUserInfo backNowUser].mIs_leg != 5) {
                    cell.mDoBtn.backgroundColor = [UIColor lightGrayColor];
                    cell.mDoBtn.enabled = NO;
                }else{
                    cell.mDoBtn.backgroundColor = M_CO;
                    cell.mDoBtn.enabled = YES;
                    [cell.mDoBtn addTarget:self action:@selector(getOrderAction:) forControlEvents:UIControlEventTouchUpInside];
                    cell.mDoBtn.tag = 20;
                }
            }
        }
 
        NSString *ordertype = nil;
        
        if (self.mType == 1) {
            ordertype = @"商品买送";
        }else if (self.mType == 2){
            ordertype = @"事情办理";
        }else{
            ordertype = @"送东西";
        }
        
        cell.mOrderType.text = [NSString stringWithFormat:@"订单类型：%@",ordertype];
        cell.mPayType.text = [NSString stringWithFormat:@"支付方式：%@",@"余额支付"];
        cell.mNote.text = [NSString stringWithFormat:@"备注：%@",self.mOrder.mComments];
        if (self.mType == 1) {
            /**
             *  cell1
             */
            for (UILabel *lb in cell.mTagView.subviews) {
                [lb removeFromSuperview];
            }
            CGFloat mWW = [Util labelTextWithWidth:self.mOrder.mTypeName]+15;
            
            UILabel *lll = [UILabel new];
            
            lll.frame = CGRectMake(5, 5, mWW, 20);
            lll.text = self.mOrder.mTypeName;
            lll.textColor = [UIColor whiteColor];
            lll.textAlignment = NSTextAlignmentCenter;
            lll.font = [UIFont systemFontOfSize:14];
            lll.backgroundColor = [UIColor colorWithRed:0.55 green:0.75 blue:0.94 alpha:1.00];
            lll.layer.masksToBounds = YES;
            lll.layer.cornerRadius = 10;
            [cell.mTagView addSubview:lll];

            
        }else if(self.mType == 2){
            /**
             *  cell2
             */
            cell.mServiceName.text = [NSString stringWithFormat:@"姓名：%@",[mUserInfo backNowUser].mNickName];
            cell.mServiceTime.text = [NSString stringWithFormat:@"时间：%@分钟",@"暂无"];

            cell.mSendAddress.text = [NSString stringWithFormat:@"地址：%@",self.mOrder.mAdress];
            cell.mArriveAddress.text = [NSString stringWithFormat:@"到达地址：%@",@"暂无"];
            cell.mNote.text = [NSString stringWithFormat:@"备注:%@",self.mOrder.mComments];
        }else{
            /**
             *  cell2
             */
            cell.mStaffPrice.text = [NSString stringWithFormat:@"物品价格:%@元",self.mOrder.mGoodsPrice];
            cell.mSendAddress.text = [NSString stringWithFormat:@"发货地址:%@",self.mOrder.mSendAddress];
            cell.mArriveAddress.text = [NSString stringWithFormat:@"送达地址:%@",self.mOrder.mArrivedAddress];
            cell.mServiceTime.text = [NSString stringWithFormat:@"交通工具：%@",self.mOrder.mTrafficName];
            cell.mServiceName.text = [NSString stringWithFormat:@"商品名称：%@",self.mOrder.mGoodsName];
            cell.mNote.text = [NSString stringWithFormat:@"备注:%@",self.mOrder.mComments];


        }
    }else{
        
#pragma mark----跑腿者操作
        UIImage *mStatusImg = nil;
        
        if (self.mOrder.mProcessStatus == 0) {
            /**
             *  取消
             */
            
            [cell.mDoBtn setTitle:@"取消订单" forState:0];
            cell.mDoBtn.enabled = NO;

            cell.mDoBtn.backgroundColor = [UIColor lightGrayColor];
            
            mStatusImg = [UIImage imageNamed:@"ppt_order_wait"];
            
        }else if (self.mOrder.mProcessStatus == 1){
            /**
             *  发布
             */
            [cell.mDoBtn setTitle:@"已发布" forState:0];
            cell.mDoBtn.backgroundColor = [UIColor lightGrayColor];
            cell.mDoBtn.enabled = NO;
            mStatusImg = [UIImage imageNamed:@"ppt_order_wait"];
        }else if (self.mOrder.mProcessStatus == 2){
            /**
             *  进行中
             */
            /**
             *  如果是跑腿者
             */
            if ([mUserInfo backNowUser].mIs_leg == 5 && [mUserInfo backNowUser].mUserId != [self.mOrder.mUserId intValue]) {
                [cell.mDoBtn setTitle:@"确认完成" forState:0];
                cell.mDoBtn.backgroundColor = M_CO;
                
                cell.mDoBtn.enabled = YES;
                mStatusImg = [UIImage imageNamed:@"ppt_order_accept"];
                [cell.mDoBtn addTarget:self action:@selector(mReleasecomformAction:) forControlEvents:UIControlEventTouchUpInside];
                cell.mDoBtn.tag = 300;
                
            }else{
                [cell.mDoBtn setTitle:@"订单进行中" forState:0];
                cell.mDoBtn.backgroundColor = [UIColor lightGrayColor];
                
                cell.mDoBtn.enabled = NO;
                mStatusImg = [UIImage imageNamed:@"ppt_order_accept"];
            }
       
            
   
            
        }else if (self.mOrder.mProcessStatus == 3){
            /**
             *  确认订单
             */
//            [cell.mDoBtn setTitle:@"订单已被确认" forState:0];
//            cell.mDoBtn.backgroundColor = [UIColor lightGrayColor];
//            cell.mDoBtn.enabled = NO;
//            mStatusImg = [UIImage imageNamed:@"ppt_order_wait"];
            /**
             *  确定完成
             */
            
            if ([mUserInfo backNowUser].mIs_leg == 5 && [mUserInfo backNowUser].mUserId != [self.mOrder.mUserId intValue]) {
                [cell.mDoBtn setTitle:@"等待确认" forState:0];
                
                cell.mDoBtn.enabled = NO;
                cell.mDoBtn.backgroundColor = [UIColor lightGrayColor];
                
    
                mStatusImg = [UIImage imageNamed:@"ppt_order_sended"];
            }else{
            
                [cell.mDoBtn setTitle:@"确认完成" forState:0];
                
                cell.mDoBtn.enabled = YES;
                cell.mDoBtn.backgroundColor = M_CO;
                
                [cell.mDoBtn addTarget:self action:@selector(finishOrderAction:) forControlEvents:UIControlEventTouchUpInside];
                cell.mDoBtn.tag = 30;
                mStatusImg = [UIImage imageNamed:@"ppt_order_sended"];
            }
        
        }else if (self.mOrder.mProcessStatus == 4){
            /**
             *  评价
             */
            if ([mUserInfo backNowUser].mIs_leg == 5 && [mUserInfo backNowUser].mUserId != [self.mOrder.mUserId intValue]) {
                [cell.mDoBtn setTitle:@"待评价" forState:0];
                cell.mDoBtn.enabled = NO;
                cell.mDoBtn.backgroundColor = [UIColor lightGrayColor];
                mStatusImg = [UIImage imageNamed:@"ppt_order_finish"];

            }else{
            
                [cell.mDoBtn setTitle:@"去评价" forState:0];
                cell.mDoBtn.enabled = YES;
                cell.mDoBtn.backgroundColor = M_CO;
                
                [cell.mDoBtn addTarget:self action:@selector(rateOrderAction:) forControlEvents:UIControlEventTouchUpInside];
                cell.mDoBtn.tag = 40;
                mStatusImg = [UIImage imageNamed:@"ppt_order_finish"];

            }
            
        }else{
            /**
             *  已完成
             */
            [cell.mDoBtn setTitle:self.mOrder.mStatusName forState:0];
            cell.mDoBtn.enabled = NO;
            cell.mDoBtn.backgroundColor = [UIColor lightGrayColor];

            mStatusImg = [UIImage imageNamed:@"ppt_order_finish"];
        }
        
        cell.mOrderStatusImg.image = mStatusImg;

        cell.mOrderStatus.text = self.mOrder.mStatusName;
        cell.mLevel.text = [NSString stringWithFormat:@"创建时间:%@",self.mOrder.mGenTime];
       
        NSString *mmname = nil;
        
        if (self.mOrder.mGoodsTypeName == nil) {
            mmname = self.mOrder.mTypeName;
        }
        if (self.mOrder.mTypeName == nil) {
            mmname = self.mOrder.mGoodsTypeName;
        }
        if (mmname == nil || mmname.length == 0 || [mmname isEqualToString:@""]) {
            mmname = @"暂无";
        }
        
        cell.mSenderMg.text = [NSString stringWithFormat:@"商品类型:%@",mmname];
        cell.mOrderNum.text = [NSString stringWithFormat:@"订单编号：%@",self.mOrder.mOrderCode];
        cell.mOrderName.text = self.mOrder.mTypeName;
        
        cell.mServiceName.text = [NSString stringWithFormat:@"姓名：%@",self.mOrder.mUserName];
        cell.mPhone.text = [NSString stringWithFormat:@"电话：%@",self.mOrder.mPhone];
        cell.mServiceTime.text = [NSString stringWithFormat:@"时间：%@分钟",self.mOrder.mArrivedTime];
        cell.mArriveAddress.text = [NSString stringWithFormat:@"地址：%@",self.mOrder.mAdress];
        cell.mSendMoney.text = [NSString stringWithFormat:@"费用：%@元",self.mOrder.mLegworkMoney];
        
        NSString *ordertype = nil;

        if (self.mType == 1) {
            ordertype = @"商品买送";
        }else if (self.mType == 2){
            ordertype = @"事情办理";
        }else{
            ordertype = @"送东西";
        }
        
        cell.mOrderType.text = [NSString stringWithFormat:@"订单类型：%@",ordertype];
        cell.mPayType.text = [NSString stringWithFormat:@"支付方式：%@",@"余额支付"];
        cell.mNote.text = [NSString stringWithFormat:@"备注：%@",self.mOrder.mComments];
        if (self.mType == 1) {
            /**
             *  cell3
             */
            
        }else if (self.mType == 2){
        
            cell.mServiceName.text = [NSString stringWithFormat:@"姓名：%@",[mUserInfo backNowUser].mNickName];
            cell.mServiceTime.text = [NSString stringWithFormat:@"时间：%@分钟",@"暂无"];
            
            cell.mSendAddress.text = [NSString stringWithFormat:@"地址：%@",self.mOrder.mAdress];
            cell.mArriveAddress.text = [NSString stringWithFormat:@"到达地址：%@",@"暂无"];
            cell.mNote.text = [NSString stringWithFormat:@"备注:%@",self.mOrder.mComments];
        }
        else{
            /**
             *  cell4
             */
 
            
            cell.mStaffPrice.text = [NSString stringWithFormat:@"物品价格:%@元",self.mOrder.mGoodsPrice];
            cell.mSendAddress.text = [NSString stringWithFormat:@"发货地址:%@",self.mOrder.mSendAddress];
            cell.mArriveAddress.text = [NSString stringWithFormat:@"送达地址:%@",self.mOrder.mArrivedAddress];
            cell.mServiceTime.text = [NSString stringWithFormat:@"交通工具：%@",self.mOrder.mTrafficName];
            cell.mServiceName.text = [NSString stringWithFormat:@"商品名称：%@",self.mOrder.mGoodsName];
            cell.mNote.text = [NSString stringWithFormat:@"备注:%@",self.mOrder.mComments];


        }
        
    }
    
    
    
    
    return cell;
    
}


#pragma mark----接单
- (void)getOrderAction:(mOrderButton *)sender{

    if (sender.tag == 20) {
        if (self.mLng ==nil || self.mLng.length == 0 || [self.mLng isEqualToString:@""]) {
            [self showErrorStatus:@"必须打开定位才能接单哦！"];
            return;
        }
        if (self.mLat ==nil || self.mLat.length == 0 || [self.mLat isEqualToString:@""]) {
            [self showErrorStatus:@"必须打开定位才能接单哦！"];
            return;
        }
        
        [self showWithStatus:@"正在操作..."];
        [[mUserInfo backNowUser] getPPTOrder:[mUserInfo backNowUser].mLegworkUserId andOrderCode:self.mOrder.mOrderCode andOrderType:[NSString stringWithFormat:@"%d",self.mType] andLat:self.mLat andLng:self.mLng block:^(mBaseData *resb) {
            
            if (resb.mSucess) {
                
                [self showSuccessStatus:resb.mMessage];
                
                [self performSelector:@selector(leftBtnTouched:) withObject:nil afterDelay:1.5];
                
                
            }else{
                
                [self showErrorStatus:resb.mMessage];
            }
            
        }];
    }
    

    
}

#pragma mark----跑腿者确认订单
- (void)mReleasecomformAction:(mOrderButton *)sender{

    if (sender.tag == 300) {
        [UIView animateWithDuration:0.25 animations:^{
            mPopView.alpha = 1;
        }];
    }

    
    
}
#pragma mark----发布者确认订单
- (void)finishOrderAction:(mOrderButton *)sender{
    if (sender.tag == 30) {
        if (self.mOrder.mOrderCode == nil || [self.mOrder.mOrderCode isEqualToString:@""] || self.mOrder.mOrderCode.length == 0) {
            [self showErrorStatus:@"订单编号有误!请确认订单后重试。"];
            return;
        }
        if (self.mLat == nil || self.mLat.length == 0 || [self.mLat isEqualToString:@""]) {
            [self showErrorStatus:@"必须打开定位才能确认完成！"];
            return;
        }
        
        [self showWithStatus:@"正在操作..."];
        
        [[GPPTer backPPTUser] finishPPTOrder:[[NSString stringWithFormat:@"%@",self.mOrder.mUserId] intValue] andOrderCode:self.mOrder.mOrderCode andOrderType:self.mType andLat:self.mLat andLng:self.mLng block:^(mBaseData *resb) {
            
            if (resb.mSucess) {
                [self showSuccessStatus:resb.mMessage];
                [self headerBeganRefresh];
            }else{
                
                [self showErrorStatus:resb.mMessage];
                [self headerBeganRefresh];
            }
            
            
        }];

    }
    
    
    
    
    
}
#pragma mark----评价订单
- (void)rateOrderAction:(mOrderButton *)sender{
    if (sender.tag == 40) {
        evolutionViewController *eee = [[evolutionViewController alloc] initWithNibName:@"evolutionViewController" bundle:nil];
        eee.mOrder = GPPTOrder.new;
        eee.mOrder = sender.mOrder;
        eee.mLat = self.mLat;
        eee.mLng = self.mLng;
        eee.mType = self.mType;
        [self pushViewController:eee];
    }
 

}


#pragma mark----取消订单
- (void)mCancelOrderAction:(mOrderButton *)sender{
    if (sender.tag == 10) {
        if (self.mLng ==nil || self.mLng.length == 0 || [self.mLng isEqualToString:@""]) {
            [self showErrorStatus:@"必须打开定位才能操作哦！"];
            return;
        }
        if (self.mLat ==nil || self.mLat.length == 0 || [self.mLat isEqualToString:@""]) {
            [self showErrorStatus:@"必须打开定位才能操作哦！"];
            return;
        }
        
        [self showWithStatus:@"正在操作..."];
        
        [[mUserInfo backNowUser] cancelOrder:[mUserInfo backNowUser].mUserId andOrderCode:sender.mOrder.mOrderCode andOrderType:_mType andLat:self.mLat andLng:self.mLng block:^(mBaseData *resb) {
            
            if (resb.mSucess) {
                
                [self showSuccessStatus:resb.mMessage];
                [self performSelector:@selector(leftBtnTouched:) withObject:nil afterDelay:1.5];

            }else{
                
                [self showErrorStatus:resb.mMessage];
            }
            
        }];
    }

    
    
    
}

#pragma mark----打电话
- (void)rightBtnTouched:(id)sender{

    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.mOrder.mPhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (void)leftBtnTouched:(id)sender{

    [self popViewController];
}

#pragma mark----弹出输入框
- (void)initPopView{

    mPopView = [mCustomTxView shareView];
    mPopView.frame = self.view.bounds;
    mPopView.alpha = 0;
    [mPopView.mCancelBtn addTarget:self action:@selector(dismissPopAction:) forControlEvents:UIControlEventTouchUpInside];
    [mPopView.mOkBtn addTarget:self action:@selector(comfirmPopAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mPopView];

}


- (void)dismissPopAction:(UIButton *)sender{

    
    [UIView animateWithDuration:0.25 animations:^{
        mPopView.alpha = 0;
    }];
    
}
- (void)comfirmPopAction:(UIButton *)sender{
    
    
    if (mPopView.mTx.text.length == 0) {
        [self showErrorStatus:@"金额不能为空！"];
        [mPopView.mTx becomeFirstResponder];
        return;
    }
    
    
    if (self.mOrder.mOrderCode == nil || [self.mOrder.mOrderCode isEqualToString:@""] || self.mOrder.mOrderCode.length == 0) {
        [self showErrorStatus:@"订单编号有误!请确认订单后重试。"];
        return;
    }
    if (self.mLat == nil || self.mLat.length == 0 || [self.mLat isEqualToString:@""]) {
        [self showErrorStatus:@"必须打开定位才能确认完成！"];
        return;
    }
    
    [self showWithStatus:@"正在操作..."];
    
    [[GPPTer backPPTUser] mServicefinishPPTOrder:[mUserInfo backNowUser].mLegworkUserId andMoney:[mPopView.mTx.text intValue] andOrderCode:self.mOrder.mOrderCode andOrderType:self.mType andLat:self.mLat andLng:self.mLng block:^(mBaseData *resb) {
        
        
        if (resb.mSucess) {
            [self showSuccessStatus:resb.mMessage];
            [self headerBeganRefresh];
            [self dismissPopAction:nil];
        }else{
            
            [self showErrorStatus:resb.mMessage];
            [self headerBeganRefresh];
        }
        
        
    }];

}
@end
