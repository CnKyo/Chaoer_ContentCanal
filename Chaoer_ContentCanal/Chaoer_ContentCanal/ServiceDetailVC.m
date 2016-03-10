//
//  ServiceDetailVC.m
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/10/29.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "ServiceDetailVC.h"
#import "ServiceCell.h"
#import "ServiceHeadView.h"
#import "AddServiceVC.h"
#import "AddServiceTypeVC.h"
#import "AddGoodsVC.h"

@interface ServiceDetailVC ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>{

    BOOL IsEdit;
    ServiceHeadView *headView;
    
    UIView *sectionView;
    
    UIButton *leftBT;
    UIButton *rightBT;
    
    UIView *lineView;
    
    UIButton *tempBT;
    int nowSelect;
    NSMutableDictionary *tempDic;
    
    NSMutableArray *selectArry;
    
    NSString *key;
}

@end

@implementation ServiceDetailVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /**
     IQKeyboardManager为自定义收起键盘
     **/
    [[IQKeyboardManager sharedManager] setEnable:YES];///视图开始加载键盘位置开启调整
    [[IQKeyboardManager sharedManager]setEnableAutoToolbar:YES];///是否启用自定义工具栏
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;///启用手势
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];///视图消失键盘位置取消调整
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];///关闭自定义工具栏
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}

- (void)viewDidLoad {
    
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    self.Title = self.mPageName = _mCate.mName;
    
    self.rightBtnTitle = @"添加服务";
    key = @"";
    
    [self.navBar.rightBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    self.navBar.rightBtn.frame = CGRectMake(DEVICE_Width-80, self.navBar.leftBtn.origin.y, 100, self.navBar.leftBtn.mheight);
    tempDic = NSMutableDictionary.new;
    
    self.tableView = _mTableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = M_BGCO;
    
    self.tableView.tableFooterView.frame = CGRectZero;
    
    headView = [ServiceHeadView shareView];
    
    headView.mSearchBar.delegate = self;
    headView.mText.text = @"服务分类列表";
    
    [self.tableView setTableHeaderView:headView];
    [headView.mEditBT addTarget:self action:@selector(EditClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [headView.mCheckBT setImage:[UIImage imageNamed:@"dp_kongquan"] forState:UIControlStateNormal];
    [headView.mCheckBT setImage:[UIImage imageNamed:@"dp_hongquan"] forState:UIControlStateSelected];
    [headView.mCheckBT addTarget:self action:@selector(CheckClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.haveFooter = YES;
    self.haveHeader = YES;
    [self.tableView headerBeginRefreshing];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 50)];
    sectionView.backgroundColor = [UIColor whiteColor];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 1)];
    line.backgroundColor = COLOR(220, 220, 221);
    [sectionView addSubview:line];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 49, DEVICE_Width, 1)];
    line2.backgroundColor = COLOR(220, 220, 221);
    [sectionView addSubview:line2];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(DEVICE_Width/2, 8, 1, 34)];
    line3.backgroundColor = COLOR(220, 220, 221);
    [sectionView addSubview:line3];
    
    
    leftBT = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width/2, 50)];
    [leftBT setTitle:@"上架服务" forState:UIControlStateNormal];
    leftBT.font = [UIFont systemFontOfSize:16];
    [leftBT setTitleColor:COLOR(249, 6, 59) forState:UIControlStateNormal];
    [sectionView addSubview:leftBT];
    leftBT.tag = 11;
    [leftBT addTarget:self action:@selector(ChoseClick:) forControlEvents:UIControlEventTouchUpInside];
    
    rightBT = [[UIButton alloc] initWithFrame:CGRectMake(DEVICE_Width/2+1, 0, DEVICE_Width/2-1, 50)];
    rightBT.font = [UIFont systemFontOfSize:16];
    [rightBT setTitle:@"下架服务" forState:UIControlStateNormal];
    [rightBT setTitleColor:COLOR(71, 72, 73) forState:UIControlStateNormal];
    [sectionView addSubview:rightBT];
    rightBT.tag = 12;
    [rightBT addTarget:self action:@selector(ChoseClick:) forControlEvents:UIControlEventTouchUpInside];
    
    lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 47, 85, 3)];
    lineView.center = leftBT.center;
    CGRect rect = lineView.frame;
    rect.origin.y = 47;
    lineView.frame = rect;
    lineView.backgroundColor = COLOR(249, 6, 59);
    [sectionView addSubview:lineView];
    
    nowSelect = 1;
    tempBT = leftBT;
    
    if (_type == 1) {
        self.rightBtnTitle = @"添加商品";
        headView.mText.text = @"产品分类列表";
        [leftBT setTitle:@"上架商品" forState:UIControlStateNormal];
        [rightBT setTitle:@"下架商品" forState:UIControlStateNormal];
    }
    
    selectArry = [[NSMutableArray alloc] initWithCapacity:0];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

    key = searchBar.text;
    
    [self.tableView headerBeginRefreshing];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{

    key = searchBar.text;
    
    [self.tableView headerBeginRefreshing];
}

