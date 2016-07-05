
//
//  releasePPtViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/12.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "releasePPtViewController.h"

#import "releaseCell.h"
#import "BlockButton.h"
#import "pptMyAddressViewController.h"
#import "bolterViewController.h"


#import "mPriceView.h"

#import "LTPickerView.h"

@interface releasePPtViewController ()<UITableViewDelegate,UITableViewDataSource,AMapLocationManagerDelegate,UITextFieldDelegate>

@end

@implementation releasePPtViewController
{
    
    mPriceView *mPopView;
    
    
    NSString *mMin;
    NSString *mMax;
    
    
    /**
     *  地址
     */
    NSString *mAddressStr;
    NSString *mAddressId;
    /**
     *  纬度
     */
    NSString *mLat;
    /**
     *  经度
     */
    NSString *mLng;
    AMapLocationManager *mLocation;
    
    
    /**
     *  需求内容
     */
    NSString *mContentStr;
    /**
     *  价格
     */
    NSString *mPrice;
    NSString *mPriceTT;
    /**
     *  酬金
     */
    NSString *mMoney;
    NSString *mMoneyTT;
    /**
     *  时间
     */
    NSString *mTimeStr;
    NSString *mTTStr;

    /**
     *  电话
     */
    NSString *mPhoneStr;
    /**
     *  回调地址
     */
    NSString *mBlockAddressStr;
    /**
     *  备注
     */
    NSString *mNoteStr;
    /**
     *  标签
     */
    NSString *mTagStr;
    
    NSString *mTagIds;

    NSString *mToolStr;
    NSString *mToolId;
    
    NSString *mGoodsName;
    NSString *mGoodsPrice;
    NSString *mSendAddress;
    NSString *mArriveAddress;


    /**
     *  时间段
     */
    NSString *mSelecteTimeStr;
    
    
    LTPickerView*LtpickerView;

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
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"发布跑腿";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.hiddenRightBtn = YES;
    
    mTagIds = nil;
    mMin = nil;
    mMax = nil;
    mLat = nil;
    mLng = nil;
    mAddressId = nil;
    mTagStr = nil;
    mTTStr = nil;
    mAddressStr = nil;
    mContentStr = nil;
    mPriceTT = nil;
    mPrice = nil;
    mMoneyTT = nil;
    mMoney = nil;
    mTimeStr = nil;
    mPhoneStr = nil;
    mBlockAddressStr = nil;
    mNoteStr = nil;
    
    mToolStr = nil;
    mToolId = nil;
    mGoodsName = nil;
    mGoodsPrice = nil;
    mArriveAddress = nil;
    mSendAddress = nil;
    
    mSelecteTimeStr = nil;
    [self initView];
    
    UIView *mBottomView = [UIView new];
    mBottomView.frame = CGRectMake(0, DEVICE_Height-60, DEVICE_Width, 60);
    mBottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mBottomView];
    
    UIButton *mBtn = [UIButton new];
    mBtn.frame = CGRectMake(15, 10, DEVICE_Width-30, 40);
    mBtn.layer.masksToBounds = YES;
    mBtn.layer.cornerRadius = 3;
    mBtn.backgroundColor = M_CO;
    [mBtn setTitle:@"发布" forState:0];
    [mBtn setTitleColor:[UIColor whiteColor] forState:0];
    
    [mBtn addTarget:self action:@selector(mReleaseAction:) forControlEvents:UIControlEventTouchUpInside];
  
    [mBottomView addSubview:mBtn];
    
    [self loadPopView];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
    
}

