//
//  pptMyMsgViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "pptMyMsgViewController.h"
#import "pptMyMsgCell.h"

@interface pptMyMsgViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray *selectArray;
@property (nonatomic, strong)NSMutableArray *dataSourceArray;

@property (nonatomic, assign)BOOL isAll;
@end

@implementation pptMyMsgViewController
{

    int mSelected;
    
    UIButton *mDeleteBtn;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"我的消息";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    _isAll = NO;
    self.selectArray = [@[] mutableCopy];
    self.dataSourceArray = [@[] mutableCopy];

    for (int i = 0; i < 8; i++) {
        NSString *string = [NSString stringWithFormat:@"jack-%d", i];
        [_dataSourceArray addObject:string];
    }


    mSelected = 1;
    if (mSelected == 1) {
        self.rightBtnTitle = @"编辑";
    }else{
        
        self.rightBtnTitle = @"取消";
    }
        
    [self initView];
}
- (void)initView{
    
    
    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
    
    //    self.haveHeader = YES;
    //    [self.tableView headerBeginRefreshing];
    
    UINib   *nib = [UINib nibWithNibName:@"pptMyMsgCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    
    mDeleteBtn = [UIButton new];
    mDeleteBtn.frame = CGRectMake(0, DEVICE_Height, DEVICE_Width, 45);
    mDeleteBtn.backgroundColor = [UIColor colorWithRed:1.00 green:0.36 blue:0.36 alpha:1.00];
    [mDeleteBtn setTitle:@"删除" forState:0];
    [mDeleteBtn setTitleColor:[UIColor whiteColor] forState:0];
    [mDeleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mDeleteBtn];
    
}
- (void)deleteAction:(UIButton *)sender{
    
    if (_selectArray.count != 0) {
        for (int i = 0; i < _selectArray.count; i++) {
            [_dataSourceArray removeObjectsInArray:_selectArray];
            [self.tableView reloadData];
        }
        
        [_selectArray removeAllObjects];
    }
    
    [self.tableView setEditing:NO animated:YES];

    [self hiddendeleteBtn];


    
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
- (void)rightBtnTouched:(id)sender{
    
    UIButton *btn = sender;
    
    if (mSelected == 1) {
        [self showDeleteBtn];
        [btn setTitle:@"取消" forState:0];
        self.leftBtnTitle = @"全选";
        mSelected = 2;
        [self.tableView setEditing:YES animated:YES];
        
       

    }else{
        _isAll = NO;
        if (_selectArray.count != 0) {

            
            [_selectArray removeAllObjects];
        }

        
        [self hiddendeleteBtn];
        [btn setTitle:@"编辑" forState:0];
        self.leftBtnTitle = @"";

        [self.navBar.leftBtn setImage:[UIImage imageNamed:@"back_bgk"] forState:UIControlStateNormal];

        mSelected = 1;
        [self.tableView setEditing:NO animated:YES];

    }
    
    
}
- (void)leftBtnTouched:(id)sender{

    if (mSelected == 2) {
        _isAll = YES;
        [self.tableView setEditing:YES animated:YES];
        if (_isAll) {
            if (_selectArray.count != 0) {
                [_selectArray removeAllObjects];
                [_selectArray addObjectsFromArray:_dataSourceArray];
            }else{
                [_selectArray addObjectsFromArray:_dataSourceArray];
            }
        }

        for (int i = 0; i < _dataSourceArray.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
    }else{

        [self popViewController];
    }
}
- (void)showDeleteBtn{

    [UIView animateWithDuration:0.25 animations:^{
        CGRect DDD = mDeleteBtn.frame;
        DDD.origin.y = DEVICE_Height-45;
        mDeleteBtn.frame = DDD;
    }];
}
- (void)hiddendeleteBtn{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect DDD = mDeleteBtn.frame;
        DDD.origin.y = DEVICE_Height;
        mDeleteBtn.frame = DDD;
        
        self.navBar.rightBtn.titleLabel.text = @"编辑";
        self.leftBtnTitle = @"";
        
        [self.navBar.leftBtn setImage:[UIImage imageNamed:@"back_bgk"] forState:UIControlStateNormal];
        
        mSelected = 1;
    }];
}

#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataSourceArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    
    pptMyMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_isAll) {
        [self.selectArray addObject:_dataSourceArray[indexPath.row]];
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.selectArray removeObject:_dataSourceArray[indexPath.row]];
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tempArray removeObject:self.tempArray[indexPath.row]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }else if (editingStyle == UITableViewCellEditingStyleInsert){
        
    }
}

@end
