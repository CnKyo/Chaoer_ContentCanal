//
//  communityStatusViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/13.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "communityStatusViewController.h"
#import "communityStatusTableViewCell.h"
#import "LiuXSegmentView.h"

#import "mCommuniyMsg.h"
@interface communityStatusViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation communityStatusViewController
{
    LiuXSegmentView *mHeaderView;
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"社区新闻";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    
    
    
    [self initView];

}

- (void)initView{

    [self loadTableView:CGRectMake(0,64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.93 green:0.94 blue:0.96 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.haveHeader = YES;
    self.haveFooter = YES;

    UINib   *nib = [UINib nibWithNibName:@"communityStatusTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
}

- (void)headerBeganRefresh{

    self.page = 1;
    
    [[mUserInfo backNowUser] getCommunityStatus:[mUserInfo backNowUser].mCommunityId andPage:self.page andType:0 block:^(mBaseData *resb, NSArray *mArr) {
        
        [self headerEndRefresh];
        [self removeEmptyView];
        [self.tempArray removeAllObjects];
        if (resb.mSucess ) {
            if (mArr.count <= 0) {
                [self addEmptyView:nil];
            }else{
                [self.tempArray addObjectsFromArray:mArr];
            }
            
            [self.tableView reloadData];
          
            
        }else{
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
            [self addEmptyView:nil];
        }
        
    }];
    
    
}
- (void)footetBeganRefresh{
    self.page ++;
    
    [[mUserInfo backNowUser] getCommunityStatus:[mUserInfo backNowUser].mCommunityId andPage:self.page andType:0 block:^(mBaseData *resb, NSArray *mArr) {
        
        [self footetEndRefresh];
        [self removeEmptyView];
        if (resb.mSucess ) {
            
            [self.tempArray addObjectsFromArray:mArr];
            
        }else{
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
            [self addEmptyView:nil];
        }
        [self.tableView reloadData];

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
    return 75;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    communityStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    GCommunityNews *GC = self.tempArray[indexPath.row];
    
    cell.mContent.text = GC.mSubTitel;
    cell.mTime.text = GC.mDateTime;
    
    cell.mTitle.text = GC.mTitel;
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",[HTTPrequest currentResourceUrl],GC.mNewsImage];

    [cell.mImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"img_default"]];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GCommunityNews *GC = self.tempArray[indexPath.row];

    
    WebVC* vc = [[WebVC alloc]init];
    vc.mName = @"社区详情";
    vc.mUrl = [NSString stringWithFormat:@"%@/app/news/getNewSContent?id=%d",[HTTPrequest returnNowURL],GC.mId];
    [self pushViewController:vc];
    

    
}

- (void)leftBtnTouched:(id)sender{
    [self popViewController];

}

@end
