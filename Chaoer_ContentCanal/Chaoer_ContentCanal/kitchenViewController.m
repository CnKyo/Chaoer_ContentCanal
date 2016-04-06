//
//  kitchenViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/4/1.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "kitchenViewController.h"
#import "kitchenTableViewCell.h"
@interface kitchenViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation kitchenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Title = self.mPageName = @"厨房";
    self.hiddenBackBtn = YES;
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    self.navBar.hidden = YES;
    [self initView];

}
- (void)initView{

    [self loadTableView:CGRectMake(0, 0, DEVICE_Width, DEVICE_Height-50) delegate:self dataSource:self];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    UINib   *nib = [UINib nibWithNibName:@"kitchenTableViewCell" bundle:nil];
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
    
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *reuseCellId = @"cell";
    
    
    kitchenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
      return cell;
    
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


@end
