//
//  mGoodsDetailViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/29.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mGoodsDetailViewController.h"

#import "mGoodsDetailBottomView.h"
#import "mGoodsDetailCell.h"

#import "UIView+Extension.h"
#import "QHLShoppingCarController.h"
#import "comFirmOrderViewController.h"

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
<UITableViewDataSource, UITableViewDelegate,mGoodsDetailBuyDelegate>

/** 商品详情整体 */
@property(strong,nonatomic)UIScrollView *scrollView;


/** 第二页 */
@property (nonatomic, strong) UIScrollView *twoPageView;
/** 网页 */
@property (strong,nonatomic)  UIWebView *webView;

@end

@implementation mGoodsDetailViewController
{
    /**
     *  底部view
     */
    mGoodsDetailBottomView *mBootomView;
    /**
     *  商品详情对象
     */
    SGoodsDetail *mGoodsDetail;
    /**
     *  是否选择收藏
     */
    BOOL mSelected;
    /**
     *  底部购买view
     */
    mGoodsDetailBottomView *mBuyView;

    
    UIView *mBgkView;
    
    int mNum;
    
    int mType;
    
}
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.mPageName = self.Title = @"商品详情";
    self.hiddenNavBar = NO;
    self.hiddenlll = YES;
    self.hiddenBackBtn = NO;
    self.hiddenRightBtn = YES;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [UIColor whiteColor];

    mNum = 1;
    [self initView];
    [self initBottomBuyView];

}
#pragma mark ----加载底部购买view
- (void)initBottomBuyView{

    mBgkView = [UIView new];
    mBgkView.frame = self.view.bounds;
    mBgkView.backgroundColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:0.3];
    mBgkView.alpha = 0;
    [self.view addSubview:mBgkView];
    
    UITapGestureRecognizer *mTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [mBgkView addGestureRecognizer:mTap];
    
    mBuyView = [mGoodsDetailBottomView shareBuyView];
    mBuyView.frame = CGRectMake(0, DEVICE_Height, self.view.frame.size.width, 160);
    mBuyView.delegate = self;
    [self.view addSubview:mBuyView];
