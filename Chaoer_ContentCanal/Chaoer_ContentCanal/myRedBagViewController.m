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
@interface myRedBagViewController ()<UITableViewDelegate,UITableViewDataSource,WKSegmentControlDelagate>

@end

@implementation myRedBagViewController
{
    mRedBagHeader *mHeaderView;
    
    UITableView *mTableView;
    
    UIView *mHeader;
    
    WKSegmentControl    *mSegmentView;
    
    NSString *mTypr;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self headerBeganRefresh];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"我的红包";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    mTypr = @"s";
    [self initViuew];
}
- (void)initViuew{

    NSString *url = [NSString stringWithFormat:@"%@%@",[HTTPrequest returnNowURL],[mUserInfo backNowUser].mUserImgUrl];

    mHeaderView = [mRedBagHeader shareView];
    [mHeaderView.mHeaderBtn sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    mHeaderView.mName.text = [mUserInfo backNowUser].mNickName;
    mHeaderView.mDEtail.text = [mUserInfo backNowUser].mIdentity;
    [self.view addSubview:mHeaderView];
    
    [mHeaderView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(@0);
        make.top.equalTo(self.view).offset(@64);
        make.height.offset(@100);
    }];

//    NSInteger margin = 0;
//    
//    DVSwitch *secondSwitch = [DVSwitch switchWithStringsArray:@[@"收到的红包", @"发出的红包"]];
//    secondSwitch.frame = CGRectMake(margin, 164, DEVICE_Width, 35);
//    secondSwitch.layer.masksToBounds = YES;
//    secondSwitch.layer.borderColor = [UIColor colorWithRed:0.78 green:0.78 blue:0.8 alpha:1].CGColor;
//    secondSwitch.layer.borderWidth = 1;
//    secondSwitch.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
//    secondSwitch.sliderColor = [UIColor colorWithRed:0.91 green:0.54 blue:0.16 alpha:1];
//    secondSwitch.labelTextColorInsideSlider = [UIColor whiteColor];
//    secondSwitch.labelTextColorOutsideSlider = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
//    secondSwitch.cornerRadius = 0;
//    [secondSwitch setPressedHandler:^(NSUInteger index) {
//        NSLog(@"点击了%lu",(unsigned long)index);
//        if (index == 0) {
//            [self loadData:@"s"];
//        }else{
//            [self loadData:@"f"];
//            
//        }
//    }];
//    [self.view addSubview:secondSwitch];

    
    
    mSegmentView = [WKSegmentControl initWithSegmentControlFrame:CGRectMake(0, 164, DEVICE_Width, 40) andTitleWithBtn:@[@"收到的红包", @"发出的红包"] andBackgroudColor:[UIColor whiteColor] andBtnSelectedColor:M_CO andBtnTitleColor:M_TextColor1 andUndeLineColor:M_CO andBtnTitleFont:[UIFont systemFontOfSize:15] andInterval:70 delegate:self andIsHiddenLine:NO];
    
    [self.view addSubview:mSegmentView];
    
    
    [self loadTableView:CGRectMake(0,mSegmentView.mbottom, DEVICE_Width, DEVICE_Height-mSegmentView.mbottom) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.93 green:0.94 blue:0.96 alpha:1.00];

    self.haveHeader = YES;
    [self.tableView headerBeginRefreshing];
    
    UINib   *nib = [UINib nibWithNibName:@"redBagTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    
}
- (void)WKDidSelectedIndex:(NSInteger)mIndex{
    NSLog(@"点击了%lu",(unsigned long)mIndex);
    if (mIndex == 0) {
        mTypr = @"s";
        [self headerBeganRefresh];
    }else{
        mTypr = @"f";
        [self headerBeganRefresh];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)headerBeganRefresh{
    [SVProgressHUD showWithStatus:@"正在加载..." maskType:SVProgressHUDMaskTypeClear];
    
    [mUserInfo getRedBag:[mUserInfo backNowUser].mUserId andType:mTypr block:^(mBaseData *resb, NSArray *marray) {
        [self headerEndRefresh];
        [self removeEmptyView];
        if (resb.mData) {
            [self.tempArray addObjectsFromArray:marray];
            [SVProgressHUD showErrorWithStatus:@"网络请求错误！"];
            [self addEmptyViewWithImg:nil];
            [self.tableView reloadData];
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"网络请求错误！"];
        }
        
    }];

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
    return 44;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    redBagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    
    return cell;
    
}

@end
