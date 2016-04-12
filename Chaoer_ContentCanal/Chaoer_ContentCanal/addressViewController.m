//
//  addressViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/4/12.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "addressViewController.h"

@interface addressViewController ()

@end

@implementation addressViewController
{

    int mType;
    
    int mCityId;
    
    int mArearId;
    
    int mCommunityId;
    
    int mBan;
    
    int mUnit;
    
    int mDoornum;
    
    int mFloor;
    
    NSMutableArray *mDoornumArr;
    
    NSMutableArray *mUnitArr;
    
    NSMutableArray *mFloorArr;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.Title = self.mPageName = @"添加地址";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    
    mType = 1;
    
    mDoornumArr = [NSMutableArray new];
    mUnitArr = [NSMutableArray new];
    mFloorArr = [NSMutableArray new];

    [self initView];
}


- (void)initView{

    self.mProvinceBtn.layer.masksToBounds = self.mCityBtn.layer.masksToBounds = self.mArearBtn.layer.masksToBounds = self.mBuildBtn.layer.masksToBounds = self.mUnitBtn.layer.masksToBounds = self.mFloorBtn.layer.masksToBounds = self.mDoorumBtn.layer.masksToBounds = YES;
    self.mProvinceBtn.layer.borderColor = self.mCityBtn.layer.borderColor = self.mArearBtn.layer.borderColor = self.mBuildBtn.layer.borderColor = self.mUnitBtn.layer.borderColor = self.mFloorBtn.layer.borderColor = self.mDoorumBtn.layer.borderColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:0.45].CGColor;
    self.mProvinceBtn.layer.borderWidth = self.mCityBtn.layer.borderWidth = self.mArearBtn.layer.borderWidth = self.mBuildBtn.layer.borderWidth = self.mUnitBtn.layer.borderWidth = self.mFloorBtn.layer.borderWidth = self.mDoorumBtn.layer.borderWidth = 0.5;
    
    self.mSaveBtn.layer.masksToBounds = YES;
    self.mSaveBtn.layer.cornerRadius = 3;

    

    
}
- (void)loadData{
    [SVProgressHUD showWithStatus:@"正在加载中..." maskType:SVProgressHUDMaskTypeClear];
    if (mType == 3) {
        
        [mUserInfo getArearId:mArearId andProvince:mCityId block:^(mBaseData *resb,NSArray *mArr) {
            [SVProgressHUD dismiss];
            [self.tempArray removeAllObjects];
            if (resb.mSucess) {
                
                [SVProgressHUD showSuccessWithStatus:resb.mMessage];
                [self.tempArray addObjectsFromArray:mArr];
                [self loadMHActionSheetView];
            }else{
                [SVProgressHUD showErrorWithStatus:resb.mMessage];
                
            }
        }];
        
    }else if (mType == 4){
        
        [mUserInfo getBuilNum:mCommunityId block:^(mBaseData *resb, NSArray *mArr) {
            [self.tempArray removeAllObjects];
            if (resb.mSucess) {
                
                [SVProgressHUD showSuccessWithStatus:resb.mMessage];
                [self.tempArray addObjectsFromArray:mArr];
                [self loadMHActionSheetView];
            }else{
                [SVProgressHUD showErrorWithStatus:resb.mMessage];
                
            }
            
        }];
        
    }else if (mType == 5){
        
        [mUserInfo getDoorNum:mCommunityId andBuildName:mBan block:^(mBaseData *resb, NSArray *mArr) {
            [self.tempArray removeAllObjects];
            if (resb.mSucess) {
                
                [SVProgressHUD showSuccessWithStatus:resb.mMessage];
                [self.tempArray addObjectsFromArray:mArr];
                [self loadMHActionSheetView];
            }else{
                [SVProgressHUD showErrorWithStatus:resb.mMessage];
                
            }
        }];
        
    }
    else{
        [mUserInfo getCityId:mCityId block:^(mBaseData *resb, NSArray *mArr) {
            [SVProgressHUD dismiss];
            [self.tempArray removeAllObjects];
            if (resb.mSucess) {
                [SVProgressHUD showSuccessWithStatus:resb.mMessage];
                
                [self.tempArray addObjectsFromArray:mArr];
                [self loadMHActionSheetView];
            }else{
                [SVProgressHUD showErrorWithStatus:resb.mMessage];
            }
            
        }];
    }
    
}