//    [mBuyView makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view).offset(@0);
//        make.bottom.equalTo(self.view.bottom).offset(@150);
//        make.width.offset(DEVICE_Width);
//        make.height.offset(@150);
//    }];
    
}
- (void)tapAction:(UITapGestureRecognizer *)sender{
    [self hiddenBuyView];
}
- (void)upDateBuyView{

    [mBuyView.mGoodsImg sd_setImageWithURL:[NSURL URLWithString:mGoodsDetail.mGoodsImg] placeholderImage:[UIImage imageNamed:@"img_default"]];
    mBuyView.mGoodsName.text = mGoodsDetail.mGoodsName;
    mBuyView.mGoodsPrice.text = [NSString stringWithFormat:@"¥%.2f元",mGoodsDetail.mGoodsPrice*mNum];
    
    mBuyView.mNum.text = [NSString stringWithFormat:@"%d",mNum];
}
- (void)showBuyView{
    [UIView animateWithDuration:0.25 animations:^{
        mBgkView.alpha = 1;
        CGRect mRR = mBuyView.frame;
        mRR.origin.y = DEVICE_Height-160;
        mBuyView.frame = mRR;
        
    }];
}
- (void)hiddenBuyView{
    [UIView animateWithDuration:0.25 animations:^{
        mBgkView.alpha = 0;
        CGRect mRR = mBuyView.frame;
        mRR.origin.y = DEVICE_Height;
        mBuyView.frame = mRR;
        
    }];
}
#pragma mark----底部购买关闭按钮
- (void)mGoodsDetailCloseActionView{
    [self hiddenBuyView];
}
#pragma mark----底部购买添加按钮
- (void)mGoodsDetailAddActionView{
    
    mNum+=1;
    [self upDateBuyView];
}
#pragma mark----底部购买减按钮
- (void)mGoodsDetailJianActionView{
    
    if (mNum <= 1) {
        return;
    }else{
        mNum-=1;
        [self upDateBuyView];
    }
    
    
}
#pragma mark----底部购买确定按钮
- (void)mGoodsDetailOkActionView{
    
    if (mType == 2) {
        [self showWithStatus:@"正在购买..."];
        [[mUserInfo backNowUser] goBuyNow:mGoodsDetail.mShopId andGoodsId:_mSGoods.mGoodsId andNum:mNum block:^(mBaseData *resb, GPayShopCar *mShopCarList) {
            [self dismiss];
            if (resb.mSucess) {
                comFirmOrderViewController *comfir = [[comFirmOrderViewController alloc] initWithNibName:@"comFirmOrderViewController" bundle:nil];
                comfir.mShopCarList = nil;
                comfir.mShopCarList = [GPayShopCar new];
                
                comfir.mShopCarList = mShopCarList;
                [self pushViewController:comfir];
                [self hiddenBuyView];
            }else{
                [self showErrorStatus:resb.mMessage];
            }
            
        }];

    }else{
        [self showWithStatus:@""];
        
        [[mUserInfo backNowUser] addGoodsToShopCar:mGoodsDetail.mShopId andGoodsId:mGoodsDetail.mGoodsId andNum:mNum block:^(mBaseData *resb) {
            
            [self dismiss];
            if (resb.mSucess) {
                mGoodsDetail.mBadge+=mNum;
                [self upDatePage];
                [self hiddenBuyView];
            }else{
                [self showErrorStatus:resb.mMessage];
            }
        }];

    }
    
   
    
}
#pragma mark----初始化导航条
- (void)initView{

    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, kSCREEN_HEIGHT - 114)];
        _scrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, (kSCREEN_HEIGHT - kSTATUSBAR_NAVIGATION_HEIGHT) * 2);
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = NO;
        _scrollView.backgroundColor = [UIColor clearColor];
    }
    [self.view  addSubview:self.scrollView];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, _scrollView.kheight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.93 alpha:1.00];
    UINib   *nib = [UINib nibWithNibName:@"mGoodsDetailCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    self.haveHeader = YES;
    self.haveFooter = YES;
    
    nib = [UINib nibWithNibName:@"mGoodsDetailHotCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];

    [self.scrollView  addSubview:self.tableView];

    
    if (!_twoPageView) {
        _twoPageView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), self.tableView.kwidth, self.tableView.kheight)];
  
    }
    [self.scrollView  addSubview:self.twoPageView];

    
    mBootomView = [mGoodsDetailBottomView shareShopCarView];
    mBootomView.frame = CGRectMake(0, DEVICE_Height-50, self.view.frame.size.width, 40);

    
    [mBootomView.mAttentionBtn addTarget:self action:@selector(mAttentionAction:) forControlEvents:UIControlEventTouchUpInside];
    [mBootomView.mShopCarBtn addTarget:self action:@selector(mShopCarAction:) forControlEvents:UIControlEventTouchUpInside];
    [mBootomView.mAddShopCarBtn addTarget:self action:@selector(mAddShopCarAction:) forControlEvents:UIControlEventTouchUpInside];
    [mBootomView.mBuyNowBtn addTarget:self action:@selector(mBuyNowAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (mGoodsDetail.mIsFocus) {
        [mBootomView.mAttentionBtn setBackgroundImage:[UIImage imageNamed:@"mGoodsDetail_collect"] forState:0];
    }else{
        [mBootomView.mAttentionBtn setBackgroundImage:[UIImage imageNamed:@"mGoodsDetail_unCollect"] forState:0];
    }
    [self.view addSubview:mBootomView];
    
    
//    [mBootomView makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view).offset(@0);
//        make.bottom.equalTo(self.view).offset(@50);
//        make.height.offset(@50);
//    }];
    
    
//    UIButton *mBB = [UIButton new];
//    mBB.frame = CGRectMake(0, DEVICE_Height-50, DEVICE_Width, 50);
//    mBB.backgroundColor = [UIColor redColor];
//    [mBB addTarget:self action:@selector(mbbAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:mBB];
    

}
- (void)mbbAction:(UIButton *)sender{
    MLLog(@"adsdasd");
}
- (void)headerBeganRefresh{
    [self initData];

    // 动画时间
    CGFloat duration = 0.4f;
    // 2.设置 UIWebView 下拉显示商品详情
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        //设置动画效果
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.scrollView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            [self headerEndRefresh];
            //结束加载
            [self.twoPageView.mj_header endRefreshing];
        }];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 设置文字、颜色、字体
    [header setTitle:@"下拉，返回商品简介" forState:MJRefreshStateIdle];
    [header setTitle:@"释放，返回商品简介" forState:MJRefreshStatePulling];
    [header setTitle:@"释放，返回商品简介" forState:MJRefreshStateRefreshing];
    
    
    
    header.stateLabel.textColor = [UIColor blackColor];
    header.stateLabel.font = [UIFont systemFontOfSize:12.f];
    self.twoPageView.mj_header = header;
    //    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    [self headerEndRefresh];

    
    [self.tableView reloadData];

}
- (void)footetBeganRefresh{
//    [self initData];

    // 动画时间
    CGFloat duration = 0.4f;
    
    // 1.设置 UITableView 上拉显示商品详情
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.scrollView.contentOffset = CGPointMake(0, self.scrollView.kheight);
        } completion:^(BOOL finished) {
            [self footetEndRefresh];
            [self.tableView.mj_footer endRefreshing];
        }];
    }];
    footer.automaticallyHidden = NO; // 关闭自动隐藏(若为YES，cell无数据时，不会执行上拉操作)
    footer.stateLabel.backgroundColor = self.tableView.backgroundColor;
    
    [footer setTitle:@"继续拖动，查看图文详情" forState:MJRefreshStateIdle];
    [footer setTitle:@"松开，即可查看图文详情" forState:MJRefreshStatePulling];
    [footer setTitle:@"松开，即可查看图文详情" forState:MJRefreshStateRefreshing];
    
    self.tableView.mj_footer = footer;
    [self footetEndRefresh];

    
}
- (void)upDatePage{
    [self upDateBuyView];
    if (mGoodsDetail.mBadge <= 0) {
        mBootomView.mGoodsNum.hidden = YES;
    }else{
        mBootomView.mGoodsNum.hidden = NO;
        mBootomView.mGoodsNum.text = [NSString stringWithFormat:@"%d",mGoodsDetail.mBadge];
    }
    
    if (mGoodsDetail.mIsFocus) {
        [mBootomView.mAttentionBtn setBackgroundImage:[UIImage imageNamed:@"mGoodsDetail_collect"] forState:0];
    }else{
        [mBootomView.mAttentionBtn setBackgroundImage:[UIImage imageNamed:@"mGoodsDetail_unCollect"] forState:0];
    }
    
   
    CGFloat mYY;
    
    if (mGoodsDetail.mGoodsDetailImgArr.count <= 0) {
        
    }else{
        
        for (int i= 0; i<mGoodsDetail.mGoodsDetailImgArr.count; i++) {
            NSString *mSS = mGoodsDetail.mGoodsDetailImgArr[i];
            NSString *mUrl = [NSString stringWithFormat:@"%@%@",[HTTPrequest currentResourceUrl],mSS];
            
            UIImageView *mImg = [UIImageView new];
            mImg.frame = CGRectMake(0, mYY, self.tableView.frame.size.width, 200);
            mImg.backgroundColor = [UIColor whiteColor];
            [mImg sd_setImageWithURL:[NSURL URLWithString:mUrl  ] placeholderImage:[UIImage imageNamed:@"img_default"]];
            [_twoPageView addSubview:mImg];
            mYY+=200;
        }

        
        _twoPageView.contentSize = CGSizeMake(self.tableView.frame.size.width, mYY);
        
    }
    [self.tableView reloadData];
}

