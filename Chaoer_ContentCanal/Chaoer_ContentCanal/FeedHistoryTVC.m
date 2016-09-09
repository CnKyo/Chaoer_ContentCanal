//
//  FeedHistoryTVC.m
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/9/9.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "FeedHistoryTVC.h"
#import "msgTableViewCell.h"
#import "APIClient.h"
#import "messageTableViewController.h"
@interface FeedHistoryTVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation FeedHistoryTVC
{
    NSArray *mArr2;
    
}
- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"投诉消息";
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    
    [self initView];
}

- (void)initView{
    UIView *vvv= [UIView new];
    vvv.frame = CGRectMake(0, 64, DEVICE_Width, 10);
    vvv.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.95 alpha:1.00];
    vvv.layer.masksToBounds = YES;
    vvv.layer.borderWidth = 1;
    vvv.layer.borderColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:0.75].CGColor;
    [self.view addSubview:vvv];
    [self loadTableView:CGRectMake(0, 0, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.95 alpha:1.00];
    //    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.haveHeader = YES;
    self.haveFooter = NO;
    
    
    UINib   *nib = [UINib nibWithNibName:@"msgCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
}

- (void)headerBeganRefresh{
    
    self.page = 1;
    
    [[APIClient sharedClient] complainListWithTag:self call:^(NSArray *tableArr, APIObject *info) {
        [self headerEndRefresh];
        [self removeEmptyView];
        [self.tempArray removeAllObjects];
        
        [self.tempArray setArray:tableArr];
        
        if (info.state == RESP_STATUS_YES) {
            if (tableArr == nil) {
                [self addEmptyViewWithImg:nil];
                return ;
            }
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        } else {
            [self addEmptyViewWithImg:nil];
            [SVProgressHUD showErrorWithStatus:info.message];
        }
        
    }];
    
}
- (void)footetBeganRefresh{
    
    self.page ++;
    
    [[APIClient sharedClient] complainListWithTag:self call:^(NSArray *tableArr, APIObject *info) {
        [self footetEndRefresh];
        [self removeEmptyView];
        
        if (info.state == RESP_STATUS_YES) {
            if (tableArr == nil) {
                [self addEmptyViewWithImg:nil];
                return ;
            }
            [self.tempArray addObjectsFromArray:tableArr];
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        } else {
            [self addEmptyViewWithImg:nil];
            [SVProgressHUD showErrorWithStatus:info.message];
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
    NSString *reuseCellId = @"cell";
    
    
    msgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    [cell setComplain:self.tempArray[indexPath.row]];
    
    return cell.mCellH;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *reuseCellId = @"cell";
    
    
    msgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    [cell setComplain:self.tempArray[indexPath.row]];
    
    
    
    return cell;
    
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    ComplainObject *mmsg = self.tempArray[indexPath.row];
    
    NSMutableString *str = [NSMutableString new];
    
    [str appendFormat:@"投诉类型:%@\n", mmsg.typeName];
    [str appendFormat:@"投诉时间:%@\n", mmsg.add_time];
    
    switch (mmsg.type) {
        case 1:
            [str appendFormat:@"投诉居民:%@%@", mmsg.community, mmsg.room];
            break;
        case 2:
            [str appendFormat:@"投诉物业:%@\n", mmsg.community];
            [str appendFormat:@"投诉人员:%@\n", mmsg.staff_name];
            break;
        case 3:
            
            break;
        default:
            break;
    }
    
    [str appendFormat:@"投诉意见:%@\n", mmsg.complain_reason];
    [str appendFormat:@"处理状态:%@\n", mmsg.state ? @"已处理" : @"未处理"];

    if (mmsg.state == YES) {
        [str appendString:@"处理状态:已处理\n"];
        [str appendFormat:@"处理意见:%@\n", mmsg.deal_result];
        [str appendFormat:@"处理时间:%@", mmsg.deal_time];
    } else
        [str appendString:@"处理状态:未处理"];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"详情" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
//    {
//        //计算文字的尺寸大小
//        CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(240, 400) lineBreakMode:NSLineBreakByCharWrapping];
//        
//        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 240, size.height)];
//        textLabel.font = [UIFont systemFontOfSize:15];
//        textLabel.textColor = [UIColor blackColor];
//        textLabel.backgroundColor = [UIColor clearColor];
//        textLabel.lineBreakMode = NSLineBreakByCharWrapping;
//        textLabel.numberOfLines = 0;
//        textLabel.textAlignment = NSTextAlignmentLeft;
//        //                        textLabel.layer.borderWidth=1;
//        //                        textLabel.layer.borderColor=[UIColor grayColor].CGColor;
//        textLabel.text = str;
//        //添加label在alerView上
//        [alert setValue:textLabel forKey:@"accessoryView"];
//        
//        //清空alertview上的message
//        alert.message = @"";
//    }
    [alert show];
}


#pragma mark----读消息
- (void)readMsg:(int)mId{
    
    [[mUserInfo backNowUser] readMsg:mId block:^(mBaseData *resb) {
        if (resb.mSucess) {
            [self showSuccessStatus:resb.mMessage];
            //[self headerBeganRefresh];
        }else{
            [self showErrorStatus:resb.mMessage];
        }
    }];
    
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewCellEditingStyleDelete;
//}
//
//- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return @"删除";
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    GMsgObj *mmsg = self.tempArray[indexPath.row];
//    
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.tempArray removeObject:self.tempArray[indexPath.row]];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        
//        [self deleteMsg:mmsg.mId];
//        
//    }
//}
//#pragma mark----删除消息
//- (void)deleteMsg:(int)mId{
//    
//    
//    
//    [[mUserInfo backNowUser] deleteMsg:mId block:^(mBaseData *resb) {
//        if (resb.mSucess) {
//            [self headerBeganRefresh];
//        }else{
//            [self showErrorStatus:resb.mMessage];
//        }
//    }];
//    
//}
@end
