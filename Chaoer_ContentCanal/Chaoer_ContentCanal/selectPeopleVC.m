//
//  selectPeopleVC.m
//  O2O_Communication_seller
//
//  Created by zzl on 15/11/11.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "selectPeopleVC.h"

@interface selectPeopleVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation selectPeopleVC
{
    NSInteger _index;
}
- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.Title = self.mPageName = self.mTagOrder.mOrderType == 1 ? @"选择配送人员":@"选择服务人员";
    
//    if( self.mTagOrder.mStaff )
//        _index = self.mTagOrder.mStaff.mId;
//    else
//        _index = -1;
    self.hiddenRightBtn = NO;
    [self setRightBtnTitle:@"确定"];
    
    [self loadTableView:CGRectMake(0, 0, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    [self setHaveHeader:YES];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView headerBeginRefreshing];
}
-(void)rightBtnTouched:(id)sender
{
//    if( _index != self.mTagOrder.mStaff.mId )
//    {
//        [SVProgressHUD showWithStatus:@"操作中..." maskType:SVProgressHUDMaskTypeClear];
//        [self.mTagOrder selectPeople:_index block:^(SResBase *resb) {
//            
//            if( resb.msuccess )
//            {
//                if( _mitblock )
//                    _mitblock( _index );
//                
//                [self performSelector:@selector(leftBtnTouched:) withObject:nil afterDelay:0.75f];
//                
//            }
//            else
//            {
//                [SVProgressHUD showErrorWithStatus:resb.mmsg];
//            }
//        }];
//    }
//    else
//        [self leftBtnTouched:nil];
}

-(void)headerBeganRefresh
{
    
//    [SPeople getPeoples:self.mTagOrder.mOrderType block:^(SResBase *resb, NSArray *all) {
//        
//        [self headerEndRefresh];
//        if( resb.msuccess )
//        {
//            [self.tempArray removeAllObjects];
//            [self.tempArray addObjectsFromArray:all];
//            [self.tableView reloadData];
//        }
//        else
//        {
//            [SVProgressHUD showErrorWithStatus:resb.mmsg];
//        }
//        
//    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tempArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if( cell == nil )
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier: nil];
    }
//    SPeople * one = [self.tempArray objectAtIndex:indexPath.row];
//    if( one.mId == _index )
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    else
//        cell.accessoryType = UITableViewCellAccessoryNone;
    
//    cell.textLabel.text = [NSString stringWithFormat:@"%@      %@",one.mName,one.mMobile];

    cell.tintColor = [UIColor redColor];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    SPeople * one = [self.tempArray objectAtIndex:indexPath.row];
//    _index = one.mId;
    [tableView reloadData];
    
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
