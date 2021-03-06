//
//  BaseVC.m
//  testBase
//
//  Created by ljg on 15-2-27.
//  Copyright (c) 2015年 ljg. All rights reserved.
//

#import "BaseVC.h"
#import "MTA.h"
#import "ViewController.h"
#import "HTTPrequest.h"
#import "dataModel.h"

#import "mGeneryEmptyView.h"
#import "MJRefresh.h"
@interface BaseVC ()<UIGestureRecognizerDelegate>
{
    UIView *emptyView;
    UIView *notifView;
}

@property (weak, nonatomic) UIView *scrollView;
@property (retain, nonatomic)UIPanGestureRecognizer *panGesture;
@property (retain, nonatomic)UIView *overLay;
@property (assign, nonatomic)BOOL isHidden;
@end

@implementation BaseVC

{
    
    mGeneryEmptyView *mEmptyView;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if( self ) {
        
        self.isStoryBoard = nibNameOrNil != nil;
        MLLog(@"<------isnib");
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        MLLog(@"--------->isnotnib");
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    //     self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.isStoryBoard = YES;
    return [super initWithCoder:aDecoder];
}

-(void)setHiddenBackBtn:(BOOL)hiddenBackBtn
{
    self.navBar.leftBtn.hidden = hiddenBackBtn;
}
-(void)setHiddenRightBtn:(BOOL)hiddenRightBtn{
    
    self.navBar.rightBtn.hidden = hiddenRightBtn;
}
-(void)setHiddenlll:(BOOL)hiddenlll{
    self.navBar.lll.hidden = hiddenlll;
}

-(void)checkUserGinfo
{
    [self removeNotifacationStatus];
}
-(void)addNotifacationStatus:(NSString *)str
{
    if (!notifView) {
        notifView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_Width, 50)];
        self.contentView.clipsToBounds = NO;
        UILabel *label = [[UILabel alloc]initWithFrame:notifView.bounds];
        label.text =str;
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        notifView.backgroundColor = COLOR(88, 88, 88);
        notifView.alpha = 0.0;
        // label.backgroundColor = [UIColor redColor];
        [notifView addSubview:label];
    }
    [self.contentView addSubview:notifView];
    
    [self notifViewAnimation:YES];
}
-(void)notifViewAnimation:(BOOL)isbegan
{
    if (isbegan) {
        [UIView animateWithDuration:1 animations:^{
            //            CGRect rect = notifView.frame;
            //            rect.origin.y=0;
            //            notifView.frame = rect;
            notifView.alpha = 1.0;
        }];
    }else
    {
        [UIView animateWithDuration:1 animations:^{
            //            CGRect rect = notifView.frame;
            //            rect.origin.y=-50;
            //            notifView.frame = rect;
            notifView.alpha = 0.0;
        }completion:^(BOOL finished) {
            [notifView removeFromSuperview];
            notifView = nil;
        }];
    }
}
-(void)removeNotifacationStatus
{
    [self notifViewAnimation:NO];
}
- (void)hideTabBar {
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = YES;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if( !_mPageName )
    {
        MLLog(@"page not name:%@",[self description]);
        assert(_mPageName);
    }
    [MTA trackPageViewBegin:self.mPageName];
    //    [MobClick beginLogPageView:_mPageName];
    
    MLLog_VC("viewWillAppear");
    
    if (self.hiddenTabBar) {
        self.tabBarController.tabBar.hidden = YES;
    }else{
        self.tabBarController.tabBar.hidden = NO;
    }
    
    
    //    if (!self.hiddenTabBar) {
    //        [super.view addSubview:self.tabBar];
    //    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //MLLog_VC("viewWillDisappear");
    
    [MTA trackPageViewEnd:self.mPageName];
    
}
-(void)setHaveHeader:(BOOL)have
{
    __block BaseVC *vc = self;
    
    NSMutableArray *mImgArr = [NSMutableArray new];
    
    for (int i =0; i<20; i++) {
        NSString *imgstr = [NSString stringWithFormat:@"fresh_%d",i];
        
        [mImgArr addObject:[UIImage imageNamed:imgstr]];
    }
    // 动画时间
    CGFloat duration = 0.3f;
    // 2.设置 UIWebView 下拉显示商品详情
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        //设置动画效果
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            
            [vc.tableView.header beginRefreshing];
        } completion:^(BOOL finished) {
            //结束加载
            [vc.tableView.header endRefreshing];
            
        }];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 设置文字、颜色、字体
    [header setTitle:@"下拉查看更多" forState:MJRefreshStateIdle];
    [header setTitle:@"松开即可刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"松开即可刷新" forState:MJRefreshStateRefreshing];
    [header setImages:mImgArr forState:MJRefreshStatePulling];
    [header setImages:mImgArr forState:MJRefreshStateIdle];
    [header setImages:mImgArr forState:MJRefreshStateRefreshing];
    header.stateLabel.textColor = [UIColor lightGrayColor];
    header.stateLabel.font = [UIFont systemFontOfSize:14];
    vc.tableView.header = header;
    
    
}
-(void)setHaveFooter:(BOOL)haveFooter
{
    
    NSMutableArray *mImgArr = [NSMutableArray new];
    
    for (int i =0; i<20; i++) {
        NSString *imgstr = [NSString stringWithFormat:@"fresh_%d",i];
        
        [mImgArr addObject:[UIImage imageNamed:imgstr]];
    }
    CGFloat duration = 0.3f;
    
    __block BaseVC *vc = self;
    // 1.设置 UITableView 上拉显示商品详情
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            [vc.tableView.footer beginRefreshing];
            
            
        } completion:^(BOOL finished) {
            [self.tableView.footer endRefreshing];
        }];
    }];
    footer.automaticallyHidden = NO; // 关闭自动隐藏(若为YES，cell无数据时，不会执行上拉操作)
    footer.stateLabel.backgroundColor = self.tableView.backgroundColor;
    [footer setTitle:@"上拉拉查看更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"松开即可刷新" forState:MJRefreshStatePulling];
    [footer setTitle:@"松开即可刷新" forState:MJRefreshStateRefreshing];
    [footer setImages:mImgArr forState:MJRefreshStatePulling];
    [footer setImages:mImgArr forState:MJRefreshStateIdle];
    [footer setImages:mImgArr forState:MJRefreshStateRefreshing];
    footer.stateLabel.textColor = [UIColor lightGrayColor];
    self.tableView.footer = footer;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    if ( [self.Title isEmpty] )
    {
        self.Title = @"base";
    }
    
    CGFloat offsetY = 0.0f;
    CGFloat contentH = DEVICE_Height;
    
    if( self.hiddenNavBar  )
    {
        //如果不要导航拦,顶部就从0开始了
        offsetY = 0.0f;
    }
    else
    {
        //如果需要,就要从导航栏下面开始
        offsetY = DEVICE_NavBar_Height;
        self.navBar =  [[NavBar alloc]init];
        self.navBar.NavDelegate = self;
        self.navBar.backgroundColor = M_CO;
        [self.view addSubview: self.navBar ];
    }
    contentH  -= offsetY;
    
    if( self.hiddenTabBar )
    {
        //如果不要下面的Tab,
        self.tabBarController.tabBar.hidden = YES;
    }
    else
    {
        self.tabBarController.tabBar.hidden = NO;//这个不行,要处理下,
        //如果需要,
        contentH  -= DEVICE_TabBar_Height;
    }
    
    
    if ( !self.isStoryBoard )
    {//如果不是XIB或者 storybaord,,,就自己处理这个问题
        self.contentView = [[ContentScrollView alloc]initWithFrame:CGRectMake(0, offsetY, DEVICE_Width, contentH)];
        self.contentView.backgroundColor = M_BGCO;
        [self.view addSubview:self.contentView];
        self.automaticallyAdjustsScrollViewInsets = NO;//这个是处理XIB的时候,要空20的时候,..这么放到这里面了
    }
    
    self.tempArray = [[NSMutableArray alloc]init];
    self.page = 0;
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}
-(void)headerBeganRefresh
{
    __block BaseVC *vc = self;
    
    NSMutableArray *mImgArr = [NSMutableArray new];
    
    for (int i =0; i<20; i++) {
        NSString *imgstr = [NSString stringWithFormat:@"fresh_%d",i];
        
        [mImgArr addObject:[UIImage imageNamed:imgstr]];
    }
    // 动画时间
    CGFloat duration = 0.3f;
    // 2.设置 UIWebView 下拉显示商品详情
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        //设置动画效果
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            
            [vc.tableView.header beginRefreshing];
        } completion:^(BOOL finished) {
            //结束加载
            [vc.tableView.header endRefreshing];
            
        }];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 设置文字、颜色、字体
    [header setTitle:@"下拉查看更多" forState:MJRefreshStateIdle];
    [header setTitle:@"松开即可刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"松开即可刷新" forState:MJRefreshStateRefreshing];
    [header setImages:mImgArr forState:MJRefreshStatePulling];
    [header setImages:mImgArr forState:MJRefreshStateIdle];
    [header setImages:mImgArr forState:MJRefreshStateRefreshing];
    header.stateLabel.textColor = [UIColor lightGrayColor];
    header.stateLabel.font = [UIFont systemFontOfSize:14];
    vc.tableView.header = header;
    
    //todo
}
-(void)footetBeganRefresh
{
    NSMutableArray *mImgArr = [NSMutableArray new];
    
    for (int i =0; i<20; i++) {
        NSString *imgstr = [NSString stringWithFormat:@"fresh_%d",i];
        
        [mImgArr addObject:[UIImage imageNamed:imgstr]];
    }
    CGFloat duration = 0.3f;
    
    __block BaseVC *vc = self;
    // 1.设置 UITableView 上拉显示商品详情
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            [vc.tableView.footer beginRefreshing];
            
            
        } completion:^(BOOL finished) {
            [self.tableView.footer endRefreshing];
        }];
    }];
    footer.automaticallyHidden = NO; // 关闭自动隐藏(若为YES，cell无数据时，不会执行上拉操作)
    footer.stateLabel.backgroundColor = self.tableView.backgroundColor;
    [footer setTitle:@"上拉拉查看更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"松开即可刷新" forState:MJRefreshStatePulling];
    [footer setTitle:@"松开即可刷新" forState:MJRefreshStateRefreshing];
    [footer setImages:mImgArr forState:MJRefreshStatePulling];
    [footer setImages:mImgArr forState:MJRefreshStateIdle];
    [footer setImages:mImgArr forState:MJRefreshStateRefreshing];
    footer.stateLabel.textColor = [UIColor lightGrayColor];
    self.tableView.footer = footer;
    //todo
}

