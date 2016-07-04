//
//  kitchenViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/4/1.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "kitchenViewController.h"
#import "kitchenTableViewCell.h"

#import "mCookDetail.h"
@interface kitchenViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation kitchenViewController
{

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Title = self.mPageName = @"厨房";
    self.hiddenBackBtn = YES;
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    
    self.page = 1;
    
    [self initView];

}
- (void)initView{

    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-114) delegate:self dataSource:self];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    
    self.haveHeader = YES;
    self.haveFooter = YES;
    
    
    UINib   *nib = [UINib nibWithNibName:@"kitchenTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
}

- (void)headerBeganRefresh{

    self.page = 1;
    
//    [SVProgressHUD showWithStatus:@"正在加载中..." maskType:SVProgressHUDMaskTypeClear];
    [[mUserInfo backNowUser] getCookList:self.page block:^(mJHBaseData *resb, NSArray *mArr) {
        [self headerEndRefresh];
        [self removeEmptyView];
        [self.tempArray removeAllObjects];
        
        if (resb.mSucess) {
            
            [SVProgressHUD dismiss];
//            [SVProgressHUD showSuccessWithStatus:@"加载成功！"];
            
            if (mArr.count <= 0) {
                [self addEmptyViewWithImg:nil];
                return ;
            }
            
            [self.tempArray addObjectsFromArray:mArr];
            [self.tableView reloadData];
            
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"加载失败！"];
            [self addEmptyViewWithImg:nil];
        }
        
        
        
    }];
    
    
}

- (void)footetBeganRefresh{

    self.page ++;
//    [SVProgressHUD showWithStatus:@"正在加载中..." maskType:SVProgressHUDMaskTypeClear];
    [[mUserInfo backNowUser] getCookList:self.page block:^(mJHBaseData *resb, NSArray *mArr) {
        [self footetEndRefresh];
        [self removeEmptyView];
        
        if (resb.mSucess) {
            
            [SVProgressHUD dismiss];
//            [SVProgressHUD showSuccessWithStatus:resb.mMessage];
            
            [self.tempArray addObjectsFromArray:mArr];
            [self.tableView reloadData];
            
            
        }else{
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
            [self addEmptyViewWithImg:nil];
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
    
    return self.tempArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *reuseCellId = @"cell";
    
    
    GCook *mCook = self.tempArray[indexPath.row];
    
    kitchenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    [cell.mBgkImg sd_cancelCurrentImageLoad];
    [cell.mBgkImg sd_setImageWithURL:[NSURL URLWithString:mCook.mImg] placeholderImage:[UIImage imageNamed:@"img_default"]];
    
    cell.mContent.text = mCook.mName;
    cell.mLeftLb.text = mCook.mFood;   
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GCook *mCook = self.tempArray[indexPath.row];

//    WebVC* vc = [[WebVC alloc]init];
//    vc.mName = mCook.mName;
//    vc.mUrl = [NSString stringWithFormat:@"http://api.avatardata.cn/Cook/Show?key=%@&id=%d",AVADA_KEY,mCook.mId];
//    [self pushViewController:vc];
 
    
    mCookDetail *mcc = [mCookDetail new];
    mcc.mTT = mCook.mName;
    mcc.mName = mCook.mName;
    mcc.mImg = mCook.mImg;
    mcc.mFood = [NSString stringWithFormat:@"%@%@",mCook.mFood,mCook.mKeywords];
    mcc.mDesctipution = mCook.mDescription;
    [self pushViewController:mcc];
    
}


@end
