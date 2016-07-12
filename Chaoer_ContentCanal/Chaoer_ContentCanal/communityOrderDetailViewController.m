//
//  communityOrderDetailViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/29.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "communityOrderDetailViewController.h"

#import "communityOrderDetailCell.h"

#import "orderStatusViewController.h"

#import "mMarketRateViewController.h"
@interface communityOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation communityOrderDetailViewController

- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    
    [super viewDidLoad];
    
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.Title = self.mPageName = @"订单详情";
    
    [self initView];
}
- (void)initView{

    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    
    
    
    self.haveHeader = YES;
    
    
    UINib   *nib = [UINib nibWithNibName:@"communityOrderDetailCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell1"];
    
    nib = [UINib nibWithNibName:@"communityOrderDetailCell2" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];

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
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.5;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 1;
    }else{
        return 5;
    }
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        return 340;
    }else{
        return 200;
    }
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    if (indexPath.section == 0) {
        reuseCellId = @"cell1";
        
        communityOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.mCheckBtn addTarget:self action:@selector(mCaheckAction:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    }else{
        
        reuseCellId = @"cell2";
        
        communityOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        
        return cell;
    }
    
    
}

- (void)mCaheckAction:(UIButton *)sender{
//    orderStatusViewController *orderS = [[orderStatusViewController alloc] initWithNibName:@"orderStatusViewController" bundle:nil];
//    [self pushViewController:orderS];
    
    mMarketRateViewController *mmm = [[mMarketRateViewController alloc] initWithNibName:@"mMarketRateViewController" bundle:nil];
    [self pushViewController:mmm];
    
}
@end
