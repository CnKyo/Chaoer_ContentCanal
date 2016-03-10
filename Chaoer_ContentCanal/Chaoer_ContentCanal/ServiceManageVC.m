//
//  ServiceManageVC.m
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/10/29.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "ServiceManageVC.h"
#import "DetailCell.h"
#import "ServiceDetailVC.h"
#import "AddServiceTypeVC.h"

@interface ServiceManageVC ()<UITableViewDataSource,UITableViewDelegate>{

    UIButton *editBT;
    
    BOOL IsEdit;
}

@end

@implementation ServiceManageVC

- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(_type == 1)
        self.mPageName = @"商品管理";
    else
        self.mPageName = @"服务管理";
    
    self.Title = self.mPageName;
    self.rightBtnTitle = @"添加分类";
    [self.navBar.rightBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    self.navBar.rightBtn.frame = CGRectMake(DEVICE_Width-80, self.navBar.leftBtn.origin.y, 100, self.navBar.leftBtn.mheight);
    
    self.tableView = _mTableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = M_BGCO;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 50)];
    headView.backgroundColor = M_BGCO;
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, 100, 50)];
    lab.textColor = COLOR(133, 134, 135);
    lab.font = [UIFont systemFontOfSize:16];
    
    if(_type == 1)
        lab.text = @"产品分类列表";
    else
        lab.text = @"服务分类列表";
    [headView addSubview:lab];
    
    editBT = [[UIButton alloc] initWithFrame:CGRectMake(DEVICE_Width-50, 0, 50, 50)];
    [editBT setTitle:@"编辑" forState:UIControlStateNormal];
    editBT.font = [UIFont systemFontOfSize:16];
    [editBT setTitleColor:COLOR(249, 11, 57) forState:UIControlStateNormal];
    [headView addSubview:editBT];
    [editBT addTarget:self action:@selector(EditClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView setTableHeaderView:headView];
    
    self.haveHeader = YES;
    [self.tableView headerBeginRefreshing];
}

- (void)rightBtnTouched:(id)sender{

    AddServiceTypeVC *addtype = [[AddServiceTypeVC alloc] initWithNibName:@"AddServiceTypeVC" bundle:nil];
    addtype.block = ^(BOOL flag){
    
        if (flag) {
            
            [self.tableView headerBeginRefreshing];
        }
    
    };
    addtype.type = _type;
    
    [self pushViewController:addtype];
}

- (void)EditClick:(UIButton *)sender
{
    IsEdit = !IsEdit;
    [self.tableView reloadData];
    
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    
    if (self.tableView.editing) {
        [editBT setTitle:@"完成" forState:UIControlStateNormal];
        [editBT setTitleColor:COLOR(133, 134, 135) forState:UIControlStateNormal];
        
    }else{
        [editBT setTitle:@"编辑" forState:UIControlStateNormal];
        [editBT setTitleColor:COLOR(249, 11, 57) forState:UIControlStateNormal];
        
    }
    
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewCellEditingStyleNone;
//}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //    需要的移动行
    NSInteger fromRow = [sourceIndexPath row];
    //    获取移动某处的位置
    NSInteger toRow = [destinationIndexPath row];
    //    从数组中读取需要移动行的数据
    id object = [self.tempArray objectAtIndex:fromRow];
    //    在数组中移动需要移动的行的数据
    [self.tempArray removeObjectAtIndex:fromRow];
    //    把需要移动的单元格数据在数组中，移动到想要移动的数据前面
    [self.tempArray insertObject:object atIndex:toRow];
    
    NSMutableArray *arry = NSMutableArray.new;
    for(STrade *trade in self.tempArray){
    
        [arry addObject:@(trade.mId)];
    }
    
    [SGoodsCate updateSort:arry block:^(SResBase *resb) {
        
    }];
}

//- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
//{
////    NSInteger row = indexPath.row;
//    
//    NSLog(@"编辑编辑");
//}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle==UITableViewCellEditingStyleDelete)
    {
        
        SGoodsCate *cate = [self.tempArray objectAtIndex:indexPath.row];
        
        [SVProgressHUD showWithStatus:@"操作中.." maskType:SVProgressHUDMaskTypeClear];
        [cate delThis:^(SResBase *resb) {
            if (resb.msuccess) {
                [SVProgressHUD dismiss];
                [self.tempArray removeObjectAtIndex:indexPath.row];
                // Delete the row from the data source.
                [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }else{
            
                [SVProgressHUD showErrorWithStatus:resb.mmsg];
            }
        }];
        
    }
}


#pragma mark ----顶部刷新数据
- (void)headerBeganRefresh{

    [SGoodsCate getGoodCates:_type block:^(SResBase *resb, NSArray *all) {
        
        [self headerEndRefresh];
        [self.tempArray removeAllObjects];
        if (resb.msuccess) {
            
            [self.tempArray removeAllObjects];
            [self.tempArray addObjectsFromArray:all];
        }
        else{
            [self addEmptyViewWithImg:nil];
        }
        
        if(all.count == 0 || all == nil)
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



#pragma mark ----列表代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *string = @"scell";
    
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    
    cell.mEditBT.tag = indexPath.row;
    [cell.mEditBT addTarget:self action:@selector(EditServiceClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (IsEdit) {
        cell.mEditBT.hidden = NO;
    }else{
       cell.mEditBT.hidden = YES;
    }
    
    SGoodsCate *cate = [self.tempArray objectAtIndex:indexPath.row];
    cell.mTitle.text = cate.mName;
    
    if(_type == 1)
        cell.mDetail.text = [NSString stringWithFormat:@"%d个商品",cate.mGoodsNum];
    else
       cell.mDetail.text = [NSString stringWithFormat:@"%d个服务",cate.mGoodsNum];
    
    return cell;
    
    
}

- (void)EditServiceClick:(UIButton *)sender{

    int index = (int)sender.tag;
    
    SGoodsCate *cate = [self.tempArray objectAtIndex:index];
    AddServiceTypeVC *addtype = [[AddServiceTypeVC alloc] initWithNibName:@"AddServiceTypeVC" bundle:nil];
    addtype.block = ^(BOOL flag){
        
        if (flag) {
            
            [self.tableView headerBeginRefreshing];
        }
        
    };

    addtype.mCate = cate;
    addtype.type = _type;
    [self pushViewController:addtype];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tempArray.count;
    
}
//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return UITableViewAutomaticDimension;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ServiceDetailVC *viewController = [storyboard instantiateViewControllerWithIdentifier:@"ServiceDetailVC"];
    
    SGoodsCate *cate = [self.tempArray objectAtIndex:indexPath.row];
    viewController.mCate = cate;
    viewController.type = _type;
    
    [self pushViewController:viewController];
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
