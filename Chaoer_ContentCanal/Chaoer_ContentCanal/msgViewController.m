//
//  msgViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/6.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "msgViewController.h"

#import "msgTableViewCell.h"

#import "messageTableViewController.h"
@interface msgViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation msgViewController
{
    NSArray *mArr2;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"消息";
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    self.hiddenTabBar = YES;
    [self initView];
    [self loadData];
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
    
    UINib   *nib = [UINib nibWithNibName:@"msgTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
}
- (void)loadData{
    
    
    UIImage *img3 = [UIImage imageNamed:@"money_msg"];
    UIImage *img4 = [UIImage imageNamed:@"community_msg"];
    UIImage *img5 = [UIImage imageNamed:@"fix_msg"];
    UIImage *img6 = [UIImage imageNamed:@"system_msg"];
    
    
    NSMutableDictionary *dic3 = [NSMutableDictionary new];
    [dic3 setObject:@"缴费通知" forKey:@"name"];
    [dic3 setObject:img3 forKey:@"img"];
    [dic3 setObject:NumberWithInt(3) forKey:@"ppp"];
    [dic3 setObject:NumberWithInt(2) forKey:@"hidden"];
    
    
    NSMutableDictionary *dic4 = [NSMutableDictionary new];
    [dic4 setObject:@"社交信息" forKey:@"name"];
    [dic4 setObject:img4 forKey:@"img"];
    [dic4 setObject:NumberWithInt(4) forKey:@"ppp"];
    [dic4 setObject:NumberWithInt(2) forKey:@"hidden"];
    
    NSMutableDictionary *dic5 = [NSMutableDictionary new];
    [dic5 setObject:@"保修信息" forKey:@"name"];
    [dic5 setObject:img5 forKey:@"img"];
    [dic5 setObject:NumberWithInt(5) forKey:@"ppp"];
    [dic5 setObject:NumberWithInt(2) forKey:@"hidden"];
    

    NSMutableDictionary *dic6 = [NSMutableDictionary new];
    [dic6 setObject:@"系统信息" forKey:@"name"];
    [dic6 setObject:img6 forKey:@"img"];
    [dic6 setObject:NumberWithInt(6) forKey:@"ppp"];
    [dic6 setObject:NumberWithInt(2) forKey:@"hidden"];
    
    mArr2 = @[dic3,dic4,dic5,dic6];
    
    
    [self.tableView  reloadData];

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
    
    return mArr2.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *reuseCellId = @"cell";
    NSDictionary *dic = mArr2[indexPath.row];

    
    msgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.mImg.image = [dic objectForKey:@"img"];
    cell.mcontent.text = [dic objectForKey:@"name"];
    return cell;
    
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = mArr2[indexPath.row];
    int  i = [[dic objectForKey:@"ppp"] intValue];
    switch (i) {
        case 3:
        {
            messageTableViewController *mmm = [[messageTableViewController alloc] initWithNibName:@"messageTableViewController" bundle:nil];
            [self pushViewController:mmm];
        }
            break;
        case 4:
        {

            
        }
            break;
        case 5:
        {

        }
            break;
        case 6:
        {
            
        }
            break;

        default:
            break;
    }

    
}

@end
