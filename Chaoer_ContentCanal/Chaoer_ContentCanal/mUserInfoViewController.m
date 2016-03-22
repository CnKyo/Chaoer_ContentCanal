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

@interface mUserInfoViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,RSKImageCropViewControllerDelegate,RSKImageCropViewControllerDataSource,UITextFieldDelegate>

@end

@implementation mUserInfoViewController
{
    UIImage *tempImage;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.Title = self.mPageName = @"个人信息";
    self.hiddenRightBtn = YES;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
    
    self.mbgkView1.layer.masksToBounds = self.mBgkView2.layer.masksToBounds = YES;
    self.mbgkView1.layer.borderColor = self.mBgkView2.layer.borderColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.86 alpha:1].CGColor;
    self.mbgkView1.layer.borderWidth = self.mBgkView2.layer.borderWidth = 0.5;
    
    
    self.mHeaderImg.layer.masksToBounds = YES;
    self.mHeaderImg.layer.cornerRadius = self.mHeaderImg.mwidth/2;
    
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
    eee.mPlaceholder = @"请输入昵称";
    eee.mtext = @"好的名字能让别人记住你。";
    eee.block = ^(NSString *content){
        
        self.mName.text = content;;
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
 *  二维码
 *
 *  @param sender
 */
- (IBAction)mErweima:(id)sender {
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
        NSLog(@"选择了第 %ld个", (long)buttonIndex);
        if (buttonIndex == 0) {
            self.mSex.text = @"男";
        }else{
            self.mSex.text = @"女";
            
        }
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
    eee.mPlaceholder = @"请输入个性签名";
    eee.mtext = @"好的签名能让别人记住你。";
    eee.block = ^(NSString *content){
        
        self.mDetail.text = content;;
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
    
    tempImage = croppedImage;//[Util scaleImg:croppedImage maxsize:140];
    
    self.mHeaderImg.image = tempImage;
    
    
}


@end