- (void)loadMHActionSheetView{
    NSString *mTt = nil;
    
    if (mType == 1) {
        mTt = @"选择城市";
    }else if (mType == 2){
        
        mTt = @"选择市区";
    }else if(mType == 3){
        mTt = @"选择小区";
    }else if(mType == 4){
        mTt = @"选择楼栋号";
    }else if(mType == 5){
        mTt = @"选择单元";
    }else if(mType == 6){
        mTt = @"选择楼层";
    }else{
        mTt = @"选择门牌号";
    }
    
    NSMutableArray  *Arrtemp = [NSMutableArray new];
    
    if (mType == 3) {
        for (GCommunity *city in self.tempArray) {
            [Arrtemp addObject:city.mCommunityName];
        }
    }else if(mType == 4){
        
        for (NSString *str in self.tempArray) {
            [Arrtemp addObject:str];
        }
        
    }else if(mType == 5){
        [mDoornumArr removeAllObjects];
        [mUnitArr removeAllObjects];
        [Arrtemp removeAllObjects];
        
        for (GdoorNum *door in self.tempArray) {
            
            if (door.mUnit) {
                if (door.mUnit == 1) {
                    [mUnitArr addObject:[NSString stringWithFormat:@"1单元"]];
                    
                }else{
                    for (int i = 1; i<door.mUnit; i++) {
                        [mUnitArr addObject:[NSString stringWithFormat:@"%d单元",i]];
                        
                    }
                }
                
                
            }
            
            
            for (int j =1; j<door.mFloor; j++) {
                [mFloorArr addObject:[NSString stringWithFormat:@"%d楼",j]];
                
            }
            for (int k = 1; k<door.mRoomNumber; k++) {
                [mDoornumArr addObject:[NSString stringWithFormat:@"%d号",k]];
            }
            [Arrtemp addObjectsFromArray:mUnitArr];
            
        }
        
    }else if(mType == 6){
        
        [Arrtemp removeAllObjects];
        [Arrtemp addObjectsFromArray:mFloorArr];
        
    }
    else if(mType == 7){
        
        [Arrtemp removeAllObjects];
        [Arrtemp addObjectsFromArray:mDoornumArr];
        
    }else{
        for (GCity *city in self.tempArray) {
            [Arrtemp addObject:city.mAreaName];
        }
    }
    
    
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:mTt style:MHSheetStyleWeiChat itemTitles:Arrtemp];
    actionSheet.cancleTitle = @"取消选择";
    
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        NSString *text = nil;
        
        if (mType == 1) {
            GCity *city = self.tempArray[index];
            text = [NSString stringWithFormat:@"%@", city.mAreaName];
            mCityId = [[NSString stringWithFormat:@"%@",city.mAreaId] intValue];
            self.mProvinceBtn.titleLabel.text = text;
            
        }else if (mType == 2){
            GCity *city = self.tempArray[index];
            text = [NSString stringWithFormat:@"%@", city.mAreaName];
            mCityId = [[NSString stringWithFormat:@"%@",city.mAreaId] intValue];
            
            self.mCityBtn.titleLabel.text = text;
            mArearId = [[NSString stringWithFormat:@"%@",city.mParentId] intValue];
            
        }else if(mType == 3){
            GCommunity *gm = self.tempArray[index];
            text = [NSString stringWithFormat:@"%@", gm.mCommunityName];
            mCommunityId = [[NSString stringWithFormat:@"%@",gm.mPropertyId] intValue];
            self.mArearBtn.titleLabel.text = text;
        }else if(mType == 4){
            NSString *gm = Arrtemp[index];
            mBan = [gm intValue];
            text = [NSString stringWithFormat:@"%@栋", gm];
            self.mBuildBtn.titleLabel.text = text;
            mUnit = [gm intValue];
            
        }else if(mType == 5){
            int gm = [mUnitArr[index] intValue];
            text = [NSString stringWithFormat:@"%d单元", gm];
            mUnit = gm;
            self.mUnitBtn.titleLabel.text = text;
            
        }else if(mType == 6){
            int gm = [mFloorArr[index] intValue];
            text = [NSString stringWithFormat:@"%d楼", gm];
            self.mFloorBtn.titleLabel.text = text;
            mFloor = gm;
            
        }
        else if(mType == 7){
            int gm = [mDoornumArr[index] intValue];
            text = [NSString stringWithFormat:@"%d号", gm];
            self.mFloorBtn.titleLabel.text = text;
            mDoornum = gm;
            
        }else{
            NSString *gm = Arrtemp[index];
            text = gm;
            self.mDoorumBtn.titleLabel.text = text;
            mDoornum = [gm intValue];
            
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
#pragma mark----省份
- (IBAction)mProvinceAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    mType = 1;
    mCityId = 0;
    [self loadData];
}
#pragma mark----城市
- (IBAction)mCirtyAction:(UIButton *)sender {
    if (mCityId == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择城市!"];
        return;
    }
    sender.selected = !sender.selected;
    mType = 2;
    [self loadData];

}
#pragma mark----小区
- (IBAction)mArearAction:(UIButton *)sender {
    if (mType == 1) {
        [SVProgressHUD showErrorWithStatus:@"请选择区县!"];
        return;
    }
    sender.selected = !sender.selected;
    mType = 3;
    [self loadData];

}
#pragma mark----楼栋
- (IBAction)mBuildAction:(UIButton *)sender {
    if (mType == 2) {
        [SVProgressHUD showErrorWithStatus:@"请选择小区!"];
        return;
    }
    sender.selected = !sender.selected;
    mType = 4;
    
    [self loadData];
}
#pragma mark----单元
- (IBAction)mUnitAction:(UIButton *)sender {
    if ([self.mBuildBtn.titleLabel.text isEqualToString:@"选择楼栋号"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择楼栋号!"];
        return;
    }
    sender.selected = !sender.selected;
    mType = 5;
    [self loadData];
}
#pragma mark----楼层
- (IBAction)mFloorAction:(UIButton *)sender {
    if ([self.mUnitBtn.titleLabel.text isEqualToString:@"选择单元"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择单元!"];
        return;
    }
    sender.selected = !sender.selected;
    mType = 6;
    
    
    [self loadMHActionSheetView];
}
#pragma mark----门牌号
- (IBAction)mDoornumAction:(UIButton *)sender {
    if ([self.mFloorBtn.titleLabel.text isEqualToString:@"选择楼层"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择楼层!"];
        return;
    }
    sender.selected = !sender.selected;
    mType = 7;
    
    
    [self loadMHActionSheetView];
}
#pragma mark----保存按钮
- (IBAction)mSaveAction:(UIButton *)sender {
    if (mType != 7) {
        [SVProgressHUD showErrorWithStatus:@"请完善您的地址信息！"];
        return;
    }
}

@end
