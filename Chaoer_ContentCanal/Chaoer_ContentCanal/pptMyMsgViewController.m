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
    
    NSMutableArray *mDeleteArr;
    
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
    mDeleteArr = [NSMutableArray new];
//    for (int i = 0; i < 8; i++) {
//        NSString *string = [NSString stringWithFormat:@"jack-%d", i];
//        [_dataSourceArray addObject:string];
//    }


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
    self.haveFooter = YES;
    self.haveHeader = YES;
    
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
- (void)headerBeganRefresh{

    self.page = 1;
    
    [[GPPTer backPPTUser] getPPTMsgList:self.page andNum:10 block:^(mBaseData *resb, NSArray *mArr) {
        [self headerEndRefresh];
        [_dataSourceArray removeAllObjects];
        [self removeEmptyView];
        
        if (resb.mSucess) {
            
            if (mArr.count <= 0) {
                [self addEmptyView:nil];
            }else{
                [_dataSourceArray addObjectsFromArray:mArr];
            }
            
            
            
        }else{
            [self showErrorStatus:resb.mMessage];
            [self addEmptyView:nil];
            
        }
        [self.tableView reloadData];

    }];
    
}

- (void)footetBeganRefresh{
    self.page ++;
    
    [[GPPTer backPPTUser] getPPTMsgList:self.page andNum:10 block:^(mBaseData *resb, NSArray *mArr) {
        [self headerEndRefresh];
        [self removeEmptyView];
        
        if (resb.mSucess) {
            
            if (mArr.count <= 0) {
                [self addEmptyView:nil];
            }else{
                [_dataSourceArray addObjectsFromArray:mArr];
                [self.tableView reloadData];
            }
            
            
            
        }else{
            [self showErrorStatus:resb.mMessage];
            [self addEmptyView:nil];
            
        }
        
    }];
}

- (void)deleteAction:(UIButton *)sender{
    [mDeleteArr removeAllObjects];
    if (_selectArray.count != 0) {
        
        for (GPPTMsgInfo *mMessage in _selectArray) {
            [mDeleteArr addObject:[NSString stringWithFormat:@"%d",mMessage.mId]];
        }
        
        
        NSString *message = @"";
        for (int i =0;i<mDeleteArr.count;i++) {
            
            NSString *str = mDeleteArr[i];
            if (i == mDeleteArr.count-1) {
                message = [message stringByAppendingString:[NSString stringWithFormat:@"%@",str]];
            }else{
                message = [message stringByAppendingString:[NSString stringWithFormat:@"%@,",str]];
            }
            
            
        }
        
        [self showWithStatus:@"正在操作..."];
        [[GPPTer backPPTUser] pptDeleteMessages:message block:^(mBaseData *resb) {
            if (resb.mSucess) {
                [self dismiss];
            }else{
                [self showErrorStatus:resb.mMessage
                 ];
            }
        }];
        
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
    
    GPPTMsgInfo *mMsg = self.dataSourceArray[indexPath.row];
    
    pptMyMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    cell.mTitle.text = mMsg.mTitle;
    cell.mcontent.text = mMsg.mContent;
    cell.mTime.text = mMsg.mGenTime;
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GPPTMsgInfo *mMsg = self.dataSourceArray[indexPath.row];

    if (!_isAll) {
        [self.selectArray addObject:_dataSourceArray[indexPath.row]];
         [mDeleteArr addObject:[NSString stringWithFormat:@"%d",mMsg.mId]];
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GPPTMsgInfo *mMsg = self.dataSourceArray[indexPath.row];

    [self.selectArray removeObject:_dataSourceArray[indexPath.row]];
    [mDeleteArr removeObject:[NSString stringWithFormat:@"%d",mMsg.mId]];

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
