//
//  dateViewController.m
//  O2O_PaoTuiSeller
//
//  Created by 密码为空！ on 15/9/2.
//  Copyright (c) 2015年 zongyoutec.com. All rights reserved.
//

#import "dateViewController.h"
#import <MapKit/MapKit.h>
#import "searchView.h"
#import "searchAndDateViewController.h"
#import "orderDetail.h"

@interface dateViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate,FDCalendarDelegate,UISearchBarDelegate>

@end

@implementation dateViewController
{

    UIView *mTopView;
    
    UITableView *mTableView;

    
    
    UIButton *tempBtn;
    UIImageView *lineImage;
    
    searchView  *mSearchVC;
    
    int mType;
    
    
    UIView*     _pickview;
    UIView*     _bgview;
    NSDate*     _startime;
    NSDate*     _enttime;
    
    BOOL        _bmodifstarttime;
    
//    SOrderPack  *Model;
    
    UIView  *CalendarVC;

    PPiFlatSegmentedControl *segmented2;

}
-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    
//    if( [SUser isNeedLogin] )
//    {
//        [self gotoLoginVC];
//        return;
//    }else{
//        
//    }
    
    [self.tableView headerBeginRefreshing];

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
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.Title = self.mPageName = @"订单管理";
    self.hiddenBackBtn = NO;
    self.hiddenRightBtn = NO;
    self.hiddenlll = YES;
    
    self.navBar.rightBtn.frame = CGRectMake(DEVICE_Width-40, 30, 22, 22);
    
    [self.navBar.rightBtn setImage:[UIImage imageNamed:@"search"] forState:0];
    [self.navBar.leftBtn setImage:[UIImage imageNamed:@"calender"] forState:0];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    // Do any additional setup after loading the view.
    
    
    mType = 1;
    [self initView];

}
- (void)initView{

    mTopView = [UIView new];
    mTopView.backgroundColor = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1];
    [self.view addSubview:mTopView];
    
    mTableView = [UITableView new];
    
    self.tableView = mTableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 285; // 设置为一个接近“平均”行高的值
    
    UINib *nib = [UINib nibWithNibName:@"orderCellNew" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    self.haveFooter = YES;
    self.haveHeader = YES;
    [self headerBeganRefresh];

    [self.view addSubview:mTableView];
    
    
      [mTopView makeConstraints:^(MASConstraintMaker *make) {
               make.top.equalTo(self.view).with.offset(64);
                make.left.equalTo(self.view).with.offset(0);
               make.right.equalTo(self.view).with.offset(0);
               make.bottom.equalTo(mTableView.top).with.offset(0);
               make.height.offset(@70);
        }];
    
    
    [mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mTopView.bottom).with.offset(0);
        
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.bottom.equalTo(self.view.bottom).with.offset(-50);
    }];

    

    [self initSearchView];
