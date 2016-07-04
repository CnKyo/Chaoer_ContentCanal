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

#import "addAddressViewController.h"
#import "TFFileUploadManager.h"
#import "needCodeViewController.h"
#import "MHDatePicker.h"


#import "comfirOrderViewController.h"

#import "FixNewCell.h"

#define YYEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]
@interface mFixViewController ()<ZJAlertListViewDelegate,ZJAlertListViewDatasource,HZQDatePickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,THHHTTPDelegate,AVCaptureFileOutputRecordingDelegate,UITableViewDelegate,UITableViewDataSource>{
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
    
    NSMutableArray  *mArrTemp;
    NSMutableArray  *mClassID;

    NSString    *mType;

    UIImage *tempImage;
    
    NSString    *mTime;
    

    NSData  *mImgData;
    NSString *mImagePath;
    
    NSData *mVedioData;
    NSString *mVedioPath;
    
    NSMutableDictionary *mPara;
    
    
    int mSelecte;
    
    
    NSURL *mVideoUrl;
    
    
    NSString *mVideoUrlString;
    
    NSString *mAddress;
    
    NSMutableArray *mAddressArr;
    
    NSString *mACommunityId;
    
    
    NSArray *mImageArr;
    
    NSArray *mTTArr;
    
}
@synthesize sType,mSuperID,mTT;
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [WJStatusBarHUD hide];

//    [self loadData];
  
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
    
    mPara = [NSMutableDictionary new];
    mAddressArr = [NSMutableArray new];
    mArrTemp = [NSMutableArray new];
    mClassID = [NSMutableArray new];

    self.assets = @[];

    if (mTT.length == 0) {
        mTT = @"物业报修";
    }else{
    
    }
    
    self.Title = self.mPageName = mTT;
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;

    mSelecte = 1;

    [self initWithView];
    
}
- (void)initWithView{

    mImageArr = @[[UIImage imageNamed:@"fix_pipeline"],[UIImage imageNamed:@"fix_clean"],[UIImage imageNamed:@"fix_ appliance"]];
    mTTArr =  @[@"管道类",@"清洁类",@"家电类"];
    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64) delegate:self dataSource:self];
    
    if (sType == 2) {
        self.tableView.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:0.45];
    }else{
        self.tableView.backgroundColor = [UIColor clearColor];
    }
    
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    if (sType == 2) {
        self.haveHeader = YES;
    }else{
    
    }

    UINib   *nib = [UINib nibWithNibName:@"FixNewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    nib = [UINib nibWithNibName:@"mFixRestCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];

}


