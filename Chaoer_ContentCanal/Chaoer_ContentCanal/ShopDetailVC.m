//
//  ShopDetailVC.m
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/10/29.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "ShopDetailVC.h"
#import "editDianpuViewController.h"
#import "yingyeTimeViewController.h"
#import "WebVC.h"
#import "peisongTimeViewController.h"
#import "APIClient.h"
#import "ChoseAreaVC.h"
#import "fix_searchInMap.h"
#import "BankManagerVC.h"
@interface ShopDetailVC ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,RSKImageCropViewControllerDelegate,RSKImageCropViewControllerDataSource>

@end

@implementation ShopDetailVC
{
    UIImage *tempImage;

    SShop   *mShop;
    
    SProvince *sp;
    SProvince *sc;
    SProvince *sa;
}


-(void)viewWillAppear:(BOOL)animated
{
    [self getData];
    
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
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Title = self.mPageName = @"店铺信息";
    
    [self.mShopNameBtn addTarget:self action:@selector(mNameAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.mShopLogo.layer.masksToBounds = YES;
    self.mShopLogo.layer.cornerRadius = self.mShopLogo.mwidth/2;
    
    [self.mShopLogoBtn addTarget:self action:@selector(mNameAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mShopNoteBtn addTarget:self action:@selector(mNameAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mShopWorkTimeBtn addTarget:self action:@selector(mNameAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mShopPeisongBtn addTarget:self action:@selector(mNameAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mShopPhoneBtn addTarget:self action:@selector(mNameAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mShopArearBtn addTarget:self action:@selector(mNameAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mShopContentBtn addTarget:self action:@selector(mNameAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mQsBT addTarget:self action:@selector(mNameAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mPsBT addTarget:self action:@selector(mNameAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mShopWorkSwitch addTarget:self action:@selector(mSwitchAction:) forControlEvents:UIControlEventValueChanged];
    
//    [self getData];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyBoardHide:) name:UIKeyboardDidHideNotification object:nil];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)KeyBoardHide:(NSNotification *)nof{

    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeClear];
    
    [mShop updateAddressDetailInfo:self.mAddressDetail.text block:^(SResBase *info) {
       
        if (info.msuccess) {
            [SVProgressHUD showSuccessWithStatus:info.mmsg];
        }else{
            [SVProgressHUD showErrorWithStatus:info.mmsg];
        }
    }];
}

- (void)getData{
    [SVProgressHUD showWithStatus:@"加载中.." maskType:SVProgressHUDMaskTypeClear];
    
    
    [SShop getShopInfo:^(SResBase *info, SShop *retobj) {
        
        if (info.msuccess) {
            [SVProgressHUD dismiss];
            mShop = retobj;
            _myjper.text = [NSString stringWithFormat:@"%d%%",mShop.mDeduct];
            [_mswitchh setOn:mShop.mIsCashOnDelivery animated:YES];
            
            _mArea.text = retobj.mRegion;
            self.mAddress.text = retobj.mAddress;
            self.mAddressDetail.text = retobj.mAddressDetail;
            self.mShopName.text = retobj.mName;
            MLLog(@"logode地址是：%@",retobj.mImg);
            [self.mShopLogo sd_setImageWithURL:[NSURL URLWithString:retobj.mImg] placeholderImage:[UIImage imageNamed:@"my_defaulimg"]];
            self.mShopNote.text = retobj.mArticle;
            
            NSArray *arr = [retobj.mBusinessHour objectForKey:@"hours"];
            if (arr == nil || arr.count == 0) {
                self.mShopWorkTime.text = @"暂无";
            }else{
                self.mShopWorkTime.text = [NSString stringWithFormat:@"%@-%@",[[retobj.mBusinessHour objectForKey:@"hours"] objectAtIndex:0],[[retobj.mBusinessHour objectForKey:@"hours"]lastObject]];
            }
            arr = [retobj.mDeliveryTime objectForKey:@"stimes"];
            if ( arr == nil || arr.count == 0 ) {
                
                self.mShopPeisongTime.text = @"暂无";
            }else{
                self.mShopPeisongTime.text = [Util mStartTimeArr:[retobj.mDeliveryTime objectForKey:@"stimes"] andmEndTimeArr:[retobj.mDeliveryTime objectForKey:@"etimes"]];
            }

            self.mPsPrice.text = [NSString stringWithFormat:@"%.2f",retobj.mDeliveryFee];
            self.mQsPrice.text = [NSString stringWithFormat:@"%.2f",retobj.mServiceFee];

            self.mShopPhone.text = retobj.mTel;
            self.mShopArear.text = retobj.mServiceRange;
            self.mShopContent.text = retobj.mBrief;
            if (retobj.mStatus==1) {
                [self.mShopWorkSwitch setOn:YES];

            }else{
                [self.mShopWorkSwitch setOn:NO];

            }

            
            if ([retobj.mArticle isEqualToString:@""] || retobj.mArticle == nil) {
                self.mShopNote.text = @"暂无公告";

            }else{
                self.mShopNote.text = retobj.mArticle;
            }
            
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:info.mmsg];
        }
    }];

}
- (void)mSwitchAction:(UISwitch *)sender{
    sender.selected = !sender.selected;
    if ( sender.selected) {
        MLLog(@"开");
        [mShop upDateYingyeStatus:1 block:^(SResBase *info) {
            if (info.msuccess) {
                [self.mShopWorkSwitch setOn:YES];

            }else{
                [SVProgressHUD showErrorWithStatus:info.mmsg];
            }
        }];
    }else{
        MLLog(@"关");
        [mShop upDateYingyeStatus:2 block:^(SResBase *info) {
            if (info.msuccess) {
                [self.mShopWorkSwitch setOn:NO];

            }else{
                [SVProgressHUD showErrorWithStatus:info.mmsg];

            }
        }];
    }
}

- (IBAction)mhaveh:(UISwitch*)sender {
    
    [SVProgressHUD showWithStatus:@"操作中..." maskType:SVProgressHUDMaskTypeClear];
    [mShop updateAvrH:sender.isOn block:^(SResBase *info) {
        if( info.msuccess )
        {
            [SVProgressHUD dismiss];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:info.mmsg];
            [_mswitchh setOn:!_mswitchh.isOn animated:YES];
        }
    }];
}

#pragma mark----各个按钮的事件
- (void)mNameAction:(UIButton *)sender{
    switch (sender.tag) {
        case 0:
        {
            MLLog(@"名称");
            
            editDianpuViewController *editVC = [[editDianpuViewController alloc] initWithNibName:@"editDianpuViewController" bundle:nil];
            editVC.itblock = ^(NSString *mBackStr){
                self.mShopName.text = mBackStr;

            };
            editVC.mType = 1;
            editVC.mShop = mShop;
            editVC.nameStr = @"店铺名称：";
            editVC.TitleStr = @"店铺名称";
            editVC.mContentStr = self.mShopName.text;
            [self pushViewController:editVC];

            
        }
            break;
        case 1:
        {
            MLLog(@"logo");
            UIActionSheet *ac = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择", nil];
            ac.tag = 1001;
            [ac showInView:[self.view window]];
        }
            break;
        case 2:
        {
            MLLog(@"公告");
            editDianpuViewController *editVC = [[editDianpuViewController alloc] initWithNibName:@"editDianpuViewController" bundle:nil];
            editVC.itblock = ^(NSString *mBackStr){
                self.mShopNote.text = mBackStr;
                
            };
            editVC.mShop = mShop;
            editVC.mType = 2;
            editVC.mContentStr = self.mShopNote.text;
            editVC.nameStr = @"店铺公告：";
            editVC.TitleStr = @"店铺公告";
            [self pushViewController:editVC];

        }
            break;
        case 3:
        {
            MLLog(@"营业时间");
            yingyeTimeViewController *yyy = [yingyeTimeViewController new];
            yyy.mWeek = [mShop.mBusinessHour objectForKey:@"weeks"];
            yyy.mHour = [mShop.mBusinessHour objectForKey:@"hours"];
            yyy.mShop = mShop;
            yyy.itblock = ^(SShop *mshop){
                
            self.mShopWorkTime.text = [NSString stringWithFormat:@"%@-%@",[[mshop.mBusinessHour objectForKey:@"hours"] objectAtIndex:0],[[mshop.mBusinessHour objectForKey:@"hours"]lastObject]];
                
            };
            [self pushViewController:yyy];

        }
            break;
        case 4:
        {
            MLLog(@"配送时间");
            peisongTimeViewController *yyy = [peisongTimeViewController new];
            yyy.mShop = mShop;
            yyy.itblock = ^(NSDictionary *mDic){
                
                self.mShopPeisongTime.text = [Util mStartTimeArr:[mDic objectForKey:@"stimes"] andmEndTimeArr:[mDic objectForKey:@"etimes"]];
                
            };

            
            [self pushViewController:yyy];

        }
            break;
        case 5:
        {
            MLLog(@"电话");
            editDianpuViewController *editVC = [[editDianpuViewController alloc] initWithNibName:@"editDianpuViewController" bundle:nil];
            editVC.itblock = ^(NSString *mBackStr){
                self.mShopPhone.text = mBackStr;
                
            };
            editVC.mShop = mShop;
            editVC.mType = 3;
            editVC.mContentStr = self.mShopPhone.text;

            editVC.nameStr = @"联系电话：";
            editVC.TitleStr = @"联系电话";
            [self pushViewController:editVC];

        }
            break;
        case 6:
        {
            MLLog(@"范围");
            WebVC* vc = [[WebVC alloc]init];
            vc.mName = @"服务范围";
            vc.mUrl = [NSString stringWithFormat:@"%@/shop.sellermap?token=%@&userId=%d",[APIClient APiWithUrl:@"api" andOtherUrl:nil],[SUser currentUser].mToken,[SUser currentUser].mUserId];

            [self pushViewController:vc];


        }
            break;
        case 7:
        {
            MLLog(@"介绍");
            editDianpuViewController *editVC = [[editDianpuViewController alloc] initWithNibName:@"editDianpuViewController" bundle:nil];
            editVC.itblock = ^(NSString *mBackStr){
                self.mShopNote.text = mBackStr;
                
            };
            editVC.mShop = mShop;
            editVC.mType = 4;
            editVC.mContentStr = self.mShopContent.text;

            editVC.nameStr = @"店铺介绍：";
            editVC.TitleStr = @"店铺介绍";
            [self pushViewController:editVC];
        }
            break;
            
        case 8:
        {
            MLLog(@"起送价");
            editDianpuViewController *editVC = [[editDianpuViewController alloc] initWithNibName:@"editDianpuViewController" bundle:nil];
            editVC.itblock = ^(NSString *mBackStr){
                self.mQsPrice.text = mBackStr;
                
            };
            editVC.mShop = mShop;
            editVC.mType = 8;
            editVC.mContentStr = self.mQsPrice.text;
            
            editVC.nameStr = @"起送价：";
            editVC.TitleStr = @"起送价";
            [self pushViewController:editVC];
        }
            break;
        case 9:
        {
            MLLog(@"配送费");
            editDianpuViewController *editVC = [[editDianpuViewController alloc] initWithNibName:@"editDianpuViewController" bundle:nil];
            editVC.itblock = ^(NSString *mBackStr){
                self.mPsPrice.text = mBackStr;
                
            };
            editVC.mShop = mShop;
            editVC.mType = 9;
            editVC.mContentStr = self.mPsPrice.text;
            
            editVC.nameStr = @"配送费：";
            editVC.TitleStr = @"配送费";
            [self pushViewController:editVC];
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

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ( buttonIndex != 2 ) {
        
        [self startImagePickerVCwithButtonIndex:buttonIndex];
    }
    
}
- (void)startImagePickerVCwithButtonIndex:(NSInteger )buttonIndex
{
    int type;
    
    
    if (buttonIndex == 0) {
        type = UIImagePickerControllerSourceTypeCamera;
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = type;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagePicker.allowsEditing =NO;
        
        [self presentViewController:imagePicker animated:YES completion:^{
            
        }];
        
    }
    else if(buttonIndex == 1){
        type = UIImagePickerControllerSourceTypePhotoLibrary;
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = type;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker animated:YES completion:NULL];
        
        
    }
    
    
    
}
- (void)imagePickerController:(UIImagePickerController *)imagePickerController didFinishPickingMediaWithInfo:(id)info
{
    
    UIImage* tempimage1 = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self gotCropIt:tempimage1];
    
    [imagePickerController dismissViewControllerAnimated:YES completion:^() {
        
    }];
    
}
-(void)gotCropIt:(UIImage*)photo
{
    RSKImageCropViewController *imageCropVC = nil;
    
    imageCropVC = [[RSKImageCropViewController alloc] initWithImage:photo cropMode:RSKImageCropModeCircle];
    imageCropVC.dataSource = self;
    imageCropVC.delegate = self;
    [self.navigationController pushViewController:imageCropVC animated:YES];
    
}
- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller
{
    
    [controller.navigationController popViewControllerAnimated:YES];
}

- (CGRect)imageCropViewControllerCustomMaskRect:(RSKImageCropViewController *)controller
{
    return   CGRectMake(self.view.center.x-_mShopLogo.frame.size.width/2, self.view.center.y-_mShopLogo.frame.size.height/2, _mShopLogo.frame.size.width, _mShopLogo.frame.size.height);
    
}
- (UIBezierPath *)imageCropViewControllerCustomMaskPath:(RSKImageCropViewController *)controller
{
    return [UIBezierPath bezierPathWithRect:CGRectMake(self.view.center.x-_mShopLogo.frame.size.width/2, self.view.center.y-_mShopLogo.frame.size.height/2, _mShopLogo.frame.size.width, _mShopLogo.frame.size.height)];
    
}
- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage
{
    
    [controller.navigationController popViewControllerAnimated:YES];
    
    tempImage = croppedImage;//[Util scaleImg:croppedImage maxsize:140];

    [mShop upDateDianpuLogo:tempImage block:^(SResBase *info) {
        if (info.msuccess) {
            _mShopLogo.image = tempImage;

        }else{
            [SVProgressHUD showErrorWithStatus:info.mmsg];
        }
    }];
    
    
}

- (IBAction)GoAreaClick:(id)sender {
    
    ChoseAreaVC *choseAreaVC = [[ChoseAreaVC alloc] initWithNibName:@"ChoseAreaVC" bundle:nil];
    
    NSArray* tt = [mShop.mRegion componentsSeparatedByString:@"-"];
    
    
    choseAreaVC.mtagshop = mShop;
    choseAreaVC.pp = SProvince.new;
    choseAreaVC.pp.mI = mShop.mProvinceId;
    if( tt.count > 0 )
        choseAreaVC.pp.mN = tt[0];
    
    choseAreaVC.cp = SProvince.new;
    choseAreaVC.cp.mI = mShop.mCityId;
    if( tt.count > 1 )
        choseAreaVC.cp.mN = tt[1];
    
    
    choseAreaVC.ap = SProvince.new;
    choseAreaVC.ap.mI = mShop.mAreaId;
    if( tt.count > 2 )
        choseAreaVC.ap.mN = tt[2];
    
    
    choseAreaVC.itblock = ^(SProvince* p,SProvince* c,SProvince* a){
        
        sp = p;
        sc = c;
        sa = a;
        if (a.mI !=0) {
            _mArea.text = [NSString stringWithFormat:@"%@-%@-%@",p.mN,c.mN,a.mN];
        }else{
            _mArea.text = [NSString stringWithFormat:@"%@-%@",p.mN,c.mN];
        }
        
    };
    
    [self pushViewController:choseAreaVC];
    
}

- (IBAction)mGoAddressClick:(id)sender {
    
    searchInMap* vc = [[searchInMap alloc]init];
    vc.mNowAddr = mShop.mAddress;
    if( mShop.mMapPointStr.length )
    {
        NSArray* t  = [mShop.mMapPointStr componentsSeparatedByString:@","];
        if( t.count ==2 )
        {
            vc.mLat = [t[0] floatValue];
            vc.mLng = [t[1] floatValue];
        }
    }
    
    vc.itblock = ^(NSString* add,float lng,float lat){
 
        [SVProgressHUD showWithStatus:@"操作中..." maskType:SVProgressHUDMaskTypeClear];
        [mShop updateAddressInfo:add lat:lat lng:lng block:^(SResBase *info) {
            
            if( info.msuccess )
            {
                [SVProgressHUD dismiss];
                self.mAddress.text = add;
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:info.mmsg];
            }
        }];
    
        
    };
    [self pushViewController:vc];
    
    
}

- (IBAction)GoBankManagerClick:(id)sender {
    

    BankManagerVC *bank = [[BankManagerVC alloc] init];
    bank.mShop = mShop;
    
    [self pushViewController:bank];
        
}



@end
