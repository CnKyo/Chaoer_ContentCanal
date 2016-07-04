//
//  myRedBagViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "myRedBagViewController.h"

#import "redBagTableViewCell.h"

#import "mRedBagHeader.h"
@interface myRedBagViewController ()<UITableViewDelegate,UITableViewDataSource,WKSegmentControlDelagate>

@end

@implementation myRedBagViewController
{
    mRedBagHeader *mHeaderView;
    
    UITableView *mTableView;
    
    UIView *mHeader;
    
    WKSegmentControl    *mSegmentView;
    
    NSString *mTypr;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self headerBeganRefresh];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"我的红包";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    mTypr = @"1";
    [self initViuew];
}
- (void)initViuew{

    NSString *url = [NSString stringWithFormat:@"%@%@",[HTTPrequest currentResourceUrl],[mUserInfo backNowUser].mUserImgUrl];

    mHeaderView = [mRedBagHeader shareView];
    [mHeaderView.mHeaderBtn sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"img_default"]];
    mHeaderView.mName.text = [mUserInfo backNowUser].mNickName;
    mHeaderView.mDEtail.text = [mUserInfo backNowUser].mIdentity;
    [self.view addSubview:mHeaderView];
    
    [mHeaderView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(@0);
        make.top.equalTo(self.view).offset(@64);
        make.height.offset(@100);
    }];


    UIView *vvv= [UIView new];
    vvv.frame = CGRectMake(0, 164, DEVICE_Width, 1);
    vvv.backgroundColor = [UIColor colorWithRed:0.93 green:0.94 blue:0.96 alpha:1.00];
    [self.view addSubview:vvv];
    
    mSegmentView = [WKSegmentControl initWithSegmentControlFrame:CGRectMake(0, 165, DEVICE_Width, 40) andTitleWithBtn:@[@"收到的红包", @"发出的红包"] andBackgroudColor:[UIColor whiteColor] andBtnSelectedColor:M_CO andBtnTitleColor:M_TextColor1 andUndeLineColor:M_CO andBtnTitleFont:[UIFont systemFontOfSize:15] andInterval:70 delegate:self andIsHiddenLine:NO andType:1];
    
    [self.view addSubview:mSegmentView];
    
    
    [self loadTableView:CGRectMake(0,mSegmentView.mbottom, DEVICE_Width, DEVICE_Height-mSegmentView.mbottom) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.93 green:0.94 blue:0.96 alpha:1.00];

    self.haveHeader = YES;
    
    UINib   *nib = [UINib nibWithNibName:@"redBagTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    
}
- (void)WKDidSelectedIndex:(NSInteger)mIndex{
    MLLog(@"点击了%lu",(unsigned long)mIndex);
    if (mIndex == 0) {
        mTypr = @"1";
        [self headerBeganRefresh];
    }else{
        mTypr = @"2";
        [self headerBeganRefresh];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)headerBeganRefresh{
//    [SVProgressHUD showWithStatus:@"正在加载..." maskType:SVProgressHUDMaskTypeClear];
    
    [mUserInfo getRedBag:[mUserInfo backNowUser].mUserId andType:mTypr block:^(mBaseData *resb, NSArray *marray) {
        [self headerEndRefresh];
        [self removeEmptyView];
        [self.tempArray removeAllObjects];
        [SVProgressHUD dismiss];
        if (resb.mSucess) {
            
            if (marray.count <= 0) {
                [self addEmptyViewWithImg:nil];
            }else{
                [self.tempArray addObjectsFromArray:marray];
            }
            [self.tableView reloadData];

            
            
        }else{

            [self addEmptyViewWithImg:nil];

        }
        
    }];

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
    
    return self.tempArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    SRedBag *mRedBag = self.tempArray[indexPath.row];
    
    redBagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];

    cell.mName.text = mRedBag.mName;
    cell.mMoney.text = [NSString stringWithFormat:@"%.2f元",mRedBag.mMoney];
    
    return cell;
    
}

@end
