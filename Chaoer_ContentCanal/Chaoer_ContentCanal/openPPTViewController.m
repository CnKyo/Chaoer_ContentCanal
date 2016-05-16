//
//  openPPTViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "openPPTViewController.h"
#import "applyPPTView.h"


#import "depositViewController.h"

#import "RSKImageCropper.h"

@interface openPPTViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,RSKImageCropViewControllerDelegate,RSKImageCropViewControllerDataSource,UINavigationControllerDelegate>

@end

@implementation openPPTViewController
{

    UIScrollView *mScrollerView;
    
    applyPPTView *mView;
    
    /**
     *  手持身份证
     */
    UIImage *mHandImg;
    
    NSData  *mHandImgData;
    NSString *mHandImgPath;
    /**
     *  正面
     */
    UIImage *mFrontImg;
    NSData  *mFrontImgData;
    NSString *mFrontImgPath;
    /**
     *  反面
     */
    UIImage *mForwordImg;
    NSData  *mForwordImgData;
    NSString *mForwordImgPath;
    
    SVerifyMsg  *mVerify;
    
    UIImage *tempImage;
    /**
     *  当前选择的哪一个
     */
    int mNowSelected;

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"申请跑跑腿";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    
    mHandImg = nil;
    mFrontImg = nil;
    mForwordImg = nil;
    
    [self initView];
    [self initData];

}
- (void)initView{

    mScrollerView = [UIScrollView new];
    mScrollerView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64);
    mScrollerView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.93 alpha:0.65];
    [self.view addSubview:mScrollerView];

    
    mView = [applyPPTView shareView];
    mView.frame = CGRectMake(0, 0, DEVICE_Width, 568);
    [mView.mOkBtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [mView.mHandBtn addTarget:self action:@selector(handAction:) forControlEvents:UIControlEventTouchUpInside];

    [mView.mFrontBtn addTarget:self action:@selector(frontAction:) forControlEvents:UIControlEventTouchUpInside];

    [mView.mForwordBtn addTarget:self action:@selector(forwordAction:) forControlEvents:UIControlEventTouchUpInside];

    [mScrollerView addSubview:mView];
    
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 568+30);
    
}

- (void)initData{

    
    [SVProgressHUD showWithStatus:@"正在加载..." maskType:SVProgressHUDMaskTypeClear];
    [mUserInfo getBundleMsg:[mUserInfo backNowUser].mUserId block:^(mBaseData *resb, SVerifyMsg *info) {

        if (resb.mSucess) {
            [SVProgressHUD dismiss];
            mVerify = info;
            [self updatePage];
        }else{
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
            
        };
        
    }];

    
    
}

- (void)updatePage{

    mView.mNameTx.text = mVerify.mReal_name;
    mView.mSexTx.text = [mUserInfo backNowUser].mSex;
    mView.mIdentifyTx.text = mVerify.mCard;
    mView.mConnectTx.text = [mUserInfo backNowUser].mPhone;
}

- (void)okAction:(UIButton *)sender{

    if (mView.mNameTx.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"姓名不能为空！"];
        [mView.mNameTx becomeFirstResponder];
        return;
    }
    if (mView.mSexTx.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"性别不能为空！"];
        [mView.mSexTx becomeFirstResponder];
        return;
    }
    if (mView.mConnectTx.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"联系方式不能为空！"];
        [mView.mConnectTx becomeFirstResponder];
        return;
    }
    if (mView.mIdentifyTx.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"身份证不能为空！"];
        [mView.mIdentifyTx becomeFirstResponder];
        return;
    }
    if (mHandImg == nil && mFrontImg == nil && mForwordImg == nil) {
        [SVProgressHUD showErrorWithStatus:@"必须完善身份证照片！"];
        return;
    }
    
    
    depositViewController *ddd = [[depositViewController alloc] initWithNibName:@"depositViewController" bundle:nil];
    [self pushViewController:ddd];
    
}

/**
 *  手持身份证
 *
 *  @param sender
 */
- (void)handAction:(UIButton *)sender{
    mNowSelected = 1;
    UIActionSheet *ac = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", nil];
    ac.tag = 1001;
    [ac showInView:[self.view window]];
}
/**
 *  正面
 *
 *  @param sender
 */
- (void)frontAction:(UIButton *)sender{
    mNowSelected = 2;
    UIActionSheet *ac = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", nil];
    ac.tag = 1001;
    [ac showInView:[self.view window]];
}
/**
 *  反面
 *
 *  @param sender   
 */
- (void)forwordAction:(UIButton *)sender{
    mNowSelected = 3;
    UIActionSheet *ac = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", nil];
    ac.tag = 1001;
    [ac showInView:[self.view window]];
}

#pragma mark - IBActionSheet/UIActionSheet Delegate Method
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1001) {
        if ( buttonIndex != 1 ) {
            
            [self startImagePickerVCwithButtonIndex:buttonIndex];
        }
    }else{
        
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
    return   CGRectMake(self.view.center.x-1, self.view.center.y-1, mView.mHandBtn.frame.size.width, mView.mHandBtn.frame.size.height);
    
}
- (UIBezierPath *)imageCropViewControllerCustomMaskPath:(RSKImageCropViewController *)controller
{
    return [UIBezierPath bezierPathWithRect:CGRectMake(self.view.center.x-1, self.view.center.y-1, mView.mHandBtn.frame.size.width, mView.mHandBtn.frame.size.height)];
    
}
- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage
{
    
    [controller.navigationController popViewControllerAnimated:YES];
    
    tempImage = croppedImage;//[Util scaleImg:croppedImage maxsize:140];
    
    if (mNowSelected == 1) {
        [mView.mHandBtn setBackgroundImage:tempImage forState:0];
    }else if (mNowSelected == 2){
        
        [mView.mFrontBtn setBackgroundImage:tempImage forState:0];
    }else{
        [mView.mForwordBtn setBackgroundImage:tempImage forState:0];
    }
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    
    NSData *imageData = UIImagePNGRepresentation(tempImage);
    NSString *aPath=[NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(),nowTimeStr];
    [imageData writeToFile:aPath atomically:YES];
    
    NSString *aPath3=[NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(),nowTimeStr];
    UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:aPath3];
    UIImageView* imageView3=[[UIImageView alloc]initWithImage:imgFromUrl3];
    
    
    tempImage = [Util scaleImg:imageView3.image maxsize:150];
    
    NSData *mmm = UIImagePNGRepresentation(tempImage);
    
    

}

@end