//
//  mGoodsDetailViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/29.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mGoodsDetailViewController.h"

#import "GoodsDetailNavView.h"
#import "mGoodsDetailCell.h"

#import "UIView+Extension.h"

// 当前设备屏幕尺寸
#define kSCREEN_RECT        ([UIScreen mainScreen].bounds)
// 当前设备屏幕宽度
#define kSCREEN_WIDTH       ([UIScreen mainScreen].bounds.size.width)
// 当前设备屏幕高度
#define kSCREEN_HEIGHT      ([UIScreen mainScreen].bounds.size.height)

// 状态栏高度
#define kSTATUSBAR_HEIGHT            (20.f)
// 导航栏高度
#define kNAVIGATION_HEIGHT           (44.f)
// 导航栏高度 + 状态栏高度
#define kSTATUSBAR_NAVIGATION_HEIGHT (64.f)
// 标签栏高度
#define kTABBAR_HEIGHT               (49.f)
// 英文键盘
#define KEYBOARD_HEIGHT_ENGLISH      (216.0f)
// 中文键盘
#define kKEYBOARD_HEIGHT_CHINESE     (252.0f)

// 底部工具条高度
#define kTOOLHEIGHT 50.f

@interface mGoodsDetailViewController ()
<UITableViewDataSource, UITableViewDelegate,mHotGoodsSelectedDelegate>

/** 商品详情整体 */
@property(strong,nonatomic)UIScrollView *scrollView;

/** 第一页 */
@property(strong,nonatomic)UITableView *mTableView;

/** 第二页 */
@property (nonatomic, strong) UIView *twoPageView;
/** 网页 */
@property (strong,nonatomic)  UIWebView *webView;
@property (nonatomic,strong)    NSMutableArray  *mSubArr;

@end

@implementation mGoodsDetailViewController
{

    GoodsDetailNavView *mNavView;
    
    GoodsDetailNavView *mBootomView;
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
    self.mSubArr = [NSMutableArray new];
    [self.mSubArr removeAllObjects];
    
    
    for (int i =0; i<10; i++) {
        NSString *sr = [NSString stringWithFormat:@"第%d个",i];
        [self.mSubArr addObject:sr];
    }


    // 添加子控件
    [self addSubView];

    // 配置上拉和下拉操作
    [self configureRefresh];

    
    [self initNavBarView];

    
}

#pragma mark----初始化导航条
- (void)initNavBarView{

    mNavView = [GoodsDetailNavView shareView];
    [mNavView.mBackBtn addTarget:self action:@selector(mBackAction:) forControlEvents:UIControlEventTouchUpInside];
    [mNavView.mShareBtn addTarget:self action:@selector(mShareAction:) forControlEvents:UIControlEventTouchUpInside];
    [mNavView.mCollectBtn addTarget:self action:@selector(mCollectionAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:mNavView];
    
    [mNavView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view).offset(@0);
        make.height.offset(@64);
    }];
    
    
    mBootomView = [GoodsDetailNavView shareShopCarView];
    [mBootomView.mAttentionBtn addTarget:self action:@selector(mAttentionAction:) forControlEvents:UIControlEventTouchUpInside];
    [mBootomView.mShopCarBtn addTarget:self action:@selector(mShopCarAction:) forControlEvents:UIControlEventTouchUpInside];
    [mBootomView.mAddShopCarBtn addTarget:self action:@selector(mAddShopCarAction:) forControlEvents:UIControlEventTouchUpInside];
    [mBootomView.mBuyNowBtn addTarget:self action:@selector(mBuyNowAction:) forControlEvents:UIControlEventTouchUpInside];

    
    [self.view addSubview:mBootomView];
    
    
    [mBootomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(@0);
        make.bottom.equalTo(self.view).offset(@50);
        make.height.offset(@50);
    }];

}
#pragma mark----关注按钮
- (void)mAttentionAction:(UIButton *)sender{

}
#pragma mark----购物车按钮
- (void)mShopCarAction:(UIButton *)sender{
    
}
#pragma mark----添加购物车按钮
- (void)mAddShopCarAction:(UIButton *)sender{
    
}
#pragma mark----立即购买按钮
- (void)mBuyNowAction:(UIButton *)sender{
    
}
#pragma mark----返回按钮
- (void)mBackAction:(UIButton *)sender{
    [self popViewController];
}
#pragma mark----分享按钮
- (void)mShareAction:(UIButton *)sender{
    
}
#pragma mark----收藏按钮
- (void)mCollectionAction:(UIButton *)sender{
    
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
#pragma mark - Lazy Methods
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, kSCREEN_HEIGHT - 114)];
        _scrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, (kSCREEN_HEIGHT - kSTATUSBAR_NAVIGATION_HEIGHT) * 2);
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = NO;
        _scrollView.backgroundColor = [UIColor clearColor];
    }
    return _scrollView;
}


