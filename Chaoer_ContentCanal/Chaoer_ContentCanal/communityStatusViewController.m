//
//  communityStatusViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/13.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "communityStatusViewController.h"
#import "communityStatusTableViewCell.h"
@interface communityStatusViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation communityStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"我的红包";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    
    [self initView];
}
- (void)initView{

    [self loadTableView:CGRectMake(0,64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.93 green:0.94 blue:0.96 alpha:1.00];
    
//    self.haveHeader = YES;
//    [self.tableView headerBeginRefreshing];
    
    UINib   *nib = [UINib nibWithNibName:@"communityStatusTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
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
    
    return 5;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    communityStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    
    return cell;
    
}


@end