- (void)rightBtnTouched:(id)sender{

    
    if (_type == 1) {//商品
       
        AddGoodsVC *addGoods = [[AddGoodsVC alloc] initWithNibName:@"AddGoodsVC" bundle:nil];
        addGoods.mCate = _mCate;
        addGoods.block = ^(BOOL flag){
            if (flag) {
                [self.tableView headerBeginRefreshing];
            }
        };

        
        [self pushViewController:addGoods];
        
        return;
    }
    
    if (_type == 2) {//服务
        AddServiceVC *addservice = [[AddServiceVC alloc] initWithNibName:@"AddServiceVC" bundle:nil];
        addservice.mCate = _mCate;
        addservice.block = ^(BOOL flag){
            if (flag) {
                [self.tableView headerBeginRefreshing];
            }
        };
        [self pushViewController:addservice];
        
    }


}

- (void)ChoseClick:(UIButton *)sender{

    if (sender.tag == tempBT.tag) {
        return;
    }
    
    [sender setTitleColor:COLOR(249, 6, 59) forState:UIControlStateNormal];
     [tempBT setTitleColor:COLOR(71, 72, 73) forState:UIControlStateNormal];
    
    if (sender.tag == 11) {
        nowSelect = 1;
        _mLeft.text = @"下架";
        _mLeftImg.image = [UIImage imageNamed:@"dp_xiajia"];
    }else{
        nowSelect = 2;
        _mLeft.text = @"上架";
        _mLeftImg.image = [UIImage imageNamed:@"dp_shangjia"];
    }
    tempBT = sender;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        lineView.center = sender.center;
        CGRect rect = lineView.frame;
        rect.origin.y = 47;
        lineView.frame = rect;
    }];
    
    [self.tableView headerBeginRefreshing];

}

- (void)CheckClick:(UIButton *)sender{

    sender.selected = !sender.selected;
    
    NSMutableArray *arry = [tempDic objectForKey:[NSString stringWithFormat:@"select%d",nowSelect]];
    for (SGoods *g in arry) {
        
        if (sender.selected) {
            g.mIsCheck = YES;
        }else{
            g.mIsCheck = NO;
        }
        
    }
    
    [self.tableView reloadData];
}

- (void)CheckClick2:(UIButton *)sender{
    
    NSMutableArray *arry = [tempDic objectForKey:[NSString stringWithFormat:@"select%d",nowSelect]];
    SGoods *goods = [arry objectAtIndex:sender.tag];
    
    goods.mIsCheck = !goods.mIsCheck;
    sender.selected = !sender.selected;
    

}

- (void)EditClick:(UIButton *)sender{

    IsEdit = !IsEdit;
    
    
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    
    if (self.tableView.editing) {
        [headView.mEditBT setTitle:@"完成" forState:UIControlStateNormal];
        [headView.mEditBT setTitleColor:COLOR(133, 134, 135) forState:UIControlStateNormal];
        headView.mText.hidden = YES;
        headView.mCheckBT.hidden = NO;
        headView.mQuanxuan.hidden = NO;
        headView.mCheckBT.selected = NO;
        
    }else{
        [headView.mEditBT setTitle:@"编辑" forState:UIControlStateNormal];
        [headView.mEditBT setTitleColor:COLOR(249, 11, 57) forState:UIControlStateNormal];
        headView.mText.hidden = NO;
        headView.mCheckBT.hidden = YES;
        headView.mQuanxuan.hidden = YES;
    }
    [self.tableView reloadData];
}


