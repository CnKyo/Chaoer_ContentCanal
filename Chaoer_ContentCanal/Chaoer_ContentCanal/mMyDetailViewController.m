//
//  mMyDetailViewController.m
//  O2O_XiCheSeller
//
//  Created by 密码为空！ on 15/7/13.
//  Copyright (c) 2015年 zongyoutec.com. All rights reserved.
//

#import "mMyDetailViewController.h"
#import "mMyDeatailView.h"
#import "RSKImageCropper.h"

#import "Masonry.h"
#import "forgetAndChangePwdView.h"
#import "changeNameViewController.h"
#import "checkPhoneViewController.h"
@interface mMyDetailViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,RSKImageCropViewControllerDelegate,RSKImageCropViewControllerDataSource,UITextFieldDelegate>



@end

@implementation mMyDetailViewController
{
    mMyDeatailView *mm;
    UIImage *tempImage;
    BOOL    _bereload;

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
    
    if( _bereload )
    {
        _bereload = NO;
        [self updateInfo];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];///视图消失键盘位置取消调整
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];///关闭自定义工具栏
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}

- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    self.hiddenlll = YES;
    self.mPageName = self.Title = @"我的信息";
    [self initView];
    // Do any additional setup after loading the view.
}
- (void)initView{
    
    mm = [mMyDeatailView shareView];
//    [mm.mHeaderImg sd_setImageWithURL:[NSURL URLWithString:[SUser currentUser].mHeadImgURL] placeholderImage:[UIImage imageNamed:@"my_defaulimg"]];
//    MLLog(@"头像地址：%@",[SUser currentUser].mHeadImgURL);
    
//    [mm.mHeaderBtn addTarget:self action:@selector(headBtnTouched:) forControlEvents:UIControlEventTouchUpInside];
//    [mm.mNameBtn setTitle:[SUser currentUser].mUserName forState:0];
//    [mm.mPhoneBtn setTitle:[SUser currentUser].mPhone forState:0];
    
    [mm.mPhoneBtn addTarget:self action:@selector(changePhone:) forControlEvents:UIControlEventTouchUpInside];
    [mm.mPwdBtn addTarget:self action:@selector(changePwd:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:mm];
    [mm makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.view).with.offset(64);
        make.height.offset(DEVICE_Height);
        make.width.offset(DEVICE_Width);
    }];
    
}
-(void)updateInfo
{
//    
//    [mm.mHeaderImg sd_setImageWithURL:[NSURL URLWithString:[SUser currentUser].mHeadImgURL] placeholderImage:[UIImage imageNamed:@"my_defaulimg"]];
//    [mm.mNameBtn setTitle:[SUser currentUser].mUserName forState:0];
//    [mm.mPhoneBtn setTitle:[SUser currentUser].mPhone forState:0];
    
}
- (void)changePhone:(UIButton *)sender{
    checkPhoneViewController *check = [[checkPhoneViewController alloc]initWithNibName:@"checkPhoneViewController" bundle:nil];
    _bereload = YES;
    [self pushViewController:check];
}
- (void)changePwd:(UIButton *)sender{
    UIStoryboard *secondStroyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    forgetAndChangePwdView *f =[secondStroyBoard instantiateViewControllerWithIdentifier:@"forget"];
    f.wkType = 1;
    [self.navigationController pushViewController:f animated:YES];
}
- (void)nameBtnTouched:(UIButton *)sender{

    changeNameViewController *change = [[changeNameViewController alloc]initWithNibName:@"changeNameViewController" bundle:nil];
    [self pushViewController:change];
  
    
}
- (BOOL)isEdit{
    return mm.mHeaderImg != nil;
}

- (void)okBtnTouched:(UIButton *)sender{
//    SUser *user = [SUser currentUser];
    if ( ![self isEdit]) {
        [SVProgressHUD showErrorWithStatus:@"没有任何数据修改"];
        return;
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)headBtnTouched:(UIButton *)sender
{
    UIActionSheet *ac = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择", nil];
    ac.tag = 1001;
    [ac showInView:[self.view window]];
}
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
    return   CGRectMake(self.view.center.x-mm.mHeaderImg.frame.size.width/2, self.view.center.y-mm.mHeaderImg.frame.size.height/2, mm.mHeaderImg.frame.size.width, mm.mHeaderImg.frame.size.height);
    
}
- (UIBezierPath *)imageCropViewControllerCustomMaskPath:(RSKImageCropViewController *)controller
{
    return [UIBezierPath bezierPathWithRect:CGRectMake(self.view.center.x-mm.mHeaderImg.frame.size.width/2, self.view.center.y-mm.mHeaderImg.frame.size.height/2, mm.mHeaderImg.frame.size.width, mm.mHeaderImg.frame.size.height)];
    
}
- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage
{
    
    [controller.navigationController popViewControllerAnimated:YES];
    
    tempImage = croppedImage;//[Util scaleImg:croppedImage maxsize:140];
    
//    [[SUser currentUser] updateUserInfo:nil HeadImg:tempImage Brief:nil block:^(SResBase *resb) {
//        if (resb.msuccess) {
//            mm.mHeaderImg.image = tempImage;
//
//        }else{
//            [SVProgressHUD showErrorWithStatus:resb.mmsg];
//        }
//    }];
    
    
}

///限制验证码输入长度
#define PASS_LENGHT 20
#pragma mark **----键盘代理方法
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *new = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSInteger res;
    if (textField.tag==20) {
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

@end
