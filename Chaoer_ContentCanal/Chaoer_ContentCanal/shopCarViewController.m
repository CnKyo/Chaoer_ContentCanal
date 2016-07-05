//
//  shopCarViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/28.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "shopCarViewController.h"
#import "shopCarHeaderAndFooterView.h"

#import "shopCarTableViewCell.h"

#import "comFirmOrderViewController.h"
@interface shopCarViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)    NSMutableArray  *mFooterDataArr;

@property(nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic, strong) NSMutableArray *deleteArr;//删除数据的数组
@property(nonatomic, strong) NSMutableArray *markArr;//标记数据的数组
@property(nonatomic, strong) UIButton *selectAllBtn;//选择按钮
@property(nonatomic, strong) UIView *baseView;//背景view
@property(nonatomic, strong) UIButton *deleteBtn;//删除
@property(nonatomic, strong) NSMutableArray *selectedRows;

@end

@implementation shopCarViewController
{
    /**
     *  列表头部view
     */
    shopCarHeaderAndFooterView *mHeaderView;
    /**
     *  列表尾部view
     */
    shopCarHeaderAndFooterView *mFooterView;
    /**
     *  列表尾部子视图
     */
    shopCarHeaderAndFooterView *mFooterSubView;
    
    /**
     *  底部视图
     */
    shopCarHeaderAndFooterView *mComfirView;
    
    UIView *mBottomView;

}
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithArray:@[@"科比·布莱恩特",@"德里克·罗斯",@"勒布朗·詹姆斯",@"凯文·杜兰特",@"德怀恩·韦德",@"克里斯·保罗"]];
        
    }
    return _dataArray;
}

- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    
    [super viewDidLoad];
    
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.Title = self.mPageName = @"购物车";
    self.mFooterDataArr = [NSMutableArray new];
    self.rightBtnTitle = @"编辑";
    
    self.deleteArr = [NSMutableArray array];
    self.markArr = [NSMutableArray array];

    
    [self initView];

}
- (void)initView{

    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-114) delegate:self dataSource:self];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    
    self.tableView.editing = NO;

    
    self.haveHeader = YES;
    
    
    UINib   *nib = [UINib nibWithNibName:@"shopCarTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    
    mComfirView = [shopCarHeaderAndFooterView shareComfirView];
    [mComfirView.mSelectAll addTarget:self action:@selector(mSelectedAllAction:) forControlEvents:UIControlEventTouchUpInside];
    [mComfirView.mGoPayBtn addTarget:self action:@selector(mGoPayAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:mComfirView];

    [mComfirView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).offset(@0);
        make.height.offset(@50);
    }];
    
    [self loadTableFooterView];
    
}
- (void)mGoPayAction:(UIButton *)sender{
    comFirmOrderViewController *comfir = [[comFirmOrderViewController alloc] initWithNibName:@"comFirmOrderViewController" bundle:nil];
    [self pushViewController:comfir];
    
}
#pragma mark----加载列表头部空view
/**
 *  加载列表头部空view
 */
- (void)loadTableHeaderEmptyView{

    [mHeaderView removeFromSuperview];
    
    if (mHeaderView == nil) {
        mHeaderView = [shopCarHeaderAndFooterView shareHeaderView];
        mHeaderView.frame = CGRectMake(0, 0, DEVICE_Width, 180);
        [self.tableView setTableHeaderView:mHeaderView];
    }
    
}
#pragma mark----加载列表底部空view
/**
 *  加载列表底部空view
 */
