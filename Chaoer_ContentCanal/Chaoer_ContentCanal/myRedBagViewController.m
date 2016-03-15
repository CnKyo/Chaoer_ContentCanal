//
//  myRedBagViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "myRedBagViewController.h"

#import "redBagTableViewCell.h"

#import "mRedBagHeader.h"
@interface myRedBagViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation myRedBagViewController
{
    mRedBagHeader *mHeaderView;
    
    UITableView *mTableView;
    
    UIView *mHeader;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"我的红包";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    [self initViuew];
}
- (void)initViuew{

    mTableView = [UITableView new];
    mTableView.backgroundColor = [UIColor clearColor];
    mTableView.frame = CGRectMake(0,64, DEVICE_Width, DEVICE_Height-50);
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:mTableView];
    
    
    UINib   *nib = [UINib nibWithNibName:@"redBagTableViewCell" bundle:nil];
    [mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    
    mHeader = [UIView new];
    mHeader.frame = CGRectMake(0, 0, DEVICE_Width, 230);
    
    
    mHeaderView = [mRedBagHeader shareView];
    mHeaderView.frame = CGRectMake(0, 0, DEVICE_Width, 195);
    [mHeader addSubview:mHeaderView];
    
    NSInteger margin = 0;
    
    DVSwitch *secondSwitch = [DVSwitch switchWithStringsArray:@[@"收到的红包", @"发出的红包"]];
    secondSwitch.frame = CGRectMake(margin, 195, DEVICE_Width, 35);
    secondSwitch.layer.masksToBounds = YES;
    secondSwitch.layer.borderColor = [UIColor colorWithRed:0.78 green:0.78 blue:0.8 alpha:1].CGColor;
    secondSwitch.layer.borderWidth = 1;
    secondSwitch.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
    secondSwitch.sliderColor = [UIColor colorWithRed:0.91 green:0.54 blue:0.16 alpha:1];
    secondSwitch.labelTextColorInsideSlider = [UIColor whiteColor];
    secondSwitch.labelTextColorOutsideSlider = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
    secondSwitch.cornerRadius = 0;
    [secondSwitch setPressedHandler:^(NSUInteger index) {
        NSLog(@"点击了%lu",(unsigned long)index);
        [mTableView reloadData];
    }];
    [mHeader addSubview:secondSwitch];
    
    [mTableView setTableHeaderView:mHeader];
    
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
    
    return 15;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    redBagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    
    return cell;
    
}

@end
