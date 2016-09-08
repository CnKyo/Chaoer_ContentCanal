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
#import "WKChoiceArearView.h"
#import "FZHPickerView.h"
@interface mFeedPersonViewController ()<UITableViewDelegate,UITableViewDataSource,NFPickerViewDelegete,WKChoiceArearDelegate,FZHPickerViewDelegate>


@end

@implementation mFeedPersonViewController
{
    /**
     *  1是小区 2是楼栋
     */
    int mType;
    
    /**
     *  社区id
     */
    int mCommunityId;
    /**
     *  楼栋
     */
    int mBan;
    /**
     *  单元
     */
    int mUnit;
    /**
     *  门牌号
     */
    int mDoornum;
    /**
     *  楼层
     */
    int mFloor;

    NSMutableArray  *Arrtemp;

    
    NSString *mmProvinceId;
    
    NSString *mmCityId;
    
    NSString *mmArearId;
    NFPickerView *pickerView;
    
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

    Arrtemp = [NSMutableArray new];

    
    self.mSubmit.layer.masksToBounds = YES;
    self.mSubmit.layer.cornerRadius = 3;
    
    
    mmProvinceId = nil;
    mmCityId = nil;
    mmArearId = nil;
    
    
    self.mReason.placeholder = @"在此写上您投诉的原因:";
    [self.mReason setHolderToTop];
    [self initPView];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadData{
    [SVProgressHUD showWithStatus:@"正在加载中..." maskType:SVProgressHUDMaskTypeClear];
    
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
    
  
}


- (void)loadMHActionSheetView{
    [Arrtemp removeAllObjects];

    if (self.tempArray.count !=0 ) {
        for (GCommunity *city in self.tempArray) {
            [Arrtemp addObject:city.mCommunityName];
        }
    }else{
        [self showErrorStatus:@"暂无数据!"];
        return;
    }
    

    
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择小区" style:MHSheetStyleWeiChat itemTitles:Arrtemp];
    actionSheet.cancleTitle = @"取消选择";
    
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        NSString *text = nil;
        
        GCommunity *gm = self.tempArray[index];
        text = [NSString stringWithFormat:@"%@", gm.mCommunityName];
        mCommunityId = gm.mPropertyId;
        self.mValiigeBtn.titleLabel.text = text;
        
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

#pragma mark----门牌号
- (IBAction)mUnitAction:(UIButton *)sender {

    [self showPView];
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

- (void)initPView{
    
    [mPView removeFromSuperview];
    [fzpickerView remove];
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
    fzpickerView.proTitleList = @[@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"],@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"],@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"],@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"]];
    [fzpickerView show:mPView.mPickView];

    
    
}
#pragma mark --- 代理方法
-(void)didSelectedPickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component RowText:(NSString *)text
{
    
    MLLog(@"%@",[NSString stringWithFormat:@"您选择了第%ld列的第%ld行，内容是%@",(long)component,(long)row,text]);
}
- (void)WKCancelAction{
    [self dismissPView];
    
}
- (void)WKOKAction{

}

- (void)showPView{

    [UIView animateWithDuration:0.25 animations:^{
//        CGRect mRRR = mPView.frame;
//        mRRR.origin.y = DEVICE_Height-200;
//        mPView.frame = mRRR;
        mPView.alpha = 1;

    }];
}

- (void)dismissPView{
    [UIView animateWithDuration:0.25 animations:^{
//        CGRect mRRR = mPView.frame;
//        mRRR.origin.y = DEVICE_Height;
//        mPView.frame = mRRR;

        mPView.alpha = 0;
        [fzpickerView remove];

    }];
}
@end
