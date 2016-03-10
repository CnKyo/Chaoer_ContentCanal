//
//  BillRecordVC.m
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/11/2.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "BillRecordVC.h"
#import "RecordCell.h"

@interface BillRecordVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation BillRecordVC

- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Title = self.mPageName = @"我的账单";
    
    
    [self loadTableView:CGRectMake(0, 0, DEVICE_Width, DEVICE_InNavBar_Height)delegate:self dataSource:self];
    
    UINib *nib = [UINib nibWithNibName:@"RecordCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"RecordCell"];
    
    self.haveHeader = YES;
    self.haveFooter = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self.tableView headerBeginRefreshing];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark ----顶部刷新数据
- (void)headerBeganRefresh{
    
    self.page=1;
    
    
    [_mShop searchBill:self.page type:2 status:nil block:^(SResBase *info, NSArray *bill) {
        
        [self headerEndRefresh];
        [self.tempArray removeAllObjects];
        if (info.msuccess) {
            
            [self.tempArray removeAllObjects];
            [self.tempArray addObjectsFromArray:bill];
        }
        else{
            [self addEmptyViewWithImg:nil];
        }
        
        if(bill.count == 0 || bill == nil)
        {
            [self addEmptyViewWithImg:nil];
        }
        else
        {
            [self removeEmptyView];
        }
        [self.tableView reloadData];
    }];
    
    
}
#pragma mark----地步刷新
-(void)footetBeganRefresh
{
    self.page++;

    [_mShop searchBill:self.page type:2 status:nil block:^(SResBase *info, NSArray *bill) {
        [self footetEndRefresh];
        if (info.msuccess) {

            [self.tempArray addObjectsFromArray:bill];
        }
        else{
            [SVProgressHUD showErrorWithStatus:info.mmsg];
        }
    }];
    
    [self.tableView reloadData];
    
}

#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.tempArray count]+1;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RecordCell *cell = (RecordCell *)[tableView dequeueReusableCellWithIdentifier:@"RecordCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        cell.mTime.text = @"日期";
        cell.mPrice.text = @"金额";
        cell.mStatus.text = @"状态";
        
        return cell;
    }
    
    SShopBill *bill = [self.tempArray objectAtIndex:indexPath.row-1];
    
    cell.mTime.text = bill.mCreateTime;
    cell.mPrice.text = [NSString stringWithFormat: @"%@",bill.mMoney];
    if (bill.mStatus == 0){
        cell.mStatus.text = @"待审核";
        cell.mStatus.textColor = COLOR(220, 162, 95);
    }else if (bill.mStatus == 1){
        cell.mStatus.text = @"成功";
        cell.mStatus.textColor = COLOR(34, 190, 82);
    }
    else if (bill.mStatus == 2){
        cell.mStatus.text = @"拒绝";
        cell.mStatus.textColor = M_CO;
    }
    
    
    return cell;
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

@end
