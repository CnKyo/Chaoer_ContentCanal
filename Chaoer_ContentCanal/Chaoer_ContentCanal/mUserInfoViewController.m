//
//  mUserInfoViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/15.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mUserInfoViewController.h"

#import "editMessageViewController.h"
#import "RSKImageCropper.h"
#import "TFFileUploadManager.h"

@interface mUserInfoViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,RSKImageCropViewControllerDelegate,RSKImageCropViewControllerDataSource,UITextFieldDelegate,THHHTTPDelegate>

@end

@implementation mUserInfoViewController
{
    UIImage *tempImage;
    
    NSString *msex;
    
    mUserInfo *mUser;
    
    NSString *mHeaderUrl;
    
    BOOL mIsEdit;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    [self loadUserInfo];
}


- (void)loadUserInfo{

    [[mUserInfo backNowUser] getNowUserInfo:^(mBaseData *resb, mUserInfo *user) {
        if (resb.mSucess) {
            [SVProgressHUD showSuccessWithStatus:resb.mMessage];
        }else{
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
        }
    }];
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"个人信息";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.rightBtnTitle = @"保存";
    
    mIsEdit = NO;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
    
    self.mbgkView1.layer.masksToBounds = self.mBgkView2.layer.masksToBounds = YES;
    self.mbgkView1.layer.borderColor = self.mBgkView2.layer.borderColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.86 alpha:1].CGColor;
    self.mbgkView1.layer.borderWidth = self.mBgkView2.layer.borderWidth = 0.5;
    
    
    self.mHeaderImg.layer.masksToBounds = YES;
    self.mHeaderImg.layer.cornerRadius = self.mHeaderImg.mwidth/2;
    
    mUser = [mUserInfo backNowUser];

    
    [self upDatePage];
}
- (void)upDatePage{
    
    
    MLLog(@"个人欣喜:%@",[mUserInfo backNowUser]);
    
    [SVProgressHUD showWithStatus:@"正在加载..." maskType:SVProgressHUDMaskTypeClear];

    NSString *url = [NSString stringWithFormat:@"%@%@",[HTTPrequest currentResourceUrl],[mUserInfo backNowUser].mUserImgUrl];

    [self.mHeaderImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    
    self.mName.text = [mUserInfo backNowUser].mNickName;
    self.mUserInfo.text = [mUserInfo backNowUser].mIdentity;
    self.mSex.text = [mUserInfo backNowUser].mSex;
    
    if ([[mUserInfo backNowUser].mSex isEqualToString:@"女"]) {
        msex = @"0";
    }else{
        msex = @"1";
    }
    
    self.mDetail.text = [mUserInfo backNowUser].mSignature;
    self.mPhone.text = [mUserInfo backNowUser].mPhone;
    [SVProgressHUD dismiss];
    
    
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
/**
 *  <#Description#>
 *
 *  @param sender <#sender description#>
 */
- (IBAction)mHeader:(id)sender {
    UIActionSheet *ac = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择", nil];
    ac.tag = 1001;
    [ac showInView:[self.view window]];
}
/**
 *  姓名
 *
 *  @param sender
 */
- (IBAction)mName:(id)sender {
    
    editMessageViewController *eee = [[editMessageViewController alloc] initWithNibName:@"editMessageViewController" bundle:nil];
    eee.mTitel = @"昵称";
    eee.mtype = 1;
    eee.mPlaceholder = @"请输入昵称";
    eee.mtext = @"好的名字能让别人记住你。";
    eee.block = ^(NSString *content){
        
        self.mName.text = content;
    };

    [self pushViewController:eee];
    
    
}
/**
 *  个人信息
 *
 *  @param sender
 */
- (IBAction)mInfo:(id)sender {
}

/**
 *  电话
 *
 *  @param sender
 */
- (IBAction)mPhone:(id)sender {
}

/**
 *  性别
 *
 *  @param sender
 */
- (IBAction)mSex:(id)sender {
    
    UIActionSheet *acc = [[UIActionSheet alloc]initWithTitle:@"请选择性别！" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
    
    [acc showInView:self.view];

    

}
#pragma mark - IBActionSheet/UIActionSheet Delegate Method
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1001) {
        if ( buttonIndex != 2 ) {
            
            [self startImagePickerVCwithButtonIndex:buttonIndex];
        }
    }else{
        MLLog(@"选择了第 %ld个", (long)buttonIndex);
        
        NSString *sex = nil;
        NSString *text = nil;
        if (buttonIndex == 0) {
            sex = @"m";
            text= @"男";
            msex = @"1";
        }else{
            text= @"女";
            sex = @"w";
            msex = @"0";
            
        }
        self.mSex.text = text;

    }

}

/**
 *  签名
 *
 *  @param sender
 */
- (IBAction)mDEtail:(id)sender {
    
    editMessageViewController *eee = [[editMessageViewController alloc] initWithNibName:@"editMessageViewController" bundle:nil];
    eee.mTitel = @"个性签名";
    eee.mtype = 2;
    eee.mPlaceholder = @"请输入个性签名";
    eee.mtext = @"好的签名能让别人记住你。";
    eee.block = ^(NSString *content){
        
        self.mDetail.text = content;
    };
    [self pushViewController:eee];
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
    return   CGRectMake(self.view.center.x-self.mHeaderImg.frame.size.width/2, self.view.center.y-self.mHeaderImg.frame.size.height/2, self.mHeaderImg.frame.size.width, self.mHeaderImg.frame.size.height);
    
}
- (UIBezierPath *)imageCropViewControllerCustomMaskPath:(RSKImageCropViewController *)controller
{
    return [UIBezierPath bezierPathWithRect:CGRectMake(self.view.center.x-self.mHeaderImg.frame.size.width/2, self.view.center.y-self.mHeaderImg.frame.size.height/2, self.mHeaderImg.frame.size.width, self.mHeaderImg.frame.size.height)];
    
}
- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage
{
    
    [controller.navigationController popViewControllerAnimated:YES];
    
    tempImage = [Util scaleImg:croppedImage maxsize:200];//[Util scaleImg:croppedImage maxsize:140];
    
    self.mHeaderImg.image = tempImage;
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    
    NSData *imageData = UIImagePNGRepresentation(tempImage);
    NSString *aPath=[NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(),nowTimeStr];
    [imageData writeToFile:aPath atomically:YES];
    
    NSString *aPath3=[NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(),nowTimeStr];
    UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:aPath3];
    UIImageView* imageView3=[[UIImageView alloc]initWithImage:imgFromUrl3];

    
    tempImage = [Util scaleImg:imageView3.image maxsize:200];
    
    NSData *mmm = UIImagePNGRepresentation(tempImage);

       
    NSMutableDictionary *para = [NSMutableDictionary new];
    
    
    
    [para setObject:NumberWithInt([mUserInfo backNowUser].mUserId) forKey:@"userId"];

    [para setObject:imageData forKey:@"file"];

    [SVProgressHUD showWithStatus:@"正在保存中..." maskType:SVProgressHUDMaskTypeClear];
    
    NSString    *mUrlStr = [NSString stringWithFormat:@"%@/resource/userInfo/uploadUserProfileImg",[HTTPrequest returnNowURL]];
    TFFileUploadManager *manage = [TFFileUploadManager shareInstance];
    manage.delegate = self;
    [manage uploadFileWithURL:mUrlStr params:para andData:mmm fileKey:@"pic" filePath:aPath  completeHander:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            MLLog(@"请求出错 %@",connectionError);
        }else{
            MLLog(@"请求返回：\n%@",response);
        }
    }];
    
}


