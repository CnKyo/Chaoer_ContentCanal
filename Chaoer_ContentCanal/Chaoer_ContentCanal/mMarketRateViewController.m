//
//  mMarketRateViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/7/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mMarketRateViewController.h"
#import "StarsView.h"
#import "mMarkeyRateCell.h"
@interface mMarketRateViewController ()<StartWithRateIndexDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation mMarketRateViewController
{

    /**
     *  子view
     */
    StarsView *mTotalView;
    StarsView *mSenderView;
    StarsView *mProductView;
    NSString *mTotal;
    
    NSString *mSend;
    NSString *mPro;
    
    
    NSInteger mOne;
    NSInteger mTwo;
    NSInteger mThree;
    
}
- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.mPageName = self.Title = @"评价";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    
    mTotal = nil;
    
    mSend = nil;
    mPro = nil;
    
    mOne = mTwo = mThree = 1;
    
    [self initView];
}

- (void)initView{


    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-124) delegate:self dataSource:self];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    UINib   *nib = [UINib nibWithNibName:@"mMarkeyRateCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    
    UIButton *mBtn = [UIButton new];
    mBtn.frame = CGRectMake(10, DEVICE_Height-55, DEVICE_Width-20, 40);
    mBtn.backgroundColor = M_CO;
    [mBtn setTitle:@"提交评价" forState:0];
    mBtn.layer.masksToBounds = YES;
    mBtn.layer.cornerRadius = 3;
    [mBtn addTarget:self action:@selector(mBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mBtn];
    
    
    
    
}
- (void)mBtnAction:(UIButton *)sender{
    MLLog(@"提交");
}
- (void)StartWithRateIndex:(NSInteger)mIndex andStarsViewTag:(NSInteger)mTag{
    mIndex = mIndex+1;
    MLLog(@"多少分:%ld选择了第几个：%ld",mIndex,(long)mTag);
    

    if (mTag == 1) {
        mOne = mIndex;
        if (mIndex == 1) {
            mTotal = @"不满意";
        }else if (mIndex == 2){
            mTotal = @"一般";
        }else if(mIndex == 3){
            mTotal = @"还行";
        }else if (mIndex == 4){
            mTotal = @"满意";
        }else{
            mTotal = @"非常满意";

        }

    }else if (mTag == 2){
        mTwo = mIndex;
        if (mIndex == 1) {
            mSend = @"不满意";
        }else if (mIndex == 2){
            mSend = @"一般";
        }else if(mIndex == 3){
            mSend = @"还行";
        }else if (mIndex == 4){
            mSend = @"满意";
        }else{
            mSend = @"非常满意";
            
        }

    }else{
        mThree = mIndex;
        if (mIndex == 1) {
            mPro = @"不满意";
        }else if (mIndex == 2){
            mPro = @"一般";
        }else if(mIndex == 3){
            mPro = @"还行";
        }else if (mIndex == 4){
            mPro = @"满意";
        }else{
            mPro = @"非常满意";
            
        }

    }
    [self.tableView reloadData];

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
    
   
    return 1;
   
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 568;
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    reuseCellId = @"cell";
    
    mMarkeyRateCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (UIView *vvv in cell.mTotalRateView.subviews) {
        [vvv removeFromSuperview];
    }
    for (UIView *vvv in cell.mSenderRate.subviews) {
        [vvv removeFromSuperview];
    }
    for (UIView *vvv in cell.mProductRateView.subviews) {
        [vvv removeFromSuperview];
    }
    
    mTotalView = [[StarsView alloc] initWithStarSize:CGSizeMake(20, 20) space:5 numberOfStar:5];
    mTotalView.score = mOne;
    
    mTotalView.delegate = self;
    mTotalView.mTag = 1;
    mTotalView.frame = CGRectMake(0, 0, cell.mTotalRateView.mwidth, cell.mTotalRateView.mheight);

    [cell.mTotalRateView addSubview:mTotalView];

    
    mSenderView = [[StarsView alloc] initWithStarSize:CGSizeMake(20, 20) space:5 numberOfStar:5];
    mSenderView.score = mTwo;
    mSenderView.delegate = self;
    mSenderView.mTag = 2;
    mSenderView.frame = CGRectMake(0, 0, cell.mSenderRate.mwidth, cell.mSenderRate.mheight);
    [cell.mSenderRate addSubview:mSenderView];
    
    
    mProductView = [[StarsView alloc] initWithStarSize:CGSizeMake(20, 20) space:5 numberOfStar:5];
    mProductView.score = mThree;
    mProductView.delegate = self;
    mProductView.mTag = 3;
    mProductView.frame = CGRectMake(0, 0, cell.mProductRateView.mwidth, cell.mProductRateView.mheight);
    [cell.mProductRateView addSubview:mProductView];
  

    cell.mTotalStatus.text = mTotal;
    cell.mSenderStatus.text = mSend;
    cell.mProductStatus.text = mPro;
    
    return cell;
    
    
    
}

@end