#pragma mark ----顶部刷新数据
- (void)headerBeganRefresh{
    
    self.page=1;
    
  
    [_mCate getGoodsList:nowSelect keywords:key page:self.page block:^(SResBase *resb, NSArray *all) {
        
        [self headerEndRefresh];
        [tempDic removeAllObjects];
        
        if (resb.msuccess) {
            
            [tempDic setObject:all forKey:[NSString stringWithFormat:@"select%d",nowSelect]];
        }
        else{
            [self addEmptyViewWithImg:nil];
            [SVProgressHUD showErrorWithStatus:resb.mmsg];
        }
        
        if(all.count == 0 )
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
#pragma mark----地步刷新
-(void)footetBeganRefresh
{
    self.page++;
    [_mCate getGoodsList:nowSelect keywords:key page:self.page block:^(SResBase *resb, NSArray *all)  {
        [self footetEndRefresh];
        if (resb.msuccess) {
            
            NSMutableArray *arry = [tempDic objectForKey:[NSString stringWithFormat:@"select%d",nowSelect]];
            
            [arry addObjectsFromArray:all];
        }
        else{
            [SVProgressHUD showErrorWithStatus:resb.mmsg];
        }
        
        NSMutableArray *arry = [tempDic objectForKey:[NSString stringWithFormat:@"select%d",nowSelect]];
        if( arry.count == 0 )
        {
            [self addEmptyViewWithImg:nil];
        }
        else
        {
            [self removeEmptyView];
        }
    }];
    
    [self.tableView reloadData];
    
}



//-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

//-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
//{
//    
//    NSMutableArray *arry = [tempDic objectForKey:[NSString stringWithFormat:@"select%d",nowSelect]];
//    //    需要的移动行
//    NSInteger fromRow = [sourceIndexPath row];
//    //    获取移动某处的位置
//    NSInteger toRow = [destinationIndexPath row];
//    //    从数组中读取需要移动行的数据
//    id object = [arry objectAtIndex:fromRow];
//    //    在数组中移动需要移动的行的数据
//    [arry removeObjectAtIndex:fromRow];
//    //    把需要移动的单元格数据在数组中，移动到想要移动的数据前面
//    [arry insertObject:object atIndex:toRow];
//    
//    NSMutableArray *arry2 = NSMutableArray.new;
//    for(STrade *trade in self.tempArray){
//        
//        [arry2 addObject:@(trade.mId)];
//    }
//    
////    [SGoods updateSort:arry block:^(SResBase *resb) {
////        
////    }];
//}

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
        NSMutableArray *arry = [tempDic objectForKey:[NSString stringWithFormat:@"select%d",nowSelect]];
        SGoods *goods = [arry objectAtIndex:indexPath.row];
        
        NSArray *ary = [[NSArray alloc] initWithObjects:@(goods.mId), nil];
        
        [SVProgressHUD showWithStatus:@"操作中.." maskType:SVProgressHUDMaskTypeClear];
        [SGoods delSome:ary block:^(SResBase *resb) {
            if (resb.msuccess) {
                [SVProgressHUD dismiss];
                
                [arry removeObjectAtIndex:indexPath.row];
                // Delete the row from the data source.
                [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                
            }else{
                [SVProgressHUD showErrorWithStatus:resb.mmsg];
            }
        }];
        
       
        
    }
}

#pragma mark ----列表代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *string = @"ServiceCell";
    
    ServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (IsEdit) {
        cell.mLeftConst.constant = 8;
        cell.mRightConst.constant = 48;
        cell.mCheck.hidden = NO;
        cell.mImg.hidden = YES;
        cell.mEdit.hidden = NO;
    }else{
        cell.mLeftConst.constant = 62;
        cell.mRightConst.constant = 15;
        cell.mCheck.hidden = YES;
        cell.mImg.hidden = NO;
        cell.mEdit.hidden = YES;
    }
    
    cell.mCheck.tag = indexPath.row;
    [cell.mCheck addTarget:self action:@selector(CheckClick2:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [cell.mCheck setImage:[UIImage imageNamed:@"dp_kongquan"] forState:UIControlStateNormal];
    [cell.mCheck setImage:[UIImage imageNamed:@"dp_hongquan"] forState:UIControlStateSelected];
    
    cell.mEdit.tag = indexPath.row;
    [cell.mEdit addTarget:self action:@selector(EditGoodsClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (headView.mCheckBT.selected) {
        cell.mCheck.selected = YES;
    }else{
         cell.mCheck.selected = NO;
    }
    
    
    NSMutableArray *arry = [tempDic objectForKey:[NSString stringWithFormat:@"select%d",nowSelect]];
    SGoods *goods = [arry objectAtIndex:indexPath.row];
    cell.mName.text = goods.mName;
    cell.mPrice.text =  [NSString stringWithFormat:@"¥%.2f",goods.mPrice];
    cell.mNum.text = [NSString stringWithFormat:@"销量：%d",goods.mSaleCount];
    
    if (goods.mImgs.count>0) {
        [cell.mImg sd_setImageWithURL:[NSURL URLWithString:[goods.mImgs objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"img_def"]];
    }
    
    if (goods.mIsCheck) {
        cell.mCheck.selected = YES;
    }else{
        cell.mCheck.selected = NO;
    }
    
    return cell;
    
    
}

- (void)EditGoodsClick:(UIButton *)sender{
    
    int index = (int)sender.tag;
    
    NSMutableArray *arry = [tempDic objectForKey:[NSString stringWithFormat:@"select%d",nowSelect]];
    SGoods *goods = [arry objectAtIndex:index];
   
    
    if (_type == 1) {
        AddGoodsVC *addservice = [[AddGoodsVC alloc] initWithNibName:@"AddGoodsVC" bundle:nil];
        addservice.mGoods = goods;
        addservice.mCate = _mCate;
        addservice.mSelect = nowSelect;
        addservice.block = ^(BOOL flag){
            if (flag) {
                [self.tableView headerBeginRefreshing];
            }
        };
        
        [self pushViewController:addservice];
        
        return;
    }
    
    if (_type == 2) {
        AddServiceVC *addservice = [[AddServiceVC alloc] initWithNibName:@"AddServiceVC" bundle:nil];
        addservice.mGoods = goods;
        addservice.mCate = _mCate;
        addservice.mSelect = nowSelect;
        addservice.block = ^(BOOL flag){
            if (flag) {
                [self.tableView headerBeginRefreshing];
            }
        };
     
        [self pushViewController:addservice];
        
        return;
    }
    
    

    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray *arry = [tempDic objectForKey:[NSString stringWithFormat:@"select%d",nowSelect]];
    return [arry count];
    
}
//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return UITableViewAutomaticDimension;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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

- (IBAction)mXiaJiaClick:(id)sender {
    
    NSMutableArray *arry = [tempDic objectForKey:[NSString stringWithFormat:@"select%d",nowSelect]];
    [selectArry removeAllObjects];
    for (SGoods *g in arry) {
        
        if (g.mIsCheck) {
            [selectArry addObject:@(g.mId)];
        }
    }
    
    if(selectArry.count<=0){
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的选择为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
        return;
    }
    
    if (nowSelect == 1) {
        [SVProgressHUD showWithStatus:@"操作中.." maskType:SVProgressHUDMaskTypeClear];
        [SGoods getOff:selectArry block:^(SResBase *resb) {
            if (resb.msuccess) {
                [SVProgressHUD showSuccessWithStatus:resb.mmsg];
                [self.tableView headerBeginRefreshing];
            }else{
                [SVProgressHUD showErrorWithStatus:resb.mmsg];
            }
        }];
    }else{
        [SVProgressHUD showWithStatus:@"操作中.." maskType:SVProgressHUDMaskTypeClear];
        [SGoods getOn:selectArry block:^(SResBase *resb) {
            if (resb.msuccess) {
                [SVProgressHUD showSuccessWithStatus:resb.mmsg];
                [self.tableView headerBeginRefreshing];
            }else{
                [SVProgressHUD showErrorWithStatus:resb.mmsg];
            }
        }];
        
    }
    
    
    
    
    
}

- (IBAction)mDeletClick:(id)sender {
    
    NSMutableArray *arry = [tempDic objectForKey:[NSString stringWithFormat:@"select%d",nowSelect]];
    [selectArry removeAllObjects];
    for (SGoods *g in arry) {
        
        if (g.mIsCheck) {
            [selectArry addObject:@(g.mId)];
        }
    }
    
    if(selectArry.count<=0){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的选择为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
        return;
    }
    
    [SVProgressHUD showWithStatus:@"操作中.." maskType:SVProgressHUDMaskTypeClear];
    [SGoods delSome:selectArry block:^(SResBase *resb) {
        if (resb.msuccess) {
            [SVProgressHUD showSuccessWithStatus:resb.mmsg];
            [self.tableView headerBeginRefreshing];
        }else{
            [SVProgressHUD showErrorWithStatus:resb.mmsg];
        }
    }];
}
@end
