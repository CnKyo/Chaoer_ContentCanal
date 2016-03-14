//
//  shopViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "shopViewController.h"

#import "mShopTableViewCell.h"
@interface shopViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation shopViewController
{

    UITableView *mLeftTableView;
    
    UITableView *mRightTableView;
    
    mAddressView *mBottomView;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.Title = self.mPageName = _mTitle;
    self.hiddenTabBar = YES;
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    [self initView];

}

- (void)initView{

    mLeftTableView = [UITableView new];
    mLeftTableView.backgroundColor = [UIColor whiteColor];
    mLeftTableView.delegate = self;
    mLeftTableView.dataSource = self;
    UINib   *nib = [UINib nibWithNibName:@"mLeftTableViewCell" bundle:nil];
    [mLeftTableView registerNib:nib forCellReuseIdentifier:@"lcell"];
    [self.view addSubview:mLeftTableView];
    
    
    mRightTableView = [UITableView new];
    mRightTableView.backgroundColor = [UIColor whiteColor];
    mRightTableView.delegate = self;
    mRightTableView.dataSource = self;
    nib = [UINib nibWithNibName:@"mRightShopTableCell" bundle:nil];
    [mRightTableView registerNib:nib forCellReuseIdentifier:@"rcell"];
    [self.view addSubview:mRightTableView];
    
    mBottomView = [mAddressView shareShopCar];
    [self.view addSubview:mBottomView];
    
    
    [mLeftTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(@0);
        make.right.equalTo(mRightTableView.left).offset(@0);
        make.top.equalTo(self.view).offset(@64);
        make.bottom.equalTo(mBottomView.top).offset(@0);
        make.width.offset(DEVICE_Width/4);
    }];
    
    [mRightTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mLeftTableView.right).offset(@0);
        make.right.equalTo(self.view).offset(@0);
        make.top.equalTo(self.view).offset(@64);
        make.bottom.equalTo(mBottomView.top).offset(@0);
    }];
    
    
    [mBottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).offset(@0);
        make.height.offset(@50);
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
    if (tableView == mLeftTableView) {
        return 4;
    }else{
    
        return 8;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == mLeftTableView) {
        return 40;
    }else{
        return 75;
    }
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = nil;
    
    if (tableView == mLeftTableView) {
        reuseCellId = @"lcell";
        mShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        
        return cell;
    }else{
        reuseCellId = @"rcell";
        mShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        
        
        
        return cell;
    }

    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableVie];
}


@end