- (UITableView *)tableView {
    if (!_mTableView) {
        _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, _scrollView.kheight) style:UITableViewStylePlain];
        _mTableView.delegate = self;
        _mTableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;

        _mTableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.93 alpha:1.00];
        UINib   *nib = [UINib nibWithNibName:@"mGoodsDetailCell" bundle:nil];
        [_mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
        
        nib = [UINib nibWithNibName:@"mGoodsDetailHotCell" bundle:nil];
        [_mTableView registerNib:nib forCellReuseIdentifier:@"cell2"];
    }
    return _mTableView;
}

#pragma mark - 第二页
- (UIView *)twoPageView {
    if (!_twoPageView) {
        _twoPageView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), self.tableView.kwidth, self.tableView.kheight)];
    }
    return _twoPageView;
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.kwidth, self.tableView.kheight)];
    }
    return _webView;
}

#pragma mark - View lifeCycle
- (void)addSubView {
    [self.view    addSubview:self.scrollView];
    [self.scrollView  addSubview:self.tableView];
    [self.scrollView  addSubview:self.twoPageView];
    [self.twoPageView addSubview:self.webView];
}

- (void)configureRefresh {
    
    // 动画时间
    CGFloat duration = 0.3f;
    
    // 1.设置 UITableView 上拉显示商品详情
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.scrollView.contentOffset = CGPointMake(0, self.scrollView.kheight);
        } completion:^(BOOL finished) {
            [self.tableView.footer endRefreshing];
        }];
    }];
    footer.automaticallyHidden = NO; // 关闭自动隐藏(若为YES，cell无数据时，不会执行上拉操作)
    footer.stateLabel.backgroundColor = self.tableView.backgroundColor;
    
    [footer setTitle:@"继续拖动，查看图文详情" forState:MJRefreshStateIdle];
    [footer setTitle:@"松开，即可查看图文详情" forState:MJRefreshStatePulling];
    [footer setTitle:@"松开，即可查看图文详情" forState:MJRefreshStateRefreshing];

    self.tableView.footer = footer;
    
    
    // 2.设置 UIWebView 下拉显示商品详情
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        //设置动画效果
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.scrollView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            //结束加载
            [self.webView.scrollView.header endRefreshing];
        }];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 设置文字、颜色、字体
    [header setTitle:@"下拉，返回商品简介" forState:MJRefreshStateIdle];
    [header setTitle:@"释放，返回商品简介" forState:MJRefreshStatePulling];
    [header setTitle:@"释放，返回商品简介" forState:MJRefreshStateRefreshing];



    header.stateLabel.textColor = [UIColor blackColor];
    header.stateLabel.font = [UIFont systemFontOfSize:12.f];
    self.webView.scrollView.header = header;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 345;
    }else{
        return 130;
    }
    
    
}
#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellId = nil;
    
    if (indexPath.row == 0) {
        cellId = @"cell";
        mGoodsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        return cell;

    }else{
    
        cellId = @"cell2";
        mGoodsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        cell.delegate = self;
        
        [cell setMDataSource:self.mSubArr];
        return cell;
    }
    



}
#pragma mark----滚动的代理方法
- (void)cellDidSelectedWithIndex:(NSInteger)mIndex{
    MLLog(@"点击了%ld个",(long)mIndex);
}
#pragma mark - UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

@end
