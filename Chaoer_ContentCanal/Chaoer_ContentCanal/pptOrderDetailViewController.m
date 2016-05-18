//
//  pptOrderDetailViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "pptOrderDetailViewController.h"
#import "pptDetailCell.h"
@interface pptOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation pptOrderDetailViewController
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

}
- (void)initView{
    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;

    self.haveHeader = YES;
    [self.tableView headerBeginRefreshing];
    
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
                [self popViewController];
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
                [self popViewController];
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
    if (self.mOrderType == 1) {
     
        cell.mOrderDetailName.text = [NSString stringWithFormat:@"下单时间：%@",self.mOrder.mGenTime];
        cell.mTHXMoney.text = [NSString stringWithFormat:@"酬劳金额:%@",self.mOrder.mLegworkMoney];
        cell.mOrderNum.text = [NSString stringWithFormat:@"订单编号：%@",self.mOrder.mOrderCode];
        cell.mOrderName.text = self.mOrder.mContext;
        cell.mServiceName.text = [NSString stringWithFormat:@"姓名：%@",self.mOrder.mUserName];
        
        cell.mPhone.text = [NSString stringWithFormat:@"电话：%@",self.mOrder.mPhone];
        
        cell.mServiceTime.text = [NSString stringWithFormat:@"时间：%@",self.mOrder.mArrivedTime];
        
        cell.mArriveAddress.text = [NSString stringWithFormat:@"地址：%@",self.mOrder.mAdress];
        
        cell.mSendMoney.text = [NSString stringWithFormat:@"酬金：%@元",self.mOrder.mLegworkMoney];
        
        if ([mUserInfo backNowUser].mUserId == [self.mOrder.mUserId intValue]) {
            cell.mDoBtn.backgroundColor = [UIColor lightGrayColor];
            cell.mDoBtn.enabled = NO;
        }else{
            cell.mDoBtn.backgroundColor = M_CO;
            cell.mDoBtn.enabled = YES;
        }

        
        [cell.mDoBtn addTarget:self action:@selector(getOrderAction:) forControlEvents:UIControlEventTouchUpInside];

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
            cell.mServiceTime.text = [NSString stringWithFormat:@"时间：%@",@"暂无"];

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
        
        UIImage *mStatusImg = nil;
        
        if (self.mOrder.mProcessStatus == 0) {
            /**
             *  取消
             */
            
            [cell.mDoBtn setTitle:@"取消订单" forState:0];
            cell.mDoBtn.enabled = YES;

            [cell.mDoBtn addTarget:self action:@selector(cancelOrderAction:) forControlEvents:UIControlEventTouchUpInside];
            
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
            [cell.mDoBtn setTitle:@"订单进行中" forState:0];
            cell.mDoBtn.backgroundColor = [UIColor lightGrayColor];
            
            cell.mDoBtn.enabled = NO;
            mStatusImg = [UIImage imageNamed:@"ppt_order_accept"];
        }else if (self.mOrder.mProcessStatus == 3){
            /**
             *  确认订单
             */
            [cell.mDoBtn setTitle:@"订单已被确认" forState:0];
            cell.mDoBtn.backgroundColor = [UIColor lightGrayColor];
            cell.mDoBtn.enabled = NO;
            mStatusImg = [UIImage imageNamed:@"ppt_order_wait"];
        }else if (self.mOrder.mProcessStatus == 4){
            /**
             *  确定完成
             */
            [cell.mDoBtn setTitle:@"确认完成" forState:0];
     
            cell.mDoBtn.enabled = YES;
            [cell.mDoBtn addTarget:self action:@selector(finishOrderAction:) forControlEvents:UIControlEventTouchUpInside];
            mStatusImg = [UIImage imageNamed:@"ppt_order_sended"];
        }else{
            /**
             *  评价
             */
            [cell.mDoBtn setTitle:@"去评价" forState:0];
            cell.mDoBtn.enabled = NO;
            [cell.mDoBtn addTarget:self action:@selector(rateOrderAction:) forControlEvents:UIControlEventTouchUpInside];
            mStatusImg = [UIImage imageNamed:@"ppt_order_finish"];
        }
        
        cell.mOrderStatusImg.image = mStatusImg;

        cell.mOrderStatus.text = self.mOrder.mStatusName;
        cell.mLevel.text = [NSString stringWithFormat:@"下单时间:%@",self.mOrder.mGenTime];
        cell.mSenderMg.text = [NSString stringWithFormat:@"个人信息:%@",self.mOrder.mUserName];
        cell.mOrderNum.text = [NSString stringWithFormat:@"订单编号：%@",self.mOrder.mOrderCode];
        cell.mOrderName.text = self.mOrder.mTypeName;
        
        cell.mServiceName.text = [NSString stringWithFormat:@"姓名：%@",self.mOrder.mUserName];
        cell.mPhone.text = [NSString stringWithFormat:@"电话：%@",self.mOrder.mPhone];
        cell.mServiceTime.text = [NSString stringWithFormat:@"时间：%@",self.mOrder.mArrivedTime];
        cell.mArriveAddress.text = [NSString stringWithFormat:@"地址：%@",self.mOrder.mAdress];
        cell.mSendMoney.text = [NSString stringWithFormat:@"费用：%@",self.mOrder.mLegworkMoney];
        
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
            cell.mServiceTime.text = [NSString stringWithFormat:@"时间：%@",@"暂无"];
            
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
- (void)getOrderAction:(UIButton *)sender{

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
            [self popViewController];
        }else{
        
            [self showErrorStatus:resb.mMessage];
        }
        
    }];
    
}
#pragma mark----取消订单
- (void)cancelOrderAction:(UIButton *)sender{

}
#pragma mark----完成订单
- (void)finishOrderAction:(UIButton *)sender{
    
}
#pragma mark----评价订单
- (void)rateOrderAction:(UIButton *)sender{
    
}
@end
