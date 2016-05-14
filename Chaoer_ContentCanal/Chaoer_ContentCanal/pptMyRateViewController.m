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
@interface pptMyRateViewController ()<UITableViewDelegate,UITableViewDataSource>

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
    
    UIButton *mSelectBtn;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"我的地址";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.hiddenRightBtn = YES;
    
    [self initHeaderView];

    [self initView];
}
- (void)initView{
    
    
    [self loadTableView:CGRectMake(0, 244, DEVICE_Width, DEVICE_Height-244) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    //    self.haveHeader = YES;
    //    [self.tableView headerBeginRefreshing];
    
    UINib   *nib = [UINib nibWithNibName:@"pptMyRateCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
}
- (void)initHeaderView{

    mHeaderView = [pptMyRateHeaderView shareView];
//    mHeaderView.frame = CGRectMake(0, 64, DEVICE_Width, 180);
    
    mGoodProgress = [[CustomProgress alloc] initWithFrame:CGRectMake(0, 0, mHeaderView.mGoodRateView.mwidth+50, 15)];
    mGoodProgress.maxValue = 100;
    //设置背景色
    mGoodProgress.bgimg.backgroundColor =[UIColor colorWithRed:188/255.0 green:188/255.0 blue:188/255.0 alpha:1];
    mGoodProgress.leftimg.backgroundColor =[UIColor colorWithRed:0.93 green:0.22 blue:0.21 alpha:1.00];
    
    mGoodProgress.presentlab.textColor = [UIColor redColor];
    [mHeaderView.mGoodRateView addSubview:mGoodProgress];

    mMidProgress = [[CustomProgress alloc] initWithFrame:CGRectMake(0, 0, mHeaderView.mMidRateView.mwidth+50, 15)];
    mMidProgress.maxValue = 100;
    //设置背景色
    mMidProgress.bgimg.backgroundColor =[UIColor colorWithRed:188/255.0 green:188/255.0 blue:188/255.0 alpha:1];
    mMidProgress.leftimg.backgroundColor =[UIColor colorWithRed:1.00 green:0.56 blue:0.56 alpha:1.00];
    
    mMidProgress.presentlab.textColor = [UIColor redColor];
    [mHeaderView.mMidRateView addSubview:mMidProgress];
    
    mBadProgress = [[CustomProgress alloc] initWithFrame:CGRectMake(0, 0, mHeaderView.mBadRateView.mwidth+50, 15)];
    mBadProgress.maxValue = 100;
    //设置背景色
    mBadProgress.bgimg.backgroundColor =[UIColor colorWithRed:188/255.0 green:188/255.0 blue:188/255.0 alpha:1];
    mBadProgress.leftimg.backgroundColor =[UIColor colorWithRed:0.34 green:0.34 blue:0.34 alpha:1.00];
    
    mBadProgress.presentlab.textColor = [UIColor redColor];
    [mHeaderView.mBadRateView addSubview:mBadProgress];
    
    
    [self.view addSubview:mHeaderView];
    
    [mHeaderView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(@0);
        make.top.equalTo(self.view).offset(@64);
        make.height.offset(@180);
    }];
    
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
    
    CGFloat btnW = DEVICE_Width/4-10;
    
    for (UIButton *bbb in mHeaderView.mSectionBtnView.subviews) {
        [bbb removeFromSuperview];
    }
    
    for (int i = 0; i<mTT.count; i++) {
        
        UIButton *btn = [UIButton new];
        btn.frame = CGRectMake(20+btnW*i, 10, btnW, 30);
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:mTT[i] forState:0];
        [btn setBackgroundImage:[UIImage imageNamed:@"ppt_my_rate_normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"ppt_my_rate_selected"] forState:UIControlStateSelected];
        
        [btn setTitleColor:M_CO forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.00] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(mSectionAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            btn.selected = YES;
        }
        
        [mHeaderView.mSectionBtnView addSubview:btn];
        
    }
    
    
    
}
- (void)mSectionAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    switch (sender.tag) {
        case 0:
        {
        
            if (sender.selected == NO) {
                
                mSelectBtn = sender;
            }else{
                mSelectBtn = nil;
            }
            
        }
            break;
        case 1:
        {
            if (sender.selected == NO) {
                
                mSelectBtn = sender;
            }else{
                mSelectBtn = nil;
            }
        }
            break;
        case 2:
        {
            if (sender.selected == NO) {
                
                mSelectBtn = sender;
            }else{
                mSelectBtn = nil;
            }
        }
            break;
        case 3:
        {
            if (sender.selected == NO) {
                
                mSelectBtn = sender;
            }else{
                mSelectBtn = nil;
            }
        }
            break;
        default:
            break;
    }
}

-(void)goodtimer
{
    mGood++;
    if (mGood<=64) {
        
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
    if (mMid<=44) {
        
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
    if (mBad<=25) {
        
        [mBadProgress setPresent:mBad];
        
    }
    else
    {
        
        [mBadTimer invalidate];
        mBadTimer = nil;
        mBad = 0;
    }
    
    
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
    
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    
    pptMyRateCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
