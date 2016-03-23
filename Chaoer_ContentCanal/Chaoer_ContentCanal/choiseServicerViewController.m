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
    
    mTableView = [UITableView new];
    mTableView.backgroundColor = [UIColor clearColor];
    mTableView.frame = CGRectMake(0, 79, DEVICE_Width, DEVICE_Height-64);
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:mTableView];
    
    
    UINib   *nib = [UINib nibWithNibName:@"choiseServicerTableViewCell" bundle:nil];
    [mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    
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
    
    choiseServicerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    float x = 2.8;
    cell.mRaitingView.numberOfStars = 5;
    cell.mRaitingView.scorePercent = x/10;
    cell.mRaitingView.allowIncompleteStar = YES;
    cell.mRaitingView.hasAnimation = YES;
    
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
