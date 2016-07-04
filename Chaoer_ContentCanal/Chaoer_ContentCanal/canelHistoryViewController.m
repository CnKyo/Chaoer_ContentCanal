//
//  canelHistoryViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/26.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "canelHistoryViewController.h"
#import "canelHistoryCell.h"
@interface canelHistoryViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation canelHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.Title = self.mPageName = @"纪录查询";;
    self.hiddenTabBar = YES;
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;

    [self initView];
}

- (void)initView{

    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.93 green:0.94 blue:0.96 alpha:1.00];

    UINib   *nib = [UINib nibWithNibName:@"canelHistoryCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    self.haveHeader = YES;
    self.haveFooter = YES;

    
}

- (void)headerBeganRefresh{

    self.page = 1;
    
    [[mUserInfo backNowUser] getCanelHistory:self.page block:^(mBaseData *resb, NSArray *mArr) {
        [self headerEndRefresh];
//        [self removeEmptyView];
        [self.tempArray removeAllObjects];
        
        
        [self DissMissEmptyView];
        
        if (resb.mSucess) {
            [self dismiss];
            if (mArr.count <= 0) {
//                [self addEmptyView:nil];
                [self ShowEmptyViewWithTitle:@"暂无数据!" andImg:nil andIsHiddenBtn:NO andHaveTabBar:YES];
            }else{
                [self.tempArray addObjectsFromArray:mArr];
                [self.tableView reloadData];
            }
            
        }else{
        
            [self showErrorStatus:resb.mMessage];
            [self ShowEmptyViewWithTitle:@"暂无数据!" andImg:nil andIsHiddenBtn:NO andHaveTabBar:YES];
        }
        
    }];
    
}


- (void)footetBeganRefresh{
    self.page ++;
    
    [[mUserInfo backNowUser] getCanelHistory:self.page block:^(mBaseData *resb, NSArray *mArr) {
        [self footetEndRefresh];
        [self removeEmptyView];
        if (resb.mSucess) {
            [self dismiss];
            if (mArr.count <= 0) {
                [self addEmptyView:nil];
            }else{
                [self.tempArray addObjectsFromArray:mArr];
                [self.tableView reloadData];
            }
            
        }else{
            
            [self showErrorStatus:resb.mMessage];
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
    return 65;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    
    GCanal *mCanel = self.tempArray[indexPath.row];
    
    canelHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    cell.mStatus.text = mCanel.mStatustr;
    cell.mTime.text = mCanel.mDeadline;
    cell.mUnit.text = [NSString stringWithFormat:@"缴费单位:%@",mCanel.mPaymentUnit];
    
    NSDictionary *mStyle = @{@"font":[UIFont systemFontOfSize:14],@"color": [UIColor redColor]};
    cell.mMoney.attributedText = [[NSString stringWithFormat:@"<font>缴费金额:</font> <color>%.2f元</color>",mCanel.mPayableMoney] attributedStringWithStyleBook:mStyle];

    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   }

@end
