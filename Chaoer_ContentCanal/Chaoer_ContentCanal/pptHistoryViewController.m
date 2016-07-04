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
{

    int mLeft;
    int mRight;
    
    NSMutableArray *mDataArray;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *mTT = nil;
    if (self.mType == 1) {
        mTT = @"跑腿纪录";
        self.hiddenRightBtn = YES;
        self.rightBtnTitle = @"历史纪录";
        [self setRightBtnWidth:100];
        
    }else{
        
        mTT = @"历史纪录";
        self.hiddenRightBtn = YES;
        
        
    }
    self.Title = self.mPageName = mTT;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    
    mLeft = 1;
    mRight = 1;
    
    mDataArray = [NSMutableArray new];
    
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
            item.itemid = [NSString stringWithFormat:@"%d",i+1];
            item.itemtitle = weakSelf.leftArray[i];
            [arrayM addObject:item];
        }
        
        MCPopMenuViewController *popVc = [[MCPopMenuViewController alloc] initWithDataSource:arrayM fromView:weakSelf.topView];
        [popVc show];
        popVc.didSelectedItemBlock = ^(MCPopMenuItem *item){
            
            [weakSelf.levelButton refreshWithTitle:item.itemtitle];
            weakSelf.levelButton.extend = item;
            
            mLeft = [[NSString stringWithFormat:@"%@",item.itemid] intValue];
            [weakSelf headerBeganRefresh];

        };
        
    };
    
    //点击等级
    self.groupButton.clickedBlock = ^(id data){
        
        NSMutableArray *arrayM = [NSMutableArray array];
        
        for (int i = 0 ; i < self.rightArray.count ; i++ ) {
            
            MCPopMenuItem *item = [[MCPopMenuItem alloc] init];
            item.itemid = [NSString stringWithFormat:@"%d",i+1];
            item.itemtitle = weakSelf.rightArray[i];
            [arrayM addObject:item];
        }
        
        MCPopMenuViewController *popVc = [[MCPopMenuViewController alloc] initWithDataSource:arrayM fromView:weakSelf.topView];
        [popVc show];
        popVc.didSelectedItemBlock = ^(MCPopMenuItem *item){
            
            [weakSelf.groupButton refreshWithTitle:item.itemtitle];
            weakSelf.groupButton.extend = item;
            mRight = [[NSString stringWithFormat:@"%@",item.itemid] intValue];
            [weakSelf headerBeganRefresh];

        };
    };
}

