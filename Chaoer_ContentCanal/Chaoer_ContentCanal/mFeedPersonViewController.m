//
//  mFeedPersonViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mFeedPersonViewController.h"
#import "MHActionSheet.h"

#import "NFPickerView.h"

@interface mFeedPersonViewController ()<UITableViewDelegate,UITableViewDataSource,NFPickerViewDelegete>


@end

@implementation mFeedPersonViewController
{
    /**
     *  1是小区 2是楼栋
     */
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
    
    NSMutableArray  *Arrtemp;

    NSInteger mUnitIndex;
    
    
    
    
    NSString *mmProvinceId;
    
    NSString *mmCityId;
    
    NSString *mmArearId;
    NFPickerView *pickerView;

    
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
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];///视图消失键盘位置取消调整
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];///关闭自定义工具栏
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.Title = self.mPageName = @"投诉居民";
    
    mType = 1;
    
    mDoornumArr = [NSMutableArray new];
    mUnitArr = [NSMutableArray new];
    mFloorArr = [NSMutableArray new];
    Arrtemp = [NSMutableArray new];
    self.mBgkView.layer.masksToBounds = YES;
    self.mBgkView.layer.borderColor = [UIColor colorWithRed:0.82 green:0.82 blue:0.84 alpha:1].CGColor;
    self.mBgkView.layer.borderWidth = 1;
    
    self.mSubmit.layer.masksToBounds = YES;
    self.mSubmit.layer.cornerRadius = 3;
    
    
    mmProvinceId = nil;
    mmCityId = nil;
    mmArearId = nil;
    
    
    self.mReason.placeholder = @"在此写上您投诉的原因:";
    [self.mReason setHolderToTop];
//    [self initTap];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadData{
    [SVProgressHUD showWithStatus:@"正在加载中..." maskType:SVProgressHUDMaskTypeClear];
    if (mType == 3) {
        
        [mUserInfo getArearId:mmProvinceId andArear:mmArearId andCity:mmCityId block:^(mBaseData *resb, NSArray *mArr) {
      
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
            [SVProgressHUD dismiss];

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
    [Arrtemp removeAllObjects];

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
        [mFloorArr removeAllObjects];
        for (int i = 0 ;i < self.tempArray.count ; i++) {
            
            GdoorNum *door = self.tempArray[i];
            [mUnitArr addObject:[NSString stringWithFormat:@"%@单元",door.mUnit]];
            
            NSMutableArray *floor = [NSMutableArray new];
            NSMutableArray *doorArr = [NSMutableArray new];
            for (int j =1; j<[[NSString stringWithFormat:@"%@",door.mFloor] intValue]; j++) {
                [floor addObject:[NSString stringWithFormat:@"%d楼",j]];
                
         
            }
            for (int k = 1; k<[[NSString stringWithFormat:@"%@",door.mRoomNumber] intValue]; k++) {
                [doorArr addObject:[NSString stringWithFormat:@"%d号",k]];
            }
            [mFloorArr addObject:floor];
            [mDoornumArr addObject:doorArr];
            
        }
        [Arrtemp addObjectsFromArray:mUnitArr];

    }else if(mType == 6){
        
        [Arrtemp removeAllObjects];
        [Arrtemp addObjectsFromArray:mFloorArr[mUnitIndex]];
        
    }
    else if(mType == 7){
        
        [Arrtemp removeAllObjects];
        [Arrtemp addObjectsFromArray:mDoornumArr[mUnitIndex]];
        
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
            mType = 2;

        }else if (mType == 2){
       

        }else if(mType == 3){
            GCommunity *gm = self.tempArray[index];
            text = [NSString stringWithFormat:@"%@", gm.mCommunityName];
            mCommunityId = gm.mPropertyId;
            self.mValiigeBtn.titleLabel.text = text;
            mType = 4;

        }else if(mType == 4){
            NSString *gm = Arrtemp[index];
            mBan = [gm intValue];
            text = [NSString stringWithFormat:@"%@栋", gm];
            self.mBuildBtn.titleLabel.text = text;
            mUnit = [gm intValue];
            mType = 5;

            
        }else if(mType == 5){
            int gm = [mUnitArr[index] intValue];
            text = [NSString stringWithFormat:@"%d单元", gm];
            mUnit = gm;
            self.mUnitBtn.titleLabel.text = text;
            mType = 6;
            
            mUnitIndex = index;

        }else if(mType == 6){
            int gm = [Arrtemp[index] intValue];
            text = [NSString stringWithFormat:@"%d楼", gm];
            self.mFloorBtn.titleLabel.text = text;
            mFloor = gm;
            mType = 7;
            

        }
        else if(mType == 7){
            int gm = [Arrtemp[index] intValue];
            text = [NSString stringWithFormat:@"%@", Arrtemp[index]];
            self.mDoorNumBtn.titleLabel.text = text;
            mDoornum = gm;
            
        }else{
            NSString *gm = Arrtemp[index];
            text = gm;
            self.mDoorNumBtn.titleLabel.text = text;
            mDoornum = [gm intValue];
            
        }
        
        
    }];

}



