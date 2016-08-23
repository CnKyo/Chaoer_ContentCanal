//
//  DryCleanOrderChooseCouponTVC.m
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/20.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "DryCleanOrderChooseCouponTVC.h"
#import "coupTableViewCell.h"
#import "exchangeCoupView.h"


@interface DryCleanOrderChooseCouponTVC ()<wkCoupCellDidSelected, UITableViewDelegate, UITableViewDataSource>

@end

@implementation DryCleanOrderChooseCouponTVC


- (id)init
{
    self = [super init];
    if (self) {
        self.tableArr = [NSMutableArray array];
        
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Title = self.mPageName = @"选择优惠券";
    self.hiddenBackBtn = NO;
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    
    self.page = 1;
    

    
    [self loadTableView:CGRectMake(0, 0, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleGray;
    
    UINib   *nib = [UINib nibWithNibName:@"coupTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
}

#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    
//    return mSegmentView;
//    
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    
//    return 40;
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.tableArr.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 170;
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellId = @"cell";
    
    
    CouponsObject *mCoup = self.tableArr[indexPath.row];
    
    coupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.mContent.text = [NSString stringWithFormat:@"%@%@",mCoup.name,mCoup.desc];
    cell.mMoney.text = [NSString stringWithFormat:@"¥%2.f",mCoup.facePrice];
    
    cell.mStore.text = mCoup.shopName;
    cell.delegate = self;
    cell.mIndexPath = indexPath;
    cell.mLogo.image = IMG(@"img_default");
    //[cell.mLogo sd_setImageWithURL:[NSURL URLWithString:mCoup.mShopLogo] placeholderImage:[UIImage imageNamed:@"img_default"]];
    
//    UIImage *coupImg = nil;
//    
//    if ([mCoup.mCoupModel isEqualToString:@"red"]) {
//        coupImg = [UIImage imageNamed:@"coup_red"];
//    }else if ([mCoup.mCoupModel isEqualToString:@"blue"]){
//        coupImg = [UIImage imageNamed:@"coup_blue"];
//    }else{
//        coupImg = [UIImage imageNamed:@"coup_green"];
//    }
//    
//    cell.mBgkImg.image = coupImg;
//    
//    NSString *tt = nil;
//    
//    if (mCoup.mEndTime.length == 0) {
//        tt = @"永久有效";
//    }else{
//        tt = [NSString stringWithFormat:@"过期时间:%@",mCoup.mEndTime];
//    }
//    
//    cell.mTime.text = tt;
    
    
    cell.mIsValid.image = [UIImage imageNamed:@"coup_beuse"];
    cell.mIsValid.hidden = YES;
//    if (mType == 1) {
//        cell.mIsValid.image = [UIImage imageNamed:@"coup_ expire"];
//        cell.mIsValid.hidden = NO;
//        
//    }else if (mType == 2){
//        cell.mIsValid.image = [UIImage imageNamed:@"coup_beuse"];
//        cell.mIsValid.hidden = NO;
//    }else{
//        cell.mIsValid.hidden = YES;
//    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)cellWithBtnClicked:(NSIndexPath *)mIndexPath{
    if (self.tableArr.count > mIndexPath.row) {
        CouponsObject *mCoup = self.tableArr[mIndexPath.row];
        if (self.chooseCallBack)
            self.chooseCallBack(mCoup);
        [self popViewController];
    }

}


@end
