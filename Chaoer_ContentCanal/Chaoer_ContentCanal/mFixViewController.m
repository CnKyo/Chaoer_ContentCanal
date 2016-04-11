//
//  mFixViewController.m
//  Chaoer_ContentCanal
//
//  Created by 王钶 on 16/3/11.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "mFixViewController.h"

#import "mFixView.h"


#import "takeFixViewController.h"

#import "fixTableViewCell.h"

#import "choiseServicerViewController.h"

#import "RSKImageCropper.h"

#import "XMNPhotoPickerFramework.h"
#import "XMNPhotoCollectionController.h"

#import "XMNAssetCell.h"

@interface mFixViewController ()<ZJAlertListViewDelegate,ZJAlertListViewDatasource,HZQDatePickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    HZQDatePickerView *_pikerView;

}

@property (nonatomic, copy)   NSArray<XMNAssetModel *> *assets;

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation mFixViewController
{
    UIScrollView *mScrollerView;
    mFixView *mView;
    
    
    ZJAlertListView *mCleanA;
    
    NSMutableArray  *mArr;
    NSMutableArray  *mClassID;

    NSString    *mType;

    UIImage *tempImage;
    
    
    
    NSString *mSuperID;
    
    NSString    *mTime;
    

    NSData  *mImgData;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
- (void)viewDidLoad {
    [super viewDidLoad];
    
    mArr = [NSMutableArray new];
    mClassID = [NSMutableArray new];

    self.assets = @[];

    self.Title = self.mPageName = @"物业报修";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    [self initView];
    
}
- (void)initView{
    
    
    UIImageView *mbgk = [UIImageView new];
    CGRect  mrr = self.view.bounds;
    mrr.origin.y = 64;
    mbgk.frame = mrr;
    mbgk.image = [UIImage imageNamed:@"mBaseBgkImg"];
    [self.view addSubview:mbgk];
    
    mScrollerView = [UIScrollView new];
    mScrollerView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-50);
    mScrollerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mScrollerView];
    
    
    mView = [mFixView shareView];
    mView.frame = CGRectMake(0, 0, DEVICE_Width, 568);

    [mView.mHomeBtn addTarget:self action:@selector(mHomeAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mCleanBtn addTarget:self action:@selector(mCleanAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mPipeBtn addTarget:self action:@selector(mPipeAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mResultBtn addTarget:self action:@selector(mResetAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mTimeBtn addTarget:self action:@selector(mTimeAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mMakeBtn addTarget:self action:@selector(mMakeAction:) forControlEvents:UIControlEventTouchUpInside];

    
    [mView.mLeftBtn addTarget:self action:@selector(mImageAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mRightBtn addTarget:self action:@selector(mVideoAction:) forControlEvents:UIControlEventTouchUpInside];


    mView.mHiddenView.alpha = 0;
    [mScrollerView addSubview:mView];
    
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 620);
    
    
    
}
- (void)loadData{

    mView.mPhone.text = [NSString stringWithFormat:@"电话：%@",[mUserInfo backNowUser].mPhone];
    
    
}
#pragma mark----图片按钮
- (void)mImageAction:(UIButton *)sender{
    //1. 推荐使用XMNPhotoPicker 的单例
    //2. 设置选择完照片的block回调
    [[XMNPhotoPicker sharePhotoPicker] setDidFinishPickingPhotosBlock:^(NSArray<UIImage *> *images, NSArray<XMNAssetModel *> *assets) {
        if (images.count > 3) {
            [SVProgressHUD showErrorWithStatus:@"图片选择不能超过3张!"];
            NSLog(@"选择的图片超过3张!");
            return ;
        }
        NSLog(@"picker images :%@ \n\n assets:%@",images,assets);
        tempImage = [Util scaleImg:images[0] maxsize:5];
        mImgData = UIImagePNGRepresentation(tempImage);
        
        self.assets = [assets copy];
        
        [mView.mLeftBtn setBackgroundImage:images[0] forState:0];

    }];
    //3. 设置选择完视频的block回调
    [[XMNPhotoPicker sharePhotoPicker] setDidFinishPickingVideoBlock:^(UIImage * image, XMNAssetModel *asset) {
        NSLog(@"picker video :%@ \n\n asset :%@",image,asset);
        self.assets = @[asset];

    }];
    //4. 显示XMNPhotoPicker
    [[XMNPhotoPicker sharePhotoPicker] showPhotoPickerwithController:self animated:YES];

}
#pragma mark----视频按钮
- (void)mVideoAction:(UIButton *)sender{
    
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

#pragma mark----预约按钮
- (void)mMakeAction:(UIButton *)sender{
    
    if (mClassID.count <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择服务类型"];
        return;
    }if (mView.mTxView.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的备注!"];
        return;


    }if (mTime.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择服务时间"];
        return;

    }
//    if (tempImage == nil) {
//        [SVProgressHUD showErrorWithStatus:@"请选择图片!"];
//        return;
//    }
    
    [SVProgressHUD showWithStatus:@"正在提交..." maskType:SVProgressHUDMaskTypeClear];
    
    [mUserInfo commiteFixOrder:[NSString stringWithFormat:@"%d",[mUserInfo backNowUser].mUserId] andOneLevel:mSuperID andClassification:mClassID[0] andRemark:mView.mTxView.text andtime:mTime andPhone:[mUserInfo backNowUser].mPhone andAddress:nil andImg:mImgData block:^(mBaseData *resb) {
        [SVProgressHUD dismiss];
        if (resb.mSucess) {
            choiseServicerViewController *ccc = [[choiseServicerViewController alloc] initWithNibName:@"choiseServicerViewController" bundle:nil];
            ccc.mData = resb;
            [self pushViewController:ccc];
        }else{
            [SVProgressHUD showErrorWithStatus:resb.mMessage];
        }
    }];
    
    

}
#pragma mark----时间选择
- (void)mTimeAction:(UIButton *)sender{
    [self setupDateView:DateTypeOfStart];

}
- (void)setupDateView:(DateType)type {
    
    _pikerView = [HZQDatePickerView instanceDatePickerView];
    _pikerView.frame = CGRectMake(0, 0, DEVICE_Width, DEVICE_Height + 20);
    [_pikerView setBackgroundColor:[UIColor clearColor]];
    _pikerView.delegate = self;
    _pikerView.type = type;
    [_pikerView.datePickerView setMinimumDate:[NSDate date]];
    [self.view addSubview:_pikerView];
    
}
- (void)getSelectDate:(NSString *)date type:(DateType)type {
    NSLog(@"%d - %@", type, date);
    
    switch (type) {
        case DateTypeOfStart:
            [mView.mTimeBtn setTitle:[NSString stringWithFormat:@"选择时间:%@", date] forState:0];
            mTime = date;
            break;

            
        default:
            break;
    }
}
#pragma mark----重新选择
- (void)mResetAction:(UIButton *)sender{
    mView.mHiddenView.alpha = 0;
    mView.mSelectedView.alpha = 1;
}
#pragma mark----家电
- (void)mHomeAction:(UIButton *)sender{
    
    mSuperID = @"1";
    
    mType = sender.titleLabel.text;

    [self getData:sender.titleLabel.text];

}
#pragma mark----清洁
- (void)mCleanAction:(UIButton *)sender{
    
    mSuperID = @"2";
    [self getData:sender.titleLabel.text];
    mType = sender.titleLabel.text;
   
}
#pragma mark----管道
- (void)mPipeAction:(UIButton *)sender{
    mSuperID = @"3";
    mType = sender.titleLabel.text;
    [self getData:sender.titleLabel.text];

}

/**
 *  获取数据
 *
 *  @param mTitle 标签
 */
- (void)getData:(NSString *)mTitle{
    [SVProgressHUD showWithStatus:@"正在加载..." maskType:SVProgressHUDMaskTypeClear];
    [mUserInfo getFixDetail:mSuperID andLevel:@"2" block:^(mBaseData *resb, NSArray *marr) {
        [self.tempArray removeAllObjects];

        if (resb.mSucess) {
            [SVProgressHUD showSuccessWithStatus:@"加载成功!"];
            [self.tempArray addObjectsFromArray:marr];
            
            mCleanA = [[ZJAlertListView alloc] initWithFrame:CGRectMake(0, 0, 180, 300)];
            
            mCleanA.titleLabel.text = mTitle;
            mCleanA.datasource = self;
            mCleanA.delegate = self;
            //点击确定的时候，调用它去做点事情
            [mCleanA setDoneButtonWithBlock:^{
                
                NSLog(@"结果是：%@",mArr);
                
                mView.mHiddenView.alpha = 1;
                mView.mSelectedView.alpha = 0;
                
                [mView.mResultBtn setTitle:mTitle forState:UIControlStateNormal];
                mView.mResultContent.text = [NSString stringWithFormat:@"%@",mArr[0]];
                [mCleanA dismiss];
                
            }];
            [mCleanA show];

        }else{
            [SVProgressHUD showErrorWithStatus:@"数据加载错误!"];
        }
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
#pragma mark -设置行数
- (NSInteger)alertListTableView:(ZJAlertListView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tempArray.count;

}

- (UITableViewCell *)alertListTableView:(ZJAlertListView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableAlertListCellWithIdentifier:identifier];
    cell.tintColor = M_CO;
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        /**
         *  cell选择样式为无
         */
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        /**
         *  自定义cell背景
         */
        UIImageView *iii = [UIImageView new];
        iii.frame = CGRectMake(0,5, 180, 45);
        iii.image = [UIImage imageNamed:@"fixcell_bgk"];
        [cell.contentView addSubview:iii];
        
    }
    if ( self.selectedIndexPath && NSOrderedSame == [self.selectedIndexPath compare:indexPath])
    {
        /**
         *  自定义cell选择样式－选中
         */
        UIImageView *iii = [UIImageView new];
        iii.frame = CGRectMake(230, 25, 10, 10);
        iii.image = [UIImage imageNamed:@"fixcell_selected"];
        [cell.contentView addSubview:iii];
        cell.accessoryView = iii;
    }
    else
    {
        /**
         *  自定义cell选择样式－未选中
         */
        UIImageView *iii = [UIImageView new];
        iii.frame = CGRectMake(230, 25, 10, 10);
        iii.image = [UIImage imageNamed:@"fixcell_unselecte"];
        [cell.contentView addSubview:iii];
        cell.accessoryView = iii;

    }
    
    GFix *fix = self.tempArray[indexPath.row];
    
    cell.textLabel.text = fix.mClassName;
    return cell;
}

- (void)alertListTableView:(ZJAlertListView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView alertListCellForRowAtIndexPath:indexPath];
    cell.tintColor = M_CO;
    UIImageView *iii = [UIImageView new];
    iii.frame = CGRectMake(230, 25, 10, 10);
    iii.image = [UIImage imageNamed:@"fixcell_unselecte"];
    [cell.contentView addSubview:iii];
    cell.accessoryView = iii;
//    cell.accessoryType = UITableViewCellAccessoryNone;
    NSLog(@"didDeselectRowAtIndexPath:%ld", (long)indexPath.row);
}

- (void)alertListTableView:(ZJAlertListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [mArr removeAllObjects];
    [mClassID removeAllObjects];
    self.selectedIndexPath = indexPath;
    UITableViewCell *cell = [tableView alertListCellForRowAtIndexPath:indexPath];
    cell.tintColor = M_CO;
    cell.selected = !cell.selected;
    if (cell.selected) {
        cell.backgroundColor = [UIColor whiteColor];
        UIImageView *iii = [UIImageView new];
        iii.frame = CGRectMake(230, 25, 10, 10);
        iii.image = [UIImage imageNamed:@"fixcell_selected"];
        [cell.contentView addSubview:iii];
        cell.accessoryView = iii;
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        GFix *fix = self.tempArray[indexPath.row];

        [mArr addObject:fix.mClassName];
        [mClassID addObject:NumberWithInt(fix.mId)];
        NSLog(@"选择了第:%ld行", (long)indexPath.row);
        NSLog(@"一共有%@",mArr);
    }else{
        NSLog(@"dasda");
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
    /**
     
     选取的信息都在info中，info 是一个字典。
     字典中的键：
     NSString *const  UIImagePickerControllerMediaType ;指定用户选择的媒体类型（文章最后进行扩展）
     NSString *const  UIImagePickerControllerOriginalImage ;原始图片
     NSString *const  UIImagePickerControllerEditedImage ;修改后的图片
     NSString *const  UIImagePickerControllerCropRect ;裁剪尺寸
     NSString *const  UIImagePickerControllerMediaURL ;媒体的URL
     NSString *const  UIImagePickerControllerReferenceURL ;原件的URL
     NSString *const  UIImagePickerControllerMediaMetadata;当来数据来源是照相机的时候这个值才有效
     
     
     */
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:@"public.image"]) {
        
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        
        //如果是拍摄的照片
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            //保存在相册
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        }
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 200, 100, 100)];
        
        //添加imgView点击事件
        //        UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xuanze)];
        
        //        [imgView addGestureRecognizer:tap];
        
        //        imgView.userInteractionEnabled = YES;
        
        imgView.image = image;
        
        imgView.layer.cornerRadius = imgView.frame.size.width / 2;
        
        imgView.clipsToBounds = YES;
        
        [self.view addSubview:imgView];
        
    }
    else if ([mediaType isEqualToString:@"public.movie"])
    {
        //获取视图的url
        NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];

        UIVideoAtPathIsCompatibleWithSavedPhotosAlbum([NSString stringWithFormat:@"%@",url]);



        //播放视频

        [self convertVideoQuailtyWithInputURL:url outputURL:nil completeHandler:^(AVAssetExportSession *exportSession) {
            switch (exportSession.status) {
                    
                case AVAssetExportSessionStatusUnknown:
                    
                    NSLog(@"AVAssetExportSessionStatusUnknown");
                    
                    break;
                    
                case AVAssetExportSessionStatusWaiting:
                    
                    NSLog(@"AVAssetExportSessionStatusWaiting");
                    
                    break;
                    
                case AVAssetExportSessionStatusExporting:
                    
                    NSLog(@"AVAssetExportSessionStatusExporting");
                    
                    break;
                    
                case AVAssetExportSessionStatusCompleted:
                    
                    NSLog(@"AVAssetExportSessionStatusCompleted");
                    NSLog(@"完成之后－－－＋－＋－＋－＋－%@",exportSession);
                    break;
                    
                case AVAssetExportSessionStatusFailed:
                    
                    NSLog(@"AVAssetExportSessionStatusFailed");
                    
                    break;
                    
                    
            }

        }];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) convertVideoQuailtyWithInputURL:(NSURL*)inputURL
                               outputURL:(NSURL*)outputURL
                         completeHandler:(void (^)(AVAssetExportSession *exportSession))handler
{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    NSLog(@"%@",compatiblePresets);
    
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
        
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
        
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        
        NSString * resultPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]];
        
        NSLog(@"resultPath = %@",resultPath);
        exportSession.outputURL = [NSURL fileURLWithPath:resultPath];
        [self getFileSize:[NSString stringWithFormat:@"%@",exportSession.outputURL]];

        exportSession.outputFileType = AVFileTypeMPEG4;
        
        exportSession.shouldOptimizeForNetworkUse = YES;
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
         
         {
             NSLog(@"-+-+-+-++-+-+-+-+--+:%@",exportSession.outputURL);

             switch (exportSession.status) {
                     
                 case AVAssetExportSessionStatusUnknown:
                     
                     NSLog(@"AVAssetExportSessionStatusUnknown");
                     
                     break;
                     
                 case AVAssetExportSessionStatusWaiting:
                     
                     NSLog(@"AVAssetExportSessionStatusWaiting");
                     
                     break;
                     
                 case AVAssetExportSessionStatusExporting:
                     
                     NSLog(@"AVAssetExportSessionStatusExporting");
                     
                     break;
                     
                 case AVAssetExportSessionStatusCompleted:
                     
                     NSLog(@"AVAssetExportSessionStatusCompleted");
                     NSLog(@"完成之后－－－＋－＋－＋－＋－%@",exportSession);
                     break;
                     
                 case AVAssetExportSessionStatusFailed:
                     
                     NSLog(@"AVAssetExportSessionStatusFailed");
                     
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
    NSLog(@"问价大小是:%f",filesize);
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
        NSLog(@"asset数据为空");
        return;
    }
    NSLog(@"%@---%@",asset.tracks,[asset tracksWithMediaType:@"vide"]);
    AVAssetTrack *assetTrack;
    if ([asset tracksWithMediaType:@"vide"].count>0) {
        assetTrack = [[asset tracksWithMediaType:@"vide"] objectAtIndex:0];
    }else{
        NSLog(@"asset数据为空");
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
    NSLog(@"最后的到的文件是：%@",exporter.outputURL);
    exporter.outputFileType = AVFileTypeMPEG4;
    exporter.shouldOptimizeForNetworkUse = YES;
    [exporter exportAsynchronouslyWithCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            switch ([exporter status]) {
                case AVAssetExportSessionStatusFailed:
                {
                    [SVProgressHUD showErrorWithStatus:@"视频处理失败"];
                    break;
                }
                    
                case AVAssetExportSessionStatusCancelled:
                    [SVProgressHUD showErrorWithStatus:@"视频处理取消"];
                    break;
                case AVAssetExportSessionStatusCompleted:
                    [SVProgressHUD showSuccessWithStatus:@"视频处理完成"];
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
        NSLog(@"无文件夹,创建文件");
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
@end
