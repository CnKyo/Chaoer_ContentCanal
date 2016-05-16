//
//  pptMyViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/13.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "pptMyViewController.h"

#import "BlockButton.h"

#import "pptMyHeaderView.h"

#import "pptMyCell.h"

#import "pptChoulaoViewController.h"
#import "pptMyInfoViewController.h"
#import "pptMyAddressViewController.h"
#import "pptMyRateViewController.h"
#import "pptMyMsgViewController.h"
@interface pptMyViewController ()<UITableViewDelegate,UITableViewDataSource
>

@end

@implementation pptMyViewController
{


    pptMyHeaderView *mHeaderView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.Title = self.mPageName = @"我的";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.hiddenRightBtn = YES;
    
    NSArray *mArrar = @[@"基本信息",@"酬金记录",@"我的地址",@"常见问题"];
    NSArray *mImgar = @[[UIImage imageNamed:@"ppt_my_info"],[UIImage imageNamed:@"ppt_my_choujin"],[UIImage imageNamed:@"ppt_my_address"],[UIImage imageNamed:@"ppt_my_faq"]];
    
    [self.tempArray addObject:mArrar];
    [self.tempArray addObject:mImgar];
    
    
    
    [self initView];


}
- (void)initView{
    
    
    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //    self.haveHeader = YES;
    //    [self.tableView headerBeginRefreshing];
    
    UINib   *nib = [UINib nibWithNibName:@"pptMyCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    mHeaderView = [pptMyHeaderView shareViuew];
    mHeaderView.frame = CGRectMake(0, 0, DEVICE_Width, 260);
    
    [mHeaderView.mMyTagBtn addTarget:self action:@selector(tagAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [mHeaderView.mMyMsgBtn addTarget:self action:@selector(msgAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [mHeaderView.mMyRateBtn addTarget:self action:@selector(rateAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *mBottomView = [UIView new];
    mBottomView.frame = CGRectMake(0, DEVICE_Height-60, DEVICE_Width, 60);
    mBottomView.backgroundColor = [UIColor whiteColor];
    
    mBottomView.layer.masksToBounds = YES;
    mBottomView.layer.borderColor = [UIColor colorWithRed:0.82 green:0.82 blue:0.82 alpha:1.00].CGColor;
    mBottomView.layer.borderWidth = 0.5;
    
   
    BlockButton *mBtn = [BlockButton new];
    mBtn.frame = CGRectMake(0, 10, DEVICE_Width, 40);
    mBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    mBtn.backgroundColor = [UIColor clearColor];
    [mBtn setTitle:@"客服电话 023-89787878" forState:0];
    [mBtn setTitleColor:M_CO forState:0];
    [mBtn btnClick:^{
        
        NSLog(@"打电话");
        
    }];
    [mBottomView addSubview:mBtn];
    [self.tableView setTableHeaderView:mHeaderView];
    [self.tableView setTableFooterView:mBottomView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark----标签
- (void)tagAction:(UIButton *)sender{

}
#pragma mark----消息
- (void)msgAction:(UIButton *)sender{
    pptMyMsgViewController *ppp = [[pptMyMsgViewController alloc] initWithNibName:@"pptMyMsgViewController" bundle:nil];
    [self pushViewController:ppp];
}
#pragma mark----评价
- (void)rateAction:(UIButton *)sender{
    pptMyRateViewController *ppp = [[pptMyRateViewController alloc] initWithNibName:@"pptMyRateViewController" bundle:nil];
    [self pushViewController:ppp];
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
    
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    
    pptMyCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    cell.mTitle.text = self.tempArray[0][indexPath.row];
    cell.mImg.image = self.tempArray[1][indexPath.row];
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        pptMyInfoViewController *ppt = [[pptMyInfoViewController alloc] initWithNibName:@"pptMyInfoViewController" bundle:nil];
        [self pushViewController:ppt];
    }else if (indexPath.row == 1){
    
        pptChoulaoViewController *ppt = [[pptChoulaoViewController alloc] initWithNibName:@"pptChoulaoViewController" bundle:nil];
        [self pushViewController:ppt];
    }else if (indexPath.row == 2){
    
        pptMyAddressViewController *ppt = [[pptMyAddressViewController alloc] initWithNibName:@"pptMyAddressViewController" bundle:nil];
        ppt.mType = 2;
        [self pushViewController:ppt];
    }else{
    
    }
    
    
    
}

@end
