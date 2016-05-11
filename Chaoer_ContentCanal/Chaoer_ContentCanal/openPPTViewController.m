//
//  openPPTViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "openPPTViewController.h"
#import "applyPPTView.h"
#import "XMNPhotoPickerFramework.h"
#import "XMNPhotoCollectionController.h"

#import "XMNAssetCell.h"

#import "depositViewController.h"

@interface openPPTViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, copy)   NSArray<XMNAssetModel *> *mHandassets;

@property (nonatomic, copy)   NSArray<XMNAssetModel *> *mFrontassets;

@property (nonatomic, copy)   NSArray<XMNAssetModel *> *mForwordassets;

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
    //1. 推荐使用XMNPhotoPicker 的单例
    //2. 设置选择完照片的block回调
    [[XMNPhotoPicker sharePhotoPicker] setDidFinishPickingPhotosBlock:^(NSArray<UIImage *> *images, NSArray<XMNAssetModel *> *assets) {
        
        if (images.count > 1 || assets.count > 1) {
            [LCProgressHUD showFailure:@"只能选择1张图片!"];
            
            NSLog(@"选择的图片超过3张!");
            return ;
        }
        
        NSLog(@"picker images :%@ \n\n assets:%@",images,assets);
        
        
        if (assets) {
            for (XMNAssetModel *model in assets) {
                mHandImg = [Util scaleImg:model.previewImage maxsize:150];
                [mView.mHandBtn setBackgroundImage:model.thumbnail forState:0];
                
            }
        }else{
            
            for (UIImage *img in images) {
                mHandImg = [Util scaleImg:img maxsize:150];
                [mView.mHandBtn setBackgroundImage:mHandImg forState:0];
            }
        }
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
        
        NSData *imageData = UIImagePNGRepresentation(mHandImg);
        NSString *aPath=[NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(),nowTimeStr];
        [imageData writeToFile:aPath atomically:YES];
        
        
        NSString *aPath3=[NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(),nowTimeStr];
        UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:aPath3];
        UIImageView* imageView3=[[UIImageView alloc]initWithImage:imgFromUrl3];
        
        mHandImgPath = aPath;
        
        mHandImgData = UIImagePNGRepresentation([Util scaleImg:imageView3.image maxsize:150]);
        
        
        self.mHandassets = [assets copy];
        
        
    }];
    //3. 设置选择完视频的block回调
    [[XMNPhotoPicker sharePhotoPicker] setDidFinishPickingVideoBlock:^(UIImage * image, XMNAssetModel *asset) {
        NSLog(@"picker video :%@ \n\n asset :%@",image,asset);
        self.mHandassets = @[asset];
        
    }];
    //4. 显示XMNPhotoPicker
    [[XMNPhotoPicker sharePhotoPicker] showPhotoPickerwithController:self animated:YES];
}
/**
 *  正面
 *
 *  @param sender
 */
- (void)frontAction:(UIButton *)sender{
    //1. 推荐使用XMNPhotoPicker 的单例
    //2. 设置选择完照片的block回调
    [[XMNPhotoPicker sharePhotoPicker] setDidFinishPickingPhotosBlock:^(NSArray<UIImage *> *images, NSArray<XMNAssetModel *> *assets) {
        
        if (images.count > 1 || assets.count > 1) {
            [LCProgressHUD showFailure:@"只能选择1张图片!"];
            
            NSLog(@"选择的图片超过3张!");
            return ;
        }
        
        NSLog(@"picker images :%@ \n\n assets:%@",images,assets);
        
        
        if (assets) {
            for (XMNAssetModel *model in assets) {
                mFrontImg = [Util scaleImg:model.previewImage maxsize:150];
                [mView.mFrontBtn setBackgroundImage:model.thumbnail forState:0];
                
            }
        }else{
            
            for (UIImage *img in images) {
                mFrontImg = [Util scaleImg:img maxsize:150];
                [mView.mFrontBtn setBackgroundImage:mFrontImg forState:0];
            }
        }
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
        
        NSData *imageData = UIImagePNGRepresentation(mFrontImg);
        NSString *aPath=[NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(),nowTimeStr];
        [imageData writeToFile:aPath atomically:YES];
        
        
        NSString *aPath3=[NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(),nowTimeStr];
        UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:aPath3];
        UIImageView* imageView3=[[UIImageView alloc]initWithImage:imgFromUrl3];
        
        mFrontImgPath = aPath;
        
        mFrontImgData = UIImagePNGRepresentation([Util scaleImg:imageView3.image maxsize:150]);
        
        
        self.mFrontassets = [assets copy];
        
        
    }];
    //3. 设置选择完视频的block回调
    [[XMNPhotoPicker sharePhotoPicker] setDidFinishPickingVideoBlock:^(UIImage * image, XMNAssetModel *asset) {
        NSLog(@"picker video :%@ \n\n asset :%@",image,asset);
        self.mFrontassets = @[asset];
        
    }];
    //4. 显示XMNPhotoPicker
    [[XMNPhotoPicker sharePhotoPicker] showPhotoPickerwithController:self animated:YES];
}
/**
 *  反面
 *
 *  @param sender   
 */
- (void)forwordAction:(UIButton *)sender{
    //1. 推荐使用XMNPhotoPicker 的单例
    //2. 设置选择完照片的block回调
    [[XMNPhotoPicker sharePhotoPicker] setDidFinishPickingPhotosBlock:^(NSArray<UIImage *> *images, NSArray<XMNAssetModel *> *assets) {
        
        if (images.count > 1 || assets.count > 1) {
            [LCProgressHUD showFailure:@"只能选择1张图片!"];
            
            NSLog(@"选择的图片超过3张!");
            return ;
        }
        
        NSLog(@"picker images :%@ \n\n assets:%@",images,assets);
        
        
        if (assets) {
            for (XMNAssetModel *model in assets) {
                mForwordImg = [Util scaleImg:model.previewImage maxsize:150];
                [mView.mForwordBtn setBackgroundImage:model.thumbnail forState:0];
                
            }
        }else{
            
            for (UIImage *img in images) {
                mForwordImg = [Util scaleImg:img maxsize:150];
                [mView.mForwordBtn setBackgroundImage:mForwordImg forState:0];
            }
        }
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
        
        NSData *imageData = UIImagePNGRepresentation(mForwordImg);
        NSString *aPath=[NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(),nowTimeStr];
        [imageData writeToFile:aPath atomically:YES];
        
        
        NSString *aPath3=[NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(),nowTimeStr];
        UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:aPath3];
        UIImageView* imageView3=[[UIImageView alloc]initWithImage:imgFromUrl3];
        
        mForwordImgPath = aPath;
        
        mForwordImgData = UIImagePNGRepresentation([Util scaleImg:imageView3.image maxsize:150]);
        
        
        self.mForwordassets = [assets copy];
        
        
    }];
    //3. 设置选择完视频的block回调
    [[XMNPhotoPicker sharePhotoPicker] setDidFinishPickingVideoBlock:^(UIImage * image, XMNAssetModel *asset) {
        NSLog(@"picker video :%@ \n\n asset :%@",image,asset);
        self.mForwordassets = @[asset];
        
    }];
    //4. 显示XMNPhotoPicker
    [[XMNPhotoPicker sharePhotoPicker] showPhotoPickerwithController:self animated:YES];
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

@end