-(void)headerEndRefresh{
    
    [self.tableView.header endRefreshing];
}//header停止刷新
-(void)footetEndRefresh{
    [self.tableView.footer endRefreshing];
}//footer停止刷新
-(void)loadTableView:(CGRect)rect delegate:(id<UITableViewDelegate>)delegate dataSource:(id<UITableViewDataSource>)datasource
{
    self.tableView = [[UITableView alloc]initWithFrame:rect];
    self.tableView.delegate = delegate;
    self.tableView.dataSource = datasource;
    //    [self.contentView addSubview:self.tableView];
    if(!self.isStoryBoard)
    {
        [self.contentView addSubview:self.tableView];
    }else
    {
        [self.view addSubview:self.tableView];
    }
    
}

-(void)leftBtnTouched:(id)sender
{
    [self dismiss];
    [self popViewController];
    //todo
}
-(void)setLeftBtnTitle:(NSString *)str{
    [self.navBar.leftBtn setImage:nil forState:UIControlStateNormal];
    [self.navBar.leftBtn setTitle:str forState:UIControlStateNormal];
}

-(void)setRightBtnTitle:(NSString *)str
{
    [self.navBar.rightBtn setImage:nil forState:UIControlStateNormal];
    [self.navBar.rightBtn setTitle:str forState:UIControlStateNormal];
}
-(void)rightBtnTouched:(id)sender
{
    //todo
}
- (void)ABtnTouched:(id)sender{
    
}
- (void)BBtnTouched:(id)sender{
    
}
- (void)setHiddenA:(BOOL)hiddenA{
    self.navBar.ABtn.hidden = hiddenA;
}
- (void)setHiddenB:(BOOL)hiddenB{
    self.navBar.BBtn.hidden = hiddenB;
}

