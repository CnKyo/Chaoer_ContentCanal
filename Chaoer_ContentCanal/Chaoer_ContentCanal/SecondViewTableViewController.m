//
//  SecondViewTableViewController.m
//  HeaderViewAndPageView
//
//  Created by su on 16/8/8.
//  Copyright © 2016年 susu. All rights reserved.
//

#import "SecondViewTableViewController.h"
#import "mFoodRateHeaderView.h"
#import "mFoodRateTableViewCell.h"
@interface SecondViewTableViewController ()<UITableViewDataSource,UITableViewDelegate,WKSegmentControlDelagate>

@property(nonatomic ,strong)UITableView * myTableView;

@end

@implementation SecondViewTableViewController
{

    /**
     *  评价切换按钮
     */
    WKSegmentControl *mRateSegmentView;
    
    /**
     *  评价headerview
     */
    mFoodRateHeaderView *mRateTableHeaderView;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, DEVICE_Height-114)];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_myTableView];
    
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib   *nib = [UINib nibWithNibName:@"mFoodRateTableViewCell" bundle:nil];
    [_myTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
 
    
    mRateTableHeaderView = [mFoodRateHeaderView shareView];
    mRateTableHeaderView.frame = CGRectMake(0, 0, DEVICE_Width, 100);
    _myTableView.tableHeaderView = mRateTableHeaderView;
    
    NSArray *mTT = @[@"全部",@"好评",@"中评",@"差评"];

    
    mRateSegmentView = [WKSegmentControl initWithSegmentControlFrame:CGRectMake(0, 165, DEVICE_Width, 40) andTitleWithBtn:mTT andBackgroudColor:[UIColor whiteColor] andBtnSelectedColor:[UIColor colorWithRed:0.91 green:0.53 blue:0.16 alpha:1.00] andBtnTitleColor:M_TextColor1 andUndeLineColor:[UIColor colorWithRed:0.91 green:0.53 blue:0.16 alpha:1.00] andBtnTitleFont:[UIFont systemFontOfSize:15] andInterval:20 delegate:self andIsHiddenLine:YES andType:2];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return mRateSegmentView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"cell";
    mFoodRateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    return cell;
}
- (void)WKDidSelectedIndex:(NSInteger)mIndex{

    MLLog(@"%ld",(long)mIndex);
}
@end
