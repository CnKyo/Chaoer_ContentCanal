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
    /**
     *  小区id
     */
    int mCommunityId;
    /**
     *  新闻类型
     */
    int mType;
    /**
     *  分类数据
     */
    NSMutableArray *mClassArr;
    
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
    
    
    mClassArr = [NSMutableArray new];
    
    [self loadClass];
    [self initView];

}

- (void)loadClass{

    
    [SVProgressHUD showWithStatus:@"正在加载中..." maskType:SVProgressHUDMaskTypeClear];
    
    [[mUserInfo backNowUser] getCommunityClass:^(mBaseData *resb, NSArray *mArr) {
        [mClassArr removeAllObjects];
        
        if (resb.mSucess) {
            
            
            if (mArr.count <= 0) {
                [SVProgressHUD showErrorWithStatus:@"暂无数据!"];
                
                [self performSelector:@selector(leftBtnTouched:) withObject:nil afterDelay:1];
                return ;

            }else{
                
                [mClassArr addObjectsFromArray:mArr];
                
                GCommunityClass *GC = mArr[0];
                mType = GC.mId;
                [self loadCommunity];
            }
            
            

            
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"暂无数据!"];
            
            [self performSelector:@selector(leftBtnTouched:) withObject:nil afterDelay:1];
        }
    }];
}

- (void)loadCommunity{

    [[mUserInfo backNowUser] getArear:^(mBaseData *resb, NSArray *mArr) {
        [self.tempArray removeAllObjects];
        if (resb.mSucess) {
            
            [SVProgressHUD showSuccessWithStatus:resb.mMessage];
            
            if (mArr.count <= 0) {
                [SVProgressHUD showErrorWithStatus:@"暂无数据!"];

                [self performSelector:@selector(leftBtnTouched:) withObject:nil afterDelay:1];
                return ;
            }else{
            
                GArear *GA = mArr[0];
                mCommunityId = GA.mId;
                [self initHeaderView];
                
            }
            
            
            

        }else{
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
            [self performSelector:@selector(leftBtnTouched:) withObject:nil afterDelay:1];
            
        }
        
    }];

}


- (void)initHeaderView{

    NSMutableArray *mTTArr = [NSMutableArray new];
    
    for (GCommunityClass *GC in mClassArr) {
        [mTTArr addObject:GC.mName];
    }
    
    [mHeaderView removeFromSuperview];
    
    mHeaderView=[[LiuXSegmentView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 60) titles:mTTArr clickBlick:^void(NSInteger index) {
        MLLog(@"点击了-----%ld",index);
        
        GCommunityClass *GC = mClassArr[index-1];
        mType = GC.mId;
        [self headerBeganRefresh];
        
    }];
    [self.view addSubview:mHeaderView];
    [self headerBeganRefresh];

}

- (void)initView{

    [self loadTableView:CGRectMake(0,124, DEVICE_Width, DEVICE_Height-124) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.93 green:0.94 blue:0.96 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.haveHeader = YES;
    self.haveFooter = YES;

    UINib   *nib = [UINib nibWithNibName:@"communityStatusTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
}

- (void)headerBeganRefresh{

    self.page = 1;
    
    [[mUserInfo backNowUser] getCommunityStatus:mCommunityId andPage:self.page andType:mType block:^(mBaseData *resb, NSArray *mArr) {
        
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
    
    [[mUserInfo backNowUser] getCommunityStatus:mCommunityId andPage:self.page andType:mType block:^(mBaseData *resb, NSArray *mArr) {
        
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
