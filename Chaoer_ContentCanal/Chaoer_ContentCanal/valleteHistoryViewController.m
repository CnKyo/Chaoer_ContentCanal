//
//  valleteHistoryViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/6.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "valleteHistoryViewController.h"

#import "valletTCell.h"

@interface valleteHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation valleteHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *str = nil;
    
    if (self.mType == 2) {
        str = @"积分纪录";
    }else{
        str = @"交易纪录";
    }
    
    self.page = 1;
    
    self.Title = self.mPageName = str;
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    self.hiddenTabBar = YES;
    [self initView];
}


- (void)initView{

    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
//    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.haveHeader = YES;
    self.haveFooter = YES;
    
    
    UINib   *nib = [UINib nibWithNibName:@"valletTCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    
}

- (void)headerBeganRefresh{

    self.page = 1;

    [[mUserInfo backNowUser] getScoreList:self.mType andPage:self.page andNum:10 block:^(mBaseData *resb, NSArray *mArr) {
        
        [self.tempArray removeAllObjects];
        [self headerEndRefresh];
        
        [self DissMissEmptyView];
        
        if (resb.mSucess) {
            [SVProgressHUD dismiss];
            if (mArr.count <= 0) {
                [self ShowEmptyViewWithTitle:@"暂时没有数据!" andImg:nil andIsHiddenBtn:NO andHaveTabBar:NO];
                return ;
            }
            
            [self.tempArray addObjectsFromArray:mArr];
            [self.tableView reloadData];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
            [self ShowEmptyViewWithTitle:nil andImg:nil andIsHiddenBtn:NO andHaveTabBar:NO];
            
        }

        
    }];
    
}


- (void)footetBeganRefresh{


    self.page ++;
    
    [[mUserInfo backNowUser] getScoreList:self.mType andPage:self.page andNum:10 block:^(mBaseData *resb, NSArray *mArr) {
        
        [self footetEndRefresh];
        
        [self removeEmptyView];
        if (resb.mSucess) {
            [SVProgressHUD dismiss];
            
            if (mArr.count <= 0) {
                [self addEmptyViewWithImg:nil];
                return ;
            }
            
            [self.tempArray addObjectsFromArray:mArr];
            [self.tableView reloadData];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
            [self addEmptyViewWithImg:nil];
            
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
    
    return 50;
    
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    
    GScroe *mScore = self.tempArray[indexPath.row];
    
    valletTCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    if (self.mType == 1) {
        cell.mImf.image = [UIImage imageNamed:@"score_cell"];
    }else{
        cell.mImf.image = [UIImage imageNamed:@"topup_cell"];
    }
    
    cell.mTime.text = mScore.mAddTime;
    
    int mType = mScore.mType;
    
    if (mType == 2) {
        cell.mStatus.text = @"充值";
        cell.mScore.text = [NSString stringWithFormat:@"%d积分",mScore.mScore];

    }else{
        cell.mStatus.text = @"支付";
        cell.mScore.text = [NSString stringWithFormat:@"%d积分",mScore.mScore];

    }
    cell.mtitle.text = mScore.mDescribe;
    
    
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];


    
}

@end
