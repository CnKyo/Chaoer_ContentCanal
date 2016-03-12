//
//  takeFixViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/12.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "takeFixViewController.h"
#import "mFixTableViewCell.h"
@interface takeFixViewController ()<UITableViewDelegate,UITableViewDataSource,WKSegmentControlDelagate>

@end

@implementation takeFixViewController
{
    UITableView *mTableView;
    
    WKSegmentControl    *mHeaderView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.hiddenTabBar = YES;
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.Title = self.mPageName = _mTitle;
    
//    self.view.backgroundColor = [UIColor whiteColor];
    [self initHeader];
    [self initView];
    // Do any additional setup after loading the view.
}
- (void)initView{

    
    mTableView = [UITableView new];
    mTableView.backgroundColor = [UIColor whiteColor];
    mTableView.frame = CGRectMake(0, 124, DEVICE_Width, DEVICE_Height);
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:mTableView];
    
    
    UINib   *nib = [UINib nibWithNibName:@"mFixTableViewCell" bundle:nil];
    [mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
}
- (void)initHeader{

    UIView *vvv = [UIView new];
    vvv.frame = CGRectMake(0, 64, DEVICE_Width, 10);
    vvv.backgroundColor = M_CO;
    [self.view addSubview:vvv];
    
    mHeaderView = [WKSegmentControl initWithSegmentControlFrame:CGRectMake(0, 74, DEVICE_Width, 50) andTitleWithBtn:@[@"预约报修",@"付款报修"] andBackgroudColor:[UIColor whiteColor] andBtnSelectedColor:M_CO andBtnTitleColor:M_CO andUndeLineColor:nil andBtnTitleFont:[UIFont fontWithName:@".Helvetica Neue Interface" size:16.0f] andInterval:0 delegate:self andIsHiddenLine:YES];
    [self.view addSubview:mHeaderView];
    
}
- (void)WKDidSelectedIndex:(NSInteger)mIndex{
    NSLog(@"第%d个",mIndex);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 5;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    mFixTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


@end
