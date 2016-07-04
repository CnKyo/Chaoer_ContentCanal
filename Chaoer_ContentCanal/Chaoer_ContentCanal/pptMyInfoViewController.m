//
//  pptMyInfoViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/13.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "pptMyInfoViewController.h"
#import "pptMyInfoCell.h"
@interface pptMyInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation pptMyInfoViewController
{

    UIView *mHeaderView;
    
    NSTimer *timer;
    NSTimer *mtimer;

    
    UILabel *mLevelLb;
    
    UILabel *mMoneyLb;
    
    CustomProgress *mLevelProgress;
    
    CustomProgress *mMoneyProgress;
    
    int level;
    
    int money;
    
    GPPTUserInfo *mPPTUser;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"我的信息";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.hiddenRightBtn = YES;

    [self initView];
    
    
}
#pragma mark----初始化headerview 
- (void)initHeaderView{

    if (mHeaderView == nil) {
        mHeaderView = [UIView new];
        mHeaderView.frame = CGRectMake(0, 0, DEVICE_Width, 140);
        mHeaderView.backgroundColor = [UIColor whiteColor];
     
    }
    
    UIView *line = [UIView new];
    line.frame = CGRectMake(0, 0, DEVICE_Width, 2);
    line.backgroundColor = [UIColor whiteColor];
    //    line.layer.masksToBounds = YES;
    //    line.layer.borderColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.89 alpha:1.00].CGColor;
    //    line.layer.borderWidth = 0.5;
    [mHeaderView addSubview:line];
    
    
    UILabel *lll = [UILabel new];
    lll.frame = CGRectMake(15, line.mbottom+10, 120, 20);
    lll.textColor = [UIColor colorWithRed:0.18 green:0.18 blue:0.18 alpha:1.00];
    lll.font = [UIFont systemFontOfSize:15];
    lll.text = @"跑跑腿等级";
    lll.textAlignment = NSTextAlignmentLeft;
    [mHeaderView addSubview:lll];
    if (mLevelLb == nil) {
        mLevelLb = [UILabel new];
        mLevelLb.frame = CGRectMake(mHeaderView.mwidth/2-60, line.mbottom+10, 120, 20);
        mLevelLb.textColor = [UIColor colorWithRed:1.00 green:0.56 blue:0.56 alpha:1.00];
        mLevelLb.font = [UIFont systemFontOfSize:15];
        mLevelLb.text = [NSString stringWithFormat:@"V%d",mPPTUser.mLevel];
        mLevelLb.textAlignment = NSTextAlignmentCenter;
        [mHeaderView addSubview:mLevelLb];

    }
    
    
    if (mLevelProgress == nil) {
        mLevelProgress = [[CustomProgress alloc] initWithFrame:CGRectMake(15, mLevelLb.mbottom+5, DEVICE_Width-30, 15) andType:1];
        mLevelProgress.mType = 1;
        mLevelProgress.maxValue = 100;
        //设置背景色
        mLevelProgress.bgimg.backgroundColor =[UIColor colorWithRed:188/255.0 green:188/255.0 blue:188/255.0 alpha:1];
        mLevelProgress.leftimg.backgroundColor =[UIColor colorWithRed:1.00 green:0.56 blue:0.56 alpha:1.00];
        
        mLevelProgress.presentlab.textColor = [UIColor redColor];
        [mHeaderView addSubview:mLevelProgress];
    }

    
    UIView *line2 = [UIView new];
    line2.frame = CGRectMake(0, mLevelProgress.mbottom+15, DEVICE_Width, 1);
    line2.backgroundColor = [UIColor colorWithRed:0.77 green:0.77 blue:0.77 alpha:0.45];
    [mHeaderView addSubview:line2];

    
    UILabel *mmm = [UILabel new];
    mmm.frame = CGRectMake(15, line2.mbottom+10, 120, 20);
    mmm.textColor = [UIColor colorWithRed:0.18 green:0.18 blue:0.18 alpha:1.00];
    mmm.font = [UIFont systemFontOfSize:15];
    mmm.text = @"累计收益";
    mmm.textAlignment = NSTextAlignmentLeft;
    [mHeaderView addSubview:mmm];

    if (mMoneyLb == nil) {
        mMoneyLb = [UILabel new];
        mMoneyLb.frame = CGRectMake(mHeaderView.mwidth/2-60, line2.mbottom+10, 120, 20);
        mMoneyLb.textColor = [UIColor colorWithRed:1.00 green:0.78 blue:0.35 alpha:1.00];
        mMoneyLb.font = [UIFont systemFontOfSize:15];
        mMoneyLb.text = [NSString stringWithFormat:@"累计收益：%d元",mPPTUser.mPile];
        mMoneyLb.textAlignment = NSTextAlignmentCenter;
        [mHeaderView addSubview:mMoneyLb];
    }
    

    if (mMoneyProgress == nil) {
        mMoneyProgress = [[CustomProgress alloc] initWithFrame:CGRectMake(15, mMoneyLb.mbottom+5, DEVICE_Width-30, 15) andType:1];
        mMoneyProgress.mType = 1;
        mMoneyProgress.maxValue = mPPTUser.mPile*5;
        //设置背景色
        mMoneyProgress.bgimg.backgroundColor =[UIColor colorWithRed:188/255.0 green:188/255.0 blue:188/255.0 alpha:1];
        mMoneyProgress.leftimg.backgroundColor =[UIColor colorWithRed:1.00 green:0.78 blue:0.35 alpha:1.00];
        mMoneyProgress.presentlab.textColor = [UIColor redColor];
        [mHeaderView addSubview:mMoneyProgress];

    }
    
    
    [self.tableView setTableHeaderView:mHeaderView];
    
    timer =[NSTimer scheduledTimerWithTimeInterval:0.02
                                            target:self
                                          selector:@selector(timer)
                                          userInfo:nil
                                           repeats:YES];
    mtimer =[NSTimer scheduledTimerWithTimeInterval:0.02
                                            target:self
                                          selector:@selector(timer22)
                                          userInfo:nil
                                           repeats:YES];
    
}