- (void)loadTableFooterView{

    [mFooterView removeFromSuperview];
    [mBottomView removeFromSuperview];
    for (UIView *subView in mBottomView.subviews) {
        [subView removeFromSuperview];
    }
//    if (_mFooterDataArr) {
    
    mBottomView = [UIView new];
    mBottomView.frame= CGRectMake(0, 0, DEVICE_Width, 1000);
    

        mFooterView = [shopCarHeaderAndFooterView shareFooterView];
        mFooterView.frame = CGRectMake(0, 0, mBottomView.mwidth, 40);
    mFooterView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    [mBottomView addSubview:mFooterView];
        
        int x = 5;
        int y = 45;
        
        for (int i = 0; i<5; i++) {
            
            
            UIView *mSubView = [UIView new];
            mSubView.frame = CGRectMake(x+10, y, DEVICE_Width/2-20, 160);
            mSubView.backgroundColor = [UIColor whiteColor];
            
            [mBottomView addSubview:mSubView];
            
            mFooterSubView = [shopCarHeaderAndFooterView shareFooterSubView];
            mFooterSubView.frame = CGRectMake(0, 0, mSubView.mwidth, mSubView.mheight);
            [mSubView addSubview:mFooterSubView];
                        
            UIButton *bbb = [UIButton new];
            bbb.backgroundColor = [UIColor clearColor];
            bbb.frame = CGRectMake(0, 0, mSubView.mwidth, mSubView.mheight);
            bbb.tag = i;
            [bbb addTarget:self action:@selector(bbbAction:) forControlEvents:UIControlEventTouchUpInside];
            [mSubView addSubview:bbb];
            
            
            x+=DEVICE_Width/2-10;
            
            if (x>=(DEVICE_Width/2-20)*2) {
                x = 5;
                y+=170;
            }
            
            
        }
    
    CGRect mRRR = mBottomView.frame;
    mRRR.size.height = y+170;
    mBottomView.frame = mRRR;
    [self.tableView setTableFooterView:mBottomView];

//    }
    
}
- (void)bbbAction:(UIButton *)sender{

    MLLog(@"点击了哪一个：%ld",(long)sender.tag);

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
#pragma mark----编辑
- (void)rightBtnTouched:(id)sender{

    UIButton *btn = sender;
    btn.selected = !btn.selected;
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    self.tableView.editing = !self.tableView.editing;

    if (btn.selected) {
        [btn setTitle:@"完成" forState:0];
        [self.tableView setEditing:YES animated:YES];
    


    }else{
        [btn setTitle:@"编辑" forState:0];
        [self.tableView setEditing:NO animated:YES];
        [mComfirView.mSelectAll setTitle:@"全选" forState:0];
        
        for (int i = 0; i < self.dataArray.count; i ++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            [self.deleteArr removeObjectsInArray:self.dataArray];
        }
    }
//    [self.tableView reloadData];

}
#pragma mark----全选
- (void)mSelectedAllAction:(UIButton *)sender{
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    self.tableView.editing = !self.tableView.editing;
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        [self.tableView setEditing:YES animated:YES];
        mComfirView.mSelectedImg.image = [UIImage imageNamed:@"ppt_add_address_selected"];
        [sender setTitle:@"取消" forState:0];
        
        for (int i = 0; i < self.dataArray.count; i ++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
            [self.deleteArr addObjectsFromArray:self.dataArray];
        }
    }else{
        [self.tableView setEditing:NO animated:YES];
        mComfirView.mSelectedImg.image = [UIImage imageNamed:@"ppt_add_address_normal"];
        [sender setTitle:@"全选" forState:0];

        for (int i = 0; i < self.dataArray.count; i ++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            [self.deleteArr removeObjectsInArray:self.dataArray];
        }
    }
    
    
    MLLog(@"self.deleteArr:%@", self.deleteArr);


}
#pragma mark -- tableviewDelegate
//是否可以编辑  默认的时YES
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//选择编辑的方式,按照选择的方式对表进行处理
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
    
}

//选择你要对表进行处理的方式  默认是删除方式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  UITableViewCellEditingStyleDelete ;
}
//选中时将选中行的在self.dataArray 中的数据添加到删除数组self.deleteArr中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tableView.editing) {
        [self.deleteArr addObject:[self.dataArray objectAtIndex:indexPath.row]];
    }else{
        NSLog(@"sssss");
    }
    
}
//取消选中时 将存放在self.deleteArr中的数据移除
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    [self.deleteArr removeObject:[self.dataArray objectAtIndex:indexPath.row]];
}
//修改删除按钮的文字
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

#pragma mark tableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 190;
  
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellId = nil;
    
    cellId = @"cell";
    
    shopCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.mGoodsName.text =  [self.dataArray objectAtIndex:indexPath.row];
    return cell;
    
    
    
}


@end
