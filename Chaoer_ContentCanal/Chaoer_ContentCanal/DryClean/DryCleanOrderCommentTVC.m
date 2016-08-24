//
//  ShopCommentTVC.m
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "DryCleanOrderCommentTVC.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "ShopCommentTableViewCell.h"
#import "APIClient.h"
#import "RatingBarView.h"
#import "QUCustomDefine.h"

static NSString * const GJShopCommentCellIndentifier = @"ShopCommentTableViewCell";

@interface DryCleanOrderCommentTVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation DryCleanOrderCommentTVC

-(void)loadView
{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Title = self.mPageName = @"商家评论";
    self.hiddenBackBtn = NO;
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    
    self.page = 1;
    
    [self initView];
}


- (void)initView{
    
    [self loadTableView:CGRectMake(0, 0, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    
    self.haveHeader = YES;
    self.haveFooter = NO;
    
    
    [self.tableView registerClass:[ShopCommentTableViewCell class] forCellReuseIdentifier:GJShopCommentCellIndentifier];
    
    UIView *headerView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 50)];
        view.backgroundColor = [UIColor clearColor];
        UIView *lineView = [view newUIViewWithBgColor:[UIColor colorWithRed:0.525 green:0.753 blue:0.125 alpha:1.000]];
        UILabel *lable = [view newUILableWithText:@"总体评分：" textColor:[UIColor colorWithRed:0.525 green:0.753 blue:0.125 alpha:1.000] font:[UIFont boldSystemFontOfSize:16]];
        RatingBarView *bar = [[RatingBarView alloc] initWithHight:25];
        [view addSubview:bar];
        [lineView makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(25);
            make.width.equalTo(3);
            make.centerY.equalTo(view.centerY);
            make.left.equalTo(view.left).offset(10);
        }];
        [lable makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(lineView);
            make.left.equalTo(lineView.right).offset(3);
        }];
        [bar makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView.top);
            make.left.equalTo(lable.right).offset(5);
        }];
        view;
    });
    self.tableView.tableHeaderView = headerView;
}

- (void)headerBeganRefresh{
    
    self.page = 1;
    
    [SVProgressHUD showWithStatus:@"加载类别中..."];
    [[APIClient sharedClient] cookCategoryQueryWithTag:self call:^(CookCategoryObject *item, APIShareSdkObject *info) {
        [self headerEndRefresh];
        [self removeEmptyView];
        [self.tempArray removeAllObjects];
        
        if (info.retCode == RETCODE_SUCCESS) {
            
            for (int i=0; i<10; i++) {
                [self.tempArray addObject:@"111"];
            }
            
            if (item == nil) {
                [self addEmptyViewWithImg:nil];
                return ;
            }
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        } else {
            [self addEmptyViewWithImg:nil];
            [SVProgressHUD showErrorWithStatus:info.msg];
        }
    }];
}



#pragma mark -- tableviewDelegate
- (void)configureCell:(ShopCommentTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    [cell loadUIWithData];

    
    //    DiscoveryThumbObject *item = [self.newsArr objectAtIndex:indexPath.row];
    //    cell.timeLable.text = item.created_at.length>0 ? item.created_at : @"未知时间";
    //    cell.msgLable.text = item.summary.length>0 ? item.summary : @"暂无描述";
    //    cell.zanCountLable.text = [NSString stringWithFormat:@"%i", item.like];
    //    cell.pingCountLable.text = [NSString stringWithFormat:@"%i", item.comments];
    
    //cell.msgLable.text = @"asdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdf";
    
    //    [cell.imgView updateConstraints:^(MASConstraintMaker *make) {
    //        make.height.equalTo(200);
    //    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tempArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    height = [tableView fd_heightForCellWithIdentifier:GJShopCommentCellIndentifier configuration:^(id cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
    //height = [self heightForCellAtIndexPath:indexPath];
    
    NSLog(@"newsTableView row:%ld   Height:%f",(long)indexPath.row, height);
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GJShopCommentCellIndentifier];
    if (cell == nil)
        cell= [[ShopCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GJShopCommentCellIndentifier];
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    CookObject *item = [self.tempArray objectAtIndex:indexPath.row];
    //    CookDetailVC *vc = [[CookDetailVC alloc] init];
    //    vc.item = item;
    //    vc.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:vc animated:YES];
}

@end
