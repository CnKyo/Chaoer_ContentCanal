//
//  wpgViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "wpgViewController.h"

#import "wpgTableViewCell.h"

#import "canPayView.h"


#import "canalViewController.h"
@interface wpgViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation wpgViewController
{
    UITableView *mTableView;
    
    canPayView *mHeaderView;
}
- (void)viewDidLoad {

    [super viewDidLoad];

    
    self.Title = self.mPageName = @"缴费-水电气费";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.hiddenRightBtn = YES;
    self.rightBtnTitle = @"纪录查询";
    CGRect  mrr = self.navBar.rightBtn.frame;
    mrr.size.width = 100;
    mrr.origin.x = DEVICE_Width-80;
    self.navBar.rightBtn.frame = mrr;

    [self initView];
}

- (void)initView{

    UIImageView *mbgk = [UIImageView new];
    CGRect  mrr = self.view.bounds;
    mrr.origin.y = 64;
    mbgk.frame = mrr;
    mbgk.image = [UIImage imageNamed:@"mBaseBgkImg"];
    [self.view addSubview:mbgk];
    
    mHeaderView = [canPayView shareHeaderView];
    mHeaderView.frame = CGRectMake(0, 64, DEVICE_Width, 50);
    [mHeaderView.mChongzhi addTarget:self action:@selector(mTopupAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mHeaderView];

    mTableView = [UITableView new];
    mTableView.backgroundColor = [UIColor clearColor];
    mTableView.frame = CGRectMake(0, mHeaderView.mbottom+10, DEVICE_Width, DEVICE_Height);
    mTableView.delegate = self;
    mTableView.dataSource = self;
//    mTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:mTableView];

    
    UINib   *nib = [UINib nibWithNibName:@"wpgTableViewCell" bundle:nil];
    [mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    

    
    
}
/**
 *  充值
 *
 *  @param sender
 */
- (void)mTopupAction:(UIButton *)sender{
    NSLog(@"充值");
    mBalanceViewController *bbb = [[mBalanceViewController alloc] initWithNibName:@"mBalanceViewController" bundle:nil];
    [self pushViewController:bbb];
}
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
    return 61;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    wpgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *mTT = nil;
    
    if (indexPath.row == 0) {
        mTT = @"缴费-电费";
    }if (indexPath.row == 1) {
        mTT = @"缴费-水费";
    }if(indexPath.row == 2){
        mTT = @"缴费-燃气费";
    }
    canalViewController *ccc= [canalViewController new];
    
    ccc.mTitel= mTT;
    [self pushViewController:ccc];
    
    
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

@end