- (void)block:(mBaseData *)resb{
    
    
    if (resb.mSucess) {
        [SVProgressHUD showSuccessWithStatus:resb.mMessage];
        mIsEdit = YES;
        mHeaderUrl = [resb.mData objectForKey:@"pic"];
        
        [self rightBtnTouched:nil];
        
    }else{
        mIsEdit = NO;
        [SVProgressHUD showErrorWithStatus:resb.mMessage];
    }
    
}

- (void)rightBtnTouched:(id)sender{

    
    if ([[mUserInfo backNowUser].mNickName isEqualToString:self.mName.text] && [[mUserInfo backNowUser].mSex isEqualToString:self.mSex.text] && [[mUserInfo backNowUser].mSignature isEqualToString:self.mDetail.text] && mIsEdit == NO) {
        [self showErrorStatus:@"未做任何修改！"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在保存中..." maskType:SVProgressHUDMaskTypeClear];
    
    [mUserInfo editUserMsg:mHeaderUrl andUserid:[mUserInfo backNowUser].mUserId andLoginName:nil andNickName:self.mName.text andSex:msex andSignate:self.mDetail.text block:^(mBaseData *resb, mUserInfo *mUser) {
        
        if (resb.mSucess) {
            [SVProgressHUD showSuccessWithStatus:resb.mMessage];
        }else{
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
        }
        
    }];
    
}

@end
