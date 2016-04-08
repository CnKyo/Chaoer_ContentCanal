//
//  messageTableViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/6.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "messageTableViewController.h"
#import "msgTableViewCell.h"
#import "msgDetailViewController.h"
@interface messageTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation messageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"消息";
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    self.hiddenTabBar = YES;
    [self initView];
}
- (void)initView{
    UIView *vvv= [UIView new];
    vvv.frame = CGRectMake(0, 64, DEVICE_Width, 10);
    vvv.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.95 alpha:1.00];
    vvv.layer.masksToBounds = YES;
    vvv.layer.borderWidth = 1;
    vvv.layer.borderColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:0.75].CGColor;
    [self.view addSubview:vvv];
    [self loadTableView:CGRectMake(0, 74, DEVICE_Width, DEVICE_Height-74) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.95 alpha:1.00];
    //    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    UINib   *nib = [UINib nibWithNibName:@"messageCell" bundle:nil];
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
    
    return 25;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *reuseCellId = @"cell";
    
    
    msgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    return cell;
    
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    msgDetailViewController *mmm = [[msgDetailViewController alloc] initWithNibName:@"msgDetailViewController" bundle:nil];
    [self pushViewController:mmm];
       
}


@end
