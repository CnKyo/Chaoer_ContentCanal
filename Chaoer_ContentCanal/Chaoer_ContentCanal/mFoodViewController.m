//
//  mFoodViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/8/16.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mFoodViewController.h"
#import "WKLeftScrollerView.h"
#import "mFoodHeaderView.h"


#import "MYSegmentView.h"

#import "OneViewTableTableViewController.h"
#import "SecondViewTableViewController.h"
#import "ThirdViewCollectionViewController.h"
#import "MainTouchTableTableView.h"
#import "MYSegmentView.h"

static CGFloat const headViewHeight = 120;

@interface mFoodViewController ()<WKLeftScrollerViewBtnDidSelectedDelegate,UITableViewDelegate,UITableViewDataSource,WKFoodHeaderViewDelegate,WKSegmentControlDelagate,UIScrollViewDelegate>

@property(nonatomic ,strong)MainTouchTableTableView * mainTableView;
@property (nonatomic, strong) MYSegmentView * RCSegView;

@property(nonatomic,strong)UIView *mView;
@property(nonatomic,strong)mFoodHeaderView *mHeaderView;

@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabView;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabViewPre;


@end

@implementation mFoodViewController

@synthesize mainTableView;

- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    
    [super viewDidLoad];
    
    
    self.hiddenlll = YES;
    self.Title = self.mPageName = @"餐饮服务";
    self.rightBtnImage = [UIImage imageNamed:@"collection_empty"];
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self initView];
    [self upDatePage];
}
- (void)initView{

    [self.view addSubview:self.mainTableView];
    [self.mainTableView addSubview:self.mView];
    
    /*
     *
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:@"leaveTop" object:nil];
}
-(void)acceptMsg : (NSNotification *)notification{
    
    NSDictionary *userInfo = notification.userInfo;
    NSString *canScroll = userInfo[@"canScroll"];
    if ([canScroll isEqualToString:@"1"]) {
        _canScroll = YES;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    /**
     * 处理联动
     */
    
    //获取滚动视图y值的偏移量
    CGFloat yOffset  = scrollView.contentOffset.y;
    
    CGFloat tabOffsetY = [mainTableView rectForSection:0].origin.y;
    CGFloat offsetY = scrollView.contentOffset.y;
    
    _isTopIsCanNotMoveTabViewPre = _isTopIsCanNotMoveTabView;
    if (offsetY>=tabOffsetY) {
        scrollView.contentOffset = CGPointMake(0, tabOffsetY);
        _isTopIsCanNotMoveTabView = YES;
    }else{
        _isTopIsCanNotMoveTabView = NO;
    }
    if (_isTopIsCanNotMoveTabView != _isTopIsCanNotMoveTabViewPre) {
        if (!_isTopIsCanNotMoveTabViewPre && _isTopIsCanNotMoveTabView) {
            //NSLog(@"滑动到顶端");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"goTop" object:nil userInfo:@{@"canScroll":@"1"}];
            _canScroll = NO;
        }
        if(_isTopIsCanNotMoveTabViewPre && !_isTopIsCanNotMoveTabView){
            //NSLog(@"离开顶端");
            if (!_canScroll) {
                scrollView.contentOffset = CGPointMake(0, tabOffsetY);
            }
        }
    }
    
    
    /**
     * 处理头部视图
     */
    if(yOffset < -headViewHeight) {
        
        CGRect f = self.mView.frame;
        f.origin.y= yOffset ;
        f.size.height=  -yOffset;
        f.origin.y= yOffset;
        
   
    }
    
}


- (UIView *)mView{
    
    
    if (_mView == nil) {
        _mView = [UIView new];
        _mView.frame = CGRectMake(0, -headViewHeight ,DEVICE_Width,headViewHeight);
        _mView.backgroundColor = [UIColor clearColor];

        _mHeaderView = [mFoodHeaderView shareView];
        _mHeaderView.delegate = self;
        
        [_mView addSubview:_mHeaderView];
        
        [_mHeaderView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(_mView).offset(@0);
        }];
    }
    return _mView;
}
-(UITableView *)mainTableView
{
    if (mainTableView == nil)
    {
        mainTableView= [[MainTouchTableTableView alloc]initWithFrame:CGRectMake(0,64,DEVICE_Width,DEVICE_Height-64)];
        mainTableView.delegate=self;
        mainTableView.dataSource=self;
        mainTableView.showsVerticalScrollIndicator = NO;
        mainTableView.contentInset = UIEdgeInsetsMake(headViewHeight,0, 0, 0);
        mainTableView.backgroundColor = [UIColor clearColor];
    }
    return mainTableView;
}
- (void)upDatePage{

    _mHeaderView.mCampH.constant = 0.1;
    _mHeaderView.mNoteView.hidden = YES;
    _mHeaderView.mCheckMoreBtn.hidden = YES;
    
    CGRect mHeadR = _mHeaderView.frame;
    mHeadR.size.height = 70;
    _mHeaderView.frame = mHeadR;
    
}
#pragma marl -tableDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return DEVICE_Height-64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //添加pageView
    [cell.contentView addSubview:self.setPageViewControllers];
    
    return cell;
}

/*
 * 这里可以任意替换你喜欢的pageView
 */
-(UIView *)setPageViewControllers
{
    if (!_RCSegView) {
        
        OneViewTableTableViewController * First=[[OneViewTableTableViewController alloc]init];
        
//        SecondViewTableViewController * Second=[[SecondViewTableViewController alloc]init];
        
        ThirdViewCollectionViewController * Third=[[ThirdViewCollectionViewController alloc]init];
        
        NSArray *controllers=@[First,Third];
        
        NSArray *titleArray =@[@"点餐",@"详情"];
        
        MYSegmentView * rcs=[[MYSegmentView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_Width, DEVICE_Height-64) controllers:controllers titleArray:titleArray ParentController:self lineWidth:DEVICE_Width/2 lineHeight:3.];
        
        _RCSegView = rcs;
    }
    return _RCSegView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  查看更多代理方法
 */
- (void)WKFoodViewCheckMoreBtnClicked{

}
@end
