//
//  goOrderViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/21.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "goOrderViewController.h"
#import "choiseServicerViewController.h"

#import "RSKImageCropper.h"

#import "XMNPhotoPickerFramework.h"
#import "XMNPhotoCollectionController.h"

#import "XMNAssetCell.h"

#import "addAddressViewController.h"
#import "TFFileUploadManager.h"
#import "needCodeViewController.h"
#import "MHDatePicker.h"

#import "choiseServicerViewController.h"
#import "goOrderView.h"
@interface goOrderViewController ()<HZQDatePickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,THHHTTPDelegate,AVCaptureFileOutputRecordingDelegate,UITableViewDelegate,UITableViewDataSource>
{

    HZQDatePickerView *_pikerView;

}
@property (nonatomic, copy)   NSArray<XMNAssetModel *> *assets;

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@end

@implementation goOrderViewController
{
    UIImage *tempImage;
    
    NSData  *mImgData;
    NSString *mImagePath;
    
    NSData *mVedioData;
    NSString *mVedioPath;
    
    int mSelecte;
    
    
    NSURL *mVideoUrl;
    
    
    NSString *mVideoUrlString;
    NSString *mImgUrlString;
    UIScrollView *mScrollerView;
    
    goOrderView *mView;
    
    NSMutableArray *mAddressArr;
    NSString *mACommunityId;

    NSString    *mTime;
    
    
    NSString *mAddressStr;
    
    NSString    *mBlockServiceName;
    NSString    *mBlockServiceId;
    

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [WJStatusBarHUD hide];
    
    [self loadData];
    
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
- (void)loadData{
    
    [SVProgressHUD showWithStatus:@"正在验证..." maskType:SVProgressHUDMaskTypeClear];
    
    [[mUserInfo backNowUser] getAddress:^(mBaseData *resb, NSArray *mArr) {
        
        
        [mAddressArr removeAllObjects];
        
        if (resb.mSucess) {
            
            [SVProgressHUD dismiss];
            
            [mAddressArr addObjectsFromArray:mArr];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
            
            [self performSelector:@selector(leftBtnTouched:) withObject:nil afterDelay:1];
            
        }
        
    }];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.Title = self.mPageName = @"确认订单";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.hiddenRightBtn = YES;
    UIButton *mCommitBtn = [UIButton new];
    mCommitBtn.frame = CGRectMake(0, DEVICE_Height-40, DEVICE_Width, 40);
    mCommitBtn.backgroundColor = M_CO;
    [mCommitBtn setTitle:@"立即下单" forState:0];
    [mCommitBtn setTitleColor:[UIColor whiteColor] forState:0];
    [mCommitBtn addTarget:self action:@selector(mCommitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mCommitBtn];
    
    
    mAddressArr = [NSMutableArray new];
    mACommunityId = nil;
    mTime = nil;
    
    mAddressStr = nil;
    mImgUrlString = nil;
    mVideoUrlString = nil;
    
    mBlockServiceId = nil;
    mBlockServiceName = nil;
    
    [self initView];
    
}
- (void)initView{
    
    mScrollerView = [UIScrollView new];
    mScrollerView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-104);
    mScrollerView.backgroundColor = [UIColor colorWithRed:0.92 green:0.91 blue:0.95 alpha:0.75];
    [self.view addSubview:mScrollerView];
    
    
    mView = [goOrderView shareView];
    mView.frame = CGRectMake(0, 0, DEVICE_Width, 630);
    
    [mView.mNoteTx setPlaceholder:@"请输入备注"];
    [mView.mNoteTx setHolderToTop];
    
    [mView.mImag sd_setImageWithURL:[NSURL URLWithString:self.mFixOrder.mSmallImage] placeholderImage:[UIImage imageNamed:@"img_default"]];
    mView.mServiceName.text = self.mFixOrder.mClassName;
    mView.mServicePrice.text = [NSString stringWithFormat:@"%@¥",self.mFixOrder.mEstimatedPrice];
    mView.mDetail.text = self.mFixOrder.mDescribe;
//    mView.mMoney.hidden = YES;
    mView.mMoney.text = [NSString stringWithFormat:@"保证金：%@元",@"20"];
    
    [mView.mAddressBtn addTarget:self action:@selector(mAddressAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mServiceTimeBtn addTarget:self action:@selector(mServiceTimeAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mChoiceServiceBtn addTarget:self action:@selector(mChoiceAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mUploadImgBtn addTarget:self action:@selector(mUploadImgAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mUploadVideoBtn addTarget:self action:@selector(mUploadVideoAction:) forControlEvents:UIControlEventTouchUpInside];

    [mScrollerView addSubview:mView];
    
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 630);
    
    
}

#pragma mark---－确认下单
- (void)mCommitAction:(UIButton *)sender{
    
    
    if (mAddressStr == nil || [mAddressStr isEqualToString:@""] || mAddressStr.length == 0) {
        [self showErrorStatus:@"请选择服务地址！"];
        return;
    }
    if (mTime == nil || [mTime isEqualToString:@""] || mTime.length == 0) {
        [self showErrorStatus:@"请选择服务时间！"];
        return;
    }
    if (mBlockServiceId == nil || [mBlockServiceId isEqualToString:@""] || mBlockServiceId.length == 0) {
        [self showErrorStatus:@"请选择服务人员！"];
        return;
    }
    if (mView.mNoteTx.text.length == 0) {
        [self showErrorStatus:@"请输入备注！"];
        return;
    }
    if (mImgUrlString == nil || [mImgUrlString isEqualToString:@""] || mImgUrlString.length == 0) {
        [self showErrorStatus:@"请上传图片！"];
        return;
    }
    [self AlertViewShow:@"为了保证服务质量，确认下单将扣除20元保证金！" alertViewMsg:@"完成服务后保证金将全额退还！" alertViewCancelBtnTiele:@"取消" alertTag:100];

    
    
}
#pragma mark---－选择地址
- (void)mAddressAction:(UIButton *)sender{
    if (mAddressArr.count <= 0) {
        [self AlertViewShow:@"未找到地址！请添加房屋！" alertViewMsg:@"添加房屋地址后才能使用保修功能哦！" alertViewCancelBtnTiele:@"取消" alertTag:10];
        
        return;
    }
    
    [self loadMHActionSheetView];

    
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10) {
        if( buttonIndex == 1)
        {
            needCodeViewController *nnn = [[needCodeViewController alloc] initWithNibName:@"needCodeViewController" bundle:nil];
            nnn.Type = 2;
            [self pushViewController:nnn];
        }

    }else{
        if( buttonIndex == 1)
        {
            [self showWithStatus:@"正在操作中..."];
            [[mUserInfo backNowUser] commitFixOrder:[NSString stringWithFormat:@"%d",self.mID] andSubClass:self.mSubClass andNote:mView.mNoteTx.text andServiceTime:mTime andAddress:mAddressStr andCommunityId:mACommunityId andServicerId:[mBlockServiceId intValue] andImgUrl:mImgUrlString andVideoUrl:mVideoUrlString block:^(mBaseData *resb) {
                
                if (resb.mSucess) {
                    [self showSuccessStatus:resb.mMessage];
                    [self dismissViewController_3];
                }else{
                    [self showErrorStatus:resb.mMessage];
                }
                
            }];

        }
    
    }
}
- (void)AlertViewShow:(NSString *)alerViewTitle alertViewMsg:(NSString *)msg alertViewCancelBtnTiele:(NSString *)cancelTitle alertTag:(int)tag{
    
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:alerViewTitle message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:@"确定", nil];
    al.delegate = self;
    al.tag = tag;
    [al show];
}

- (void)loadMHActionSheetView{
    
    MLLog(@"得到的数据是：%@",mAddressArr);
    
    NSMutableArray *madd = [NSMutableArray new];
    
    for (GAddress *mAddresss in mAddressArr) {
        [madd addObject:mAddresss.mAddressName];
    }
    
    
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择地址:" style:MHSheetStyleWeiChat itemTitles:madd];
    actionSheet.cancleTitle = @"取消选择";
    
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        
        GAddress *mAddresss = mAddressArr[index];
        mView.mServiceAddress.text = mAddresss.mAddressName;
 
        mACommunityId = mAddresss.mAddressId;
        mAddressStr = mAddresss.mAddressName;
        
    }];
}