- (void)initTableView{
    
    NSArray *tt=  @[@"管道类",@"清洁类",@"家电类"];
    mSuperID = @"1";
    WKLeftView *mLeftView = [[WKLeftView alloc] initWithFrame:CGRectMake(0, 64, 80, DEVICE_Height) titles:tt clickBlick:^(NSInteger index) {
        MLLog(@"点击了%ld",(long)index);
        mType = tt[index-1];
        mSuperID = [NSString stringWithFormat:@"%ld",(long)index];

        [self headerBeganRefresh];

    }];
    mLeftView.layer.masksToBounds = YES;
    mLeftView.layer.borderColor = [UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:0.45].CGColor;
    mLeftView.layer.borderWidth = 0.5;
    [self.view addSubview:mLeftView];
    
    [self loadTableView:CGRectMake(mLeftView.mright, 64, DEVICE_Width-80, DEVICE_Height-64) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.haveHeader = YES;
    [self headerBeganRefresh];
    UINib   *nib = [UINib nibWithNibName:@"mFixRestCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    
}

- (void)headerBeganRefresh{

    [mUserInfo getFixDetail:mSuperID andLevel:@"2" block:^(mBaseData *resb, NSArray *marr) {
        [self headerEndRefresh];
        
        [self.tempArray removeAllObjects];
        [self.tableView reloadData];
        if (resb.mSucess) {
            [self.tempArray addObjectsFromArray:marr];
            [self.tableView reloadData];
            
        }else{
            [LCProgressHUD showFailure:@"数据加载错误!"];
            
        }
    }];

    
}

#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (sType == 2) {
        
        return self.tempArray.count%2==0?self.tempArray.count/2:self.tempArray.count/2+1;
        
    }else{
        return mImageArr.count;
    }
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (sType == 2) {
        return 195;
    }else{
        return 150;
    }
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *reuseCellId = nil;

    
    if (sType == 2) {
        reuseCellId = @"cell2";
        fixTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        
        GFix *GF = self.tempArray[indexPath.row*2];
        GFix *GF2;
        if ((indexPath.row+1)*2>self.tempArray.count) {
            cell.mBgk2.hidden = YES;
        }else{
            GF2 = [self.tempArray objectAtIndex:indexPath.row*2+1];
            cell.mBgk2.hidden = NO;
        }
        
        
        cell.mName.text = GF.mClassName;
        cell.mPrice.text = [NSString stringWithFormat:@"%@¥",GF.mEstimatedPrice];
        cell.mDetail.text = GF.mDescribe;
        
        [cell.mImg sd_setImageWithURL:[NSURL URLWithString:GF.mSmallImage] placeholderImage:[UIImage imageNamed:@"img_default"]];
        
        cell.mName2.text = GF2.mClassName;
        cell.mPrice2.text = [NSString stringWithFormat:@"%@¥",GF2.mEstimatedPrice];
        cell.mDetail2.text = GF2.mDescribe;
        
        [cell.mImg2 sd_setImageWithURL:[NSURL URLWithString:GF2.mSmallImage] placeholderImage:[UIImage imageNamed:@"img_default"]];
        
        [cell.mSelectBtn1 addTarget:self action:@selector(fooBtn1Touched:) forControlEvents:UIControlEventTouchUpInside];
        [cell.mSelectBtn2 addTarget:self action:@selector(fooBtn2Touched:) forControlEvents:UIControlEventTouchUpInside];

        
        return cell;
        
    }else{
        reuseCellId = @"cell";
        FixNewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
        cell.mImg.image = mImageArr[indexPath.row];
        return cell;
    }

}
-(void)fooBtn1Touched:(UIButton *)sender
{
    fixTableViewCell *cell = (fixTableViewCell*)[sender findSuperViewWithClass:[fixTableViewCell class]];
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    
    GFix *GF = [self.tempArray objectAtIndex:index.row*2];
    
    comfirOrderViewController *ccc = [[comfirOrderViewController alloc] initWithNibName:@"comfirOrderViewController" bundle:nil];
    
    
    ccc.mFixOrder = GFix.new;
    ccc.mFixOrder = GF;
    ccc.mSubClass = mSuperID;
    ccc.mID = GF.mId;
    [self presentModalViewController :ccc];

    
}
-(void)fooBtn2Touched:(UIButton *)sender
{

    
    fixTableViewCell *cell = (fixTableViewCell*)[sender findSuperViewWithClass:[fixTableViewCell class]];
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    
    GFix *GF = [self.tempArray objectAtIndex:index.row*2+1];
    
    comfirOrderViewController *ccc = [[comfirOrderViewController alloc] initWithNibName:@"comfirOrderViewController" bundle:nil];
    
    
    ccc.mFixOrder = GFix.new;
    ccc.mFixOrder = GF;
    ccc.mSubClass = mSuperID;
    ccc.mID = GF.mId;
    [self presentModalViewController :ccc];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (sType == 2) {
        GFix *GF = self.tempArray[indexPath.row];
        
        comfirOrderViewController *ccc = [[comfirOrderViewController alloc] initWithNibName:@"comfirOrderViewController" bundle:nil];
        
        
        ccc.mFixOrder = GFix.new;
        ccc.mFixOrder = GF;
        ccc.mSubClass = mSuperID;
        ccc.mID = GF.mId;
        [self presentModalViewController :ccc];
    }else{
    
        mFixViewController   *ppp = [[mFixViewController alloc] initWithNibName:@"mFixViewController" bundle:nil];
        ppp.sType = 2;
        ppp.mSuperID = [NSString stringWithFormat:@"%ld",indexPath.row+1];
        ppp.mTT = mTTArr[indexPath.row];
        [self presentModalViewController:ppp];
    }

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
    [mView.mAddressBtn addTarget:self action:@selector(mAddressAction:) forControlEvents:UIControlEventTouchUpInside];

    
    [mView.mLeftBtn addTarget:self action:@selector(mImageAction:) forControlEvents:UIControlEventTouchUpInside];
    [mView.mRightBtn addTarget:self action:@selector(mVideoAction:) forControlEvents:UIControlEventTouchUpInside];


    
    mView.mLeftBtn.layer.masksToBounds = mView.mRightBtn.layer.masksToBounds = YES;
    mView.mLeftBtn.layer.cornerRadius = mView.mRightBtn.layer.cornerRadius = 3;
    
    

    mView.mHiddenView.alpha = 0;
    [mScrollerView addSubview:mView];
    
    mScrollerView.contentSize = CGSizeMake(DEVICE_Width, 620);
    
    
    
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
    
    
    mView.mPhone.text = [NSString stringWithFormat:@"电话：%@",[mUserInfo backNowUser].mPhone];
 
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
        
        mView.mAddress.text = [NSString stringWithFormat:@"地点：%@",mAddresss.mAddressName];
        mACommunityId = mAddresss.mAddressId;
        mAddress = mAddresss.mAddressName;

        
    }];
}


