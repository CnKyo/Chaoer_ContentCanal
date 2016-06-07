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
#import "AddressPickView.h"




#import "NFPickerView.h"
#import "WKPickerView.h"


#import "choiceArearViewController.h"

#import "AbstractActionSheetPicker+Interface.h"//这个是定义取消和确定按钮
#import "ActionSheetPicker.h"
#import "XKPEActionPickersDelegate.h"
#import "XKPEWeightAndHightActionPickerDelegate.h"
#define kScreenSize [UIScreen mainScreen].bounds.size
@interface needCodeViewController ()<XKPEDocPopoDelegate,XKPEWeigthAndHightDelegate,NFPickerViewDelegete,UITextFieldDelegate,WKPickerViewDelegate>

@property (nonatomic ,strong) XKPEActionPickersDelegate *detailAddressPicker; //4列

@property (nonatomic , strong) XKPEWeightAndHightActionPickerDelegate *widthAnHigh;//列组

@end

@implementation needCodeViewController
{
    UIScrollView *mScrollerView;
    
    needCodeView    *mView;
    
    
    
    NSString *mProvinceId;

    NSString *mCityId;
    
    NSString *mArearId;
    
    int mType;
    
   int mCommunityId;
    
    NSString *mBan;
    
    NSString *mUnit;
    
    NSString *mDoornum;
    
    NSString *mFloor;
    
    NSMutableArray *mDoornumArr;
    
    NSMutableArray *mUnitArr;
    
    NSMutableArray *mFloorArr;
    
    NSMutableArray  *Arrtemp;
    
    NSInteger mUnitIndex;
    
    
    NSMutableArray *mIdentify;
    
    AddressPickView *addressPickView;
    NSString *mAddressStr;
    
    
    
    
    NSMutableArray *mTT1;
    NSMutableArray *mTT2;
    NSMutableArray *mTT3;
    NSMutableArray *mTT4;

    
    NFPickerView *pickerView;

    WKPickerView *mDetailPickView;
    
    NSString *mBlockArearId;
    
    
    
    /**
     *  详细地址
     */
    NSString *mDetailAddressStr;

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
    NSString *mtt = nil;
    if (self.Type == 1) {
        mtt = @"实名认证";
    }else{
        mtt = @"添加房屋";
    }
    
    self.Title = self.mPageName = mtt;
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    mType = 1;
    
    mDoornumArr = [NSMutableArray new];
    mUnitArr = [NSMutableArray new];
    mFloorArr = [NSMutableArray new];

    Arrtemp = [NSMutableArray new];
    mIdentify = [NSMutableArray new];

    mCommunityId = 0;
    mBlockArearId = nil;
    
    mProvinceId = nil;
    mCityId = nil;
    mArearId = nil;
    
    mTT1 = [NSMutableArray new];
    mTT2 = [NSMutableArray new];
    mTT3 = [NSMutableArray new];
    mTT4 = [NSMutableArray new];
    
    mBan = nil;
    mUnit = nil;
    mFloor= nil;
    mDoornum= nil;
    
    
    mAddressStr = nil;
    
    
    mDetailAddressStr = nil;
    [self updatePage];
    
}
#pragma mark----装载循环小区楼栋数据
- (void)initViewData{

    NSString *datastr = nil;
    
    for (int i=0; i<=50; i++) {
        
        if (i == 0) {
            datastr = [NSString stringWithFormat:@"楼栋"];
            [mTT1 addObject:datastr];
        }else{
            datastr = [NSString stringWithFormat:@"%ld栋",(long)i];
            [mTT1 addObject:datastr];
        }
        
        
        
    }
    for (int i=0; i<=40; i++) {
        NSString *datastr = nil;
        
        if (i == 0) {
            datastr = [NSString stringWithFormat:@"单元"];
            [mTT2 addObject:datastr];
        }else{
            datastr = [NSString stringWithFormat:@"%ld单元",(long)i];
            [mTT2 addObject:datastr];
        }
        
        
        
    }
    for (int i=0; i<=50; i++) {
        NSString *datastr = nil;
        
        if (i == 0) {
            datastr = [NSString stringWithFormat:@"楼层"];
            [mTT3 addObject:datastr];
        }else{
            datastr = [NSString stringWithFormat:@"%ld楼",(long)i];
            [mTT3 addObject:datastr];
        }
        
        
        
    }
    for (int i=0; i<=50; i++) {
        NSString *datastr = nil;
        
        if (i == 0) {
            datastr = [NSString stringWithFormat:@"门牌号"];
            [mTT4 addObject:datastr];
        }else{
            datastr = [NSString stringWithFormat:@"%ld号",(long)i];
            [mTT4 addObject:datastr];
        }
        
        
        
    }
}