#pragma mark---－选择时间
- (void)mServiceTimeAction:(UIButton *)sender{
    
    MHDatePicker *selectTimePicker = [[MHDatePicker alloc] init];
    __weak typeof(self) weakSelf = self;
    [selectTimePicker didFinishSelectedDate:^(NSDate *selectedDate) {
        
        
        mTime = [weakSelf dateStringWithDate:selectedDate DateFormat:@"yyyy-MM-dd"];
        
        [mView.mServiceTimeBtn setTitle:[NSString stringWithFormat:@"%@", mTime] forState:0];
    }];

    
    
}
- (NSString *)dateStringWithDate:(NSDate *)date DateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *str = [dateFormatter stringFromDate:date];
    return str ? str : @"";
}

#pragma mark---－确认人员
- (void)mChoiceAction:(UIButton *)sender{
    
    if (mAddressStr == nil || [mAddressStr isEqualToString:@""] || mAddressStr.length == 0) {
        [self showErrorStatus:@"请选择服务地址!"];
        return;
    }
    
    choiseServicerViewController *ccc = [[choiseServicerViewController alloc] initWithNibName:@"choiseServicerViewController" bundle:nil];
    ccc.Type = 1;
    ccc.mSubClass = self.mSubClass;
    ccc.mID = self.mID;
    ccc.mAddress = mAddressStr;
    ccc.block = ^(NSString *content ,NSString *mId){
        
        mBlockServiceName = content;
        mBlockServiceId = mId;
        
        [sender setTitle:content forState:0];
    };
    [self presentModalViewController:ccc];
    
    
}
#pragma mark---－上传图片
- (void)mUploadImgAction:(UIButton *)sender{
    mSelecte = 1;
    //1. 推荐使用XMNPhotoPicker 的单例
    //2. 设置选择完照片的block回调
    [[XMNPhotoPicker sharePhotoPicker] setDidFinishPickingPhotosBlock:^(NSArray<UIImage *> *images, NSArray<XMNAssetModel *> *assets) {
        
        if (images.count > 1 || assets.count > 1) {
            [LCProgressHUD showFailure:@"只能选择1张图片!"];
            
            MLLog(@"选择的图片超过3张!");
            return ;
        }
        
        MLLog(@"picker images :%@ \n\n assets:%@",images,assets);
        
        
        if (assets) {
            for (XMNAssetModel *model in assets) {
                tempImage = [Util scaleImg:model.previewImage maxsize:150];
                [mView.mUploadImgBtn setBackgroundImage:model.thumbnail forState:0];
                
            }
        }else{
            
            for (UIImage *img in images) {
                tempImage = [Util scaleImg:img maxsize:150];
                [mView.mUploadImgBtn setBackgroundImage:tempImage forState:0];
            }
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
        
        mImagePath = aPath;
        
        mImgData = UIImagePNGRepresentation([Util scaleImg:imageView3.image maxsize:150]);
        
        
        self.assets = [assets copy];
        
        NSMutableDictionary *para = [NSMutableDictionary new];
        [para setObject:@"apply" forKey:@"type"];
        [para setObject:mImgData forKey:@"file"];
        
        NSString    *mUrlStr = [NSString stringWithFormat:@"%@/resource/warranty/uploadWarrantyImg",[HTTPrequest returnNowURL]];
        TFFileUploadManager *manage = [TFFileUploadManager shareInstance];
        manage.delegate = self;
        [manage uploadFileWithURL:mUrlStr params:para andData:mImgData fileKey:@"pic" filePath:aPath  completeHander:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            if (connectionError) {
                MLLog(@"请求出错 %@",connectionError);
            }else{
                MLLog(@"请求返回：\n%@",response);
            }
        }];

        
    }];
    //3. 设置选择完视频的block回调
    [[XMNPhotoPicker sharePhotoPicker] setDidFinishPickingVideoBlock:^(UIImage * image, XMNAssetModel *asset) {
        MLLog(@"picker video :%@ \n\n asset :%@",image,asset);
        self.assets = @[asset];
        
    }];
    //4. 显示XMNPhotoPicker
    [[XMNPhotoPicker sharePhotoPicker] showPhotoPickerwithController:self animated:YES];

    
    
}

