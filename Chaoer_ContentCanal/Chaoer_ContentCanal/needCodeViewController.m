//
//  needCodeViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/22.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "needCodeViewController.h"
#import "needCodeView.h"
#import "MHActionSheet.h"

#import "verifyBankViewController.h"
@interface needCodeViewController ()

@end

@implementation needCodeViewController
{
    UIScrollView *mScrollerView;
    
    needCodeView    *mView;
    
    int mCityId;
    
    int mArearId;
    
    int mType;
    
    int mCommunityId;
    
    int mBan;
    
    int mUnit;
    
    int mDoornum;
    
    int mFloor;
    
    NSMutableArray *mDoornumArr;
    
    NSMutableArray *mUnitArr;
    
    NSMutableArray *mFloorArr;

    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /**
     IQKeyboardManager为自定义收起键盘
     **/
    [[IQKeyboardManager sharedManager] setEnable:YES];///视图开始加载键盘位置开启调整
    [[IQKeyboardManager sharedManager]setEnableAutoToolbar:YES];///是否启用自定义工具栏
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;///启用手势
    //    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];///视图消失键盘位置取消调整
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];///关闭自定义工具栏
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.89 green:0.90 blue:0.90 alpha:1.00];
    self.Title = self.mPageName = @"实名认证";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    mType = 1;
    
    mDoornumArr = [NSMutableArray new];
    mUnitArr = [NSMutableArray new];
    mFloorArr = [NSMutableArray new];

    
    [self initview];
}
- (void)initview{
    
    UIImageView *iii = [UIImageView new];
    
    iii.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64);
    iii.image = [UIImage imageNamed:@"mBaseBgkImg"];
    [self.view addSubview:iii];
    
    mScrollerView = [UIScrollView new];
    mScrollerView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64);
    mScrollerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mScrollerView];
    
    
    mView = [needCodeView shareView];
    mView.frame = CGRectMake(0, 0, DEVICE_Width, 568);
    
    
    
    if ([[mUserInfo backNowUser].mIdentity isEqualToString:@"房主"]) {
        mView.mMasterBtn.selected = YES;
    }else{
        mView.mVisitorBtn.selected = YES;
    }
    
    [mView.mCityBtn addTarget:self action:@selector(cityAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mArearBtn addTarget:self action:@selector(arearAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mCommunityBtn addTarget:self action:@selector(communityAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [mView.mBuildBtn addTarget:self action:@selector(builAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mUnitBtn addTarget:self action:@selector(unitAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mDoorNuimBtn addTarget:self action:@selector(doornumAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mFloorBtn addTarget:self action:@selector(floorAction:) forControlEvents:UIControlEventTouchUpInside];

    
    [mView.mOkBtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [mView.mMasterBtn addTarget:self action:@selector(choiseAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mVisitorBtn addTarget:self action:@selector(choiseAction:) forControlEvents:UIControlEventTouchUpInside];



    [mScrollerView addSubview:mView];
    
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 568);
    
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
            mView.mCityLb.text = text;
            mType = 2;

        }else if (mType == 2){
            GCity *city = self.tempArray[index];
            text = [NSString stringWithFormat:@"%@", city.mAreaName];
            mCityId = [[NSString stringWithFormat:@"%@",city.mAreaId] intValue];

            mView.mArearLb.text = text;
            mArearId = [[NSString stringWithFormat:@"%@",city.mParentId] intValue];
            mType = 3;

        }else if(mType == 3){
            GCommunity *gm = self.tempArray[index];
            text = [NSString stringWithFormat:@"%@", gm.mCommunityName];
            mCommunityId = [[NSString stringWithFormat:@"%@",gm.mPropertyId] intValue];
            mView.mCommunityLb.text = text;
            mType = 4;

        }else if(mType == 4){
            NSString *gm = Arrtemp[index];
            mBan = [gm intValue];
            text = [NSString stringWithFormat:@"%@栋", gm];
            mView.mBuildLb.text = text;
            mUnit = [gm intValue];
            mType = 5;

            
        }else if(mType == 5){
            int gm = [mUnitArr[index] intValue];
            text = [NSString stringWithFormat:@"%d单元", gm];
            mUnit = gm;
            mView.mUnitLb.text = text;
            mType = 6;

            
        }else if(mType == 6){
            int gm = [mFloorArr[index] intValue];
            text = [NSString stringWithFormat:@"%d楼", gm];
            mView.mFloorLb.text = text;
            mFloor = gm;
            mType = 7;

        }
        else if(mType == 7){
            int gm = [mDoornumArr[index] intValue];
            text = [NSString stringWithFormat:@"%d号", gm];
            mView.mDoorNumLb.text = text;
            mDoornum = gm;
            
        }else{
            NSString *gm = Arrtemp[index];
            text = gm;
            mView.mDoorNumLb.text = text;
            mDoornum = [gm intValue];

        }
        
        
    }];
}


- (void)cityAction:(UIButton *)sender{
    if (mView.mNameTx.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的名称！"];
        [mView.mNameTx becomeFirstResponder];
        return;
    }
    sender.selected = !sender.selected;
    mType = 1;
    mCityId = 0;
    [self loadData];

}
- (void)arearAction:(UIButton *)sender{
    if (mCityId == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择城市!"];
        return;
    }
    sender.selected = !sender.selected;
    mType = 2;
    [self loadData];



}

- (void)communityAction:(UIButton *)sender{
    
 
    if (mType == 1) {
        [SVProgressHUD showErrorWithStatus:@"请选择区县!"];
        return;
    }
    sender.selected = !sender.selected;
    mType = 3;
    [self loadData];

 

}


- (void)unitAction:(UIButton *)sender{
    if ([mView.mBuildLb.text isEqualToString:@"选择楼栋号"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择楼栋号!"];
        return;
    }
    sender.selected = !sender.selected;
    mType = 5;
    [self loadData];

    
}
- (void)floorAction:(UIButton *)sender{
    if ([mView.mUnitLb.text isEqualToString:@"选择单元"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择单元!"];
        return;
    }
    sender.selected = !sender.selected;
    mType = 6;
    
    
    [self loadMHActionSheetView];
}
- (void)doornumAction:(UIButton *)sender{
    

    if ([mView.mFloorLb.text isEqualToString:@"选择楼层"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择楼层!"];
        return;
    }
    sender.selected = !sender.selected;
    mType = 7;
    
    
    [self loadMHActionSheetView];
    


}
- (void)builAction:(UIButton *)sender{

    if ([mView.mCommunityLb.text isEqualToString:@"选择小区"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择小区!"];
        return;
    }
    sender.selected = !sender.selected;
    mType = 4;

    [self loadData];


}



- (void)okAction:(UIButton *)sender{
    
    
    [SVProgressHUD showWithStatus:@"正在认证中..." maskType:SVProgressHUDMaskTypeClear];
    
    [mUserInfo realCode:nil andUserId:[mUserInfo backNowUser].mUserId andCommunityId:mCommunityId andBannum:mBan andUnnitnum:mUnit andFloor:mFloor andDoornum:mDoornum block:^(mBaseData *resb) {
    
        if (resb.mSucess ) {
            [SVProgressHUD showSuccessWithStatus:resb.mMessage];
            verifyBankViewController *vvv = [[verifyBankViewController alloc] initWithNibName:@"verifyBankViewController" bundle:nil];
            [self pushViewController:vvv];
        }else{
        
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
        }
        
    }];
    
}

- (void)choiseAction:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            if (sender.selected == NO) {
                mView.mMasterBtn.selected = YES;
                mView.mVisitorBtn.selected = NO;
            }else{
                sender.selected = NO;
                
            }
        }
            break;
        case 2:
        {
            if (sender.selected == NO) {
                mView.mMasterBtn.selected = NO;
                mView.mVisitorBtn.selected = YES;
            }else{
                sender.selected = NO;
                
            }
        }
            break;
  
        default:
            break;
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

@end