#pragma mark----提交按钮
- (IBAction)mSubmitAction:(id)sender {

    if (self.mReason.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您投诉的内容！"];
        return;
    }if (mType != 7) {
        [SVProgressHUD showErrorWithStatus:@"请选择您要投诉的信息！"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在提交..." maskType:SVProgressHUDMaskTypeClear];
    [mUserInfo feedPerson:[NSString stringWithFormat:@"%d",mCommunityId] andBuilId:[NSString stringWithFormat:@"%d",mBan] andUnit:[NSString stringWithFormat:@"%d",mUnit] andFloor:[NSString stringWithFormat:@"%d",mFloor] andDoornum:[NSString stringWithFormat:@"%d",mDoornum] andReason:self.mReason.text block:^(mBaseData *resb) {
        
        if (resb.mSucess) {
            [SVProgressHUD showSuccessWithStatus:resb.mMessage];
            [self popViewController];
        }else{
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
        }
        
    }];
    
}

#pragma mark----省份
- (IBAction)provinceAction:(UIButton *)sender {
    mType = 1;
    mCityId = 0;

    [SVProgressHUD showWithStatus:@"正在加载中..." maskType:SVProgressHUDMaskTypeClear];
    
    [[mUserInfo backNowUser] getCodeAddress:^(mBaseData *resb, NSArray *mArr) {
        
        if (resb.mSucess) {
            
            [SVProgressHUD showSuccessWithStatus:resb.mMessage];
            
            [pickerView removeFromSuperview];
            
            pickerView = [[NFPickerView alloc] initWithFrame:CGRectMake(0, DEVICE_Height-220, DEVICE_Width, 220) andArr:mArr];
            
            pickerView.delegate = self;
            [pickerView show];
            
        }else{
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
        }
    }];

    
    
    
}
- (void)pickerDidSelectProvinceName:(NSString *)provinceName andProvinId:(int)ProvinceId cityName:(NSString *)cityName andArearId:(int)ArearId countrys:(NSString *)countrys andCityId:(int)CityId{
    
    MLLog(@"省市区名称:%@%@%@",provinceName,cityName,countrys);
    
    [self.mProvinceBtn setTitle:[NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,countrys] forState:0];
    
    mmProvinceId = [NSString stringWithFormat:@"%d",ProvinceId];
    mmCityId = [NSString stringWithFormat:@"%d",CityId];
    mmArearId = [NSString stringWithFormat:@"%d",ArearId];
    
    
    MLLog(@"省市区id:%d-%d-%d",ProvinceId,ArearId,CityId);
    
    
}


#pragma mark----小区
- (IBAction)mValiigeAction:(UIButton *)sender {
    if (mmProvinceId.length == 0 || [mmProvinceId isEqualToString:@""] || mmProvinceId == nil) {
        [SVProgressHUD showErrorWithStatus:@"请选择城市!"];
        return;
    }
    mType = 3;
    [self loadData];



}

#pragma mark----楼栋
- (IBAction)mBuildAction:(UIButton *)sender {
    if (mType == 3 || mType == 2 || mType == 1) {
        [SVProgressHUD showErrorWithStatus:@"请选择小区!"];
        return;
    }
    mType = 4;
    
    [self loadData];
}
#pragma mark----单元
- (IBAction)mUnitAction:(UIButton *)sender {
    if (mType == 4 || mType == 3 || mType == 2 || mType == 1) {
        [SVProgressHUD showErrorWithStatus:@"请选择楼栋号!"];
        return;
    }
    mType = 5;
    [self loadData];
}
#pragma mark----楼层
- (IBAction)mFloorAction:(UIButton *)sender {
    if (mType == 5 || mType == 4 || mType == 3 || mType == 2 || mType == 1) {
        [SVProgressHUD showErrorWithStatus:@"请选择单元!"];
        return;
    }
    mType = 6;
    
    
    [self loadMHActionSheetView];
}
#pragma mark----门牌号
- (IBAction)mDoorAction:(UIButton *)sender {
    if (mType == 6 || mType == 5 || mType == 4 || mType == 3 || mType == 2 || mType == 1) {
        [SVProgressHUD showErrorWithStatus:@"请选择楼层!"];
        return;
    }
    mType = 7;
    
    
    [self loadMHActionSheetView];
}


- (void)showValigeView:(BOOL)mselected{
    [UIView animateWithDuration:0.25 animations:^{
        if (mselected) {
            self.mValiigeH.constant = 200;
            
        }else{
            self.mValiigeH.constant = 0;
            
        }
        
        self.mBuildH.constant = 0;
        self.mDoorNumH.constant = 0;
        
        
    }];
}
- (void)showBuildView:(BOOL)mselected{
    [UIView animateWithDuration:0.25 animations:^{
        if (mselected) {
            self.mBuildH.constant = 200;
            
        }else{
            self.mBuildH.constant = 0;
            
        }
        self.mValiigeH.constant = 0;
        self.mDoorNumH.constant = 0;
        
    }];
}
- (void)showDoorNumView:(BOOL)mselected{
    [UIView animateWithDuration:0.25 animations:^{
        if (mselected) {
            self.mDoorNumH.constant = 150;
            
        }else{
            self.mDoorNumH.constant = 0;
            
        }
        self.mValiigeH.constant = 0;
        self.mBuildH.constant = 0;
        
    }];
}
- (void)hiddenView:(UITableView *)mTT{
    if (mTT == self.mValiigeTableView) {
        self.mValiigeH.constant = 0;
        self.mValiigeBtn.selected = YES;

    }if (mTT == self.mBuildTableView) {
        self.mBuildH.constant = 0;

    }else{
        self.mDoorNumH.constant = 0;

    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//-(void)initTap{
//    
//    UITapGestureRecognizer *ttt = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mTapAction)];
//    [self.view addGestureRecognizer:ttt];
//}
//- (void)mTapAction{
//    [self.mReason resignFirstResponder];
//}


#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if (tableView == self.mValiigeTableView) {
        return 10;
    }if (tableView == self.mBuildTableView) {
        return 10;
    }else{
        return 5;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    UITableViewCell *cell = (UITableViewCell*)[tableView  dequeueReusableCellWithIdentifier:reuseCellId];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCellId];
        
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",(long)indexPath.row];
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    if (tableView == self.mValiigeTableView) {
        
        [self.mValiigeBtn setTitle:[NSString stringWithFormat:@"选择了第%ld行",(long)indexPath.row] forState:UIControlStateSelected];
        [self hiddenView:self.mValiigeTableView];
    }if (tableView == self.mBuildTableView) {
        [self.mBuildBtn setTitle:[NSString stringWithFormat:@"选择了第%ld行",(long)indexPath.row] forState:UIControlStateSelected];
        [self hiddenView:self.mBuildTableView];

    }else{
        [self.mDoorNumBtn setTitle:[NSString stringWithFormat:@"选择了第%ld行",(long)indexPath.row] forState:UIControlStateSelected];
        [self hiddenView:self.mDoorNumTableView];

    }
    
    MLLog(@"第%ld行",(long)indexPath.row);
    
}

@end
