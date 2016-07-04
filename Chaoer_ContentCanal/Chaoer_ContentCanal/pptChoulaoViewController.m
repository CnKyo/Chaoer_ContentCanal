//
//  pptChoulaoViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/13.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "pptChoulaoViewController.h"
#import "choulaoCell.h"
@interface pptChoulaoViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation pptChoulaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"累计酬劳";
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
    
    UINib   *nib = [UINib nibWithNibName:@"choulaoCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];


    
}


- (void)headerBeganRefresh{
    
    self.page = 1;
    
    [[GPPTer backPPTUser] getPPTTotleMoney:self.page andNum:10 block:^(mBaseData *resb, NSArray *mArr) {
        
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
    
    [[GPPTer backPPTUser] getPPTTotleMoney:self.page andNum:10 block:^(mBaseData *resb, NSArray *mArr) {
        
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
    
    return 65;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    GPPTReward *mReward = self.tempArray[indexPath.row];
    
    choulaoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    cell.mTime.text = mReward.mGenTime;
    cell.mTitle.text = mReward.mPileTitle;
    cell.mContent.text = [NSString stringWithFormat:@"酬金:%d元",mReward.mPileMoney];
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
