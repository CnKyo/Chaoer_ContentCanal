//
//  orderTongjiViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/20.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "orderTongjiViewController.h"
#import "myOrderTableViewCell.h"

#import "myOrderViewController.h"
@interface orderTongjiViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation orderTongjiViewController
{

    NSArray *marr;
    
    int mType;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.Title = self.mPageName = @"订单统计";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    
    mType = 1;
    
  
    [self initViuew];
}
- (void)initViuew{
    
    UIImageView *iii = [UIImageView new];
    
    iii.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64);
    iii.image = [UIImage imageNamed:@"mBaseBgkImg"];
    [self.view addSubview:iii];


    [self loadTableView:CGRectMake(0,64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.93 green:0.94 blue:0.96 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.haveHeader = YES;
    
    UINib   *nib = [UINib nibWithNibName:@"myOrderTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    

    
}


- (void)headerBeganRefresh{
    
    
    
//    [SVProgressHUD showWithStatus:@"正在加载中..." maskType:SVProgressHUDMaskTypeClear];
    [[mUserInfo backNowUser] getOrderList:mType block:^(mBaseData *resb, NSArray *mArr) {
        
        [self.tempArray removeAllObjects];
        [self headerEndRefresh];
        
        [self removeEmptyView];
        if (resb.mSucess) {
            [SVProgressHUD dismiss];
//            [SVProgressHUD showSuccessWithStatus:resb.mMessage];
            
            if (mArr.count <= 0) {
                [self addEmptyViewWithImg:nil];
                return ;
            }
            
            [self.tempArray addObjectsFromArray:mArr];
            [self.tableView reloadData];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
            [self addEmptyViewWithImg:nil];
            
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
    
    return self.tempArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    GOrderCount *mOrder = self.tempArray[indexPath.row];
    
    myOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    cell.mName.text = mOrder.mOrderName;
    cell.mNum.text = [NSString stringWithFormat:@"订单数：%@",mOrder.mOrderNum];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    GOrderCount *mOrder = self.tempArray[indexPath.row];
    
    myOrderViewController *mmm = [[myOrderViewController alloc] initWithNibName:@"myOrderViewController" bundle:nil];
    mmm.mType = mOrder.mOrderType ;
    [self pushViewController:mmm];
    
}

@end
