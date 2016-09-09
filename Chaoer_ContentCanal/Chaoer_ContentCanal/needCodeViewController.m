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

#import "WKChoiceArearView.h"
#import "FZHPickerView.h"

#define kScreenSize [UIScreen mainScreen].bounds.size
@interface needCodeViewController ()<NFPickerViewDelegete,UITextFieldDelegate,WKPickerViewDelegate,WKChoiceArearDelegate,FZHPickerViewDelegate>

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
    
    
    WKChoiceArearView *mPView;
    FZHPickerView *fzpickerView;

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
    
    mBan = mUnit = mFloor = mDoornum = @"1";

    
    
    mAddressStr = nil;
    
    
    mDetailAddressStr = nil;
    [self updatePage];
    [self initPView];

    
}
#pragma mark----装载循环小区楼栋数据
- (void)initViewData{

    NSString *datastr = nil;
    
    for (int i=0; i<=50; i++) {
        
                   datastr = [NSString stringWithFormat:@"%ld栋",(long)i];
            [mTT1 addObject:datastr];
        
        
        
        
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

    if (mDetailAddressStr == 0 || [mDetailAddressStr isEqualToString:@""] || mDetailAddressStr == nil || [mView.mChoiceArearBtn.titleLabel.text isEqualToString:@"请选择小区"]) {
        
        [self showErrorStatus:@"小区名不能为空！请重新选择！"];
        return;
        
    }
    [self loadDoorNum];
}
#pragma mark----加载数据地址
- (void)loadDoorNum{
    [self showWithStatus:@"正在加载..."];
    [mUserInfo getBuilNum:mCommunityId block:^(mBaseData *resb, NSArray *mArr) {
        [self dismiss];

        if (resb.mSucess) {
            
            if (mArr.count == 0) {
                [self showPView];

            }
            else{
                [self showPView];

            }
        }else{
            
            [self showPView];

        }
    }];
    
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
    
    
    if (mView.mNameTx.text.length == 0) {
        [self showErrorStatus:@"请输入户主姓名！"];
        return;
    }
    if (mView.mPhoneTx.text.length == 0) {
        [self showErrorStatus:@"请输入手机号码！"];
        return;
    }
    if (mCityId.length == 0) {
        [self showErrorStatus:@"请选择地区！"];
        return;
    }
    if ([mView.mChoiceArearBtn.titleLabel.text isEqualToString:@"请选择小区"]) {
        [self showErrorStatus:@"请选择小区！"];
        return;
    }
    if ([mView.mChoiceDetailBtn.titleLabel.text isEqualToString:@"如1单元1楼1号"]) {
        [self showErrorStatus:@"请选择详细地址！"];
        return;
    }
    if (!mIdentify.count) {
        [self showErrorStatus:@"请选择您的身份"];
        return;
    }
    

    
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
        
     
        [[mUserInfo backNowUser] realyCodeAndCommunityId:1 andName:mView.mNameTx.text andCommunityId:mBlockArearId andBanNum:mBan andUnitNum:mUnit andFloorNum:mFloor andRoomNum:mDoornum andIdentify:mIdentify[0] andAddcommunity:isUp andcommunityName:mView.mChoiceArearBtn.titleLabel.text andAddress:[NSString stringWithFormat:@"%@%@",mView.mChoiceCityBtn.titleLabel.text,mView.mChoiceArearBtn.titleLabel.text] andProvinceID:mProvinceId andArearId:mArearId andCityId:mCityId andPhone:mView.mPhoneTx.text block:^(mBaseData *resb) {
            if (resb.mSucess ) {
                [SVProgressHUD showSuccessWithStatus:resb.mMessage];
     
                
                [self popViewController];
                
            }else{
                
                [SVProgressHUD showErrorWithStatus:resb.mMessage];
            }
        }];
        
        
        
        
    }else{
        
      
        
        [SVProgressHUD showWithStatus:@"正在操作中..." maskType:SVProgressHUDMaskTypeClear];
        [[mUserInfo backNowUser] realyCodeAndCommunityId:2 andName:mView.mNameTx.text andCommunityId:mBlockArearId andBanNum:mBan andUnitNum:mUnit andFloorNum:mFloor andRoomNum:mDoornum andIdentify:mIdentify[0] andAddcommunity:isUp andcommunityName:mView.mChoiceArearBtn.titleLabel.text andAddress:[NSString stringWithFormat:@"%@%@",mView.mChoiceCityBtn.titleLabel.text,mView.mChoiceArearBtn.titleLabel.text] andProvinceID:mProvinceId andArearId:mArearId andCityId:mCityId andPhone:mView.mPhoneTx.text  block:^(mBaseData *resb) {
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
- (void)initPView{
    
    
    [mTT1 removeAllObjects];
    [mTT2 removeAllObjects];
    [mTT3 removeAllObjects];
    [mTT4 removeAllObjects];
    
    
    for (int k = 1; k<50; k++) {
        
        [mTT1 addObject:[NSString stringWithFormat:@"%ld栋",(long)k]];
    }
    for (int j = 1; j<40; j++) {
        [mTT2 addObject:[NSString stringWithFormat:@"%ld单元",(long)j]];
    }
    
    for (int k = 1; k<50; k++) {
        [mTT3 addObject:[NSString stringWithFormat:@"%d楼",k]];
        
        
    }
    
    for (int l = 1; l<50; l++) {
        [mTT4 addObject:[NSString stringWithFormat:@"%d号",l]];
    }
    
    
    
    
    
    [mPView removeFromSuperview];
    mPView = [WKChoiceArearView shareView];
    mPView.delegate = self;
    mPView.alpha = 0;
    [self.view addSubview:mPView];
    
    [mPView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(@0);
        make.bottom.equalTo(self.view).offset(@0);
        make.height.offset(@200);
    }];
    
    // 选择框
    fzpickerView = [[FZHPickerView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 150)];
    // 显示选中框
    fzpickerView.fzdelegate = self;
    fzpickerView.proTitleList = @[mTT1,mTT2,mTT3,mTT4];
    [fzpickerView show:mPView.mPickView];
    
    
    
}
#pragma mark --- 代理方法
-(void)didSelectedPickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component RowText:(NSString *)text
{
    
    
    MLLog(@"%@---row:%ld",[NSString stringWithFormat:@"您选择了第%ld列的第%ld行，内容是%@",(long)component,(long)row,text],(long)row);
    
    
    switch (component) {
        case 0:
        {
            mBan = [NSString stringWithFormat:@"%ld",row];
        }
            break;
        case 1:
        {
            mUnit = [NSString stringWithFormat:@"%ld",row];
        }
            break;
        case 2:
        {
            mFloor = [NSString stringWithFormat:@"%ld",row];
            
        }
            break;
        case 3:
        {
            mDoornum = [NSString stringWithFormat:@"%ld",row];
            
        }
            break;
            
        default:
            break;
    }
    
    
    
}
- (void)WKCancelAction{
    [self dismissPView];
    
    mBan = mUnit = mFloor = mDoornum = @"1";
    
    [mView.mChoiceDetailBtn setTitle:@"如1单元1楼1号" forState:0];
    
    
}
- (void)WKOKAction{
    [self dismissPView];
    [mView.mChoiceDetailBtn setTitle:[NSString stringWithFormat:@"%@栋%@单元%@楼%@号",mBan,mUnit,mFloor,mDoornum] forState:0];
    
}

- (void)showPView{
    
    [UIView animateWithDuration:0.25 animations:^{

        mPView.alpha = 1;
        
    }];
}

- (void)dismissPView{
    [UIView animateWithDuration:0.25 animations:^{

        
        mPView.alpha = 0;
        
    }];
}

@end