-(void)timer
{
    level++;
    if (level<=mPPTUser.mLevel) {
        
        [mLevelProgress setPresent:level];
        
    }
    else
    {
        
        [timer invalidate];
        timer = nil;
        level = 0;
    }
    
    
}
-(void)timer22
{
    money++;
    if (money <= mPPTUser.mPile){
        [mMoneyProgress setPresent:money];
    }
    else
    {
        
        [mtimer invalidate];
        mtimer = nil;
        money = 0;
        
    }
    
    
}
- (void)initView{
    
    
    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.haveHeader = YES;
    
    UINib   *nib = [UINib nibWithNibName:@"pptMyInfoCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    UIView *mFooter = [UIView new];
    mFooter.frame = CGRectMake(0, 10, DEVICE_Width, 60);
    mFooter.backgroundColor = [UIColor clearColor];
    
    UIButton *mLogout = [UIButton new];
    mLogout.frame = CGRectMake(15, 10, DEVICE_Width-30, 40);
    mLogout.backgroundColor = M_CO;
    mLogout.layer.masksToBounds = YES;
    mLogout.layer.cornerRadius = 3;
    [mLogout setTitle:@"注销身份" forState:0];
    [mLogout setTitleColor:[UIColor whiteColor] forState:0];
    [mLogout addTarget:self action:@selector(logoutAction:) forControlEvents:UIControlEventTouchUpInside];
    [mFooter addSubview:mLogout];
    [self.tableView setTableFooterView:mFooter];

    
}
- (void)logoutAction:(UIButton *)sender{
    
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
                [self popViewController_2];
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


- (void)headerBeganRefresh{

    [[GPPTer backPPTUser] getPPTBaseUserInfo:^(mBaseData *resb, GPPTUserInfo *user) {
        
        [self headerEndRefresh];
        if (resb.mSucess) {
            
            mPPTUser = user;
            [self initHeaderView];
            [self.tableView reloadData];
            
        }else{
        
            [self showErrorStatus:resb.mMessage];
            [self popViewController];
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
    
    return 280;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    
    pptMyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.mName.text = mPPTUser.mName;
    cell.mSex.text = mPPTUser.mSex;
    cell.mIdentify.text = [NSString stringWithFormat:@"%@",mPPTUser.mCardID];
    cell.mConnect.text = mPPTUser.mTel;
    cell.mAcount.text = mPPTUser.mTel;
    cell.mMoney.text = [NSString stringWithFormat:@"%d元",mPPTUser.mDeposit];
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