#pragma mark----关注按钮
- (void)mAttentionAction:(UIButton *)sender{
    
    
    if (mGoodsDetail.mIsFocus) {
        mSelected = NO;
    }else{
        mSelected = YES;
    }
    
    [self showWithStatus:@"正在操作中..."];
    [[mUserInfo backNowUser] collectGoods:mGoodsDetail.mShopId andGoodsId:mGoodsDetail.mGoodsId andType:mSelected block:^(mBaseData *resb, NSArray *mArr) {
        [self dismiss];
        if (resb.mSucess) {
            mGoodsDetail.mIsFocus = mSelected;

            [self upDatePage];
            
        }else{
            [self showErrorStatus:resb.mMessage];
        }
        
    }];
    
    
}
#pragma mark----购物车按钮
- (void)mShopCarAction:(UIButton *)sender{
   
    QHLShoppingCarController *shopcar = [QHLShoppingCarController new];
    [self pushViewController:shopcar];
    
}
#pragma mark----添加购物车按钮
- (void)mAddShopCarAction:(UIButton *)sender{
    
    mType = 3;
    
    [self showBuyView];
    
    

   
    
}
#pragma mark----立即购买按钮
- (void)mBuyNowAction:(UIButton *)sender{
    
    mType = 2;
    
    [self showBuyView];

    
}

#pragma mark---- 加载数据源
- (void)initData{
    [self showWithStatus:@"正在加载..."];
    [[mUserInfo backNowUser] getGoodsDetail:_mSGoods.mGoodsId andShopId:_mShopId block:^(mBaseData *resb, SGoodsDetail *SGoods) {
        [self headerEndRefresh];
        [self removeEmptyView];
        [self dismiss];
        if (resb.mSucess) {
            mGoodsDetail = SGoods;
            // 添加子控件
            [self upDatePage];

            [self.tableView reloadData];
        }else{
            [self showErrorStatus:resb.mMessage];
            [self performSelector:@selector(leftBtnTouched:) withObject:self afterDelay:1.0];
        
            
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



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row == 0) {
        NSString *cellId = nil;
        
        cellId = @"cell";
        mGoodsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setMGoodsDetail:mGoodsDetail];
        return cell.mCellH;
    }else{
    
        NSString *cellId = nil;
        cellId = @"cell2";
        mGoodsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell setMGoodsDetail:mGoodsDetail];
        return cell.mGoodsDetailH;
    }
    

  
    
}
#pragma mark - UITableViewDataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return  1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellId = nil;
    
    if (indexPath.row == 0) {
        cellId = @"cell";
    
    }else{
    
        cellId = @"cell2";
      
    }
    mGoodsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell setMGoodsDetail:mGoodsDetail];
    return cell;


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