#pragma mark---－上传视频
- (void)mUploadVideoAction:(UIButton *)sender{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    
    UIAlertAction *localvideo = [UIAlertAction actionWithTitle:@"本地视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self locallVideo];
    }];
    UIAlertAction *shotvideo = [UIAlertAction actionWithTitle:@"拍摄视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self shotVideo];
    }];
    
    
    [alertController addAction:localvideo];
    [alertController addAction:shotvideo];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];

    
}
#pragma mark----上传视频
- (void)upLoadVideo{
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    
    
    [para setObject:mVedioData forKey:@"video"];
    
    MLLog(@"上传的参数是：%@",para);
    
    [LBProgressHUD showHUDto:self.view withTips:@"正在上传视频..." animated:YES];
    
    NSString    *mUrlStr = [NSString stringWithFormat:@"%@/app/upload/uploadVideo",[HTTPrequest returnNowURL]];
    TFFileUploadManager *manage = [TFFileUploadManager shareInstance];
    manage.delegate = self;
    
    [manage uploadFileWithURL:mUrlStr params:para andData:mVedioData fileKey:@"video" filePath:mVedioPath completeHander:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            MLLog(@"请求出错 %@",connectionError);
        }else{
            MLLog(@"请求返回：\n%@",response);
        }
    }];
    
}

