//
//  pptChartsViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/12.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "pptChartsViewController.h"
#import "pptChartsTableViewCell.h"
@interface pptChartsViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation pptChartsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"跑腿榜";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.hiddenRightBtn = YES;
    [self initView];

}
- (void)initView{
    
    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.haveHeader = YES;
    self.haveFooter = YES;
    
    UINib   *nib = [UINib nibWithNibName:@"pptChartsTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    
    
}
- (void)headerBeganRefresh{

    self.page = 1;
    
    [[mUserInfo backNowUser] getPPTRoll:self.page andNum:10 block:^(mBaseData *resb, NSArray *mArr) {
        
        [self headerEndRefresh];
        [self removeEmptyView];
        [self.tempArray removeAllObjects];
        if (resb.mSucess) {
            
            if (mArr.count <= 0) {
                [self addEmptyView:nil];
            }else{
            
                [self.tempArray addObjectsFromArray:mArr];
            }
            [self.tableView reloadData];
        }else{
        
            [self showErrorStatus:resb.mMessage];
            [self addEmptyView:nil];
        }
        
    }];
    
    

}

- (void)footetBeganRefresh{
    self.page ++;
    
    [[mUserInfo backNowUser] getPPTRoll:self.page andNum:10 block:^(mBaseData *resb, NSArray *mArr) {
        
        [self footetEndRefresh];
        [self removeEmptyView];
        if (resb.mSucess) {
            
            if (mArr.count <= 0) {
                [self addEmptyView:nil];
            }else{
                
                [self.tempArray addObjectsFromArray:mArr];
            }
            [self.tableView reloadData];
        }else{
            
            [self showErrorStatus:resb.mMessage];
            [self addEmptyView:nil];
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
    
    return 90;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    GPPTRankList *mRank = self.tempArray[indexPath.row];
    
    pptChartsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    NSString *url = [NSString stringWithFormat:@"%@%@",[HTTPrequest currentResourceUrl],mRank.mHeaderImg];
    
    [cell.mHeader sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"icon_headerdefault"]];
    
    cell.mName.text = mRank.mName;
    cell.mLevel.text = [NSString stringWithFormat:@"V%d",mRank.mLevel];
    cell.mPhone.text = mRank.mTel;
    cell.mOrderNum.text = [NSString stringWithFormat:@"月接单:%d单",mRank.mOrderNum];
    
    cell.mTagArr = mRank.mTags;
    
    return cell;
    
}


@end