-(void)setTitle:(NSString *)str
{
    _Title = str;
    self.navBar.titleLabel.text = str;
}
- (void)setABtnTitle:(NSString *)ABtnTitle
{
    [self.navBar.ABtn setImage:nil forState:UIControlStateNormal];
    [self.navBar.ABtn setTitle:ABtnTitle forState:UIControlStateNormal];
}
- (void)setBBtnTitle:(NSString *)BBtnTitle
{
    [self.navBar.BBtn setImage:nil forState:UIControlStateNormal];
    [self.navBar.BBtn setTitle:BBtnTitle forState:UIControlStateNormal];
}



-(void)addEmptyView:(NSString *)str
{
    return [self addEmptyViewWithImg:nil];
    
    if (emptyView) {
        [self.tableView addSubview:emptyView];
        return;
    }
    emptyView = [[UIView alloc]initWithFrame:CGRectMake(emptyView.bounds.size.width / 2, emptyView.frame.size.height / 2-20, DEVICE_Width, 200)];
    emptyView.backgroundColor = [UIColor clearColor];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(150, 100, 43, 90)];
    //    image.center = CGPointMake(emptyView.bounds.size.width / 2, emptyView.frame.size.height / 2-20) ;
    image.image = [UIImage imageNamed:@"ic_empty"];
    [emptyView addSubview:image];
    UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 250, 60)];
    [addBtn setCenter:CGPointMake(emptyView.bounds.size.width / 2, emptyView.frame.size.height / 2+20)];
    [addBtn setTitle:str forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //  [addBtn addTarget:self action:@selector(addbtnTouched) forControlEvents:UIControlEventTouchUpInside];
    [emptyView addSubview:addBtn];
    self.tableView.tableFooterView = emptyView;
}
-(void)addEmptyViewWithImg:(NSString *)img
{
    if( img == nil )
        img = @"ic_empty";
    
    if (emptyView) {
        [self.tableView addSubview:emptyView];
        if (self.tableView == nil) {
            emptyView.frame = CGRectMake(0, 64, DEVICE_Width, 200);
            [self.view addSubview:emptyView];
            
        }
        
        return;
    }
    
    emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_Width, 300)];
    emptyView.backgroundColor = [UIColor clearColor];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(emptyView.bounds.size.width / 2-50, emptyView.frame.size.height / 2-40, 100, 100)];
    //    image.center = CGPointMake(emptyView.bounds.size.width / 2, emptyView.frame.size.height / 2-40) ;
    image.image = [UIImage imageNamed:img];
    [emptyView addSubview:image];
    
    //    UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 250, 60)];
    //    [addBtn setCenter:CGPointMake(emptyView.bounds.size.width / 2, emptyView.frame.size.height / 2+20)];
    //    [addBtn setTitle:str forState:UIControlStateNormal];
    //    [addBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //    [emptyView addSubview:addBtn];
    //
    self.tableView.tableFooterView = emptyView;
    
}
- (void)addKEmptyView:(NSString *)view{
    if ( view == nil) {
        
        view = @"ic_empty";
        
    }
    
    self.tableView.hidden = YES;
    
    emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, 120, DEVICE_Width, 200)];
    emptyView.backgroundColor = [UIColor clearColor];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(150, 140, 140, 105)];
    image.center = CGPointMake(emptyView.bounds.size.width / 2, emptyView.frame.size.height / 2-20) ;
    image.image = [UIImage imageNamed:view];
    [emptyView addSubview:image];
    
    [self.view addSubview:emptyView];
    
}

