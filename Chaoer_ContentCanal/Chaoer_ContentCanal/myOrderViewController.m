//
//  myOrderViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "myOrderViewController.h"
#import "myOrderTableViewCell.h"

#import "makeFixOrderDetailViewController.h"
#import "mFixViewController.h"
#import "choiseServicerViewController.h"

@interface myOrderViewController ()<UITableViewDelegate,UITableViewDataSource,WKSegmentControlDelagate>

@end

@implementation myOrderViewController
{

}
@synthesize mType;
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    [self headerBeganRefresh];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.Title = self.mPageName = @"我的订单";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    
    
    self.page = 1;
    
    [self initViuew];
}
- (void)initViuew{
    
    UIImageView *iii = [UIImageView new];
    
    iii.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64);
    iii.image = [UIImage imageNamed:@"mBaseBgkImg"];
    [self.view addSubview:iii];
    
    
    [self loadTableView:CGRectMake(0,64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.93 green:0.94 blue:0.96 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;

    self.haveHeader = YES;
    self.haveFooter = YES;

    
    UINib   *nib = [UINib nibWithNibName:@"myOrderCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    nib = [UINib nibWithNibName:@"mTopUpPhoneCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell1"];

}

- (void)headerBeganRefresh{
//    [SVProgressHUD showWithStatus:@"正在加载中..." maskType:SVProgressHUDMaskTypeClear];

    self.page = 1;
 
    if ([mType isEqualToString:@"3"]) {
        [SVProgressHUD showErrorWithStatus:@"暂无数据！"];
        
        return;
    }else{
    
        [[mUserInfo backNowUser] getOrder:mType andStart:self.page andEd:10 block:^(mBaseData *resb, NSArray *mArr) {
            
            [self.tempArray removeAllObjects];
            [self headerEndRefresh];
            
            [self removeEmptyView];
            if (resb.mSucess) {
                [SVProgressHUD dismiss];
//                [SVProgressHUD showSuccessWithStatus:resb.mMessage];
                
                if (mArr.count <= 0) {
                    [self addEmptyViewWithImg:nil];
                    return ;
                }
                
                [self.tempArray addObjectsFromArray:mArr];
                [self.tableView reloadData];
                
            }else{
                
                [SVProgressHUD showErrorWithStatus:resb.mMessage];
                [self addEmptyViewWithImg:nil];
                
            }
            
        }];

    }
    
    
   }

- (void)footetBeganRefresh{
//    [SVProgressHUD showWithStatus:@"正在加载中..." maskType:SVProgressHUDMaskTypeClear];
    self.page ++;
    if ([mType isEqualToString:@"3"]) {
        [SVProgressHUD showErrorWithStatus:@"暂无数据！"];
        
        return;
    }else{
        [[mUserInfo backNowUser] getOrder:mType andStart:self.page andEd:10 block:^(mBaseData *resb, NSArray *mArr) {
            
            [self footetEndRefresh];
            
            [self removeEmptyView];
            if (resb.mSucess) {
                [SVProgressHUD dismiss];
//                [SVProgressHUD showSuccessWithStatus:resb.mMessage];
                
                if (mArr.count <= 0) {
                    [self addEmptyViewWithImg:nil];
                    return ;
                }
                
                [self.tempArray addObjectsFromArray:mArr];
                [self.tableView reloadData];
                
            }else{
                
                [SVProgressHUD showErrorWithStatus:resb.mMessage];
                [self addEmptyViewWithImg:nil];
                
            }
            
        }];

        
    }
    
    
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
    
    return self.tempArray.count ;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([mType isEqualToString:@"1"]) {
        return 170;
    }else{
        return 50;
    }
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = nil;
    
    if ([mType isEqualToString:@"1"]) {
        reuseCellId = @"cell";
    }else{
        reuseCellId = @"cell1";
        
    }
    
    GFixOrder *mFix = self.tempArray[indexPath.row];
    
    myOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    

    cell.mOrderStatus.text = mFix.mOrderStatus;
    cell.mOrderPrice.text = [NSString stringWithFormat:@"金额:%.2f元",mFix.mOrderPrice];
    cell.mOrderName.text = [NSString stringWithFormat:@"%@-%@",mFix.mClassificationName,mFix.mClassificationName2];
    cell.mServiceTime.text = [NSString stringWithFormat:@"服务时间：%@",mFix.mOrderServiceTime];
    cell.mServiceAddress.text = [NSString stringWithFormat:@"服务地址：%@",mFix.mAddress];
    MLLog(@"图片地址是：%@",[NSString stringWithFormat:@"%@%@",[HTTPrequest currentResourceUrl],mFix.mOrderImage]);
    
    if ([mFix.mOrderImage isEqualToString:@""] || mFix.mOrderImage == nil) {
        cell.mImage1.image = [UIImage imageNamed:@"logo"];
        
        cell.mAddressLeft.constant = 0;
        cell.mServiceTimeLeft.constant = 0;
    }else{
        [cell.mImage1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[HTTPrequest currentResourceUrl],mFix.mOrderImage]] placeholderImage:[UIImage imageNamed:@"img_default"]];
    }
    
    cell.mPhone.text = mFix.mPhone;

//    cell.mPhone.text = [NSString stringWithFormat:@"%@-%.2f元",mFix.mPhone,mFix.mOrderPrice];
    cell.mPhoneTime.text = mFix.addTime;
    cell.mPhoneMoney.text = [NSString stringWithFormat:@"充值金额:%.2f元",mFix.mOrderPrice];
    cell.mPhoneStatus.text = mFix.mDescription;
    
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    GFixOrder *mFix = self.tempArray[indexPath.row];
    
    if ([mType isEqualToString:@"1"]) {
        if (mFix.mStatus == 4) {
            
            choiseServicerViewController *ccc = [[choiseServicerViewController alloc] initWithNibName:@"choiseServicerViewController" bundle:nil];
            ccc.Type = 2;
            ccc.mFix = GFixOrder.new;
            ccc.mFix = mFix;
            [self pushViewController:ccc];
            
            
        }
        else{
            
            makeFixOrderDetailViewController *mmm = [[makeFixOrderDetailViewController alloc] initWithNibName:@"makeFixOrderDetailViewController" bundle:nil];
            
            mmm.mFixOrder = GFixOrder.new;
            
            mmm.mFixOrder = mFix;
            
            [self pushViewController:mmm];
        }

    }else{

        
    }
    
    
    


}


@end
