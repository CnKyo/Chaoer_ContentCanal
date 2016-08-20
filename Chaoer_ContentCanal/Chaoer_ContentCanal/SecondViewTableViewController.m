//
//  SecondViewTableViewController.m
//  HeaderViewAndPageView
//
//  Created by su on 16/8/8.
//  Copyright © 2016年 susu. All rights reserved.
//

#import "SecondViewTableViewController.h"
#import "mFoodRateHeaderView.h"
#import "mFoodRateTableViewCell.h"
#import "RatingBar.h"

@interface SecondViewTableViewController ()<UITableViewDataSource,UITableViewDelegate,WKSegmentControlDelagate,WKRateCellImgClickDelegate>

@property(nonatomic ,strong)UITableView * myTableView;

@end

@implementation SecondViewTableViewController
{

    /**
     *  评价切换按钮
     */
    WKSegmentControl *mRateSegmentView;
    
    /**
     *  评价headerview
     */
    mFoodRateHeaderView *mRateTableHeaderView;
    
    RatingBar *mRateServiceView;
    RatingBar *mRateProducteView;
    
    NSArray *mImgArr;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    mImgArr = @[[UIImage imageNamed:@"setup"],[UIImage imageNamed:@"setup"],[UIImage imageNamed:@"setup"],[UIImage imageNamed:@"setup"]];

    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, DEVICE_Height-114)];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_myTableView];
    
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib   *nib = [UINib nibWithNibName:@"mFoodRateTableViewCell" bundle:nil];
    [_myTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
 
    
    mRateTableHeaderView = [mFoodRateHeaderView shareView];
    mRateTableHeaderView.frame = CGRectMake(0, 0, DEVICE_Width, 100);
    
    mRateServiceView = [[RatingBar alloc] initWithFrame:CGRectMake(0, 0, mRateTableHeaderView.mSericeRateView.mwidth, mRateTableHeaderView.mSericeRateView.mheight)];
    mRateServiceView.enable = NO;
    [mRateTableHeaderView.mSericeRateView addSubview:mRateServiceView];
    mRateProducteView = [[RatingBar alloc] initWithFrame:CGRectMake(0, 0, mRateTableHeaderView.mProductRateView.mwidth, mRateTableHeaderView.mProductRateView.mheight)];
    mRateProducteView.enable = NO;
    [mRateTableHeaderView.mProductRateView addSubview:mRateProducteView];

    
    
    _myTableView.tableHeaderView = mRateTableHeaderView;
    
    NSArray *mTT = @[@"全部",@"好评",@"中评",@"差评"];

    
    mRateSegmentView = [WKSegmentControl initWithSegmentControlFrame:CGRectMake(0, 165, DEVICE_Width, 40) andTitleWithBtn:mTT andBackgroudColor:[UIColor whiteColor] andBtnSelectedColor:[UIColor colorWithRed:0.91 green:0.53 blue:0.16 alpha:1.00] andBtnTitleColor:M_TextColor1 andUndeLineColor:[UIColor colorWithRed:0.91 green:0.53 blue:0.16 alpha:1.00] andBtnTitleFont:[UIFont systemFontOfSize:15] andInterval:20 delegate:self andIsHiddenLine:YES andType:3];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return mRateSegmentView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"cell";
    mFoodRateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    [cell setMRateNum:3];
    [cell setMImgArr:mImgArr];
    
    return cell;
}
- (void)cellWithImgBrowserClickedAndTag:(NSInteger)mTag andSubViews:(UIView *)msubViews{
    //1.创建图片浏览器
    MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
    
    //2.告诉图片浏览器显示所有的图片
    NSMutableArray *photos = [NSMutableArray array];
    for (int i = 0 ; i < mImgArr.count; i++) {
        //传递数据给浏览器
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.image = mImgArr[i];
        photo.srcImageView = msubViews.subviews[i];
        [photos addObject:photo];
    }
    brower.photos = photos;
    
    //3.设置默认显示的图片索引
    brower.currentPhotoIndex = mTag;
    
    //4.显示浏览器
    [brower show];

}

- (void)WKDidSelectedIndex:(NSInteger)mIndex{

    MLLog(@"%ld",(long)mIndex);
}
@end