- (void)removeEmptyView2{
    self.tableView.hidden = NO;
    [emptyView removeFromSuperview];
}

- (void)hiddenEmptyView{
    
    emptyView.hidden = YES;
    
}

-(void)removeEmptyView
{
    if (emptyView) {
        self.tableView.tableFooterView = nil;
        emptyView = nil;
    }
    emptyView.hidden = YES;
    
}



-(void)setRightBtnImage:(UIImage *)rightImage
{
    [self.navBar.rightBtn setTitle:nil forState:UIControlStateNormal];
    [self.navBar.rightBtn setImage:rightImage forState:UIControlStateNormal];
}
-(void)setRightBtnWidth:(CGFloat)size              //setRightBtnWidth Set方法
{
    self.navBar.rightBtn.frame = CGRectMake(DEVICE_Width-size+10, 27, size, 31);
}
-(void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)popViewController_2
{
    NSMutableArray* vcs = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    if( vcs.count > 2 )
    {
        [vcs removeLastObject];
        [vcs removeLastObject];
        [self.navigationController setViewControllers:vcs   animated:YES];
    }
    else
        [self popViewController];
}
-(void)popViewController_3
{
    NSMutableArray* vcs = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    if( vcs.count > 2 )
    {
        [vcs removeLastObject];
        [vcs removeLastObject];
        [vcs removeLastObject];
        [self.navigationController setViewControllers:vcs   animated:YES];
    }
    else
        [self popViewController];
}
- (void)popViewController:(int)whatYouWant{
    NSMutableArray* vcs = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    
    if (whatYouWant == 1) {
        [self popViewController];
    }else if (whatYouWant == 2){
        [self popViewController_2];
    }else if (whatYouWant == 3){
        [self popViewController_3];
    }else if (whatYouWant == 4){
        [vcs removeLastObject];
        [vcs removeLastObject];
        [vcs removeLastObject];
        [vcs removeLastObject];
        [self.navigationController setViewControllers:vcs   animated:YES];
    }
}