//    [self loadPickView];
    [self loadCalender];
    
    self.page=1;
    [self loadTopView];
    

}
- (void)loadTopView{

//    [[SUser currentUser] getMyOrders:self.page status:mType date:nil keywords:nil block:^(SResBase *resb,SOrderPack *retobj) {
//        
//        if (resb.msuccess) {
//            
//            
//            NSString    *ing = [NSString stringWithFormat:@"进行中(%d)",retobj.mIngCount];
//            NSString    *finish = [NSString stringWithFormat:@"全部(%d)",retobj.mCount];
//            
//            if( segmented2 == nil )
//            {
//                segmented2 =[[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(10, 20 , DEVICE_Width-20, 35) items:@[@{@"text":ing},@{@"text":finish}]iconPosition:IconPositionRight andSelectionBlock:^(NSUInteger segmentIndex) {
//                    if (segmentIndex ==0) {
//                        
//                        NSLog(@"left");
//                        mType = 1;
//                        [self headerBeganRefresh];
//                        
//                    }
//                    if (segmentIndex == 1) {
//                        
//                        NSLog(@"mid");
//                        mType = 0;
//                        [self headerBeganRefresh];
//                        
//                    }
//                }];
//                segmented2.color=[UIColor whiteColor];
//                segmented2.borderWidth=0.5;
//                segmented2.borderColor=[UIColor colorWithRed:0.702 green:0.702 blue:0.702 alpha:1];
//                segmented2.selectedColor=[UIColor colorWithRed:1.000 green:0.184 blue:0.314 alpha:1];
//                segmented2.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:16],
//                                            NSForegroundColorAttributeName:[UIColor colorWithRed:0.290 green:0.290 blue:0.290 alpha:1]};
//                segmented2.selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:16],
//                                                    NSForegroundColorAttributeName:[UIColor whiteColor]};
//                [mTopView addSubview:segmented2];
//            }
//            else
//            {
//                [segmented2 setTitle:ing forSegmentAtIndex:0];
//                [segmented2 setTitle:finish forSegmentAtIndex:1];
//            }
//        }
//        else{
//        }
//        
//    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark----顶部刷新
-(void)headerBeganRefresh
{
    self.page=1;
  
    
//    [[SUser currentUser] getMyOrders:self.page status:mType date:nil keywords:nil block:^(SResBase *resb,SOrderPack *retobj) {
//        
//        [self headerEndRefresh];
//        
//        NSString    *ing = [NSString stringWithFormat:@"进行中(%d)",retobj.mIngCount];
//        NSString    *finish = [NSString stringWithFormat:@"全部(%d)",retobj.mCount];
//        
//        [segmented2 setTitle:ing forSegmentAtIndex:0];
//        [segmented2 setTitle:finish forSegmentAtIndex:1];
//        
//        
//        [self.tempArray removeAllObjects];
//        if (resb.msuccess) {
//            Model = retobj;
//            [self.tempArray addObjectsFromArray:retobj.mOrders];
//            [self.tableView reloadData];
//
//        }
//        else{
//            [SVProgressHUD showErrorWithStatus:resb.mmsg];
//        }
//        
//        if( self.tempArray.count == 0 )
//        {
//            [self addEmptyViewWithImg:nil];
//        }
//        else
//        {
//            [self removeEmptyView];
//        }
//    }];

    
    
    
}
#pragma mark----地步刷新
-(void)footetBeganRefresh
{

    self.page ++;
    
//    [[SUser currentUser] getMyOrders:self.page status:mType  date:nil keywords:nil block:^(SResBase *resb, SOrderPack *retobj) {
//        [self footetEndRefresh];
//        if (resb.msuccess) {
//            Model = retobj;
//
//            [self.tempArray addObjectsFromArray:retobj.mOrders];
//            [self.tableView reloadData];
//
//        }
//        else{
//            [SVProgressHUD showErrorWithStatus:resb.mmsg];
//        }
//        
//        if( self.tempArray.count == 0 )
//        {
//            [self addEmptyViewWithImg:nil];
//        }
//        else
//        {
//            [self removeEmptyView];
//        }
//    }];
    
    
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
    return 141;

}

//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSString *reuseCellId = @"cell";
//    
//    orderCellNew *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
//    
//    cell.model = self.tempArray[indexPath.row];
//    
//    return cell;
//
//}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SOrder *sorder = self.tempArray[indexPath.row];
    orderDetail* vc = [[orderDetail alloc]initWithNibName:@"orderDetail" bundle:nil];
    vc.mtagOrder = sorder;
    [self pushViewController:vc];
    
    
}
#pragma mark----左边的按钮---日历
- (void)leftBtnTouched:(id)sender{
//    _bmodifstarttime = YES;
//    [self showPick];
    [self showCalendar];

}
#pragma mark----右边的按钮---搜索
- (void)rightBtnTouched:(id)sender{
    [self showSearchView];
    
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    
    searchAndDateViewController *sss = [searchAndDateViewController new];
    sss.searchStr = searchBar.text;
    [self pushViewController:sss];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    [self hidenSearchView];

}


- (void)showSearchView{

    
    [UIView animateWithDuration:0.3f animations:^{
        CGRect f = mSearchVC.frame;
        f.origin.y = 20;
        mSearchVC.frame = f;
        
    }];

}
- (void)hidenSearchView{
    [UIView animateWithDuration:0.3f animations:^{
        CGRect f = mSearchVC.frame;
        f.origin.y = -70;
        mSearchVC.frame = f;
        
    }];
}
- (void)initSearchView{

    mSearchVC = [searchView shareView];
    mSearchVC.frame = CGRectMake(0, -70, DEVICE_Width, 50);
    mSearchVC.mSearch.delegate = self;
    [mSearchVC.mSearchBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mSearchVC];
}
- (void)cancelAction:(UIButton *)sender{
    [self hidenSearchView];
}

#pragma mark----日历

