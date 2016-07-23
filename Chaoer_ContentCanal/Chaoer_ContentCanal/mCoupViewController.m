
//
//  mCoupViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/6/24.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mCoupViewController.h"

#import "coupTableViewCell.h"

#import "exchangeCoupView.h"
@interface mCoupViewController ()<UITableViewDelegate,UITableViewDataSource,WKSegmentControlDelagate,wkCoupCellDidSelected>


@end

@implementation mCoupViewController
{

    WKSegmentControl    *mSegmentView;
    int mType;
    
    
    exchangeCoupView *mPopView;
}
@synthesize mSType;
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
    self.hiddenTabBar = YES;
    
    [super viewDidLoad];
    
    self.hiddenRightBtn = NO;
    self.hiddenlll = YES;
    self.Title = self.mPageName = @"我的优惠券";
    self.rightBtnTitle = @"兑换";
    mType = 0;
    [self initView];
    [self initPopView];
}
- (void)initView{
    
    
    
    [self loadTableView:CGRectMake(0, 0, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
    
    
    self.haveHeader = YES;
    self.haveFooter = YES;
    
    
    UINib   *nib = [UINib nibWithNibName:@"coupTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    mSegmentView = [WKSegmentControl initWithSegmentControlFrame:CGRectMake(0, 165, DEVICE_Width, 40) andTitleWithBtn:@[@"未使用", @"已过期",@"已使用"] andBackgroudColor:[UIColor whiteColor] andBtnSelectedColor:M_CO andBtnTitleColor:M_TextColor1 andUndeLineColor:M_CO andBtnTitleFont:[UIFont systemFontOfSize:15] andInterval:20 delegate:self andIsHiddenLine:NO andType:1];
}

- (void)headerBeganRefresh{

    self.page = 1;
    
    [[mUserInfo backNowUser] getCoupList:self.page andStats:mType block:^(mBaseData *resb, NSArray *mArr) {
        [self headerEndRefresh];
        [self dismiss];
        [self.tempArray removeAllObjects];
        [self removeEmptyView];
        if (resb.mSucess) {
            
            
            if (mArr.count <= 0) {
                [self addEmptyView:nil];
            }else{
            
                [self.tempArray addObjectsFromArray:mArr];
            }
            [self.tableView reloadData];

        }else{
        
            [self showErrorStatus:resb.mMessage];
            [self addEmptyView:nil];
        }
        
    }];
}
- (void)footetBeganRefresh{

    self.page ++;
    
    [[mUserInfo backNowUser] getCoupList:self.page andStats:mType block:^(mBaseData *resb, NSArray *mArr) {
        [self footetEndRefresh];
        [self dismiss];
        [self removeEmptyView];
        if (resb.mSucess) {
            
            
            if (mArr.count <= 0) {
                [self addEmptyView:nil];
            }else{
                
                [self.tempArray addObjectsFromArray:mArr];
            }
            [self.tableView reloadData];

        }else{
            
            [self showErrorStatus:resb.mMessage];
            [self addEmptyView:nil];
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
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    return mSegmentView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.tempArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 170;
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellId = @"cell";
    
    
    GCoup *mCoup = self.tempArray[indexPath.row];
    
    coupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.mContent.text = [NSString stringWithFormat:@"%@%@",mCoup.mCoupName,mCoup.mCoupContent];
    cell.mMoney.text = [NSString stringWithFormat:@"¥%@",mCoup.mFacePrice];
   
    cell.mStore.text = mCoup.mShopName;
    cell.delegate = self;
    cell.mIndexPath = indexPath;
    [cell.mLogo sd_setImageWithURL:[NSURL URLWithString:mCoup.mShopLogo] placeholderImage:[UIImage imageNamed:@"img_default"]];
    
    UIImage *coupImg = nil;
    
    if ([mCoup.mCoupModel isEqualToString:@"red"]) {
        coupImg = [UIImage imageNamed:@"coup_red"];
    }else if ([mCoup.mCoupModel isEqualToString:@"blue"]){
        coupImg = [UIImage imageNamed:@"coup_blue"];
    }else{
        coupImg = [UIImage imageNamed:@"coup_green"];
    }
    
    cell.mBgkImg.image = coupImg;
    
    NSString *tt = nil;
    
    if (mCoup.mEndTime.length == 0) {
        tt = @"永久有效";
    }else{
        tt = [NSString stringWithFormat:@"过期时间:%@",mCoup.mEndTime];
    }
    
    cell.mTime.text = tt;
    
    
    if (mType == 1) {
        cell.mIsValid.image = [UIImage imageNamed:@"coup_ expire"];
        cell.mIsValid.hidden = NO;

    }else if (mType == 2){
        cell.mIsValid.image = [UIImage imageNamed:@"coup_beuse"];
        cell.mIsValid.hidden = NO;
    }else{
        cell.mIsValid.hidden = YES;
    }
    
    return cell;
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (void)WKDidSelectedIndex:(NSInteger)mIndex{
    MLLog(@"点击了%lu",(unsigned long)mIndex);
    
    mType = [[NSString stringWithFormat:@"%ld",(long)mIndex] intValue];
    [self headerBeganRefresh];
    
    
}

- (void)rightBtnTouched:(id)sender{
    [self showPopView];
    
}

#pragma mark----弹出兑换view
- (void)initPopView{


    mPopView = [exchangeCoupView shareView];
    mPopView.alpha = 0;
    mPopView.frame = self.view.bounds;
    [mPopView.mCancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [mPopView.mOkBtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mPopView];

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
    
}

- (void)cancelAction:(UIButton *)sender{
    [self dissmissPopView];
}

- (void)okAction:(UIButton *)sender{
    MLLog(@"兑换");
    if (mPopView.mTx.text.length == 0) {
        [self showErrorStatus:@"兑换码不能为空！"];
        [mPopView.mTx becomeFirstResponder];
        return;
    }
    
}
- (void)showPopView{

    [UIView animateWithDuration:0.3 animations:^{
        mPopView.alpha = 1;
    }];
    
}

- (void)dissmissPopView{
    [UIView animateWithDuration:0.3 animations:^{
        mPopView.alpha = 0;
    }];
    
}

- (void)tapAction:(UITapGestureRecognizer *)sender{

    [self dissmissPopView];
}

- (void)cellWithBtnClicked:(NSIndexPath *)mIndexPath{
    
    GCoup *mCoup = self.tempArray[mIndexPath.row];
    
    if (mSType != 2 ) {
        MLLog(@"你点他有啥用啊？");
        
    }else{
        if (mType == 0) {
            MLLog(@"点击了啥？");
            
            [self showWithStatus:@"正在操作中..."];
            [[mUserInfo backNowUser] useCoup:self.mShopId block:^(mBaseData *resb) {
                [self dismiss];
                if (resb.mSucess) {
                    self.block(mCoup.mCoupName,[NSString stringWithFormat:@"%d",mCoup.mCoupId],mCoup.mFacePrice);
                    
                    [self leftBtnTouched:nil];
                    
                }else{
                    [self showErrorStatus:resb.mMessage];
                    [self.tableView reloadData];
                }
            }];

            
        }
        
    }

    
}
@end
