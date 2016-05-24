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



#import "choiceArearViewController.h"

#import "AbstractActionSheetPicker+Interface.h"//这个是定义取消和确定按钮
#import "ActionSheetPicker.h"
#import "XKPEActionPickersDelegate.h"
#import "XKPEWeightAndHightActionPickerDelegate.h"
#define kScreenSize [UIScreen mainScreen].bounds.size
@interface needCodeViewController ()<XKPEDocPopoDelegate,XKPEWeigthAndHightDelegate,NFPickerViewDelegete,UITextFieldDelegate>

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
    
    NSString *mBlockArearId;

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
    [self initViewData];
    
    
    mAddressStr = nil;
    
    [self updatePage];
    
}

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
    [self showWithStatus:@"正在加载中..."];
    [pickerView removeFromSuperview];
    pickerView = [[NFPickerView alloc] initWithFrame:CGRectMake(20, CGRectGetHeight(self.view.frame)/2-110, CGRectGetWidth(self.view.frame)-40, 220)];
    pickerView.delegate = self;
    [pickerView show];
    [self dismiss];
    
 

    
}

- (void)pickerDidSelectProvinceName:(NSString *)provinceName andProvinId:(int)ProvinceId cityName:(NSString *)cityName andArearId:(int)ArearId countrys:(NSString *)countrys andCityId:(int)CityId{
    
    NSLog(@"省市区名称:%@%@%@",provinceName,cityName,countrys);
    
    [mView.mChoiceCityBtn setTitle:[NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,countrys] forState:0];
    
    mProvinceId = [NSString stringWithFormat:@"%d",ProvinceId];
    mCityId = [NSString stringWithFormat:@"%d",CityId];
    mArearId = [NSString stringWithFormat:@"%d",ArearId];
    
    
    NSLog(@"省市区id:%d-%d-%d",ProvinceId,ArearId,CityId);
    
    
}

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

            }else{
                mBlockArearId = mId;
            }
            
            
            
            [mView.mChoiceArearBtn setTitle:content forState:0];
            
            
        };
        
        [self pushViewController:ccc];
        
    }
    
    
    
}
- (void)mSelectDetailAction:(UIButton *)sender{
    

    _detailAddressPicker = [[XKPEActionPickersDelegate alloc]initWithArr1:mTT1 Arr2:mTT2 arr3:mTT3 arr4:mTT4 title:@"详细住址"];
    _detailAddressPicker.delegates = self;
    
    ActionSheetCustomPicker *action = [[ActionSheetCustomPicker alloc]initWithTitle:@"录入住址" delegate:_detailAddressPicker showCancelButton:YES origin:self.view];
    [action customizeInterface];
    [action showActionSheetPicker];

    
}
//三组数据的点击事件
-(void)xkactionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin{

    
    if ([_detailAddressPicker.title isEqualToString:@"详细住址"]) { //体重处理 当出现弹框但是没有滑动选择就点确认时，获取的数据时空，所以分情况处理
        
        NSLog(@"选择的地址是：%@%@%@",_detailAddressPicker.selectedKey1,_detailAddressPicker.selectedkey2,_detailAddressPicker.selectedkey3);
        
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
        
        mBan = _detailAddressPicker.selectedKey1;
        mUnit = _detailAddressPicker.selectedkey2;
        mFloor = _detailAddressPicker.selectedkey3;
        mDoornum = _detailAddressPicker.selectedkey4;
        
        
        
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
                [mIdentify addObject:NumberWithFloat(2)];
                mView.mOneImg.image = [UIImage imageNamed:@"ppt_add_address_selected"];
                mView.mTwoImg.image = [UIImage imageNamed:@"ppt_add_address_normal"];

            }else{
                sender.selected = NO;
                [mIdentify removeObject:NumberWithFloat(2)];
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
                [mIdentify addObject:NumberWithFloat(1)];
                mView.mTwoImg.image = [UIImage imageNamed:@"ppt_add_address_selected"];
                mView.mOneImg.image = [UIImage imageNamed:@"ppt_add_address_normal"];

            }else{
                sender.selected = NO;
                [mIdentify removeObject:NumberWithFloat(1)];
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
    
    
    
    if (self.Type == 1) {
        [SVProgressHUD showWithStatus:@"正在认证中..." maskType:SVProgressHUDMaskTypeClear];
        
     
        [[mUserInfo backNowUser] realyCodeAndCommunityId:1 andCommunityId:mBlockArearId andBanNum:mBanStr1 andUnitNum:mUnitStr andFloorNum:mFloorStr andRoomNum:mDoorNmStr andIdentify:mIdentify[0] andAddcommunity:isUp andcommunityName:mView.mChoiceArearBtn.titleLabel.text andAddress:[NSString stringWithFormat:@"%@%@",mView.mChoiceCityBtn.titleLabel.text,mView.mChoiceArearBtn.titleLabel.text] andProvinceID:mProvinceId andArearId:mArearId andCityId:mCityId andPhone:mView.mPhoneTx.text block:^(mBaseData *resb) {
            if (resb.mSucess ) {
                [SVProgressHUD showSuccessWithStatus:resb.mMessage];
                verifyBankViewController *vvv = [[verifyBankViewController alloc] initWithNibName:@"verifyBankViewController" bundle:nil];
                [self pushViewController:vvv];
            }else{
                
                [SVProgressHUD showErrorWithStatus:resb.mMessage];
            }
        }];
        
        
        
        
    }else{
        [SVProgressHUD showWithStatus:@"正在操作中..." maskType:SVProgressHUDMaskTypeClear];
        [[mUserInfo backNowUser] realyCodeAndCommunityId:2 andCommunityId:mBlockArearId andBanNum:mBanStr1 andUnitNum:mUnitStr andFloorNum:mFloorStr andRoomNum:mDoorNmStr andIdentify:mIdentify[0] andAddcommunity:isUp andcommunityName:mView.mChoiceArearBtn.titleLabel.text andAddress:[NSString stringWithFormat:@"%@%@",mView.mChoiceCityBtn.titleLabel.text,mView.mChoiceArearBtn.titleLabel.text] andProvinceID:mProvinceId andArearId:mArearId andCityId:mCityId andPhone:mView.mPhoneTx.text  block:^(mBaseData *resb) {
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
