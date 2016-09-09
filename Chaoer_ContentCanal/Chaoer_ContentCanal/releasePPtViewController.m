
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
// contain this header
#import "UIView+TYAlertView.h"
// if you want blur efffect contain this
#import "TYAlertController+BlurEffects.h"
@interface releasePPtViewController ()<UITableViewDelegate,UITableViewDataSource,AMapLocationManagerDelegate,UITextFieldDelegate,UITextViewDelegate>
/**
 *  发布模型
 */
@property (strong,nonatomic)GPPTRelease *mRealease;

@end

@implementation releasePPtViewController
{
    
    mPriceView *mPopView;

    AMapLocationManager *mLocation;
    
    LTPickerView*LtpickerView;
    
    NSMutableArray *mPriceArr;
    
    NSString *mTime;

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
    
    _mRealease = [GPPTRelease new];
    mTime = nil;
    mPriceArr = [NSMutableArray new];
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
    self.mRealease.mMinPrice = mPopView.mMin.text;
    self.mRealease.mMaxPrice = mPopView.mMax.text;
    
    int mIn = 0;
    mIn = [self.mRealease.mMinPrice intValue];
    int mAx = 0;
    mAx = [self.mRealease.mMaxPrice intValue];
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
    self.mRealease.mMoney = @"";
    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;

//    self.haveHeader = YES;
    
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

- (void)loadAddress{

    mLocation = [[AMapLocationManager alloc] init];
    mLocation.delegate = self;
    [mLocation setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    mLocation.locationTimeout = 3;
    mLocation.reGeocodeTimeout = 3;
    [mLocation requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error)
        {
            
            NSString *eee =@"定位失败！请检查网络和定位设置！";

            MLLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            [self showErrorStatus:eee];
            
        }
        if (location) {
            NSLog(@"location:%@", location);
            self.mLat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
            self.mLng = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
        }
    
        if (regeocode)
        {
            
            MLLog(@"reGeocode:%@", regeocode);
            [self showSuccessStatus:@"定位成功"];

            
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
        
        return 183;
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
        cell.mContentTx.delegate = self;
        cell.mContentTx.text = self.mRealease.mContent;
        cell.mAddress.text = self.mRealease.mAddress;

        if (self.mType == 2) {
            cell.mAddTagBtn.hidden = YES;
        }else{
            cell.mAddTagBtn.hidden = NO;

        }
        
        [cell.mAddTagBtn addTarget:self action:@selector(mTagAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        if (self.mRealease.mTag.length == 0) {
            
        }else{
        
            
            for (UILabel *lb in cell.mTagiew.subviews) {
                [lb removeFromSuperview];
            }
            
            
            CGFloat W = [Util labelTextWithWidth:self.mRealease.mTag]+20;
            
            UILabel *lll = [UILabel new];
            lll.frame = CGRectMake(15, 5, W, 30);
            lll.text = self.mRealease.mTag;
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
            cell.mMoneyTx.text = self.mRealease.mMoney;
            cell.mMoneyTx.delegate = self;
            
            if (self.mRealease.mMaxPrice.length != 0 || self.mRealease.mMinPrice.length != 0) {
                
                [cell.mPriceBtn setTitle:[NSString stringWithFormat:@"%@元至%@元",self.mRealease.mMinPrice,self.mRealease.mMaxPrice] forState:0];
                
                
            }
     
            
            [cell.mPriceBtn addTarget:self action:@selector(mPriceAction:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
            
        }
        
        else  if (self.mType == 2) {
            reuseCellId = @"cell3";
            
            releaseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.mMoneyTx.delegate = self;
            cell.mMoneyTx.text = self.mRealease.mMoney;
         
            
            return cell;
            
        }else{
            
            reuseCellId = @"cell6";
            
            releaseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.mMoneyTx.text = self.mRealease.mMoney;

            cell.mMoneyTx.delegate = self;
            cell.mGoodsName.delegate = self;

            cell.mGoodsPriceTx.delegate = self;
            self.mRealease.mGoodsName = cell.mGoodsName.text;

            self.mRealease.mGoodsPrice = cell.mGoodsPriceTx.text;
            
            return cell;
        }
    }else{
        
        if (self.mType == 3) {
            reuseCellId = @"cell5";
            
            releaseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell.mChoiceTool addTarget:self action:@selector(choiceToolAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.mtimeBtn addTarget:self action:@selector(mSelectTimeAction:) forControlEvents:UIControlEventTouchUpInside];
            
            if (self.mRealease.mToolStr.length != 0) {
                [cell.mChoiceTool setTitle:self.mRealease.mToolStr forState:0];

            }
            self.mRealease.mTime = cell.mTime.text;
            
            cell.mPhone.text = self.mRealease.mPhone;
            cell.mNoteTX.text = self.mRealease.mNote;
            self.mRealease.mBAddress = cell.mSndAddressTx.text;
            self.mRealease.mEAddress = cell.mArriveAddressTx.text;
            cell.mPhone.delegate = self;
            cell.mTime.delegate = self;
            cell.mNoteTX.delegate = self;
            cell.mSndAddressTx.delegate = self;
            cell.mArriveAddressTx.delegate = self;
            
            return cell;
        }else{
            reuseCellId = @"cell4";
            
            releaseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell.mAddressBtn addTarget:self action:@selector(addressAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.mtimeBtn addTarget:self action:@selector(mSelectTimeAction:) forControlEvents:UIControlEventTouchUpInside];

            self.mRealease.mTime = cell.mTime.text;
            
            cell.mPhone.text = self.mRealease.mPhone;
            cell.mNoteTX.text = self.mRealease.mNote;
            
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
        mTime = mTT2[num];
        [weakSelf.tableView reloadData];
    
    
    };

    
    
}

- (void)choiceToolAction:(UIButton *)sender{

    [self LoadTool];
    
}
- (void)LoadTool{

    [self showWithStatus:@"正在加载..."];
    [[mUserInfo backNowUser] getTool:^(mBaseData *resb, NSArray *mArr) {
        
        if (resb.mSucess) {
            [self dismiss];
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
    
        self.mRealease.mToolStr = mTool.mToolName;
        self.mRealease.mToolId = [NSString stringWithFormat:@"%d",mTool.mId];
        
        [self.tableView reloadData];
    }];

}
#pragma mark----选择价格
- (void)mPriceAction:(UIButton *)sender{

//    [self showPopView];
    
    
    TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"商品价格" message:@"请输入价格区间"];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancle handler:^(TYAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];
    
    // 弱引用alertView 否则 会循环引用
    __typeof (alertView) __weak weakAlertView = alertView;
    [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        [mPriceArr removeAllObjects];
        NSLog(@"%@",action.title);
        for (UITextField *textField in weakAlertView.textFieldArray) {
            if (textField.text.length != 0) {
                [mPriceArr addObject:textField.text];
            }
            
        }
        
        if (mPriceArr.count == 0 || mPriceArr.count == 1) {
            [self showErrorStatus:@"必须请输入最高价和最低价!"];
            [mPopView.mMin becomeFirstResponder];
            return;
        }
       
        self.mRealease.mMinPrice = mPriceArr[0];
        self.mRealease.mMaxPrice = mPriceArr[1];
        
        int mIn = 0;
        mIn = [self.mRealease.mMinPrice intValue];
        int mAx = 0;
        mAx = [self.mRealease.mMaxPrice intValue];
        if (mIn > mAx) {
            [self showErrorStatus:@"最高价不能低于最低价！"];
            return;
        }else{
            
            [self.tableView reloadData];
        }
        

    }]];
    
    [alertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.placeholder = @"请输入最低价";
    }];
    [alertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.placeholder = @"请输入最高价";
    }];
    
    // first way to show
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert];
    
    [alertController setViewWillShowHandler:^(UIView *alertView) {
        NSLog(@"ViewWillShow");
    }];
    
    [alertController setViewDidShowHandler:^(UIView *alertView) {
        NSLog(@"ViewDidShow");
    }];
    
    [alertController setViewWillHideHandler:^(UIView *alertView) {
        NSLog(@"ViewWillHide");
    }];
    
    [alertController setViewDidHideHandler:^(UIView *alertView) {
        NSLog(@"ViewDidHide");
    }];
    
    [alertController setDismissComplete:^{
        NSLog(@"DismissComplete");
    }];
    
    //alertController.alertViewOriginY = 60;
    [self presentViewController:alertController animated:YES completion:nil];

}
- (void)mTagAction:(UIButton *)sender{
    bolterViewController *bbb =[[bolterViewController alloc] initWithNibName:@"bolterViewController" bundle:nil];
    bbb.mType = 1;
    bbb.mSubType = self.mSubType;
    
    bbb.block = ^(NSString *content,NSString *mTagId){
        self.mRealease.mTag = content;
        self.mRealease.mTagId = mTagId;
        [self.tableView reloadData];
    };

    
    [self pushViewController:bbb];

}
- (void)addressAction:(UIButton *)sender{

    
    pptMyAddressViewController *ppt = [[pptMyAddressViewController alloc] initWithNibName:@"pptMyAddressViewController" bundle:nil];
    ppt.mType = 1;
    ppt.block = ^(NSString *content ,NSString *mId,NSString *mName){
        self.mRealease.mAddress = content;
        self.mRealease.mAddressId = mId;
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
    
    /**
     *  2酬劳 11是电话 12是地址 300是备注 201发货地址 202收货地址 301商品名称 302商品价格
     */
    
     if(textField.tag == 2){
        self.mRealease.mMoney = textField.text;
        //[self.tableView reloadData];
    }else if(textField.tag == 11){
        self.mRealease.mPhone = textField.text;
        //[self.tableView reloadData];

    }
    else if(textField.tag == 12){
        self.mRealease.mAddress = textField.text;
        //[self.tableView reloadData];
        
    }
    else if(textField.tag == 300){
        self.mRealease.mNote = textField.text;

        //[self.tableView reloadData];
        
    } else if(textField.tag == 201){
        self.mRealease.mBAddress = textField.text;
        
        //[self.tableView reloadData];
        
    } else if(textField.tag == 202){
        self.mRealease.mEAddress = textField.text;
        
        //[self.tableView reloadData];
        
    }
    else if(textField.tag == 301){
        self.mRealease.mGoodsName = textField.text;
        
        //[self.tableView reloadData];
        
    } else if(textField.tag == 302){
        self.mRealease.mGoodsPrice = textField.text;
        
        //[self.tableView reloadData];
        
    }

    
    
}
- (void)textViewDidEndEditing:(UITextView *)textView{
        self.mRealease.mContent = textView.text;
        //[self.tableView reloadData];

    
}

#pragma mark----发布
/**
 *  发布
 *
 *  @param sender 
 */
- (void)mReleaseAction:(UIButton *)sender{

    [[IQKeyboardManager sharedManager] resignFirstResponder];
    
    if ([mUserInfo backNowUser].mMoney < [self.mRealease.mMoney floatValue]) {
        [self showErrorStatus:@"余额不足，发布失败！"];
        return;
    }
    if (self.mLat == nil || self.mLat.length == 0 || [self.mLat isEqualToString:@""]) {
        [self showErrorStatus:@"必须开启定位才能发布订单！"];
        [self loadAddress];
        
        return ;
    }
    if (self.mLng == nil || self.mLng.length == 0 || [self.mLng isEqualToString:@""]) {
        [self showErrorStatus:@"必须开启定位才能发布订单！"];
        [self loadAddress];
        
        return ;
    }
    if (self.mRealease.mContent.length == 0) {
        [self showErrorStatus:@"需求不能为空！"];
        return;
    }
    if (self.mType == 3) {
        if (self.mRealease.mGoodsName.length == 0) {
            [self showErrorStatus:@"请输入商品名称！"];
            return;
        }
    }
    if (self.mType == 2 || self.mType == 1) {
        if (self.mRealease.mAddress.length == 0) {
            [self showErrorStatus:@"地址不能为空！"];
            return;
        }
    }

    
    if (self.mType == 1 || self.mType == 3) {
        if (self.mRealease.mTag.length == 0) {
            [self showErrorStatus:@"标签不能为空！"];
            return;
        }
    }
    
    if (self.mType == 2 || self.mType == 3) {
        
    
    }else{
        
        if (self.mRealease.mMinPrice.length == 0) {
            [self showErrorStatus:@"请输入最低价!"];
            return;
        }
        if (self.mRealease.mMaxPrice.length == 0) {
            [self showErrorStatus:@"请输入最高价!"];
            return;
        }

        
    }
    if (self.mRealease.mMoney.length == 0) {
        [self showErrorStatus:@"酬劳金额不能为空！"];
        return;
    }
    
    if (self.mType == 3) {
        
    }else{
        if (mTime.length == 0) {
            [self showErrorStatus:@"时间不能为空！"];
            return;
        }
    }
    
  
    if(![Util isMobileNumber:self.mRealease.mPhone]){
        [self showErrorStatus:@"请输入合法的手机号码"];
        return;
    }

    int mIn = 0;
    mIn = [self.mRealease.mMinPrice intValue];
    int mAx = 0;
    mAx = [self.mRealease.mMaxPrice intValue];
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
        [[mUserInfo backNowUser] releasePPTorder:self.mType andTagId:self.mRealease.mTagId andMin:self.mRealease.mMinPrice andMAx:self.mRealease.mMaxPrice andLat:self.mLat andLng:self.mLng andContent:self.mRealease.mContent andMoney:self.mRealease.mMoney andAddress:self.mRealease.mAddressId andPhone:self.mRealease.mPhone andNote:self.mRealease.mNote andArriveTime:mTime block:^(mBaseData *resb) {
            
            if (resb.mSucess) {
                [[NSNotificationCenter defaultCenter] postNotificationName:MyUserNeedUpdateNotification object:nil];
                
                [self showSuccessStatus:resb.mMessage];
                [self popViewController];
            }else{
                [self showErrorStatus:resb.mMessage];
            }
            
        }];
        
        
    }else if(self.mType == 2){
        [[mUserInfo backNowUser] releasePPTorder:self.mType andTagId:nil andMin:nil andMAx:nil andLat:self.mLat andLng:self.mLng andContent:self.mRealease.mContent andMoney:self.mRealease.mMoney andAddress:self.mRealease.mAddressId andPhone:self.mRealease.mPhone andNote:self.mRealease.mNote andArriveTime:mTime block:^(mBaseData *resb) {
            
            if (resb.mSucess) {
                [[NSNotificationCenter defaultCenter] postNotificationName:MyUserNeedUpdateNotification object:nil];
                
                [self showSuccessStatus:resb.mMessage];
                [self popViewController];
            }else{
                [self showErrorStatus:resb.mMessage];
            }
            
        }];
    }else{
    
        [[mUserInfo backNowUser] releasePPTSendorder:3 andTagId:self.mRealease.mTagId andMin:nil andMAx:nil andLat:self.mLat andLng:self.mLng andContent:nil andMoney:self.mRealease.mMoney andAddress:nil andPhone:self.mRealease.mPhone andNote:self.mRealease.mNote andArriveTime:mTime andGoodsName:self.mRealease.mGoodsName andGoodsPrice:self.mRealease.mGoodsPrice andSendAddress:self.mRealease.mBAddress andArriveAddress:self.mRealease.mEAddress andTool:self.mRealease.mToolId block:^(mBaseData *resb) {
            
            if (resb.mSucess) {
                [[NSNotificationCenter defaultCenter] postNotificationName:MyUserNeedUpdateNotification object:nil];
                
                [self showSuccessStatus:resb.mMessage];
                [self popViewController];
            }else{
                [self showErrorStatus:resb.mMessage];
            }
            
            
        }];
    }
    

}

@end