/**
 *  模态跳转返回上一级
 */
- (void)dismissViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
/**
 *  模态跳转返回上二级
 */
- (void)dismissViewController_2{
    self.presentingViewController.view.alpha = 0;
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  模态跳转返回上三级
 */
- (void)dismissViewController_3{
    self.presentingViewController.view.alpha = 0;
    [self.presentingViewController.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  模态跳转返回上n级
 */
- (void)dismissViewController:(int)whatYouWant{
    self.presentingViewController.view.alpha = 0;
    [self.presentingViewController.presentingViewController.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)popToRootViewController{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)pushViewController:(UIViewController *)vc{
    if( [vc isKindOfClass:[BaseVC class] ] )
    {
        if( ((BaseVC*)vc).isMustLogin )
        {
            
        }
        else
            
            [self.navigationController pushViewController:vc animated:YES];
    }
    else
        
        [self.navigationController pushViewController:vc animated:YES];
}

- (void)presentModalViewController:(UIViewController *)vc{
    if( [vc isKindOfClass:[BaseVC class] ] )
    {
        if( ((BaseVC*)vc).isMustLogin )
        {
            
        }
        else
            
            [self presentViewController:vc animated:YES completion:nil];
    }
    else
        
        [self presentViewController:vc animated:YES completion:nil];
}



-(void)setToViewController:(UIViewController *)vc
{
    NSMutableArray* vcs = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    [vcs removeLastObject];
    [vcs addObject:vc];
    [self.navigationController setViewControllers:vcs   animated:YES];
    
}
-(void)setToViewController_2:(UIViewController *)vc
{
    NSMutableArray* vcs = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    [vcs removeLastObject];
    if( vcs.count )
        [vcs removeLastObject];//把上一级也删除了
    
    [vcs addObject:vc];
    [self.navigationController setViewControllers:vcs   animated:YES];
}

-(void)showWithStatus:(NSString *)str //调用svprogresssview加载框 参数：加载时显示的内容
{
    [SVProgressHUD showWithStatus:str maskType:SVProgressHUDMaskTypeClear];
}
-(void)dismiss //隐藏svprogressview
{
    [SVProgressHUD dismiss];
}
-(void)showSuccessStatus:(NSString *)str//展示成功状态svprogressview
{
    [SVProgressHUD showSuccessWithStatus:str];
}
-(void)showErrorStatus:(NSString *)astr//展示失败状态svprogressview
{
    [SVProgressHUD showErrorWithStatus:astr];
}
-(void)didSelectBtn:(NSInteger)tag
{
    
    
    switch (tag) {
        case 0:
            if (self.tabBarController.selectedIndex == 0) {
                
                return;
                
            }
            else
                self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:0];
            break;
        case 1:
            if (self.tabBarController.selectedIndex == 1) {
                return;
            }
            else
                
                self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
            break;
        case 2:
            if (self.tabBarController.selectedIndex == 2) {
                return;
            }
            else
                self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:2];
            break;
        case 3:
            if (self.tabBarController.selectedIndex == 3) {
                return;
            }
            else
                self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:3];
            break;
        default:
            break;
    }
    /*
     CATransition *animation =[CATransition animation];
     [animation setDuration:0.5f];
     [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
     [animation setType:kCATransitionFade];
     [animation setSubtype:kCATransitionFade];
     [self.view.layer addAnimation:animation forKey:@"change"];
     */
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)gotoLoginVC
{
    //    LoginVC *vclog = [[LoginVC alloc]init];
    //    [self pushViewController:vclog];//LoginVC,RegisterVC 里面的isMustLogin 一定不能设置了,否则递归
    
    if( [self.navigationController.topViewController isKindOfClass:[ViewController class]] )
    {
        return;
    }
    
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    id viewController = [storyboard instantiateViewControllerWithIdentifier:@"login"];
    
    [self presentViewController:viewController animated:YES completion:nil];
    //    [self.navigationController pushViewController:viewController animated:YES];
    
}


//设置跟随滚动的滑动试图
-(void)followRollingScrollView:(UIView *)scrollView
{
    self.scrollView = scrollView;
    
    self.panGesture = [[UIPanGestureRecognizer alloc] init];
    self.panGesture.delegate=self;
    self.panGesture.minimumNumberOfTouches = 1;
    [self.panGesture addTarget:self action:@selector(handlePanGesture:)];
    [self.scrollView addGestureRecognizer:self.panGesture];
    
    self.overLay = [[UIView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    self.overLay.alpha=0;
    self.overLay.backgroundColor=self.navigationController.navigationBar.barTintColor;
    [self.navigationController.navigationBar addSubview:self.overLay];
    [self.navigationController.navigationBar bringSubviewToFront:self.overLay];
}

#pragma mark - 兼容其他手势
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark - 手势调用函数
-(void)handlePanGesture:(UIPanGestureRecognizer *)panGesture
{
    CGPoint translation = [panGesture translationInView:[self.scrollView superview]];
    
    //显示
    if (translation.y >= 5) {
        if (self.isHidden) {
            
            self.overLay.alpha=0;
            CGRect navBarFrame=NavBarFrame;
            CGRect scrollViewFrame=self.scrollView.frame;
            
            navBarFrame.origin.y = 20;
            scrollViewFrame.origin.y += 44;
            scrollViewFrame.size.height -= 44;
            
            [UIView animateWithDuration:0.2 animations:^{
                NavBarFrame = navBarFrame;
                self.scrollView.frame=scrollViewFrame;
                
            }];
            self.isHidden= NO;
        }
    }
    
    //隐藏
    if (translation.y <= -20) {
        if (!self.isHidden) {
            CGRect frame =NavBarFrame;
            CGRect scrollViewFrame=self.scrollView.frame;
            frame.origin.y = -24;
            scrollViewFrame.origin.y -= 44;
            scrollViewFrame.size.height += 44;
            
            [UIView animateWithDuration:0.2 animations:^{
                NavBarFrame = frame;
                self.scrollView.frame=scrollViewFrame;
                
            } completion:^(BOOL finished) {
                self.overLay.alpha=1;
            }];
            self.isHidden=YES;
        }
    }
    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    MLLog(@"------>来没来？");
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    MLLog(@"<------来没来？");
    
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if( self.navigationController.viewControllers.count == 1 )  return NO;
    return YES;
}

#pragma mark----加载空视图
- (void)ShowEmptyViewWithTitle:(NSString *)mTitle andImg:(UIImage *)mImg andIsHiddenBtn:(BOOL)mHidden andHaveTabBar:(BOOL)mIsTabbar{
    
    
    CGFloat mHH;
    
    if (mIsTabbar) {
        mHH = 114;
    }else{
        mHH = 64;
    }
    
    
    mEmptyView = [mGeneryEmptyView shareView];
    
    mEmptyView.alpha = 1;
    
    if (mTitle) {
        mEmptyView.mEmptyTitle.text = mTitle;
    }
    if (mImg) {
        mEmptyView.mEmptyImg.image = mImg;
    }
    
    
    mEmptyView.mEmptyBtn.hidden = mHidden;
    
    [mEmptyView.mEmptyBtn addTarget:self action:@selector(mReloadAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:mEmptyView];
    
    [mEmptyView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(@0);
        make.bottom.equalTo(self.view).offset(DEVICE_Height-mHH);
        make.top.equalTo(self.view).offset(@64);
    }];
    
    
    
    
}


- (void)mReloadAction:(UIButton *)sender{
    [self DissMissEmptyView];
    [self headerBeganRefresh];
}

#pragma mark----隐藏空视图
- (void)DissMissEmptyView{
    
    
    [UIView animateWithDuration:0.25 animations:^{
        
        mEmptyView.alpha = 0;
        [mEmptyView removeFromSuperview];
        
    }];
    
    
}

@end
