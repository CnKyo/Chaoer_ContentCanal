//
//  hasCodeViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/22.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "hasCodeViewController.h"
#import "hasCodeTableViewCell.h"

@interface hasCodeViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation hasCodeViewController
{
    
    UITableView *mTableView;
    

    SVerifyMsg  *mVerify;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.89 green:0.90 blue:0.90 alpha:1.00];
    self.Title = self.mPageName = @"实名认证";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    [self initview];
}

- (void)initview{
    
    UIView *header = [UIView new];
    header.frame = CGRectMake(0, 64, DEVICE_Width, 15);
    header.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    header.layer.masksToBounds = YES;
    header.layer.borderColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.89 alpha:1.00].CGColor;
    header.layer.borderWidth = 1;
    [self.view addSubview:header];
    
    mTableView = [UITableView new];
    mTableView.backgroundColor = [UIColor clearColor];
    mTableView.frame = CGRectMake(0, header.mbottom, DEVICE_Width, DEVICE_Height-79);
    mTableView.delegate = self;
    mTableView.dataSource = self;
    [self.view addSubview:mTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"hasCodeTableViewCell" bundle:nil];
    [mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    
    [self loadData];
}

- (void)loadData{
    [SVProgressHUD showWithStatus:@"正在加载..." maskType:SVProgressHUDMaskTypeClear];
    [mUserInfo getBundleMsg:[mUserInfo backNowUser].mUserId block:^(mBaseData *resb, SVerifyMsg *info) {
        
        if (resb.mData) {
            [SVProgressHUD showSuccessWithStatus:@"加载成功！"];
            mVerify = info;
            [mTableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:@"数据错误！"];
            [self leftBtnTouched:nil];
        };
        
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
    
    return 7;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    hasCodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    if (indexPath.row == 0) {
        cell.mName.text = @"帐号";
        cell.mContent.text = [mUserInfo backNowUser].mPhone;
    }
    if (indexPath.row == 1) {
        cell.mName.text = @"姓名";
        cell.mContent.text = [mUserInfo backNowUser].mNickName;
    }
    if (indexPath.row == 2) {
        cell.mName.text = @"身份证";
        cell.mContent.text = [mUserInfo backNowUser].mNickName;
    }
    if (indexPath.row == 3) {
        cell.mName.text = @"银行卡";
        cell.mContent.text = [mUserInfo backNowUser].mNickName;
    }
    if (indexPath.row == 4) {
        cell.mName.text = @"物管公司";
        cell.mContent.text = mVerify.mCompanyName;
    }
    if (indexPath.row == 5) {
        cell.mName.text = @"居住关系";
        cell.mContent.text = [mUserInfo backNowUser].mNickName;
    }
    if (indexPath.row == 6) {
        cell.mName.text = @"地址信息";
        cell.mContent.text = mVerify.mVillageName;
    }
    
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

@end
