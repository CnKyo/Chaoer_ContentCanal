//
//  choiseServicerViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/23.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "choiseServicerViewController.h"
#import "choiseServicerTableViewCell.h"
#import "DLStarRatingControl.h"
#import "TQStarRatingView.h"

#import "choiceServicerViewController.h"

#import "makeServiceViewController.h"
@interface choiseServicerViewController ()<UITableViewDelegate,UITableViewDataSource,StarRatingViewDelegate>

@end

@implementation choiseServicerViewController
{

    UITableView *mTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.Title = self.mPageName = @"确认订单";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    [self initview];
}

- (void)initview{
    
    UIImageView *iii = [UIImageView new];

    iii.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64);
    iii.image = [UIImage imageNamed:@"mBaseBgkImg"];
    [self.view addSubview:iii];
    
    [self loadTableView:CGRectMake(0, 79, DEVICE_Width, DEVICE_Height-79) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor clearColor];

    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.haveHeader = YES;
    [self headerBeganRefresh];
    
    
    UINib   *nib = [UINib nibWithNibName:@"choiseServicerTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    
}
- (void)headerBeganRefresh{
    
    NSString *address = [self.mData.mData objectForKey:@"address"];
    [SVProgressHUD showWithStatus:@"正在提交..." maskType:SVProgressHUDMaskTypeClear];

    [mUserInfo getServiceName:address andLng:nil andLat:nil andOneLevel:[self.mData.mData objectForKey:@"classification1"] andTwoLevel:[self.mData.mData objectForKey:@"classification2"] block:^(mBaseData *resb, NSArray *marr) {
        [SVProgressHUD dismiss];
        [self.tempArray removeAllObjects];
        if (resb.mSucess) {
            
            [SVProgressHUD showSuccessWithStatus:resb.mMessage];
            [self.tempArray addObjectsFromArray:marr];
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
        }
    }];
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
    
    return self.tempArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    
    SServicer *ss = self.tempArray[indexPath.row];
    
    choiseServicerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    cell.mName.text = ss.mMerchantName;
    cell.mDistance.text  = ss.mDistance;
    
//    int x = ss.mPraiseRate;
//    cell.mRaitingView.numberOfStars = 5;
//    cell.mRaitingView.scorePercent = x/10;
//    cell.mRaitingView.allowIncompleteStar = YES;
//    cell.mRaitingView.hasAnimation = YES;
    
    [cell.mDoneBtn addTarget:self action:@selector(makeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    choiceServicerViewController *sss = [choiceServicerViewController new];
    [self pushViewController:sss];
}
#pragma mark----预约按钮
- (void)makeAction:(UIButton *)sender{

    makeServiceViewController *mmm = [[makeServiceViewController alloc] initWithNibName:@"makeServiceViewController" bundle:nil];
    [self pushViewController:mmm
     ];
    
}

@end
