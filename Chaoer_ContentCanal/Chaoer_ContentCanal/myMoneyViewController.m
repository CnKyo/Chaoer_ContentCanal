//
//  myMoneyViewController.m
//  O2O_Communication_seller
//
//  Created by 密码为空！ on 15/9/18.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "myMoneyViewController.h"
#import "footView.h"
#import "moreCell.h"
@interface myMoneyViewController ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation myMoneyViewController
{
    UITableView *mTableView;
    
    footView    *mHeaderView;
    
    int page;
    
//    SMyMoney *mMoney;
}
- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.Title = self.mPageName = @"我的佣金";
    // Do any additional setup after loading the view.
    [self initView];
}
- (void)initView{
    mTableView = [UITableView new];
    [self.view addSubview:mTableView];
    [mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(64);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.bottom.equalTo(self.view).offset(0);
    }];
    self.tableView = mTableView;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = M_BGCO;
    
    UINib *nib = [UINib nibWithNibName:@"myMoneyCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    self.haveHeader = YES;
    self.haveFooter = YES;
}

#pragma mark ----顶部刷新数据
- (void)headerBeganRefresh{
    [SVProgressHUD showWithStatus:@"正在获取数据..." maskType:SVProgressHUDMaskTypeClear];
    page = 1;
//    [[SUser currentUser] getMoney:page block:^(SResBase *resb, SMyMoney *money) {
//        
//        [self headerEndRefresh];
//        
//
//        if (resb.msuccess) {
//            mMoney = money;
//            [SVProgressHUD dismiss];
//        }
//        else{
//            [SVProgressHUD showErrorWithStatus:resb.mmsg];
//        }
//        if( mMoney.mContent.count == 0 )
//        {
//            [self addEmptyViewWithImg:nil];
//        }
//        else
//        {
//            [self removeEmptyView];
//        }
//        [self.tableView reloadData];
//    }];
//    
    
}
#pragma mark----地步刷新
-(void)footetBeganRefresh
{
    [SVProgressHUD showWithStatus:@"正在获取数据..." maskType:SVProgressHUDMaskTypeClear];
    page ++;
//    [[SUser currentUser] getMoney:page block:^(SResBase *resb, SMyMoney *money) {
//        [self footetEndRefresh];
//        if (resb.msuccess) {
//            mMoney = money;
//
//             [self.tableView reloadData];
//            [SVProgressHUD dismiss];
//            
//        }
//        else{
//            [SVProgressHUD showErrorWithStatus:resb.mmsg];
//        }
//        
//        if( mMoney.mContent.count == 0 )
//        {
//            [self addEmptyViewWithImg:nil];
//        }
//        else
//        {
//            [self removeEmptyView];
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
    
//    return mMoney.mContent.count;
    return 3;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *reuseCellId = @"cell";

    moreCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    if (!cell)
    {
        cell = [[moreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
//    SMoney *monry = mMoney.mContent[indexPath.row];
//
//    cell.mTime.text = monry.mCreateTime;
//    cell.mOrderID.text = [NSString stringWithFormat:@"订单编号：%@",monry.mOrderId];
//    cell.mPrice.text = [NSString stringWithFormat:@"+%.2f",monry.mMoney];
    

    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 154;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    mHeaderView = [footView shareMyMoney];
    
//    mHeaderView.mMyMoney.text = [NSString stringWithFormat:@"¥%.2f",mMoney.mTotleMoney];

    return mHeaderView;
    
}

                    

@end
