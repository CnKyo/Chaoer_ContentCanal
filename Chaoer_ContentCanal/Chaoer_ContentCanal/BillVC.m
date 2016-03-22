//
//  BillVC.m
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/10/30.
//  Copyright (c) 2015年 zongyoutec.com. All rights reserved.
//

#import "BillVC.h"
#import "BillCell.h"
#import "BillHeadView.h"
#import "BillSectionView.h"
#import "WithDrawVC.h"
#import "CZVC.h"

@interface BillVC ()<UITableViewDelegate,UITableViewDataSource>{

    BillSectionView *sectionView;
    
    int nowSelect;
    UIButton *tempBT;
    
    UIView *line;
    
    NSMutableDictionary *tempDic;
    
    BillHeadView *headView;
    
    BOOL flag;
}

@end

@implementation BillVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self.tableView headerBeginRefreshing];
    [self getShop];
}

- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Title = self.mPageName = @"我的账单";
    
    tempDic = NSMutableDictionary.new;
    
    [self loadTableView:CGRectMake(0, 0, DEVICE_Width, DEVICE_InNavBar_Height)delegate:self dataSource:self];
    
    UINib *nib = [UINib nibWithNibName:@"BillCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"BillCell"];
    
    self.haveHeader = YES;
    self.haveFooter = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    

    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    headView = [BillHeadView shareView];
    [self.tableView setTableHeaderView:headView];
//     headView.mMoney.text = [NSString stringWithFormat:@"¥%.2f",_mShop.mBalance];
    [headView.mButton addTarget:self action:@selector(TiXianClick:) forControlEvents:UIControlEventTouchUpInside];
    [headView.mczBt addTarget:self action:@selector(CZClick:) forControlEvents:UIControlEventTouchUpInside];

    sectionView = [BillSectionView shareView];
    
    for (UIButton *button in sectionView.subviews) {
        
        if ([button isKindOfClass:[UIButton class]]) {
            
            [button addTarget:self action:@selector(ChoseClick:) forControlEvents:UIControlEventTouchUpInside];
            
            if (button.tag == 10) {
                tempBT = button;
            }
        }
    }
    
    nowSelect = 0;
    line = [[UIView alloc] initWithFrame:CGRectMake(0, 53, DEVICE_Width/3, 2)];
    [sectionView addSubview:line];
    line.backgroundColor = M_CO;
    

}

- (void)leftBtnTouched:(id)sender{

    if (_itblock) {
        _itblock(flag);
    }
    
    [self popViewController];
}

- (void)getShop{

//    [SShop getShopInfo:^(SResBase *info, SShop *retobj) {
//        
//        if (info.msuccess) {
//            [SVProgressHUD dismiss];
//            
//            _mShop = retobj;
//             headView.mMoney.text = [NSString stringWithFormat:@"¥%.2f",_mShop.mBalance];
//            
//        }else{
//            
//            [SVProgressHUD showErrorWithStatus:info.mmsg];
//        }
//    }];
}

- (void)CZClick:(UIButton *)sender
{
    
    CZVC* vc = [[CZVC alloc]initWithNibName:@"CZVC" bundle:nil];
    [self pushViewController:vc];
    
}

- (void)TiXianClick:(UIButton *)sender
{
    
    [SVProgressHUD showWithStatus:@"加载中.." maskType:SVProgressHUDMaskTypeClear];
    
//    [[SUser currentUser] getBankInfo:^(SResBase *resb, SWithDrawInfo *retobj) {
//        
//        if (resb.msuccess) {
//            
//            [SVProgressHUD dismiss];
//            
//            if (!retobj || retobj == nil) {
//                UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您还没有添加银行卡" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                
//                [alt show];
//                
//                return;
//            }else{
//            
//                WithDrawVC *withDraw = [[WithDrawVC alloc] initWithNibName:@"WithDrawVC" bundle:nil];
//                withDraw.mShop = _mShop;
//                withDraw.mDrawInfo = retobj;
//                
//                withDraw.itblock = ^(BOOL flags){
//                
//                    if (flags) {
//                        [self getShop];
//                        
//                        flag = YES;
//                    }
//                };
//                [self pushViewController:withDraw];
//            }
//            
//        }else{
//            
//            [SVProgressHUD showErrorWithStatus:resb.mmsg];
//        }
//    }];


   
}

