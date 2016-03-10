//
//  BankManagerVC.m
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/12/11.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "BankManagerVC.h"
#import "AddBankInfo.h"
#import "BankCell.h"

@interface BankManagerVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation BankManagerVC

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    
    [self headerBeganRefresh];
}

- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mPageName = @"银行卡管理";

    self.Title = self.mPageName;
    
    [self loadTableView:CGRectMake(0, 0, DEVICE_Width, DEVICE_InNavBar_Height) delegate:self dataSource:self];
    self.tableView.tableFooterView = UIView.new;
    self.haveHeader = YES;
    self.haveFooter = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = M_BGCO;
    
    UINib *nib = [UINib nibWithNibName:@"BankCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    self.rightBtnTitle = @"添加";

}

- (void)rightBtnTouched:(id)sender{
    
    AddBankInfo *bankInfo = [[AddBankInfo alloc] initWithNibName:@"AddBankInfo" bundle:nil];
    bankInfo.mShopInfo = _mShop;
    [self pushViewController:bankInfo];
}


#pragma mark ----顶部刷新数据
- (void)headerBeganRefresh{
    
    [self.tempArray removeAllObjects];
    
    [SVProgressHUD showWithStatus:@"加载中.." maskType:SVProgressHUDMaskTypeClear];
    
    [SWithDrawInfo GetBankInfo:^(SResBase *resb, SWithDrawInfo *retobj) {
        
        [self.tableView headerEndRefreshing];
        
        if (resb.msuccess) {
            
            [SVProgressHUD dismiss];
            
            if (!retobj || retobj == nil) {
                
                [self addEmptyView:nil];
                
                self.hiddenRightBtn = NO;
                self.rightBtnTitle = @"添加";
                
                return;
            }else{
                
                self.rightBtnTitle = nil;
                self.hiddenRightBtn = YES;
                self.tempArray = [NSMutableArray arrayWithObject:retobj];
                
                [self removeEmptyView];
                [self.tableView reloadData];
            }
            
        }else{
            [self addEmptyView:nil];
            [SVProgressHUD showErrorWithStatus:resb.mmsg];
        }
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


-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    BankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SWithDrawInfo *draw = [self.tempArray objectAtIndex:indexPath.row];
    
    cell.mName.text = [NSString stringWithFormat:@"%@\t%@",draw.mName,draw.mBank];
    cell.mNo.text = draw.mBankNo;
    
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{

    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    if(editingStyle==UITableViewCellEditingStyleDelete){
    
        SWithDrawInfo *draw = [self.tempArray objectAtIndex:indexPath.row];
        
        [SVProgressHUD showWithStatus:@"删除中.." maskType:SVProgressHUDMaskTypeClear];
        [draw DeleteBankInfo:^(SResBase *resb) {
          
            if (resb.msuccess) {
                [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                
                [self.tempArray removeAllObjects];
                [self.tableView reloadData];
                [self addEmptyView:nil];
                self.hiddenRightBtn = NO;
                self.rightBtnTitle = @"添加";
            }else{
                [SVProgressHUD showErrorWithStatus:resb.mmsg];
            }
        }];
    }
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//    SWithDrawInfo *draw = [self.tempArray objectAtIndex:indexPath.row];
//    
//    AddBankInfo *bankInfo = [[AddBankInfo alloc] initWithNibName:@"AddBankInfo" bundle:nil];
//    
//    bankInfo.mDraw = draw;
//    [self pushViewController:bankInfo];
//    
//}

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
