//
//  ThirdViewCollectionViewController.m
//  HeaderViewAndPageView
//
//  Created by su on 16/8/8.
//  Copyright © 2016年 susu. All rights reserved.
//

#import "ThirdViewCollectionViewController.h"
#import "mDetailSectionView.h"
#import "mCampTionTableViewCell.h"
@interface ThirdViewCollectionViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic ,strong)UITableView * myTableView;

@end

@implementation ThirdViewCollectionViewController
{

    mDetailSectionView *mSectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, DEVICE_Height-114)];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_myTableView];
    
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib   *nib = [UINib nibWithNibName:@"mCampTionTableViewCell" bundle:nil];
    [_myTableView registerNib:nib forCellReuseIdentifier:@"cell1"];

    nib = [UINib nibWithNibName:@"mDetailShopImgCell" bundle:nil];
    [_myTableView registerNib:nib forCellReuseIdentifier:@"cell2"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    mSectionView = [mDetailSectionView shareView];
    return mSectionView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 40;
    }else{
        return 0;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }else{
        return 1;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 40;
    }else{
        return 355;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = nil;
    
    
    if (indexPath.section == 0) {
        identifier = @"cell1";
        mCampTionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    
    }else{
        
        identifier = @"cell2";
        mCampTionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }
    
  
}


@end