- (void)ChoseClick:(UIButton *)sender{

    if (sender == tempBT) {
        return;
    }
    nowSelect = (int)sender.tag - 10;
    
    [sender setTitleColor:M_CO forState:UIControlStateNormal];
    [tempBT setTitleColor:M_TCO forState:UIControlStateNormal];
    
    
    [UIView animateWithDuration:0.2 animations:^{
        
        line.center = sender.center;
        CGRect rect = line.frame;
        rect.origin.y = 53;
        line.frame = rect;
    }];

    
    [self.tableView headerBeginRefreshing];
    
    tempBT = sender;
}

#pragma mark ----顶部刷新数据
- (void)headerBeganRefresh{
    
    self.page=1;
//    [_mShop searchBill:self.page type:1 status:nowSelect block:^(SResBase *info, NSArray *bill) {
//        
//        [self headerEndRefresh];
//        [self.tempArray removeAllObjects];
//        if (info.msuccess) {
//            
//            [tempDic setObject:bill forKey:[NSString stringWithFormat:@"select%d",nowSelect]];
//            
//            self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//        }
//        else{
//            [self addEmptyViewWithImg:nil];
//            [SVProgressHUD showErrorWithStatus:info.mmsg];
//        }
//        
//        if(bill.count == 0 )
//        {
//            [self addEmptyViewWithImg:nil];
//        }
//        else
//        {
//            [self removeEmptyView];
//        }
//        [self.tableView reloadData];
//    }];
    
    
}
#pragma mark----地步刷新
-(void)footetBeganRefresh
{
    self.page++;
//    [_mShop searchBill:self.page type:1 status:nowSelect block:^(SResBase *info, NSArray *bill) {
//        [self footetEndRefresh];
//        
//        if (info.msuccess) {
//            
//            NSMutableArray *arry = [tempDic objectForKey:[NSString stringWithFormat:@"select%d",nowSelect]];
//            
//            [arry addObjectsFromArray:bill];
//        }
//        else{
//            [SVProgressHUD showErrorWithStatus:info.mmsg];
//        }
//        
//         NSMutableArray *arry = [tempDic objectForKey:[NSString stringWithFormat:@"select%d",nowSelect]];
//        if( arry.count == 0 )
//        {
//            [self addEmptyViewWithImg:nil];
//        }
//        else
//        {
//            [self removeEmptyView];
//        }
//        
//        if (bill.count == 0) {
//            [SVProgressHUD showSuccessWithStatus:@"暂无新数据"];
//        }
//        
//        [self.tableView reloadData];
//    }];
//    
//    
    
}


#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *arry = [tempDic objectForKey:[NSString stringWithFormat:@"select%d",nowSelect]];
    return [arry count];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 55;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BillCell *cell = (BillCell *)[tableView dequeueReusableCellWithIdentifier:@"BillCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSMutableArray *arry = [tempDic objectForKey:[NSString stringWithFormat:@"select%d",nowSelect]];
//    
//    SShopBill *bill = [arry objectAtIndex:indexPath.row];
//    
//    cell.mTime.text = bill.mCreateTime;
//    cell.mRemark.text =[NSString stringWithFormat: @"备注：%@",bill.mRemark];
//    cell.mPrice.text = bill.mMoney;
//    if (bill.mStatus == 0){
//        cell.mState.text = @"待审核";
//        cell.mPrice.textColor = M_CO;
//        cell.mState.textColor = COLOR(220, 162, 95);
//    }else if (bill.mStatus == 1){
//        cell.mState.text = @"成功";
//        cell.mPrice.textColor = COLOR(34, 190, 82);
//        cell.mState.textColor = COLOR(34, 190, 82);
//    }
//    else if (bill.mStatus == 2){
//        cell.mState.text = @"拒绝";
//        cell.mPrice.textColor = M_CO;
//        cell.mState.textColor = COLOR(220, 162, 95);
//    }
    
    
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