- (void)block:(mBaseData *)resb{
    [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    if (mSelecte == 2) {
        
        if (resb.mSucess) {
            
            [LCProgressHUD showSuccess:@"视频上传成功！"];
            
            mVideoUrlString = [resb.mData objectForKey:@"video"];
            
        }else{
            [LCProgressHUD showFailure:resb.mMessage];
        }
        
    }else{
        if (resb.mSucess) {
            [LCProgressHUD showSuccess:@"图片上传成功！"];
            mImgUrlString = [resb.mData objectForKey:@"pic"];
            
        }else{
            [LCProgressHUD showFailure:resb.mMessage];
        }
        
    }
    
    
    
    
}

//本地视频
- (void)locallVideo
{
    UIImagePickerController *imgPickerCtrl = [[UIImagePickerController alloc] init];
    
    imgPickerCtrl.delegate = self;
    
    imgPickerCtrl.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    //自定媒体类型
    imgPickerCtrl.mediaTypes = @[@"public.movie"];
    
    [self presentViewController:imgPickerCtrl animated:YES completion:nil];
    
}
//拍摄视频
- (void)shotVideo
{
    UIImagePickerController *imgPickerCtrl = [[UIImagePickerController alloc] init];
    
    imgPickerCtrl.delegate = self;
    
    imgPickerCtrl.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    imgPickerCtrl.mediaTypes = @[@"public.movie"];
    
    [self presentViewController:imgPickerCtrl animated:YES completion:nil];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    if ([mediaType isEqualToString:@"public.image"]){
        
        UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        ;
        MLLog(@"%@",image);
        NSString *imageFile = [documentsDirectory stringByAppendingPathComponent:@"temp.jpg"];
        ;
        
        success = [fileManager fileExistsAtPath:imageFile];
        if(success) {
            success = [fileManager removeItemAtPath:imageFile error:&error];
        }
        
        tempImage = image;
        [UIImageJPEGRepresentation(image, 1.0f) writeToFile:imageFile atomically:YES];
        
        //SETIMAGE(image);
        //CFShow([[NSFileManager defaultManager] directoryContentsAtPath:[NSHomeDirectory() stringByAppendingString:@"/Documents"]]);
        ;    }
    else if([mediaType isEqualToString:@"public.movie"]){
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        mVideoUrl = videoURL;
        [mView.mUploadVideoBtn setBackgroundImage:[self imageWithMediaURL:mVideoUrl] forState:0];
        
        [self saveVideoWith:videoURL];
        
        
        //
        //        /****************************************/
        //
        //        NSString *videoFile = [documentsDirectory stringByAppendingPathComponent:@"temp.mov"];
        //        ;
        //
        //        success = [fileManager fileExistsAtPath:videoFile];
        //        if(success) {
        //            success = [fileManager removeItemAtPath:videoFile error:&error];
        //        }
        //        [mVedioData writeToFile:videoFile atomically:YES];
        //        //CFShow([[NSFileManager defaultManager] directoryContentsAtPath:[NSHomeDirectory() stringByAppendingString:@"/Documents"]]);
        //        ;    //NSLog(videoURL);
        //
        
        
        
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (void) convertVideoQuailtyWithInputURL:(NSURL*)inputURL
                               outputURL:(NSURL*)outputURL
                         completeHandler:(void (^)(AVAssetExportSession *exportSession))handler
{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    MLLog(@"%@",compatiblePresets);
    
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
        
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
        
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        
        NSString * resultPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]];
        
        MLLog(@"resultPath = %@",resultPath);
        exportSession.outputURL = [NSURL fileURLWithPath:resultPath];
        [self getFileSize:[NSString stringWithFormat:@"%@",exportSession.outputURL]];
        
        exportSession.outputFileType = AVFileTypeMPEG4;
        
        exportSession.shouldOptimizeForNetworkUse = YES;
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
         
         {
             MLLog(@"-+-+-+-++-+-+-+-+--+:%@",exportSession.outputURL);
             
             switch (exportSession.status) {
                     
                 case AVAssetExportSessionStatusUnknown:
                     
                     MLLog(@"AVAssetExportSessionStatusUnknown");
                     
                     break;
                     
                 case AVAssetExportSessionStatusWaiting:
                     
                     MLLog(@"AVAssetExportSessionStatusWaiting");
                     
                     break;
                     
                 case AVAssetExportSessionStatusExporting:
                     
                     MLLog(@"AVAssetExportSessionStatusExporting");
                     
                     break;
                     
                 case AVAssetExportSessionStatusCompleted:
                     
                     MLLog(@"AVAssetExportSessionStatusCompleted");
                     MLLog(@"完成之后－－－＋－＋－＋－＋－%@",exportSession);
                     break;
                     
                 case AVAssetExportSessionStatusFailed:
                     
                     MLLog(@"AVAssetExportSessionStatusFailed");
                     
                     break;
                     
                     
             }
             
         }];
        
    }
    
}