- (void)initView{
    [self loadTableView:CGRectMake(0, 104, DEVICE_Width, DEVICE_Height-104) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.haveHeader = YES;
    self.haveFooter = YES;
    
    UINib   *nib = [UINib nibWithNibName:@"pptHistoryTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    
}

- (void)headerBeganRefresh{

    
    MLLog(@"左边：%d右边：%d",mLeft,mRight);
    
    self.page = 1;
    
    [[mUserInfo backNowUser] getPPTOrderHisTory:mLeft andRight:mRight and:self.page andNum:10 block:^(mBaseData *resb, NSArray *mArr) {
        
        [self headerEndRefresh];
        [self removeEmptyView];
        [mDataArray removeAllObjects];
        [self.tableView reloadData];
        if (resb.mSucess) {
            
            if (mArr.count <= 0) {
                [self addEmptyView:nil];
            }else{
            
                [mDataArray addObjectsFromArray:mArr];
            }
            [self.tableView reloadData];
        }else{
            [self addEmptyView:nil];
            [self showErrorStatus:resb.mMessage];
        }
        
        
    }];
    
    
}

- (void)footetBeganRefresh{

    self.page ++;
    
    [[mUserInfo backNowUser] getPPTOrderHisTory:mLeft andRight:mRight and:self.page andNum:10 block:^(mBaseData *resb, NSArray *mArr) {
        
        [self footetEndRefresh];
        [self removeEmptyView];
        
        if (resb.mSucess) {
            
            if (mArr.count <= 0) {
                [self addEmptyView:nil];
            }else{
                
                [mDataArray addObjectsFromArray:mArr];
            }
            [self.tableView reloadData];
        }else{
            [self addEmptyView:nil];
            [self showErrorStatus:resb.mMessage];
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
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return mDataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    return 100;
  
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *reuseCellId = nil;
    reuseCellId = @"cell";

    GPPTOrder *mOrder = mDataArray[indexPath.row];
    
    pptHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    cell.mStatus.text = mOrder.mStatusName;
    
    [cell.mImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[HTTPrequest currentResourceUrl],mOrder.mPortrait]] placeholderImage:[UIImage imageNamed:@"img_default"]];

    
    if (mOrder.mProcessStatus == 0) {
        /**
         *  取消
         */
        
        [cell.mRateBtn setTitle:@"取消订单" forState:0];
        cell.mRateBtn.enabled = NO;
        
        
        
    }else if (mOrder.mProcessStatus == 1){
        /**
         *  发布
         */
        [cell.mRateBtn setTitle:@"已发布" forState:0];
        cell.mRateBtn.enabled = NO;
        
    }else if (mOrder.mProcessStatus == 2){
        /**
         *  进行中
         */
        [cell.mRateBtn setTitle:@"订单进行中" forState:0];
        
        cell.mRateBtn.enabled = NO;
    }else if (mOrder.mProcessStatus == 3){
        /**
         *  确认订单
         */
        [cell.mRateBtn setTitle:@"订单已被确认" forState:0];
        cell.mRateBtn.enabled = NO;
    }else if (mOrder.mProcessStatus == 4){
        /**
         *  确定完成
         */
        [cell.mRateBtn setTitle:@"确认完成" forState:0];
        
        cell.mRateBtn.enabled = YES;
        [cell.mRateBtn addTarget:self action:@selector(finishOrderAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        /**
         *  评价
         */
        cell.mRateBtn.enabled = NO;
        [cell.mRateBtn addTarget:self action:@selector(mRateAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }

    

    if (mOrder.mComments == nil) {
        mOrder.mComments = @"创建时间";
    }
   
    
    if (mRight == 1) {
        
        cell.mNameAndTime.text = [NSString stringWithFormat:@"%@-%@",mOrder.mContext,mOrder.mGenTime];
        cell.mContent.text = mOrder.mComments;
        cell.mMoney.text = [NSString stringWithFormat:@"酬金:%@¥",mOrder.mLegworkMoney];
        cell.mDistanceAndTime.text = [NSString stringWithFormat:@"%@分钟",mOrder.mArrivedTime];
        
    }else if (mRight == 2){
        if (mOrder.mContext == nil) {
            mOrder.mContext = @"创建时间";
        }
        cell.mNameAndTime.text = [NSString stringWithFormat:@"%@-%@",mOrder.mContext,mOrder.mGenTime];
        cell.mContent.text = mOrder.mContext;
        cell.mMoney.text = [NSString stringWithFormat:@"酬金:%@¥",mOrder.mLegworkMoney];
        cell.mDistanceAndTime.text = @"";
    }else{
        if (mOrder.mGoodsName == nil) {
            mOrder.mGoodsName = @"创建时间";
        }
        cell.mNameAndTime.text = [NSString stringWithFormat:@"%@-%@",mOrder.mGoodsName,mOrder.mGenTime];
        cell.mContent.text = mOrder.mContext;
        cell.mMoney.text = [NSString stringWithFormat:@"酬金:%@¥",mOrder.mLegworkMoney];
        cell.mDistanceAndTime.text = [NSString stringWithFormat:@"商品类型：%@",@"买东西"];
    }
    
    

    return cell;
    


}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GPPTOrder *mOrder = mDataArray[indexPath.row];

    pptOrderDetailViewController *ppp = [[pptOrderDetailViewController alloc] initWithNibName:@"pptOrderDetailViewController" bundle:nil];
    ppp.mOrderType = 2;
    ppp.mType = mRight;
    ppp.mOrder = GPPTOrder.new;
    ppp.mOrder = mOrder;
    ppp.mLng = self.mLng;
    ppp.mLat = self.mLat;
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
#pragma mark----完成订单
- (void)finishOrderAction:(UIButton *)sender{
    
}
@end