#pragma mark----图片按钮
- (void)mImageAction:(UIButton *)sender{
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
                [mView.mLeftBtn setBackgroundImage:model.thumbnail forState:0];
                
            }
        }else{
        
            for (UIImage *img in images) {
                tempImage = [Util scaleImg:img maxsize:150];
                [mView.mLeftBtn setBackgroundImage:tempImage forState:0];
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
        
        
    }];
    //3. 设置选择完视频的block回调
    [[XMNPhotoPicker sharePhotoPicker] setDidFinishPickingVideoBlock:^(UIImage * image, XMNAssetModel *asset) {
        MLLog(@"picker video :%@ \n\n asset :%@",image,asset);
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

#pragma mark----提交预约按钮
- (void)mMakeAction:(UIButton *)sender{
    
    if (mClassID.count <= 0) {
        [LCProgressHUD showFailure:@"请选择服务类型"];

        return;
    }if (mView.mTxView.text.length == 0) {
        [LCProgressHUD showFailure:@"请输入您的备注!"];

        return;


    }if (mTime.length == 0) {
        [LCProgressHUD showFailure:@"请选择服务时间!"];

        return;

    }
    if (!mImgData) {
        [LCProgressHUD showFailure:@"请选择图片!"];
        return;
    }
    if (mAddress == nil || [mAddress isEqualToString:@""]) {
        [LCProgressHUD showFailure:@"请选择服务地址!"];
        return;
    }
    
    [self commit];


    
}

- (void)commit{
    
    mSelecte = 1;
    
    [mPara setObject:[NSString stringWithFormat:@"%d",[mUserInfo backNowUser].mUserId] forKey:@"uid"];
    [mPara setObject:mImgData forKey:@"image"];
    [mPara setObject:[NSString stringWithFormat:@"%@",mSuperID] forKey:@"classification1"];
    [mPara setObject:[NSString stringWithFormat:@"%@",mClassID[0]] forKey:@"classification2"];
    [mPara setObject:mView.mTxView.text forKey:@"remarks"];
    [mPara setObject:mTime forKey:@"appointmentTime"];
    [mPara setObject:[mUserInfo backNowUser].mPhone forKey:@"phone"];
    [mPara setObject:mAddress forKey:@"address"];
    [mPara setObject:mACommunityId forKey:@"communityId"];

    
    if (mVideoUrlString == nil || [mVideoUrlString isEqualToString:@""]) {
        
    }else{
        [mPara setObject:mVideoUrlString forKey:@"video"];

    }
    
    MLLog(@"这里提交的参数是：%@",mPara);
    
    [LBProgressHUD showHUDto:self.view withTips:@"正在提交..." animated:YES];

    NSString    *mUrlStr = [NSString stringWithFormat:@"%@app/warrantyOrder/addRepairOrder",[HTTPrequest returnNowURL]];
    TFFileUploadManager *manage = [TFFileUploadManager shareInstance];
    manage.delegate = self;
    
    
    
    [manage uploadFileWithURL:mUrlStr params:mPara andData:mImgData fileKey:@"pic" filePath:mImagePath completeHander:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            MLLog(@"请求出错 %@",connectionError);
        }else{
            MLLog(@"请求返回：\n%@",response);
        }
    }];
  }
#pragma mark----上传视频
- (void)upLoadVideo{
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    

    [para setObject:mVedioData forKey:@"video"];
    
    MLLog(@"上传的参数是：%@",para);
    
    [LBProgressHUD showHUDto:self.view withTips:@"正在上传视频..." animated:YES];

    NSString    *mUrlStr = [NSString stringWithFormat:@"%@app/upload/uploadVideo",[HTTPrequest returnNowURL]];
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
            [LCProgressHUD showSuccess:resb.mMessage];
            choiseServicerViewController *ccc = [[choiseServicerViewController alloc] initWithNibName:@"choiseServicerViewController" bundle:nil];
            ccc.Type = 1;
            ccc.mData = mBaseData.new;
            ccc.mData = resb;
            [self presentModalViewController:ccc];
            

            
        }else{
            [LCProgressHUD showFailure:resb.mMessage];
        }

    }

    
    
    
}