- (void)tap{
    [self hiddenPopView];
}
#pragma mark----加载价格view
- (void)loadPopView{

    mPopView = [mPriceView shareView];
    mPopView.backgroundColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:0.75];
    mPopView.alpha = 0;
    [mPopView.mCancelBtn addTarget:self action:@selector(mCancelAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [mPopView.mOkBtn addTarget:self action:@selector(mOkAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:mPopView];
    
    [mPopView makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.top.bottom.equalTo(self.view).offset(@0);
    }];
    
    
}
- (void)mCancelAction:(UIButton *)sender{
    [self hiddenPopView];
}
- (void)mOkAction:(UIButton *)sender{

    if (mPopView.mMin.text.length == 0) {
        [self showErrorStatus:@"请输入最低价!"];
        [mPopView.mMin becomeFirstResponder];
        return;
    }
    if (mPopView.mMax.text.length == 0) {
        [self showErrorStatus:@"请输入最高价!"];
        [mPopView.mMax becomeFirstResponder];
        return;
    }
    mMin = mPopView.mMin.text;
    mMax = mPopView.mMax.text;
    
    int mIn = 0;
    mIn = [mMin intValue];
    int mAx = 0;
    mAx = [mMax intValue];
    if (mIn > mAx) {
        [self showErrorStatus:@"最高价不能低于最低价！"];
        [mPopView.mMax becomeFirstResponder];

        return;
    }else{
        [self hiddenPopView];
        
        [self.tableView reloadData];
    }


    
}
- (void)showPopView{

    [UIView animateWithDuration:0.25 animations:^{
        mPopView.alpha = 1;
        
    }];
    
}

- (void)hiddenPopView{
    [UIView animateWithDuration:0.25 animations:^{
        mPopView.alpha = 0;
        
    }];
    
}

- (void)initView{
    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;

    self.haveHeader = YES;
    
    UINib   *nib = [UINib nibWithNibName:@"releaseCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    nib = [UINib nibWithNibName:@"releaseCell2" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];
    nib = [UINib nibWithNibName:@"releaseCell3" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell3"];
    nib = [UINib nibWithNibName:@"releaseCell4" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell4"];
    nib = [UINib nibWithNibName:@"releaseCell5" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell5"];
    nib = [UINib nibWithNibName:@"releaseCell6" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell6"];
    
}

- (void)headerBeganRefresh{

    mLocation = [[AMapLocationManager alloc] init];
    mLocation.delegate = self;
    [mLocation setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    mLocation.locationTimeout = 3;
    mLocation.reGeocodeTimeout = 3;
    [WJStatusBarHUD showLoading:@"正在定位中..."];
    [mLocation requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        [self headerEndRefresh];
        if (error)
        {
            
            NSString *eee =@"定位失败！请检查网络和定位设置！";
            [WJStatusBarHUD showErrorImageName:nil text:eee];
            mAddressStr = eee;
            MLLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
        }
        if (location) {
            NSLog(@"location:%@", location);
            mLat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
            mLng = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
        }
    
        if (regeocode)
        {
            [WJStatusBarHUD showSuccessImageName:nil text:@"定位成功"];
            
            MLLog(@"reGeocode:%@", regeocode);
            mAddressStr = [NSString stringWithFormat:@"%@%@%@",regeocode.formattedAddress,regeocode.street,regeocode.number];
            
        }
        [self.tableView reloadData];
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
    
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        
        return 210;
    }else if (indexPath.row == 1){
        if (self.mType == 1) {
            return 110;
            
        }
        else if (self.mType == 2) {
            
            return 50;
            
            
        }else{
            return 160;
            
            
        }
    }else{
        if (self.mType == 3) {
            return 360;
        }else{
            return 215;
        }
        
        
        
    }
    

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *reuseCellId = nil;

    if (indexPath.row == 0) {
        
        reuseCellId = @"cell";
        
        releaseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.mAddress.text = mAddressStr;
        
        mContentStr = cell.mContentTx.text;
        
        if (self.mType == 2) {
            cell.mAddTagBtn.hidden = YES;
        }else{
            cell.mAddTagBtn.hidden = NO;

        }
        
        [cell.mAddTagBtn addTarget:self action:@selector(mTagAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        if (mTagStr == nil || mTagStr.length == 0 || [mTagStr isEqualToString:@""]) {
            
        }else{
        
            
            for (UILabel *lb in cell.mTagiew.subviews) {
                [lb removeFromSuperview];
            }
            
            
            CGFloat W = [Util labelTextWithWidth:mTagStr]+20;
            
            UILabel *lll = [UILabel new];
            lll.frame = CGRectMake(15, 5, W, 30);
            lll.text = mTagStr;
            lll.textAlignment = NSTextAlignmentCenter;
            lll.font = [UIFont systemFontOfSize:13];
            lll.textColor = [UIColor whiteColor];
            lll.backgroundColor = [UIColor colorWithRed:0.60 green:0.78 blue:0.96 alpha:1.00];
            lll.layer.masksToBounds = YES;
            lll.layer.cornerRadius = 15;
            [cell.mTagiew addSubview:lll];
            
        }
        
        return cell;
        
    }else if (indexPath.row == 1){
        
        if (self.mType == 1) {
            reuseCellId = @"cell2";
            
            releaseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            mMoney = cell.mMoneyTx.text;
            
            cell.mMoneyTx.delegate = self;
            
            if (mMin != nil || mMax != nil) {
                
                [cell.mPriceBtn setTitle:[NSString stringWithFormat:@"%@元至%@元",mMin,mMax] forState:0];
                
                
            }
     
            
            [cell.mPriceBtn addTarget:self action:@selector(mPriceAction:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
            
        }
        
        else  if (self.mType == 2) {
            reuseCellId = @"cell3";
            
            releaseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.mMoneyTx.delegate = self;
            mMoney = cell.mMoneyTx.text;
         
            
            return cell;
            
        }else{
            
            reuseCellId = @"cell6";
            
            releaseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            mMoney = cell.mMoneyTx.text;
            mGoodsName = cell.mGoodsName.text;

            cell.mMoneyTx.delegate = self;
            mGoodsPrice = cell.mGoodsPriceTx.text;
            
            return cell;
        }
    }else{
        
        if (self.mType == 3) {
            reuseCellId = @"cell5";
            
            releaseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell.mChoiceTool addTarget:self action:@selector(choiceToolAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.mtimeBtn addTarget:self action:@selector(mSelectTimeAction:) forControlEvents:UIControlEventTouchUpInside];
            
            if (mToolStr != nil) {
                [cell.mChoiceTool setTitle:mToolStr forState:0];

            }
            mTimeStr = cell.mTime.text;
            
            mPhoneStr = cell.mPhone.text;
            mNoteStr = cell.mNoteTX.text;
            mSendAddress = cell.mSndAddressTx.text;
            mArriveAddress = cell.mArriveAddressTx.text;
            cell.mPhone.delegate = self;
            cell.mTime.delegate = self;
            cell.mNoteTX.delegate = self;
            
            
            return cell;
        }else{
            reuseCellId = @"cell4";
            
            releaseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell.mAddressBtn addTarget:self action:@selector(addressAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.mtimeBtn addTarget:self action:@selector(mSelectTimeAction:) forControlEvents:UIControlEventTouchUpInside];

            mTimeStr = cell.mTime.text;
            
            mPhoneStr = cell.mPhone.text;
            mNoteStr = cell.mNoteTX.text;
            
            cell.mPhone.delegate = self;
            cell.mTime.delegate = self;
            cell.mNoteTX.delegate = self;
            return cell;
        }
        

    }

    
}
#pragma mark----选择时间短
- (void)mSelectTimeAction:(UIButton *)sender{

    NSArray *mTT = @[@"30分钟",@"60分钟",@"90分钟",@"2小时",@"3小时",@"4小时",@"5小时",@"8小时",@"12小时"];
    
//    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择地址:" style:MHSheetStyleWeiChat itemTitles:mTT];
//    actionSheet.cancleTitle = @"取消选择";
//    
//    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
//        
//         NSArray *mTT2 = @[@"30",@"60",@"90",@"120",@"180",@"240",@"300",@"480",@"720"];
//        
//        [sender setTitle:title forState:0];
//        mSelecteTimeStr = mTT2[index-1];
//        [self.tableView reloadData];
//        
//    }];

   LtpickerView = [LTPickerView new];
    LtpickerView.dataSource = mTT;//设置要显示的数据
    LtpickerView.defaultStr = mTT[0];//默认选择的数据
    [LtpickerView show];//显示
    __weak __typeof(self)weakSelf = self;

    //回调block
    LtpickerView.block = ^(LTPickerView* obj,NSString* str,int num){
        //obj:LTPickerView对象
        //str:选中的字符串
        //num:选中了第几行
        MLLog(@"选择了第%d行的%@",num,str);
        NSArray *mTT2 = @[@"30",@"60",@"90",@"120",@"180",@"240",@"300",@"480",@"720"];
        
        [sender setTitle:[NSString stringWithFormat:@"%@内送达",str] forState:0];
        mSelecteTimeStr = mTT2[num];
        [weakSelf.tableView reloadData];
    
    
    };

    
    
}

- (void)choiceToolAction:(UIButton *)sender{

    [self LoadTool];
    
}
- (void)LoadTool{

    [self showWithStatus:@"正在加载..."];
    [[mUserInfo backNowUser] getTool:^(mBaseData *resb, NSArray *mArr) {
        [self dismiss];
        if (resb.mSucess) {
            
            [self loadActionSheet:mArr];
            
        }else{
            [self showErrorStatus:resb.mMessage];
        }
    }];
    
}
- (void)loadActionSheet:(NSArray *)mARR{
 
    NSMutableArray *mTT = [NSMutableArray new];
    
    
    for (GPPTools *mTool in mARR) {
    
        [mTT addObject:mTool.mToolName];
        
    }
    
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择交通工具" style:MHSheetStyleWeiChat itemTitles:mTT];
    actionSheet.cancleTitle = @"取消选择";
    
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        GPPTools *mTool = mARR[index];
    
        mToolStr = mTool.mToolName;
        mToolId = [NSString stringWithFormat:@"%d",mTool.mId];
        
        [self.tableView reloadData];
    }];

}
#pragma mark----选择价格
- (void)mPriceAction:(UIButton *)sender{

    [self showPopView];
}
- (void)mTagAction:(UIButton *)sender{
    bolterViewController *bbb =[[bolterViewController alloc] initWithNibName:@"bolterViewController" bundle:nil];
    bbb.mType = 1;
    bbb.mSubType = self.mSubType;
    
    bbb.block = ^(NSString *content,NSString *mTagId){
        mTagStr = content;
        mTagIds = mTagId;
        [self.tableView reloadData];
    };

    
    [self pushViewController:bbb];

}
- (void)addressAction:(UIButton *)sender{

    
    pptMyAddressViewController *ppt = [[pptMyAddressViewController alloc] initWithNibName:@"pptMyAddressViewController" bundle:nil];
    ppt.mType = 1;
    ppt.block = ^(NSString *content ,NSString *mId){
        mBlockAddressStr = content;
        mAddressId = mId;
        [sender setTitle:content forState:0];
    };
    [self pushViewController:ppt];

    
}

///限制电话号码输入长度
#define TEXT_MAXLENGTH 11
///限制验证码输入长度
#define PASS_LENGHT 20
#pragma mark **----键盘代理方法
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *new = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSInteger res;
    if (textField.tag==11) {
        res= TEXT_MAXLENGTH-[new length];
        
    }else
    {
        res= PASS_LENGHT-[new length];
        
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

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 200) {
        mTTStr = [NSString stringWithFormat:@"%@分钟",textField.text];
        [self.tableView reloadData];
    }else if (textField.tag == 1){
        mPriceTT = [NSString stringWithFormat:@"%@元",textField.text];
        [self.tableView reloadData];
    }else if(textField.tag == 2){
        mMoneyTT = [NSString stringWithFormat:@"%@元",textField.text];
        [self.tableView reloadData];
    }else{
        [self.tableView reloadData];

    }
    
    
}
#pragma mark----发布
/**
 *  发布
 *
 *  @param sender 
 */
- (void)mReleaseAction:(UIButton *)sender{

    if ([mUserInfo backNowUser].mMoney < [mMoney floatValue]) {
        [self showErrorStatus:@"余额不足，发布失败！"];
        return;
    }
    if (mLat == nil || mLat.length == 0 || [mLat isEqualToString:@""]) {
        [self showErrorStatus:@"必须开启定位才能发布订单！"];
        [self headerBeganRefresh];
        
        return ;
    }
    if (mLng == nil || mLng.length == 0 || [mLng isEqualToString:@""]) {
        [self showErrorStatus:@"必须开启定位才能发布订单！"];
        [self headerBeganRefresh];
        
        return ;
    }
    if (mContentStr == nil || mContentStr.length == 0) {
        [self showErrorStatus:@"需求不能为空！"];
        return;
    }
    if (self.mType == 3) {
        if (mGoodsName == nil || mGoodsName.length == 0 || [mGoodsName isEqualToString:@""]) {
            [self showErrorStatus:@"请输入商品名称！"];
            return;
        }
    }
    if (self.mType == 2 || self.mType == 1) {
        if (mBlockAddressStr == nil || mBlockAddressStr.length == 0) {
            [self showErrorStatus:@"地址不能为空！"];
            return;
        }
    }
    
    if (self.mType == 1 || self.mType == 3) {
        if (mTagStr == nil || mTagStr.length == 0) {
            [self showErrorStatus:@"标签不能为空！"];
            return;
        }
    }
    
    if (self.mType == 2 || self.mType == 3) {
        
    
    }else{
        
        if (mMin == nil) {
            [self showErrorStatus:@"请输入最低价!"];
            return;
        }
        if (mMax == nil) {
            [self showErrorStatus:@"请输入最高价!"];
            return;
        }

        
    }
    if (mMoney == nil || mMoney.length == 0) {
        [self showErrorStatus:@"酬劳金额不能为空！"];
        return;
    }
    
    if (self.mType == 3) {
        
    }else{
        if (mSelecteTimeStr == nil || mSelecteTimeStr.length == 0) {
            [self showErrorStatus:@"时间不能为空！"];
            return;
        }
    }
    
  
    if(![Util isMobileNumber:mPhoneStr]){
        [self showErrorStatus:@"请输入合法的手机号码"];
        return;
    }

    if (mNoteStr == nil || mNoteStr.length == 0) {
        [self showErrorStatus:@"备注不能为空！"];
        return;
    }
    int mIn = 0;
    mIn = [mMin intValue];
    int mAx = 0;
    mAx = [mMax intValue];
    if (mIn > mAx) {
        [self showErrorStatus:@"最高价不能低于最低价！"];
        [mPopView.mMax becomeFirstResponder];
        
        return;
    }
    MLLog(@"发布");
 
    
    //        mLng = @"106.51594";
    //        mLat = @"29.539027";
    [self showWithStatus:@"正在发布..."];
    
    if (self.mType == 1) {
        [[mUserInfo backNowUser] releasePPTorder:self.mType andTagId:mTagIds andMin:mMin andMAx:mMax andLat:mLat andLng:mLng andContent:mContentStr andMoney:mMoney andAddress:mAddressId andPhone:mPhoneStr andNote:mNoteStr andArriveTime:mSelecteTimeStr block:^(mBaseData *resb) {
            
            if (resb.mSucess) {
                [self showSuccessStatus:resb.mMessage];
                [self popViewController];
            }else{
                [self showErrorStatus:resb.mMessage];
            }
            
        }];
        
        
    }else if(self.mType == 2){
        [[mUserInfo backNowUser] releasePPTorder:self.mType andTagId:nil andMin:nil andMAx:nil andLat:mLat andLng:mLng andContent:mContentStr andMoney:mMoney andAddress:mAddressId andPhone:mPhoneStr andNote:mNoteStr andArriveTime:mSelecteTimeStr block:^(mBaseData *resb) {
            
            if (resb.mSucess) {
                [self showSuccessStatus:resb.mMessage];
                [self popViewController];
            }else{
                [self showErrorStatus:resb.mMessage];
            }
            
        }];
    }else{
    
        [[mUserInfo backNowUser] releasePPTSendorder:3 andTagId:mTagIds andMin:nil andMAx:nil andLat:mLat andLng:mLng andContent:nil andMoney:mMoney andAddress:nil andPhone:mPhoneStr andNote:mNoteStr andArriveTime:nil andGoodsName:mGoodsName andGoodsPrice:mGoodsPrice andSendAddress:mSendAddress andArriveAddress:mArriveAddress andTool:mToolId block:^(mBaseData *resb) {
            
            if (resb.mSucess) {
                [self showSuccessStatus:resb.mMessage];
                [self popViewController];
            }else{
                [self showErrorStatus:resb.mMessage];
            }
            
            
        }];
    }
    

}

@end
