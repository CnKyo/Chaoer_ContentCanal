//
//  barCodeViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/5.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "barCodeViewController.h"
#import "mBarCodeView.h"
#import "barCodeCell.h"

@interface barCodeViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation barCodeViewController
{

    UIScrollView *mScrollerView;
    
    mBarCodeView *mView;
    mBarCodeView *mShareView;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"我的二维码名片";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.rightBtnImage = [UIImage imageNamed:@"share_bgk"];
    
//    [self initView];
    
    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.allowsSelection = YES;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.93 alpha:1.00];
    [self.view addSubview:self.tableView];

    UINib   *nib = [UINib nibWithNibName:@"barCodeCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    
    [self loadShareView];
    
    UITapGestureRecognizer *ttt = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:ttt];
    

}
#pragma mark----构造主页面
- (void)initView{
    
    mScrollerView = [UIScrollView new];
    mScrollerView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64);
    mScrollerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mScrollerView];

    
    mView = [mBarCodeView shareView];
    mView.frame = CGRectMake(0, 0, DEVICE_Width, 600);
    NSString *url = [NSString stringWithFormat:@"%@%@",[HTTPrequest returnNowURL],[mUserInfo backNowUser].mUserImgUrl];

    [mView.mHeader sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"icon_headerdefault"]];
    
    mView.mNickName.text = [mUserInfo backNowUser].mNickName;
    mView.mIdentify.text = [mUserInfo backNowUser].mIdentity;
    mView.mPhone.text = [mUserInfo backNowUser].mPhone;
    
    [mScrollerView addSubview:mView];
    
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 590);
    
    
}

- (void)loadShareView{
 
    
    mShareView = [mBarCodeView shareBottomView];
    mShareView.frame = CGRectMake(0, DEVICE_Height, DEVICE_Width, 80);
    
    [mShareView.mShareWechat addTarget:self action:@selector(mWechat:) forControlEvents:UIControlEventTouchUpInside];
    [mShareView.mShareTencent addTarget:self action:@selector(mTencent:) forControlEvents:UIControlEventTouchUpInside];
    [mShareView.mShareWebo addTarget:self action:@selector(mWebo:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:mShareView];
    [mShareView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(@0);
        make.top.equalTo(self.view).offset(DEVICE_Height);
        make.height.offset(@80);
    }];
}


- (void)mWechat:(UIButton *)sender{
    NSLog(@"微信");
}

- (void)mTencent:(UIButton *)sender{
    NSLog(@"qq");
}
- (void)mWebo:(UIButton *)sender{
    NSLog(@"微博");
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
    [self shaowShareView];
    
}

- (void)tap{

    [self hiddenSahreView];
}

- (void)shaowShareView{

    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect rrr = mShareView.frame;
        rrr.origin.y = DEVICE_Height-80;
        mShareView.frame = rrr;
        
    }];
    
}

- (void)hiddenSahreView{
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect rrr = mShareView.frame;
        rrr.origin.y = DEVICE_Height;
        mShareView.frame = rrr;
        
    }];
}

#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 609;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    NSString *reuseCellId = @"cell";
    
    
    barCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    NSString *url = [NSString stringWithFormat:@"%@%@",[HTTPrequest returnNowURL],[mUserInfo backNowUser].mUserImgUrl];
    
    [cell.mHeader sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"icon_headerdefault"]];
    
    cell.mNickName.text = [mUserInfo backNowUser].mNickName;
    cell.mIdentify.text = [mUserInfo backNowUser].mIdentity;
    cell.mPhone.text = [mUserInfo backNowUser].mPhone;

    
    
    return cell;
    
    
    
}



@end
