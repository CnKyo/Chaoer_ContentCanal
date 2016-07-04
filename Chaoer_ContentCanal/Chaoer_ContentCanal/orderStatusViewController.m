//
//  orderStatusViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/29.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "orderStatusViewController.h"

#import "mOrderStatusCell.h"

@interface orderStatusViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation orderStatusViewController
{

    NSMutableArray *mDataArr;
    
}
- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    
    [super viewDidLoad];
    
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.Title = self.mPageName = @"状态跟踪";
    
    mDataArr = [NSMutableArray new];
    
    [self initView];

}
- (void)initView{
    
    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    
    
    
    self.haveHeader = YES;
    
    
    UINib   *nib = [UINib nibWithNibName:@"mOrderStatusCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
 
    for (int i = 0; i<5; i++) {
        [mDataArr addObject:[NSString stringWithFormat:@"第%d个",i]];
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
    
    return mDataArr.count;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    reuseCellId = @"cell";
    
    mOrderStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.mTime.text = mDataArr[indexPath.row];
   
    if (indexPath.row == 0) {
        cell.mTopLine.hidden = YES;
        cell.mPoint.image = [UIImage imageNamed:@"orderStatus_yellow"];
    }else if (indexPath.row == mDataArr.count-1 ){
    
        cell.mBottomLine.hidden = YES;
        cell.mPoint.image = [UIImage imageNamed:@"orderStatus_gray"];

    }else{
        cell.mBottomLine.hidden = NO;
        cell.mPoint.image = [UIImage imageNamed:@"orderStatus_gray"];
    }
    
    
    return cell;
    
    
    
}

@end
