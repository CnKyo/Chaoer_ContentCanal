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

    mBarCodeView *mView;
    mBarCodeView *mShareView;
    
    BOOL isYes;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"我的二维码名片";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.rightBtnImage = [UIImage imageNamed:@"share_bgk"];
    [SVProgressHUD dismiss];
    [self initView];

    [self loadShareView];
    
    UITapGestureRecognizer *ttt = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:ttt];
    

}
- (void)initView{
    
    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.93 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    UINib   *nib = [UINib nibWithNibName:@"barCodeCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
}
- (void)loadShareView{
 
    
    mShareView = [mBarCodeView shareBottomView];
    
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
    MLLog(@"微信");
}

- (void)mTencent:(UIButton *)sender{
    MLLog(@"qq");
}
- (void)mWebo:(UIButton *)sender{
    MLLog(@"微博");
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
    
    UIButton *btn = sender;
    btn.selected = !btn.selected;
    btn.selected = !isYes;
    if (btn.selected) {
        [self shaowShareView];
        isYes = YES;
    }else{
        [self hiddenSahreView];
        isYes = NO;
    }
    
    
    
}

- (void)tap{

    [self hiddenSahreView];
    isYes = NO;
}

- (void)shaowShareView{

    [UIView animateWithDuration:0.35 animations:^{
        
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

    NSString *url = [NSString stringWithFormat:@"%@%@",[HTTPrequest currentResourceUrl],[mUserInfo backNowUser].mUserImgUrl];
    
    [cell.mHeader sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"icon_headerdefault"]];
    
    cell.mNickName.text = [mUserInfo backNowUser].mNickName;
    cell.mIdentify.text = [mUserInfo backNowUser].mIdentity;
    cell.mPhone.text = [mUserInfo backNowUser].mPhone;

    
    
    return cell;
    
    
    
}



@end
