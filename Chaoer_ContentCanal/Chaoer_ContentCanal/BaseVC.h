//
//  BaseVC.h
//  testBase
//
//  Created by ljg on 15-2-27.
//  Copyright (c) 2015年 ljg. All rights reserved.
//
#import "NavBar.h"
#import "MJRefresh.h"
#import "TabBar.h"
#import "ContentScrollView.h"

@interface BaseVC : UIViewController<NavBarDelegate,TabBarDelegate>

@property (nonatomic,strong) NSString *mShopName;

@property (nonatomic,assign)BOOL  isStoryBoard;
@property (nonatomic,strong)    NSString* mPageName;
@property (nonatomic,strong) NavBar *navBar;
@property (nonatomic,strong)ContentScrollView *contentView;
@property (nonatomic,assign)BOOL  hiddenTabBar;         //是否需要tabbar 必须写在[super loadview]之前
@property (nonatomic,assign)BOOL  hiddenNavBar;         //是否需要navbar 同上
@property (nonatomic,assign)BOOL  hiddenBackBtn;        //是否需要navbar 同上

@property (nonatomic,assign)BOOL  hiddenRightBtn;        //是否需要navbar 同上
@property (nonatomic,assign)BOOL  hiddenlll;        //是否需要navbar 同上

@property (nonatomic,assign)BOOL  hiddenA;        //是否需要navbar 同上
@property (nonatomic,assign)BOOL  hiddenB;        //是否需要navbar 同上

/**
 *  navbar左边按钮titele
 */
@property (nonatomic,strong) NSString *leftBtnTitle;
@property (nonatomic,strong) NSString *rightBtnTitle;   //navbar右边按钮title
@property (nonatomic,strong) NSString *ABtnTitle;   //navbar右边按钮title
@property (nonatomic,strong) NSString *BBtnTitle;   //navbar右边按钮title

@property (nonatomic,strong) NSString *Title;           //navbartitle
@property (nonatomic,strong) UIImage *rightBtnImage;    //navbarimage
@property (nonatomic,assign) BOOL haveHeader;           //navbarimage
@property (nonatomic,assign) BOOL haveFooter;           //navbarimage
@property (nonatomic,strong) UITableView *tableView;    //navbartitle
@property (nonatomic,strong)    NSMutableArray *tempArray; //tableview存储数据数组
@property (nonatomic,assign)   int  page;               //tableview翻页
@property (nonatomic,strong) TabBar *tabBar;            //tabbar
@property (nonatomic,assign)    BOOL    isMustLogin;//不需要登陆就可以进入该页面,否则就先跳转到登陆界面,pushViewController里面判断的
-(void)addNotifacationStatus:(NSString *)str;   
-(void)removeNotifacationStatus;
-(void)leftBtnTouched:(id)sender;                       //左边navbar事件
-(void)rightBtnTouched:(id)sender;                      //右边navbar事件

-(void)ATouched:(id)sender;                       //左边navbar事件
-(void)BTouched:(id)sender;                      //右边navbar事件

-(void)setABtnTitle:(NSString *)ABtnTitle;                //RightBtntitle Set方法
-(void)setBBtnTitle:(NSString *)BBtnTitle;                //RightBtntitle Set方法

-(void)setHiddenABtn:(BOOL)hiddenA;
-(void)setHiddenBBtn:(BOOL)hiddenB;
-(void)setHiddenRightBtn:(BOOL)hiddenRightBtn;
-(void)setHiddenlll:(BOOL)hiddenlll;



-(void)setTitle:(NSString *)test;                       //title Set方法
/**
 *  leftbtntitleset方法
 *
 *  @param str
 */
-(void)setLeftBtnTitle:(NSString *)str;
-(void)setRightBtnTitle:(NSString *)str;                //RightBtntitle Set方法
-(void)setRightBtnImage:(UIImage *)rightImage;          //RightBtnimage Set方法
-(void)popViewController;                               //返回上个controller
-(void)popViewController_2;                             //返回上上个controller
/**
 *  返回上上上个controller
 */
- (void)popViewController_3;
/**
 *  想返回哪几个上级controller
 *
 *  @param whatYouWant 上级页面个数
 */
- (void)popViewController:(int)whatYouWant;


/**
 *  模态跳转返回上一级
 */
- (void)dismissViewController;
/**
 *  模态跳转返回上二级
 */
- (void)dismissViewController_2;
/**
 *  模态跳转返回上三级
 */
- (void)dismissViewController_3;
/**
 *  模态跳转返回上n级
 */
- (void)dismissViewController:(int)whatYouWant;


-(void)popToRootViewController;                         //返回rootController
-(void)pushViewController:(UIViewController *)vc;       //跳转到某个controller
/**
 *  模态跳转方法
 *
 *  @param vc 跳转的viewcontroller
 */
- (void)presentModalViewController:(UIViewController *)vc;
-(void)setToViewController:(UIViewController *)vc;       //直接设置过去
-(void)setToViewController_2:(UIViewController *)vc;     //直接设置过去,并且把上一级也移除了

-(void)headerBeganRefresh;                              //header刷新
-(void)footetBeganRefresh;                              //footer刷新
-(void)headerEndRefresh;                                //header停止刷新
-(void)footetEndRefresh;                                //footer停止刷新

/**
 *  header数据
 */
-(void)headerData;
/**
 *  footer数据
 */
-(void)footerData;

-(void)loadTableView:(CGRect)rect delegate:(id<UITableViewDelegate>)delegate dataSource:(id<UITableViewDataSource>)datasource;
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;//tableview代理 用来在没数据的情况下隐藏分割线
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;//同上
/**
 *  是否顶部刷新
 *
 *  @param haveHeader yes or no
 */
-(void)setHaveHeader:(BOOL)haveHeader;
/**
 *  是否底部刷新
 *
 *  @param haveFooter yes or no
 */
-(void)setHaveFooter:(BOOL)haveFooter;
-(void)setHiddenBackBtn:(BOOL)hiddenBackBtn;
-(void)addEmptyView:(NSString *)str;                    //空数据添加view 参数:需要显示得内容
-(void)addEmptyViewWithImg:(NSString *)img;
-(void)removeEmptyView;                                 //移除空数据view
-(void)showWithStatus:(NSString *)str;                  //调用svprogresssview加载框 参数：加载时显示的内容
-(void)dismiss;                                         //隐藏svprogressview
-(void)showSuccessStatus:(NSString *)str;               //展示成功状态svprogressview 参数:成功状态显示字符串
-(void)showErrorStatus:(NSString *)astr;                 //展示失败状态svprogressview 参数:失败状态显示字符串
-(void)checkUserGinfo;
//加载tabview

-(void)gotoLoginVC;

-(void)setRightBtnWidth:(CGFloat)size;              //setRightBtnWidth Set方法

- (void)addKEmptyView:(NSString *)view;
- (void)removeEmptyView2;
- (void)hiddenEmptyView;

-(void)followRollingScrollView:(UIView *)scrollView;


#pragma maek----空view
/**
 *  显示空view
 *
 *  @param mTitle  标题
 *  @param mImg    图片
 *  @param mHidden 是否隐藏按钮
 *  @param mHight  高度
 */
- (void)ShowEmptyViewWithTitle:(NSString *)mTitle andImg:(UIImage *)mImg andIsHiddenBtn:(BOOL)mHidden andHaveTabBar:(BOOL)mIsTabbar;

#pragma maek----隐藏空view
- (void)DissMissEmptyView;



@end