- (void)loadPickView{
    UINib* nib = [UINib nibWithNibName:@"pickVC" bundle:nil];
    _pickview = [nib instantiateWithOwner:self options:nil].firstObject;
    
    UIButton* canclebt = (UIButton*)[_pickview viewWithTag:1];
    [canclebt addTarget:self action:@selector(pickbtclicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* okbt = (UIButton*)[_pickview viewWithTag:2];
    [okbt addTarget:self action:@selector(pickbtclicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _startime = [NSDate date];
    
    
}
-(void)updateTimeInfo
{
   
    MLLog(@"///////////--%@",[Util getTimeStringSS:_startime]);
    
    searchAndDateViewController *sss = [searchAndDateViewController new];
    sss.dateStr = [Util getTimeStringSS:_startime];
    [self pushViewController:sss];
    
}
-(void)pickbtclicked:(UIButton*)sender
{
    if( sender.tag == 1 )
    {//取消
        
    }
    else
    {//确定
        UIDatePicker* tmppick = (UIDatePicker*)[_pickview viewWithTag:3];
        if( _bmodifstarttime )
        {//修改开始时间
            
            _startime = tmppick.date;
           
        }
        [self updateTimeInfo];
    }
    [self hidenPick];
}
-(void)bgclicked:(id)sender
{
    [self hidenPick];
}
-(void)showPick
{
    CGRect mR = _pickview.frame;
    mR.size.width = DEVICE_Width;
    mR.origin.y = DEVICE_Height;
    _pickview.frame = mR;
    
    _bgview = [[UIView alloc]initWithFrame:self.view.bounds];
    _bgview.alpha = 0.1;
    _bgview.userInteractionEnabled = YES;
    UITapGestureRecognizer* guest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgclicked:)];
    [_bgview addGestureRecognizer: guest];
    
    UIImageView * bgimag = [[UIImageView alloc]initWithFrame:_bgview.bounds];
    bgimag.backgroundColor = [UIColor blackColor];
    bgimag.alpha = 0.75f;
    [_bgview addSubview: bgimag];
    [_bgview addSubview: _pickview];
    UIDatePicker* tmppick = (UIDatePicker*)[_pickview viewWithTag:3];
    if( _bmodifstarttime )
    {
        tmppick.date = _startime;
    }
    
    
    CGRect f = _pickview.frame;
    f.origin.y = DEVICE_Height-49;
    _pickview.frame = f;
    
    [self.view addSubview: _bgview];
    [UIView animateWithDuration:0.3f animations:^{
        
        _bgview.alpha = 1;
        CGRect ff = _pickview.frame;
        ff.origin.y -= ff.size.height;
        _pickview.frame = ff;
        
    }];
    
}
-(void)hidenPick
{
    [UIView animateWithDuration:0.3f animations:^{
        
        CGRect ff = _pickview.frame;
        ff.origin.y = DEVICE_Height;
        _pickview.frame = ff;
        _bgview.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [_bgview removeFromSuperview];
        [_pickview removeFromSuperview];
        _bgview = nil;
        
    }];
    
}
#pragma mark----Calendar
- (void)loadCalender{
    
    CalendarVC = [UIView new];
    CalendarVC.frame = CGRectMake(0, 0-self.view.frame.size.height-20, self.view.frame.size.width, self.view.frame.size.height);
    CalendarVC.backgroundColor = [UIColor colorWithRed:0.827 green:0.827 blue:0.827 alpha:0.9];
    [self.view addSubview:CalendarVC];
    
    FDCalendar *calendar = [[FDCalendar alloc] initWithCurrentDate:[NSDate date]];
    CGRect frame = calendar.frame;
    frame.origin.y = 64;
    calendar.frame = frame;
    calendar.delegate = self;
    [CalendarVC addSubview:calendar];
    
    UIButton *ssBtn = [UIButton new];
    ssBtn.frame = CGRectMake(10, calendar.frame.size.height+calendar.frame.origin.y+20, CalendarVC.frame.size.width-20 , 50);
    ssBtn.layer.masksToBounds = YES;
    ssBtn.layer.cornerRadius = 4;
    ssBtn.backgroundColor = [UIColor colorWithRed:1.000 green:0.184 blue:0.314 alpha:1];
    [ssBtn setTitle:@"取消" forState:0];
    [ssBtn addTarget:self action:@selector(aaAction:) forControlEvents:UIControlEventTouchUpInside];
    [CalendarVC addSubview:ssBtn];
    
}

- (void)showCalendar{
    [UIView animateWithDuration:0.3f animations:^{
        CGRect f = CalendarVC.frame;
        f.origin.y = 0;
        CalendarVC.frame = f;
        
    }];
}
- (void)hiddenCalendar{
    [UIView animateWithDuration:0.3f animations:^{
        CGRect f = CalendarVC.frame;
        f.origin.y = 0-self.view.frame.size.height-20;
        CalendarVC.frame = f;
        
    }];
}
- (void)aaAction:(UIButton *)sender{
    [self hiddenCalendar];
}
- (void)btnAction:(UIButton *)sender{
    [self showCalendar];
}

#pragma mark - FDCalendarDelegate

- (void)calendar:(FDCalendarItem *)item didSelectedDate:(NSDate *)date{
    NSLog(@"%@",date);
    [self hiddenCalendar];
    searchAndDateViewController *sss = [searchAndDateViewController new];
    sss.dateStr = [Util getTimeStringSS:date];
    [self pushViewController:sss];

}

@end
