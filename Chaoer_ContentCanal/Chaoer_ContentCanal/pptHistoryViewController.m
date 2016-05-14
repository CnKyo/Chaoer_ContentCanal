//
//  pptHistoryViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/13.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "pptHistoryViewController.h"
#import "pptHistoryTableViewCell.h"
#import "MCMenuButton.h"
#import "MCPopMenuViewController.h"
#import "pptOrderDetailViewController.h"

#import "evolutionViewController.h"
@interface pptHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>
/**
 *  头部筛选模块
 */
@property (nonatomic,strong,nonnull)UIView *topView;
@property (nonatomic,strong,nonnull)MCMenuButton *levelButton;
@property (nonatomic,strong,nonnull)MCMenuButton *groupButton;

@property (nonatomic,strong,nonnull)NSArray *leftArray;
@property (nonatomic,strong,nonnull)NSArray *rightArray;
@end

@implementation pptHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *mTT = nil;
    if (self.mType == 1) {
        mTT = @"跑腿纪录";
        self.hiddenRightBtn = NO;
        self.rightBtnTitle = @"历史纪录";
        [self setRightBtnWidth:100];
        
    }else{
        
        mTT = @"历史纪录";
        self.hiddenRightBtn = YES;
        
        
    }
    self.Title = self.mPageName = mTT;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;

 
    self.leftArray = @[@"发布跑单",@"接手跑单"];
    self.rightArray = @[@"商品买送",@"办理事情",@"我去跑腿"];
    [self setupTopView];

    
    [self initView];

}
/**
 *  设置头部
 */
- (void)setupTopView
{
    self.topView = [[UIView alloc] init];
    self.topView.backgroundColor = [UIColor whiteColor];
    self.topView.layer.masksToBounds = YES;
    self.topView.layer.borderColor = [UIColor colorWithRed:0.68 green:0.68 blue:0.68 alpha:1.00].CGColor;
    self.topView.layer.borderWidth = 0.5;
    
    self.topView.frame = CGRectMake(0, 64, DEVICE_Width, 40);
    
    [self.view addSubview:self.topView];
    
    
    
    // 这个之封装了 一个带有三角的按钮 ，至于他在什么位置，你可以随便设置，不需要使用这种sd 布局，其他的都可以，只是设置位置
    
    self.levelButton = [[MCMenuButton alloc] initWithTitle:@"发布跑单" titleStyle:TitleStyleDefault];
    self.levelButton.frame = CGRectMake(0, 0, DEVICE_Width/2, 40);
    
    [self.topView addSubview:self.levelButton];
    
    self.groupButton = [[MCMenuButton alloc] initWithTitle:@"商品买送"];
    self.groupButton.frame = CGRectMake(DEVICE_Width/2, 0, DEVICE_Width/2, 40);
    
    [self.topView addSubview:self.groupButton];

    __weak typeof(self) weakSelf = self;
    //点击等级
    self.levelButton.clickedBlock = ^(id data){
        
        NSMutableArray *arrayM = [NSMutableArray array];
        
        
        for (int i = 0 ; i < self.leftArray.count ; i++ ) {
            
            MCPopMenuItem *item = [[MCPopMenuItem alloc] init];
            item.itemid = @"0";
            item.itemtitle = weakSelf.leftArray[i];
            [arrayM addObject:item];
        }
        
        MCPopMenuViewController *popVc = [[MCPopMenuViewController alloc] initWithDataSource:arrayM fromView:weakSelf.topView];
        [popVc show];
        popVc.didSelectedItemBlock = ^(MCPopMenuItem *item){
            
            [weakSelf.levelButton refreshWithTitle:item.itemtitle];
            weakSelf.levelButton.extend = item;
            
        };
        
    };
    
    //点击等级
    self.groupButton.clickedBlock = ^(id data){
        
        NSMutableArray *arrayM = [NSMutableArray array];
        
        for (int i = 0 ; i < self.rightArray.count ; i++ ) {
            
            MCPopMenuItem *item = [[MCPopMenuItem alloc] init];
            item.itemid = @"0";
            item.itemtitle = weakSelf.rightArray[i];
            [arrayM addObject:item];
        }
        
        MCPopMenuViewController *popVc = [[MCPopMenuViewController alloc] initWithDataSource:arrayM fromView:weakSelf.topView];
        [popVc show];
        popVc.didSelectedItemBlock = ^(MCPopMenuItem *item){
            
            [weakSelf.groupButton refreshWithTitle:item.itemtitle];
            weakSelf.groupButton.extend = item;
            
        };
    };
}

- (void)initView{
    [self loadTableView:CGRectMake(0, 104, DEVICE_Width, DEVICE_Height-104) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //    self.haveHeader = YES;
    //    [self.tableView headerBeginRefreshing];
    
    UINib   *nib = [UINib nibWithNibName:@"pptHistoryTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    nib = [UINib nibWithNibName:@"pptHistoryTableViewCell2" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];

    
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
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (self.mType == 1) {
        return 100;
    }else{
        return 160;
    }
    
  
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *reuseCellId = nil;
    if (self.mType == 1) {
        reuseCellId = @"cell";

    }else{
        reuseCellId = @"cell2";

    }
    
    pptHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    [cell.mRateBtn addTarget:self action:@selector(mRateAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    


}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    pptOrderDetailViewController *ppp = [[pptOrderDetailViewController alloc] initWithNibName:@"pptOrderDetailViewController" bundle:nil];
    ppp.mOrderType = 2;
    ppp.mType = 3;
    [self pushViewController:ppp];
}

- (void)rightBtnTouched:(id)sender{

    pptHistoryViewController *ppt = [[pptHistoryViewController alloc] initWithNibName:@"pptHistoryViewController" bundle:nil];
    ppt.mType = 2;
    [self pushViewController:ppt];
    
}

- (void)mRateAction:(UIButton *)sender{

    evolutionViewController *eee = [[evolutionViewController alloc] initWithNibName:@"evolutionViewController" bundle:nil];
    [self pushViewController:eee];
}
@end
