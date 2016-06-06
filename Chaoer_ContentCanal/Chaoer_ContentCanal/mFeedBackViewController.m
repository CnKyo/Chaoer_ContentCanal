//
//  mFeedBackViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mFeedBackViewController.h"
#import "mFeedBackCell.h"
#import "mFeedManageViewController.h"
#import "mFeedCompanyViewController.h"

#import "mFeedPersonViewController.h"

#import "feedbackViewController.h"
#import "needCodeViewController.h"
#import "verifyBankViewController.h"
@interface mFeedBackViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation mFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.Title = self.mPageName = @"投诉建议";
    
    [self initView];
}

- (void)initView{

    NSArray *mTT = @[@"投诉居民",@"投诉物管",@"对公司的建议"];
    
    [self.tempArray addObjectsFromArray:mTT];
    
    
    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.93 green:0.94 blue:0.96 alpha:1.00];
//    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    UINib   *nib = [UINib nibWithNibName:@"mFeedBackCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
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
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if( buttonIndex == 1)
    {
       
        needCodeViewController *nnn = [[needCodeViewController alloc] initWithNibName:@"needCodeViewController" bundle:nil];
        nnn.Type = 1;
        
        [self pushViewController:nnn];
        
        
        
    }
}

- (void)AlertViewShow:(NSString *)alerViewTitle alertViewMsg:(NSString *)msg alertViewCancelBtnTiele:(NSString *)cancelTitle alertTag:(int)tag{
    
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:alerViewTitle message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:@"去认证", nil];
    al.delegate = self;
    al.tag = tag;
    [al show];
}




#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.tempArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    mFeedBackCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    cell.mTTT.text = self.tempArray[indexPath.row];
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.row == 0) {
        if (![mUserInfo backNowUser].mIsHousingAuthentication) {
            [self AlertViewShow:@"未实名认证！" alertViewMsg:@"通过认证即可使用更多功能？" alertViewCancelBtnTiele:@"取消" alertTag:10];
            return;
        }
        
        
        mFeedPersonViewController *mmm = [[mFeedPersonViewController alloc] initWithNibName:@"mFeedPersonViewController" bundle:nil];
        [self pushViewController:mmm];
    }else if (indexPath.row == 1){
        if (![mUserInfo backNowUser].mIsHousingAuthentication) {
            [self AlertViewShow:@"未实名认证！" alertViewMsg:@"通过认证即可使用更多功能？" alertViewCancelBtnTiele:@"取消" alertTag:10];
            return;
        }
        mFeedManageViewController *mmm = [[mFeedManageViewController alloc] initWithNibName:@"mFeedManageViewController" bundle:nil];
        [self pushViewController:mmm];
        
    }else if (indexPath.row == 2){
        UIStoryboard *secondStroyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        feedbackViewController *f =[secondStroyBoard instantiateViewControllerWithIdentifier:@"xxx"];
        [self.navigationController pushViewController:f animated:YES];
        
    }
    
    
    
    
}


@end
