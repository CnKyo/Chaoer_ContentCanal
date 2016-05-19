//
//  evolutionViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/7.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "evolutionViewController.h"
#import "MovieAddComment.h"
#import "complaintViewController.h"
@interface evolutionViewController ()<MoveViewDelagate>

@end

@implementation evolutionViewController
{
    UIScrollView *mScrollerView;
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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.Title = self.mPageName = @"评价";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.rightBtnTitle = @"投诉";
    [self initView];
}
- (void)initView{
    self.view.backgroundColor = [UIColor clearColor];
    
    mScrollerView = [UIScrollView new];
    mScrollerView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height);
    mScrollerView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
    [self.view addSubview:mScrollerView];
    
    [self loadData];
    
    
}

- (void)loadData{

    [self showWithStatus:@"正在加载..."];
    [[mUserInfo backNowUser] getSystemTags:^(mBaseData *resb, NSArray *mArr) {
        
        if (resb.mSucess) {
            
            [self dismiss];
            [self updatePage:mArr];
            
        }else{
            [self showErrorStatus:resb.mMessage];
            [self popViewController];
        }
    }];
    
    
}

- (void)updatePage:(NSArray *)mData{
    MovieAddComment *movie = [[MovieAddComment alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width,568) andArray:mData];
    movie.delegate = self;
    movie.mContent.placeholder = @"请输入您的评论";
    movie.mOrder = GPPTOrder.new;
    movie.mOrder = self.mOrder;
    movie.mLng = self.mLng;
    movie.mLat = self.mLat;
    movie.mType = self.mType;
    [mScrollerView addSubview:movie];
    
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 568);


}
#pragma mark----代理方法
- (void)isSucess:(BOOL)mSucess{

    if (mSucess) {
        [self popViewController_2];
    }else{
        [self showErrorStatus:@"评价失败，请重试！"];
        [self popViewController];
    }
    
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
- (void)rightBtnTouched:(id)sender{
    complaintViewController *ccc = [[complaintViewController alloc] initWithNibName:@"complaintViewController" bundle:nil];
    
    ccc.mType = self.mType;
    ccc.mOrder = GPPTOrder.new;
    ccc.mOrder = self.mOrder;
    
    [self pushViewController:ccc];
    
}
@end
