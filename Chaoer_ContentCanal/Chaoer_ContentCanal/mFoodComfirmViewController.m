//
//  mFoodComfirmViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mFoodComfirmViewController.h"
#import "mFoodComfirmHeaderView.h"
#import "mFoodComfirmTableViewCell.h"
#import "LTPickerView.h"
#import "goPayViewController.h"

@interface mFoodComfirmViewController ()<UITableViewDelegate,UITableViewDataSource,WKFoodComfirmViewDelegate,LTPickerViewDelegate>

@end

@implementation mFoodComfirmViewController
{
    /**
     *  headerview
     */
    mFoodComfirmHeaderView *mHeaderView;
    /**
     *  footerview
     */
    mFoodComfirmHeaderView *mFooterView;
    /**
     *  底部view
     */
    mFoodComfirmHeaderView *mBottomView;
    /**
     *  分组view
     */
    mFoodComfirmHeaderView *mSectionView;
    
    LTPickerView*LtpickerView;

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
    self.hiddenTabBar = YES;
    
    [super viewDidLoad];
    
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.Title = self.mPageName = @"确认订单";
    [self initView];
}
- (void)initView{
    
    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-114) delegate:self dataSource:self];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    
    
    
    //    self.haveHeader = YES;
    
    
    UINib   *nib = [UINib nibWithNibName:@"mFoodComfirmTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    mHeaderView = [mFoodComfirmHeaderView shareHeaderView];
    mHeaderView.frame = CGRectMake(0, 0, DEVICE_Width, 198);
    mHeaderView.delegate = self;
    self.tableView.tableHeaderView = mHeaderView;
    
    mFooterView = [mFoodComfirmHeaderView shareFooterView];
    mFooterView.frame = CGRectMake(0, 0, DEVICE_Width, 220);
    mFooterView.delegate = self;
    self.tableView.tableFooterView = mFooterView;
    
    mBottomView = [mFoodComfirmHeaderView shareBottomView];
    mBottomView.delegate = self;
    [self.view addSubview:mBottomView];
    [mBottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).offset(@0);
        make.height.offset(@50);
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
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    
    return 1;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    mSectionView = [mFoodComfirmHeaderView shareSectionView];
    
    mSectionView.delegate = self;
    return mSectionView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44;
    
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    reuseCellId = @"cell";
    
    mFoodComfirmTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;

    
    
}


/**
 *  地址代理方法
 */
- (void)WKFoodComfirmViewWithAddressBtnclick{

}
/**
 *  送达时间代理方法
 */
- (void)WKFoodComfirmViewWithSendTimeBtnclick{
    
    NSArray *mTT = @[@"30分钟",@"60分钟",@"90分钟",@"2小时",@"3小时",@"4小时",@"5小时",@"8小时",@"12小时"];
    LtpickerView = [LTPickerView new];
    LtpickerView.dataSource = mTT;//设置要显示的数据
    LtpickerView.defaultStr = mTT[0];//默认选择的数据
    [LtpickerView show];//显示
    
    LtpickerView.delegate = self;

    
   

}

- (void)LTPickerViewDidSelected:(id)obj andTitle:(NSString *)mTT andNum:(long)mNum{

    MLLog(@"选择了第%ld行的%@",mNum,mTT);
    
    [mHeaderView.mSendTimeBtn setTitle:[NSString stringWithFormat:@"%@内送达",mTT] forState:0];
}
/**
 *  优惠卷代理方法
 */
- (void)WKFoodComfirmViewWithCoupBtnclick{

}

/**
 *  去支付代理方法
 */
- (void)WKFoodComfirmViewWithGoPayBtnclick{
    goPayViewController *goPay = [[goPayViewController alloc] initWithNibName:@"goPayViewController" bundle:nil];

    [self pushViewController:goPay];
}

@end
