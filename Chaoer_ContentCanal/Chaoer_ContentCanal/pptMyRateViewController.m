//
//  pptMyRateViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "pptMyRateViewController.h"
#import "pptMyRateCell.h"

#import "pptMyRateHeaderView.h"
@interface pptMyRateViewController ()<UITableViewDelegate,UITableViewDataSource,WKSegmentControlDelagate>

@end

@implementation pptMyRateViewController
{

    pptMyRateHeaderView *mHeaderView;
    
    
    NSTimer *mGoodTimer;
    NSTimer *mMidTimer;
    NSTimer *mBadTimer;
    
    CustomProgress *mGoodProgress;
    
    CustomProgress *mMidProgress;
    
    CustomProgress *mBadProgress;
    
    int mGood;
    
    int mMid;
    
    int mBad;
    
    WKSegmentControl    *mSegmentView;
    
    int mType;


}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self headerBeganRefresh];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"我的评价";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.hiddenRightBtn = YES;
    
    mType = 0;
    
    [self initView];
}
- (void)initView{
    
    
    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.haveFooter = YES;
    self.haveHeader = YES;
    
    UINib   *nib = [UINib nibWithNibName:@"pptMyRateCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self initHeaderView];

}
- (void)initHeaderView{

    mHeaderView = [pptMyRateHeaderView shareView];
    mHeaderView.frame = CGRectMake(0, 0, DEVICE_Width, 130);
    
    
    mHeaderView.mRatePoint.text = [NSString stringWithFormat:@"%d",[GPPTer backPPTUser].mTotleRateCount];
    mGoodProgress = [[CustomProgress alloc] initWithFrame:CGRectMake(0, 2, mHeaderView.mGoodRateView.mwidth+50, 10) andType:2];

    mGoodProgress.mType = 2;
    mGoodProgress.maxValue = [GPPTer backPPTUser].mGoodRateCount*10;
    //设置背景色
    mGoodProgress.bgimg.backgroundColor =[UIColor colorWithRed:188/255.0 green:188/255.0 blue:188/255.0 alpha:1];
    mGoodProgress.leftimg.backgroundColor =[UIColor colorWithRed:0.93 green:0.22 blue:0.21 alpha:1.00];
    
    mGoodProgress.presentlab.textColor = [UIColor redColor];
    [mHeaderView.mGoodRateView addSubview:mGoodProgress];

    mMidProgress = [[CustomProgress alloc] initWithFrame:CGRectMake(0, 2, mHeaderView.mMidRateView.mwidth+50, 10) andType:2];

    mMidProgress.mType = 2;

    mMidProgress.maxValue = [GPPTer backPPTUser].mMidRateCount*10;
    //设置背景色
    mMidProgress.bgimg.backgroundColor =[UIColor colorWithRed:188/255.0 green:188/255.0 blue:188/255.0 alpha:1];
    mMidProgress.leftimg.backgroundColor =[UIColor colorWithRed:1.00 green:0.56 blue:0.56 alpha:1.00];
    
    mMidProgress.presentlab.textColor = [UIColor redColor];
    [mHeaderView.mMidRateView addSubview:mMidProgress];
    
    mBadProgress = [[CustomProgress alloc] initWithFrame:CGRectMake(0, 2, mHeaderView.mBadRateView.mwidth+50, 10) andType:2];

    mBadProgress.mType = 2;

    
    mBadProgress.maxValue = [GPPTer backPPTUser].mBadRatecount*10;
    //设置背景色
    mBadProgress.bgimg.backgroundColor =[UIColor colorWithRed:188/255.0 green:188/255.0 blue:188/255.0 alpha:1];
    mBadProgress.leftimg.backgroundColor =[UIColor colorWithRed:0.34 green:0.34 blue:0.34 alpha:1.00];
    
    mBadProgress.presentlab.textColor = [UIColor redColor];
    [mHeaderView.mBadRateView addSubview:mBadProgress];
    
    [self.tableView setTableHeaderView:mHeaderView];
//    [self.view addSubview:mHeaderView];
//    
//    [mHeaderView makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view).offset(@0);
//        make.top.equalTo(self.view).offset(@64);
//        make.height.offset(@180);
//    }];
    
    mGoodTimer =[NSTimer scheduledTimerWithTimeInterval:0.02
                                            target:self
                                          selector:@selector(goodtimer)
                                          userInfo:nil
                                           repeats:YES];
    mMidTimer =[NSTimer scheduledTimerWithTimeInterval:0.02
                                             target:self
                                           selector:@selector(midtimer)
                                           userInfo:nil
                                            repeats:YES];
    mBadTimer =[NSTimer scheduledTimerWithTimeInterval:0.02
                                             target:self
                                           selector:@selector(badtimer)
                                           userInfo:nil
                                            repeats:YES];

    
    
    NSArray *mTT = @[@"全部",@"好评",@"中评",@"差评"];
    
    mSegmentView = [WKSegmentControl initWithSegmentControlFrame:CGRectMake(0, 165, DEVICE_Width, 40) andTitleWithBtn:mTT andBackgroudColor:[UIColor whiteColor] andBtnSelectedColor:M_CO andBtnTitleColor:M_TextColor1 andUndeLineColor:M_CO andBtnTitleFont:[UIFont systemFontOfSize:15] andInterval:20 delegate:self andIsHiddenLine:YES andType:2];
    
    
}

-(void)goodtimer
{
    mGood++;
    if (mGood<=[GPPTer backPPTUser].mGoodRateCount) {
        
        [mGoodProgress setPresent:mGood];
        
    }
    else
    {
        
        [mGoodTimer invalidate];
        mGoodTimer = nil;
        mGood = 0;
    }
    
    
}
-(void)midtimer
{
    mMid++;
    if (mMid<=[GPPTer backPPTUser].mMidRateCount) {
        
        [mMidProgress setPresent:mMid];
        
    }
    else
    {
        
        [mMidTimer invalidate];
        mMidTimer = nil;
        mMid = 0;
    }
    
    
}
-(void)badtimer
{
    mBad++;
    if (mBad<=[GPPTer backPPTUser].mBadRatecount) {
        
        [mBadProgress setPresent:mBad];
        
    }
    else
    {
        
        [mBadTimer invalidate];
        mBadTimer = nil;
        mBad = 0;
    }
    
    
}


- (void)headerBeganRefresh{
    
    self.page = 1;
    
    [[GPPTer backPPTUser] getPPTRateList:mType andPage:self.page andNum:10 block:^(mBaseData *resb, NSArray *mArr) {
        
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
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
  
    return mSegmentView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}
- (void)WKDidSelectedIndex:(NSInteger)mIndex{
    MLLog(@"点击了%lu",(unsigned long)mIndex);
    mType = [[NSString stringWithFormat:@"%ld",(long)mIndex] intValue];
    [self headerBeganRefresh];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    GPPTRateList *mRate = self.tempArray[indexPath.row];
    
    pptMyRateCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.mName.text = mRate.mNickName;
    cell.mContent.text = mRate.mContent;
    cell.mTime.text = mRate.mGenTime;
    cell.mPoint.text = [NSString stringWithFormat:@"%d分",mRate.mService_efficiency];
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