- (void)updatePage{
    mScrollerView = [UIScrollView new];
    mScrollerView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64);
    mScrollerView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.93 alpha:0.45];
    [self.view addSubview:mScrollerView];
    
    
    mView = [needCodeView initWithView];
    mView.frame = CGRectMake(0, 0, DEVICE_Width, 568);
    
    
    mView.mPhoneTx.delegate = self;

    if ([mUserInfo backNowUser].mPhone) {
        mView.mPhoneTx.text = [mUserInfo backNowUser].mPhone;
//        mView.mPhoneTx.enabled = NO;
    }else{
    

    }
    
    [mView.mChoiceCityBtn addTarget:self action:@selector(mSelectCityAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mChoiceArearBtn addTarget:self action:@selector(mSelectArearAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mChoiceDetailBtn addTarget:self action:@selector(mSelectDetailAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mOneBtn addTarget:self action:@selector(mOneAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mTwoBtn addTarget:self action:@selector(mOneAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [mView.mTijiaoBtn addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
    [mScrollerView addSubview:mView];
    
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 568);

    
    
    
    
    
}

#pragma mark----加载地址
- (void)loadAddress{
    
   
    [self showWithStatus:@"正在加载..."];
    [[mUserInfo backNowUser] getCodeAddress:^(mBaseData *resb, NSArray *mArr) {
        
        [self.tempArray removeAllObjects];
        if (resb.mSucess) {
            [self.tempArray addObjectsFromArray:mArr];
        }else{
        
            [self showErrorStatus:resb.mMessage];
        }
    }];
    

}

#pragma mark----重新设计后的界面⬇️
- (void)mSelectCityAction:(UIButton *)sender{
    [self loadAddressPick];
    
}

- (void)loadAddressPick{
    
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
#pragma mark----选择地址代理方法
- (void)pickerDidSelectProvinceName:(NSString *)provinceName andProvinId:(int)ProvinceId cityName:(NSString *)cityName andArearId:(int)ArearId countrys:(NSString *)countrys andCityId:(int)CityId{
    
    MLLog(@"省市区名称:%@%@%@",provinceName,cityName,countrys);
    
    [mView.mChoiceCityBtn setTitle:[NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,countrys] forState:0];
    
    mProvinceId = [NSString stringWithFormat:@"%d",ProvinceId];
    mCityId = [NSString stringWithFormat:@"%d",CityId];
    mArearId = [NSString stringWithFormat:@"%d",ArearId];
    
    
    MLLog(@"省市区id:%d-%d-%d",ProvinceId,ArearId,CityId);
    
    
}
#pragma mark----选择详细地址代理方法
- (void)WKPickerViewSelectedView:(NSDictionary *)obj{

    
}

#pragma mark----选择小区
- (void)mSelectArearAction:(UIButton *)sender{
    
    
    if (mProvinceId == nil || mProvinceId.length == 0 || [mProvinceId isEqualToString:@""]) {
        [self showErrorStatus:@"请选择地区！"];
        return;
    }else{
        choiceArearViewController *ccc = [[choiceArearViewController alloc] initWithNibName:@"choiceArearViewController" bundle:nil];
        
        ccc.mProvinceId = mProvinceId;
        ccc.mArearId= mArearId;
        ccc.mCityId = mCityId;
        
        ccc.block = ^(NSString *content ,NSString *mId){
            
            
            
            if (mId == nil || mId.length == 0 ||[mId isEqualToString:@""]) {

                mBlockArearId = @"";
                [self initViewData];
            }else{
                mBlockArearId = mId;
                [self loadArearData];
            }
            
            if (content.length == 0 || [content isEqualToString:@""] || content == nil) {
                
            }else{
                mDetailAddressStr = content;
                [mView.mChoiceArearBtn setTitle:mDetailAddressStr forState:0];
            }
            
        
            
        };
        
        [self pushViewController:ccc];
        
    }
    
    
    
}

#pragma mark----加载小区数据
/**
 *  加载小区数据
 */
- (void)loadArearData{

    [self showWithStatus:@"正在加载..."];
    [[mUserInfo backNowUser] getBanAndUnitAndFloors:mBlockArearId block:^(mBaseData *resb, NSArray *mArr) {
        [self dismiss];
//        if (resb.mSucess) {
        
            
 
            
//            [self reloadData:mArr];
//            
//            
//        }else{
        
            [self initViewData];

//        }
        
        
    }];
    
    
}
- (void)reloadData:(NSArray *)mData{

    
    [mTT1 removeAllObjects];
    [mTT2 removeAllObjects];
    [mTT3 removeAllObjects];
    [mTT4 removeAllObjects];
    
    for (int i = 0; i<mData.count; i++) {
        
        GAddArearObj *mAddObj = mData[i];
        
        [mTT1 addObject:[NSString stringWithFormat:@"%d栋",mAddObj.mBan]];
        
        GArearUnitAndFloorObj *mUnitObj = mAddObj.mUnitList[0];
        
        if (i == 0) {
            for (int j = 0; j<mUnitObj.mUnit; j++) {
                [mTT2 addObject:[NSString stringWithFormat:@"%d单元",j+1]];
            }
            
            for (int k = 0; k<mUnitObj.mFloor; k++) {
                [mTT3 addObject:[NSString stringWithFormat:@"%d楼",k+1]];
                
                
            }
            
            for (int l = 0; l<mUnitObj.mRoomNum; l++) {
                [mTT4 addObject:[NSString stringWithFormat:@"%d号",l+1]];
            }
            
        }
       
    }
    
    
    
    
}
#pragma mark----选择详细地址
/**
 *  选择详细地址
 *
 *  @param sender
 */
- (void)mSelectDetailAction:(UIButton *)sender{
    
//    if (mBlockArearId == nil || mBlockArearId.length == 0 || [mBlockArearId isEqualToString:@""]) {
//        [self showErrorStatus:@"小区名不能为空！请重新选择！"];
//        return;
//    }
    
    
    if (mDetailAddressStr == 0 || [mDetailAddressStr isEqualToString:@""] || mDetailAddressStr == nil || [mView.mChoiceArearBtn.titleLabel.text isEqualToString:@"请选择小区"]) {
        
        [self showErrorStatus:@"小区名不能为空！请重新选择！"];
        return;
        
    }
    
    _detailAddressPicker = [[XKPEActionPickersDelegate alloc]initWithArr1:mTT1 Arr2:mTT2 arr3:mTT3 arr4:mTT4 title:@"详细住址"];
    _detailAddressPicker.delegates = self;
    
    ActionSheetCustomPicker *action = [[ActionSheetCustomPicker alloc]initWithTitle:@"录入住址" delegate:_detailAddressPicker showCancelButton:YES origin:self.view];
    [action customizeInterface];
    [action showActionSheetPicker];

    
}
//三组数据的点击事件
-(void)xkactionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin{

    
    if ([_detailAddressPicker.title isEqualToString:@"详细住址"]) { //体重处理 当出现弹框但是没有滑动选择就点确认时，获取的数据时空，所以分情况处理
        
        MLLog(@"选择的地址是：%@%@%@",_detailAddressPicker.selectedKey1,_detailAddressPicker.selectedkey2,_detailAddressPicker.selectedkey3);
        
        if ([_detailAddressPicker.selectedKey1 isEqualToString:@"楼栋"]) {
            [mView.mChoiceDetailBtn setTitle:[NSString stringWithFormat:@"%@%@%@%@",mTT1[0],_detailAddressPicker.selectedkey2,_detailAddressPicker.selectedkey3,_detailAddressPicker.selectedkey4] forState:0];
        }
        if ([_detailAddressPicker.selectedkey2 isEqualToString:@"单元"]) {
            [mView.mChoiceDetailBtn setTitle:[NSString stringWithFormat:@"%@%@%@%@",_detailAddressPicker.selectedKey1,mTT2[0],_detailAddressPicker.selectedkey3,_detailAddressPicker.selectedkey4] forState:0];
        }
        if ([_detailAddressPicker.selectedkey3 isEqualToString:@"楼层"]) {
            [mView.mChoiceDetailBtn setTitle:[NSString stringWithFormat:@"%@%@%@%@",_detailAddressPicker.selectedKey1,_detailAddressPicker.selectedkey2,mTT3[0],_detailAddressPicker.selectedkey4] forState:0];
        }
        if ([_detailAddressPicker.selectedkey4 isEqualToString:@"门牌号"]) {
            [mView.mChoiceDetailBtn setTitle:[NSString stringWithFormat:@"%@%@%@%@",_detailAddressPicker.selectedKey1,_detailAddressPicker.selectedkey2,_detailAddressPicker.selectedkey3,mTT4[0]] forState:0];
        }
        if (_detailAddressPicker.selectedKey1 == nil || _detailAddressPicker.selectedkey2 == nil || _detailAddressPicker.selectedkey3 == nil || _detailAddressPicker.selectedkey4 == nil) {
            
            
            
            [mView.mChoiceDetailBtn setTitle:[NSString stringWithFormat:@"%@%@%@%@",mTT1[0],mTT2[0],mTT3[0],mTT4[0]] forState:0];
            
            
        }else{
            [mView.mChoiceDetailBtn setTitle:[NSString stringWithFormat:@"%@%@%@%@",_detailAddressPicker.selectedKey1,_detailAddressPicker.selectedkey2,_detailAddressPicker.selectedkey3,_detailAddressPicker.selectedkey4] forState:0];
        }
        
        if (mTT1.count == 1) {
            mBan = mTT1[0];
        }else{
            mBan = _detailAddressPicker.selectedKey1;
        }
        
        if (mTT2.count == 1) {
            mUnit = mTT2[0];
        }else{
            mUnit = _detailAddressPicker.selectedkey2;
        }
        if (mTT3.count == 0) {
            mFloor = mTT3[0];
        }else{
            mFloor = _detailAddressPicker.selectedkey3;
        }
        
        if (mTT4.count == 0 ) {
            mDoornum = mTT4[0];
        }else{
            mDoornum = _detailAddressPicker.selectedkey4;
        }
        
        if (_detailAddressPicker.selectedKey1 == nil) {
            mBan = mTT1[0];
        }else{
            mBan = _detailAddressPicker.selectedKey1;
        }
        
        if ( _detailAddressPicker.selectedkey2 == nil) {
            mUnit = mTT2[0];
        }else{
            mUnit = _detailAddressPicker.selectedkey2;
        }
        if ( _detailAddressPicker.selectedkey3 == nil) {
            mFloor = mTT3[0];
        }else{
            mFloor = _detailAddressPicker.selectedkey3;
        }
        
        if ( _detailAddressPicker.selectedkey4 == nil) {
            mDoornum = mTT4[0];
        }else{
            mDoornum = _detailAddressPicker.selectedkey4;
        }
        
        [mView.mChoiceDetailBtn setTitle:[NSString stringWithFormat:@"%@%@%@%@",mBan,mUnit,mFloor,mDoornum] forState:0];

        
        
    }

    
    
}


- (void)mOneAction:(UIButton *)sender{
    [mIdentify removeAllObjects];
    
    switch (sender.tag) {
        case 1:
        {
            if (sender.selected == NO) {
                mView.mMasterBtn.selected = YES;
                mView.mVisitorBtn.selected = NO;
                [mIdentify addObject:NumberWithFloat(1)];
                mView.mOneImg.image = [UIImage imageNamed:@"ppt_add_address_selected"];
                mView.mTwoImg.image = [UIImage imageNamed:@"ppt_add_address_normal"];

            }else{
                sender.selected = NO;
                [mIdentify removeObject:NumberWithFloat(1)];
                mView.mOneImg.image = [UIImage imageNamed:@"ppt_add_address_normal"];
                mView.mTwoImg.image = [UIImage imageNamed:@"ppt_add_address_normal"];


                
            }
        }
            break;
        case 2:
        {
            if (sender.selected == NO) {
                mView.mMasterBtn.selected = NO;
                mView.mVisitorBtn.selected = YES;
                [mIdentify addObject:NumberWithFloat(2)];
                mView.mTwoImg.image = [UIImage imageNamed:@"ppt_add_address_selected"];
                mView.mOneImg.image = [UIImage imageNamed:@"ppt_add_address_normal"];

            }else{
                sender.selected = NO;
                [mIdentify removeObject:NumberWithFloat(2)];
                mView.mTwoImg.image = [UIImage imageNamed:@"ppt_add_address_normal"];
                mView.mOneImg.image = [UIImage imageNamed:@"ppt_add_address_normal"];

            }
        }
            break;
            
        default:
            break;
    }

}

#pragma mark----重新设计后的界面⬆️


#pragma mark----实名认证
- (void)commitAction:(UIButton *)sender{
    
    
    if ([mView.mDoorNumLb.text isEqualToString:@"选择门牌号"]) {
        [SVProgressHUD showErrorWithStatus:@"请完善你的信息!"];
        return;
    }
    if (!mIdentify.count) {
        [self showErrorStatus:@"请选择您的身份"];
        return;
    }
    
    if (mBan == nil || mBan.length <= 0 ||[mBan isEqualToString:@""] || [mBan isEqualToString:@"楼栋"]) {
        [self showErrorStatus:@"请完善详细地址！"];
        return;
    }
    if (mUnit == nil || mUnit.length <= 0 ||[mUnit isEqualToString:@""] || [mUnit isEqualToString:@"单元"]) {
        [self showErrorStatus:@"请完善详细地址！"];
        return;
    }
    if (mFloor == nil || mFloor.length <= 0 ||[mFloor isEqualToString:@""] || [mFloor isEqualToString:@"楼层"]) {
        [self showErrorStatus:@"请完善详细地址！"];
        return;
    }
    if (mDoornum == nil || mDoornum.length <= 0 ||[mDoornum isEqualToString:@""] || [mDoornum isEqualToString:@"门牌号"]) {
        [self showErrorStatus:@"请完善详细地址！"];
        return;
    }
    
    NSArray *mBanArr = [mBan componentsSeparatedByString:@"栋"];
    NSString *mBanStr1 = [mBanArr objectAtIndex:0];
    
    NSArray *mUnitArrr = [mUnit componentsSeparatedByString:@"单元"];
    NSString *mUnitStr = [mUnitArrr objectAtIndex:0];
    
    
    NSArray *mFloorArrr = [mFloor componentsSeparatedByString:@"楼"];
    NSString *mFloorStr = [mFloorArrr objectAtIndex:0];
    
    
    
    NSArray *mDoomNumArr = [mDoornum componentsSeparatedByString:@"号"];
    NSString *mDoorNmStr = [mDoomNumArr objectAtIndex:0];
    
    BOOL isUp;
    
    if (mBlockArearId == nil || mBlockArearId.length == 0 || [mBlockArearId isEqualToString:@""]) {
        isUp = YES;
    }else{
        isUp = NO;
    }
    
    if (mView.mNameTx.text.length == 0) {
        [self showErrorStatus:@"姓名不能为空！"];
        [mView.mNameTx becomeFirstResponder];
        [mView.mNameTx shake];
        return;
    }
    
    if (self.Type == 1) {
        [SVProgressHUD showWithStatus:@"正在认证中..." maskType:SVProgressHUDMaskTypeClear];
        
     
        [[mUserInfo backNowUser] realyCodeAndCommunityId:1 andName:mView.mNameTx.text andCommunityId:mBlockArearId andBanNum:mBanStr1 andUnitNum:mUnitStr andFloorNum:mFloorStr andRoomNum:mDoorNmStr andIdentify:mIdentify[0] andAddcommunity:isUp andcommunityName:mView.mChoiceArearBtn.titleLabel.text andAddress:[NSString stringWithFormat:@"%@%@",mView.mChoiceCityBtn.titleLabel.text,mView.mChoiceArearBtn.titleLabel.text] andProvinceID:mProvinceId andArearId:mArearId andCityId:mCityId andPhone:mView.mPhoneTx.text block:^(mBaseData *resb) {
            if (resb.mSucess ) {
                [SVProgressHUD showSuccessWithStatus:resb.mMessage];
     
                
                [self popViewController];
                
            }else{
                
                [SVProgressHUD showErrorWithStatus:resb.mMessage];
            }
        }];
        
        
        
        
    }else{
        
      
        
        [SVProgressHUD showWithStatus:@"正在操作中..." maskType:SVProgressHUDMaskTypeClear];
        [[mUserInfo backNowUser] realyCodeAndCommunityId:2 andName:mView.mNameTx.text andCommunityId:mBlockArearId andBanNum:mBanStr1 andUnitNum:mUnitStr andFloorNum:mFloorStr andRoomNum:mDoorNmStr andIdentify:mIdentify[0] andAddcommunity:isUp andcommunityName:mView.mChoiceArearBtn.titleLabel.text andAddress:[NSString stringWithFormat:@"%@%@",mView.mChoiceCityBtn.titleLabel.text,mView.mChoiceArearBtn.titleLabel.text] andProvinceID:mProvinceId andArearId:mArearId andCityId:mCityId andPhone:mView.mPhoneTx.text  block:^(mBaseData *resb) {
            if (resb.mSucess ) {
                [SVProgressHUD showSuccessWithStatus:resb.mMessage];
               
                [self popViewController];
            }else{
                
                [SVProgressHUD showErrorWithStatus:resb.mMessage];
            }
        }];
        

    }
    
    
}

- (void)choiseAction:(UIButton *)sender{
    [mIdentify removeAllObjects];

    switch (sender.tag) {
        case 1:
        {
            if (sender.selected == NO) {
                mView.mMasterBtn.selected = YES;
                mView.mVisitorBtn.selected = NO;
                [mIdentify addObject:NumberWithFloat(2)];

            }else{
                sender.selected = NO;
                [mIdentify removeObject:NumberWithFloat(2)];

            }
        }
            break;
        case 2:
        {
            if (sender.selected == NO) {
                mView.mMasterBtn.selected = NO;
                mView.mVisitorBtn.selected = YES;
                [mIdentify addObject:NumberWithFloat(1)];

            }else{
                sender.selected = NO;
                [mIdentify removeObject:NumberWithFloat(1)];

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
///限制电话号码输入长度
#define TEXT_MAXLENGTH 11
///限制验证码输入长度
#define PASS_LENGHT 20
#pragma mark **----键盘代理方法
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *new = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSInteger res;
    if (textField.tag==20) {
        res= PASS_LENGHT-[new length];
        
        
    }else
    {
        res= TEXT_MAXLENGTH-[new length];
        
    }
    if(res >= 0){
        return YES;
    }
    else{
        NSRange rg = {0,[string length]+res};
        if (rg.length>0) {
            NSString *s = [string substringWithRange:rg];
            [textField setText:[textField.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    
}

@end
