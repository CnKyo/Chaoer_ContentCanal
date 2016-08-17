//
//  HouseKeepShopTVC.m
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "HouseKeepShopTVC.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "HouseKeepShopInfoTableViewCell.h"

static NSString * const GJCellIndentifier = @"HouseKeepShopTVCTableViewCell1";

@interface HouseKeepShopTVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation HouseKeepShopTVC

-(void)loadView
{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Title = self.mPageName = @"家政服务";
    self.hiddenBackBtn = YES;
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    
    self.page = 1;
    
    [self initView];
    
    
    
    
}
- (void)initView{
    
    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-114) delegate:self dataSource:self];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    
    self.haveHeader = YES;
    self.haveFooter = NO;
    
    
    [self.tableView registerClass:[HouseKeepShopInfoTableViewCell class] forCellReuseIdentifier:GJCellIndentifier];
}

- (void)headerBeganRefresh{
    
    self.page = 1;
    
//    [SVProgressHUD showWithStatus:@"加载类别中..."];
//    [[APIClient sharedClient] cookCategoryQueryWithTag:self call:^(CookCategoryObject *item, APIObject *info) {
//        [self headerEndRefresh];
//        [self removeEmptyView];
//        [self.tempArray removeAllObjects];
//        
//        if (info.retCode == RETCODE_SUCCESS) {
//            self.item = item;
//            if (item == nil) {
//                [self addEmptyViewWithImg:nil];
//                return ;
//            }
//            [self.tableView reloadData];
//            [SVProgressHUD dismiss];
//        } else {
//            [self addEmptyViewWithImg:nil];
//            [SVProgressHUD showErrorWithStatus:info.msg];
//        }
//    }];
}



#pragma mark -- tableviewDelegate
- (void)configureCell:(HouseKeepShopInfoTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
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
    if (indexPath.section == 0) {
        CGFloat height = 0;
        height = [tableView fd_heightForCellWithIdentifier:GJCellIndentifier configuration:^(id cell) {
            [self configureCell:cell atIndexPath:indexPath];
        }];
        //height = [self heightForCellAtIndexPath:indexPath];
        
        NSLog(@"newsTableView row:%ld   Height:%f",(long)indexPath.row, height);
        return height;
    }
    return 60;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        HouseKeepShopInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GJCellIndentifier];
        if (cell == nil)
            cell= [[HouseKeepShopInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GJCellIndentifier];
        
        [self configureCell:cell atIndexPath:indexPath];
        return cell;
    }
    static NSString *CellIdentifier = @"HouseKeepShopTVCTableViewCell1";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        UIView *superView = cell.contentView;
        
    }
//    CookObject *item = [self.tempArray objectAtIndex:indexPath.row];
//    cell.text1Lable.text = item.name;
//    cell.text2Lable.text = item.ctgTitles;
//    [cell.iconImgView setImageWithURL:[NSURL URLWithString:item.thumbnail] placeholderImage:IMG(@"DefaultImg.png")];
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
