//
//  goodsSearchViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/30.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "goodsSearchViewController.h"
#import "GoodsDetailNavView.h"

#import "mSearchHeaderSectionView.h"

#import "mGoodsSearchCell.h"
@interface goodsSearchViewController ()<UITableViewDelegate,UITableViewDataSource,cellDidSelectedDelegate>

@end

@implementation goodsSearchViewController
{

    GoodsDetailNavView *mNavView;
    
    
    mSearchHeaderSectionView *mSectionView;
    
    NSMutableArray *mDataArr;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /**
     IQKeyboardManager为自定义收起键盘
     **/
    [[IQKeyboardManager sharedManager] setEnable:YES];///视图开始加载键盘位置开启调整
    [[IQKeyboardManager sharedManager]setEnableAutoToolbar:YES];///是否启用自定义工具栏
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;///启用手势
    //    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];///视图消失键盘位置取消调整
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];///关闭自定义工具栏
    
}

- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.mPageName  = @"商品详情";
    self.hiddenNavBar = YES;
    self.hiddenlll = YES;
    self.hiddenBackBtn = YES;
    self.hiddenRightBtn = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    mDataArr = [NSMutableArray new];
    
    for (int i = 0; i<10; i++) {
        [mDataArr addObject:[NSString stringWithFormat:@"这是第%d个",i]];
    }
    
    
    [self initNavBarView];
    [self initView];

}
#pragma mark----初始化导航条
- (void)initNavBarView{
    
    mNavView = [GoodsDetailNavView shareSearchView];
    [mNavView.mBackBtn addTarget:self action:@selector(mBackAction:) forControlEvents:UIControlEventTouchUpInside];
    [mNavView.mSearchBtn addTarget:self action:@selector(mSearchAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:mNavView];
    
    [mNavView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view).offset(@0);
        make.height.offset(@64);
    }];
    
    
}
- (void)mBackAction:(UIButton *)sender{
    [self popViewController];
    
}
- (void)mSearchAction:(UIButton *)sender{

    
}

- (void)initView{


    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    
    self.haveHeader = YES;
    
    UINib   *nib = [UINib nibWithNibName:@"mGoodsSearchCell" bundle:nil];
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
    return 2;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    mSectionView = [mSearchHeaderSectionView shareView];
    mSectionView.frame = CGRectMake(0, 0, DEVICE_Width, 50);
    [mSectionView.mCleanBtn addTarget:self action:@selector(mCleanAction:) forControlEvents:UIControlEventTouchUpInside];
    if (section == 1) {
        mSectionView.mTitle.text = @"热门推荐";
        mSectionView.mCleanBtn.hidden = YES;
    }
    
    return mSectionView;
    
}
- (void)mCleanAction:(UIButton *)sender{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = nil;
    
    cellId = @"cell";
    
    mGoodsSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    [cell setMDataSource:mDataArr];

    return cell.mHight;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellId = nil;
    
    cellId = @"cell";
    
    mGoodsSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    [cell setMDataSource:mDataArr];
    
    return cell;
    
}

- (void)cellDidSelectedWithIndex:(NSInteger)index{
    MLLog(@"点击了%ld",(long)index);
    [self popViewController];
}

@end
