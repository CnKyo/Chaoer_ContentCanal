//
//  SellerVC.m
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/11/3.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "SellerVC.h"

@interface SellerVC ()<UITableViewDataSource,UITableViewDelegate>{

    NSMutableArray *arry;
}

@end

@implementation SellerVC

- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Title = self.mPageName = @"选择服务人员";
    
    self.rightBtnTitle = @"完成";
    
    [self loadTableView:CGRectMake(0, 0, DEVICE_Width, DEVICE_InNavBar_Height)delegate:self dataSource:self];
    
    UINib *nib = [UINib nibWithNibName:@"RecordCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"RecordCell"];
    
    self.haveHeader = YES;
    self.haveFooter = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    arry = [[NSMutableArray alloc] initWithCapacity:0];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView headerBeginRefreshing];
    
    
   
}

- (void)rightBtnTouched:(id)sender{
    
    for (SPeople *p in self.tempArray) {
        if (p.mIsCheck) {
            [arry addObject:p];
        }
    }
    
    if (_block) {
        _block(arry);
    }
    
    [self popViewController];
}

- (void)headerBeganRefresh{

    [SVProgressHUD showWithStatus:@"加载中.." maskType:SVProgressHUDMaskTypeClear];
    
    [SPeople getPeoples:2 block:^(SResBase *resb, NSArray *all) {
        [self.tableView headerEndRefreshing];
        if (resb.msuccess) {
            [SVProgressHUD dismiss];
            
            self.tempArray = [[NSMutableArray alloc] initWithArray:all];
            
        }else{
            [SVProgressHUD showErrorWithStatus:resb.mmsg];
        }
        
        if(all.count == 0 || !all)
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

#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.tempArray count];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mycell"];
    }
    cell.tintColor = M_CO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SPeople *people = [self.tempArray objectAtIndex:indexPath.row];

    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.text = people.mName;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = COLOR(71, 72, 73);
    cell.detailTextLabel.textAlignment = NSTextAlignmentLeft;
    cell.detailTextLabel.text = people.mMobile;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.textColor = COLOR(71, 72, 73);
    
    if (people.mIsCheck) {
         cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
         cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    SPeople *people = [self.tempArray objectAtIndex:indexPath.row];
    
    people.mIsCheck = !people.mIsCheck;
    
    [self.tableView reloadData];
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