- (CGFloat) getFileSize:(NSString *)path
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024;
    }
    MLLog(@"问价大小是:%f",filesize);
    return filesize;
}

- (void)saveVideoWith:(NSURL *)url
{
    NSError *error = nil;
    CGSize renderSize = CGSizeMake(0, 0);
    CMTime totalDuration = kCMTimeZero;
    AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
    AVAsset *asset = [AVAsset assetWithURL:url];
    if (!asset) {
        MLLog(@"asset数据为空");
        return;
    }
    MLLog(@"%@---%@",asset.tracks,[asset tracksWithMediaType:@"vide"]);
    AVAssetTrack *assetTrack;
    if ([asset tracksWithMediaType:@"vide"].count>0) {
        assetTrack = [[asset tracksWithMediaType:@"vide"] objectAtIndex:0];
    }else{
        MLLog(@"asset数据为空");
        return;
    }
    renderSize.width = MAX(renderSize.width, assetTrack.naturalSize.height);
    renderSize.height = MAX(renderSize.height, assetTrack.naturalSize.width);
    
    CGFloat renderW = MIN(renderSize.width, renderSize.height);
    AVMutableCompositionTrack *audioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset.duration)
                        ofTrack:[[asset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0]
                         atTime:totalDuration
                          error:nil];
    
    AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    
    [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset.duration)
                        ofTrack:assetTrack
                         atTime:totalDuration
                          error:&error];
    
    //fix orientationissue
    AVMutableVideoCompositionLayerInstruction *layerInstruciton = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
    
    totalDuration = CMTimeAdd(totalDuration, asset.duration);
    
    CGFloat rate;
    rate = renderW / MIN(assetTrack.naturalSize.width, assetTrack.naturalSize.height);
    
    CGAffineTransform layerTransform = CGAffineTransformMake(assetTrack.preferredTransform.a, assetTrack.preferredTransform.b, assetTrack.preferredTransform.c, assetTrack.preferredTransform.d, assetTrack.preferredTransform.tx * rate, assetTrack.preferredTransform.ty * rate);
    layerTransform = CGAffineTransformConcat(layerTransform, CGAffineTransformMake(1, 0, 0, 1, 0, -(assetTrack.naturalSize.width - assetTrack.naturalSize.height) / 2.0));//向上移动取中部影响
    layerTransform = CGAffineTransformScale(layerTransform, rate, rate);//放缩，解决前后摄像结果大小不对称
    
    [layerInstruciton setTransform:layerTransform atTime:kCMTimeZero];
    [layerInstruciton setOpacity:0.0 atTime:totalDuration];
    
    NSMutableArray *layerInstructionArray = [[NSMutableArray alloc] init];
    [layerInstructionArray addObject:layerInstruciton];
    
    NSString *filePath = [[self class] getVideoMergeFilePathString];
    
    mVedioPath = filePath;
    
    NSURL *mergeFileURL = [NSURL fileURLWithPath:filePath];
    
    //export
    AVMutableVideoCompositionInstruction *mainInstruciton = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    mainInstruciton.timeRange = CMTimeRangeMake(kCMTimeZero, totalDuration);
    mainInstruciton.layerInstructions = layerInstructionArray;
    AVMutableVideoComposition *mainCompositionInst = [AVMutableVideoComposition videoComposition];
    mainCompositionInst.instructions = @[mainInstruciton];
    mainCompositionInst.frameDuration = CMTimeMake(1, 30);
    mainCompositionInst.renderSize = CGSizeMake(renderW, renderW);
    
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetMediumQuality];
    exporter.videoComposition = mainCompositionInst;
    exporter.outputURL = mergeFileURL;
    MLLog(@"最后的到的文件是：%@",exporter.outputURL);
    
    if ([self getFileSize:[NSString stringWithFormat:@"%@",exporter.outputURL]] >= 10.0*1024) {
        [LCProgressHUD showFailure:@"选择的文件太大了！"];
        
        return;
    }
    
    exporter.outputFileType = AVFileTypeMPEG4;
    exporter.shouldOptimizeForNetworkUse = YES;
    [exporter exportAsynchronouslyWithCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            switch ([exporter status]) {
                case AVAssetExportSessionStatusFailed:
                {
                    
                    [LCProgressHUD showFailure:@"视频处理失败！"];
                    
                    break;
                }
                    
                case AVAssetExportSessionStatusCancelled:
                    [LCProgressHUD showFailure:@"视频处理取消！"];
                    
                    break;
                case AVAssetExportSessionStatusCompleted:
                    [LCProgressHUD showSuccess:@"视频处理完成"];
                    mVedioData = [NSData dataWithContentsOfURL:exporter.outputURL];
                    mSelecte = 2;
                    [self upLoadVideo];
                    
                    //视频转码成功,删除原始文件
                    [[NSFileManager defaultManager] removeItemAtURL:url error:nil];
                    break;
                default:
                    break;
            }
        });
    }];
    
}
+ (NSString *)getVideoMergeFilePathString
{
    NSString *path =[NSString stringWithFormat:@"%@/tmp/",NSHomeDirectory()];
    NSString *testDirectory = [path stringByAppendingPathComponent:@"videos"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager isExecutableFileAtPath:testDirectory]) {
        MLLog(@"无文件夹,创建文件");
        [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    
    NSString *fileName = [[testDirectory stringByAppendingPathComponent:nowTimeStr] stringByAppendingString:@".mp4"];
    
    return fileName;
}

- (CGFloat) getVideoLength:(NSURL *)URL
{
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                                     forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:URL options:opts];
    float second = 0;
    second = urlAsset.duration.value/urlAsset.duration.timescale;
    return second;
}
/**
 *  通过视频的URL，获得视频缩略图
 *
 *  @param url 视频URL
 *
 *  @return首帧缩略图
 */
- (UIImage *)imageWithMediaURL:(NSURL *)url {
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                                     forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    // 初始化媒体文件
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
    // 根据asset构造一张图
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    // 设定缩略图的方向
    // 如果不设定，可能会在视频旋转90/180/270°时，获取到的缩略图是被旋转过的，而不是正向的（自己的理解）
    generator.appliesPreferredTrackTransform = YES;
    // 设置图片的最大size(分辨率)
    generator.maximumSize = CGSizeMake(600, 450);
    // 初始化error
    NSError *error = nil;
    // 根据时间，获得第N帧的图片
    // CMTimeMake(a, b)可以理解为获得第a/b秒的frame
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 10000) actualTime:NULL error:&error];
    // 构造图片
    UIImage *image = [UIImage imageWithCGImage: img];
    return image;
}

- (void)leftBtnTouched:(id)sender{
    [self dismissViewController];
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
