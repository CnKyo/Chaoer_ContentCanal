//
//  CookTVC.m
//  EasySearch
//
//  Created by 瞿伦平 on 16/3/11.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "CookTVC.h"
#import "APIClient.h"
#import "UIImageView+AFNetworking.h"
#import "CookDetailVC.h"
#import "ImageTextTableViewCell.h"

@interface CookTVC ()<UITableViewDelegate,UITableViewDataSource>

@end



@implementation CookTVC

-(void)loadView
{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Title = self.mPageName = _item.categoryInfo.name;
    self.hiddenBackBtn = NO;
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    
    self.page = 1;
    
    [self initView];
    
}
- (void)initView{
    
    [self loadTableView:CGRectMake(0, 0, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    //self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    
    self.haveHeader = YES;
    self.haveFooter = YES;
    
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


- (void)headerBeganRefresh{
    
    self.page = 1;
    
    [[APIClient sharedClient] cookListWithTag:self cookId:_item.categoryInfo.ctgId name:@"" pageIndex:self.page call:^(int totalpage, NSArray *tableArr, APIShareSdkObject *info) {
        [self headerEndRefresh];
        [self removeEmptyView];
        [self.tempArray removeAllObjects];
        
        if (info.retCode == RETCODE_SUCCESS) {
            if (tableArr.count <= 0) {
                [self addEmptyViewWithImg:nil];
                return ;
            }
            [self.tempArray addObjectsFromArray:tableArr];
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        } else {
            [self addEmptyViewWithImg:nil];
            [SVProgressHUD showErrorWithStatus:info.msg];
        }
    }];
}

- (void)footetBeganRefresh{
    
    self.page ++;
    
    [[APIClient sharedClient] cookListWithTag:self cookId:_item.categoryInfo.ctgId name:@"" pageIndex:self.page call:^(int totalpage, NSArray *tableArr, APIShareSdkObject *info) {
        [self footetEndRefresh];
        [self removeEmptyView];
        
        if (info.retCode == RETCODE_SUCCESS) {
            [self.tempArray addObjectsFromArray:tableArr];
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        } else {
            [self addEmptyViewWithImg:nil];
            [SVProgressHUD showErrorWithStatus:info.msg];
        }
        
        [self footetEndRefresh];
        [self removeEmptyView];
    }];
}





#pragma mark -- tableviewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tempArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CookTVCTableViewCell";
    ImageTextTableViewCell *cell = (ImageTextTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell= [[ImageTextTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    CookObject *item = [self.tempArray objectAtIndex:indexPath.row];
    cell.text1Lable.text = item.name;
    cell.text2Lable.text = item.ctgTitles;
    [cell.iconImgView setImageWithURL:[NSURL URLWithString:item.thumbnail] placeholderImage:IMG(@"DefaultImg.png")];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CookObject *item = [self.tempArray objectAtIndex:indexPath.row];
    CookDetailVC *vc = [[CookDetailVC alloc] init];
    vc.item = item;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