#pragma mark----时间选择
- (void)mTimeAction:(UIButton *)sender{
//    [self setupDateView:DateTypeOfStart];
    
   MHDatePicker *selectTimePicker = [[MHDatePicker alloc] init];
    __weak typeof(self) weakSelf = self;
    [selectTimePicker didFinishSelectedDate:^(NSDate *selectedDate) {

        
        mTime = [weakSelf dateStringWithDate:selectedDate DateFormat:@"yyyy-MM-dd"];
        
        [mView.mTimeBtn setTitle:[NSString stringWithFormat:@"选择时间:%@", mTime] forState:0];
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
- (void)setupDateView:(DateType)type {
    
    _pikerView = [HZQDatePickerView instanceDatePickerView];
    _pikerView.frame = CGRectMake(0, 0, DEVICE_Width, DEVICE_Height + 20);
    [_pikerView setBackgroundColor:[UIColor clearColor]];
    _pikerView.delegate = self;
    _pikerView.type = type;
    [_pikerView.datePickerView setMinimumDate:[NSDate date]];
    [self.view addSubview:_pikerView];
    
}
#pragma mark----时间选择
- (void)getSelectDate:(NSString *)date type:(DateType)type {
    MLLog(@"%d - %@", type, date);
    
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
    [WJStatusBarHUD hide];

    mSuperID = @"1";
    
    mType = sender.titleLabel.text;

    [self getData:sender.titleLabel.text];

}
#pragma mark----清洁
- (void)mCleanAction:(UIButton *)sender{
    [WJStatusBarHUD hide];

    mSuperID = @"2";
    [self getData:sender.titleLabel.text];
    mType = sender.titleLabel.text;
   
}
#pragma mark----管道
- (void)mPipeAction:(UIButton *)sender{
    [WJStatusBarHUD hide];

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
    [LBProgressHUD showHUDto:self.view withTips:@"正在加载中..." animated:YES];
    [mUserInfo getFixDetail:mSuperID andLevel:@"2" block:^(mBaseData *resb, NSArray *marr) {
        
        [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        [self.tempArray removeAllObjects];

        if (resb.mSucess) {
            [LCProgressHUD showSuccess:resb.mMessage];
            [self.tempArray addObjectsFromArray:marr];
            
            mCleanA = [[ZJAlertListView alloc] initWithFrame:CGRectMake(0, 0, 180, 300)];
            
            mCleanA.titleLabel.text = mTitle;
            mCleanA.datasource = self;
            mCleanA.delegate = self;
            //点击确定的时候，调用它去做点事情
            [mCleanA setDoneButtonWithBlock:^{
                
                MLLog(@"结果是：%@",mArrTemp);
                
                mView.mHiddenView.alpha = 1;
                mView.mSelectedView.alpha = 0;
                
                [mView.mResultBtn setTitle:mTitle forState:UIControlStateNormal];
                mView.mResultContent.text = [NSString stringWithFormat:@"%@",mArrTemp[0]];
                [mCleanA dismiss];
                
            }];
            [mCleanA show];

        }else{
            [LCProgressHUD showFailure:@"数据加载错误!"];

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
    MLLog(@"didDeselectRowAtIndexPath:%ld", (long)indexPath.row);
}

- (void)alertListTableView:(ZJAlertListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [mArrTemp removeAllObjects];
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

        [mArrTemp addObject:fix.mClassName];
        [mClassID addObject:NumberWithInt(fix.mId)];
        MLLog(@"选择了第:%ld行", (long)indexPath.row);
        MLLog(@"一共有%@",mArrTemp);
    }else{
        MLLog(@"dasda");
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
        [mView.mRightBtn setBackgroundImage:[self imageWithMediaURL:mVideoUrl] forState:0];

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


- (void)mAddressAction:(UIButton *)sender{

//    addAddressViewController *add = [[addAddressViewController alloc] initWithNibName:@"addAddressViewController" bundle:nil];
//    
//    
//    [self pushViewController:add];
    
    if (mAddressArr.count <= 0) {
        [self AlertViewShow:@"未找到地址！请添加房屋！" alertViewMsg:@"添加房屋地址后才能使用保修功能哦！" alertViewCancelBtnTiele:@"取消" alertTag:10];

        return;
    }
    
    [self loadMHActionSheetView];
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
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if( buttonIndex == 1)
    {
        needCodeViewController *nnn = [[needCodeViewController alloc] initWithNibName:@"needCodeViewController" bundle:nil];
        nnn.Type = 2;
        [self pushViewController:nnn];
    }
}
- (void)AlertViewShow:(NSString *)alerViewTitle alertViewMsg:(NSString *)msg alertViewCancelBtnTiele:(NSString *)cancelTitle alertTag:(int)tag{
    
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:alerViewTitle message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:@"离开", nil];
    al.delegate = self;
    al.tag = tag;
    [al show];
}

@end
