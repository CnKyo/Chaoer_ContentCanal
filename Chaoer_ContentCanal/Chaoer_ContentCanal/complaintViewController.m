//
//  complaintViewController.m
//  Chaoer_ContentCanal
//
//  Created by Mac on 16/5/14.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "complaintViewController.h"

#import "BlockButton.h"
#import "complaintTableViewCell.h"

#import "RSKImageCropper.h"
#import "TFFileUploadManager.h"

@interface complaintViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,RSKImageCropViewControllerDelegate,RSKImageCropViewControllerDataSource,UINavigationControllerDelegate,THHHTTPDelegate>

@end

@implementation complaintViewController
{
    UIImage *tempImage;
    
    UIImage *tempImage1;
    UIImage *tempImage2;

    UIImage *tempImage3;

    /**
     *  当前选择的哪一个
     */
    int mNowSelected;
    
    
    NSString *mImgPath;
    NSString *mImgPath2;
    NSString *mImgPath3;
    
    NSString *mContent;
    

    NSString *mTagString;
    
    NSMutableArray *mImgArr;
    
    int mTagId;
    
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
    self.Title = self.mPageName = @"投诉";
    self.hiddenlll = YES;
    self.hiddenTabBar = YES;
    self.hiddenRightBtn = YES;
    
    mContent = nil;
    mTagString = @"请选择投诉理由";
    mTagId = 100000;
    mImgArr = [NSMutableArray new];
    
    
    tempImage1 = [UIImage imageNamed:@"ppt_complain_addimg"];
    tempImage2 = [UIImage imageNamed:@"ppt_complain_addimg"];
    tempImage3 = [UIImage imageNamed:@"ppt_complain_addimg"];
    
    UIView *bbb = [UIView new];
    bbb.frame = CGRectMake(0, DEVICE_Height-60,  DEVICE_Width, 60);
    bbb.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bbb];
    
    UIButton *mBtn = [UIButton new];
    mBtn.frame = CGRectMake(15, 10, DEVICE_Width-30, 40);
    mBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    mBtn.backgroundColor = M_CO;
    
    mBtn.layer.masksToBounds = YES;
    mBtn.layer.cornerRadius = 3;
    [mBtn setTitle:@"提交" forState:0];
    [mBtn setTitleColor:[UIColor whiteColor] forState:0];
    [mBtn addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];

    [bbb addSubview:mBtn];
    
    [self initView];
}
#pragma mark----提交投诉
- (void)commitAction:(UIButton *)sender{
    MLLog(@"提交");
    
    if (mContent.length == 0) {
        [self showErrorStatus:@"请完善投诉内容!"];
        return ;
    }
    if (mTagId == 100000) {
        [self showErrorStatus:@"请输入投诉理由!"];
        return ;
    }
 
    
    [self showWithStatus:@"正在提交..."];
    
    
    NSString *mImages = @"";
    for (int i =0;i<mImgArr.count;i++) {
        
        NSString *str = mImgArr[i];
        if (i == mImgArr.count-1) {
            mImages = [mImages stringByAppendingString:[NSString stringWithFormat:@"%@",str]];
        }else{
            mImages = [mImages stringByAppendingString:[NSString stringWithFormat:@"%@,",str]];
        }
        
        
    }

    
    
    [[mUserInfo backNowUser] feedBackOrder:[mUserInfo backNowUser].mUserId andLegUserId:[mUserInfo backNowUser].mLegworkUserId andContent:mContent andFeedTagId:mTagId andOrderType:self.mType andOrderCode:self.mOrder.mOrderCode andImags:mImages block:^(mBaseData *resb) {
        
        
        if (resb.mSucess) {
            
            [self showSuccessStatus:resb.mMessage];
            [self popViewController_3];
            
        }else{
            
            [self showErrorStatus:resb.mMessage];
        }
        
    }];
    

}

- (void)initView{
    
    
    
    [self loadTableView:CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-124) delegate:self dataSource:self];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.haveHeader = YES;
    
    UINib   *nib = [UINib nibWithNibName:@"complaintTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    
    
}

- (void)headerBeganRefresh{

    [self showWithStatus:@"加载中..."];
    [[mUserInfo backNowUser] getFeedBackTags:^(mBaseData *resb, NSArray *mArr) {
        
        [self headerEndRefresh];
        
        if (resb.mSucess) {
            [self dismiss];
            
            [self.tempArray addObjectsFromArray:mArr];
            
            
        }else{
        
            [self showErrorStatus:resb.mMessage];
            [self popViewController];
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
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 355;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseCellId = @"cell";
    
    
    complaintTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.mResonLb.text = mTagString;
    mContent = cell.mContent.text;
    
    [cell.mPickImg1 addTarget:self action:@selector(pickAction1) forControlEvents:UIControlEventTouchUpInside];
    [cell.mPickImg2 addTarget:self action:@selector(pickAction2) forControlEvents:UIControlEventTouchUpInside];
    [cell.mPickImg3 addTarget:self action:@selector(pickAction3) forControlEvents:UIControlEventTouchUpInside];
    
    
    [cell.mResonBtn addTarget:self action:@selector(reasonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.mPickImg1 setBackgroundImage:tempImage1 forState:0];
    [cell.mPickImg2 setBackgroundImage:tempImage2 forState:0];
    [cell.mPickImg3 setBackgroundImage:tempImage3 forState:0];
    return cell;
    
}

- (void)reasonAction:(UIButton *)sender{
    [self loadMHActionSheetView];
}


- (void)pickAction1{
    mNowSelected = 1;
    UIActionSheet *ac = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", nil];
    ac.tag = 1001;
    [ac showInView:[self.view window]];
}
- (void)pickAction2{
    mNowSelected = 2;
    UIActionSheet *ac = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", nil];
    ac.tag = 1001;
    [ac showInView:[self.view window]];
}
- (void)pickAction3{
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
    return   CGRectMake(self.view.center.x-1, self.view.center.y-1, 80, 80);
    
}
- (UIBezierPath *)imageCropViewControllerCustomMaskPath:(RSKImageCropViewController *)controller
{
    return [UIBezierPath bezierPathWithRect:CGRectMake(self.view.center.x-1, self.view.center.y-1, 80, 80)];
    
}
- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage
{
    
    [controller.navigationController popViewControllerAnimated:YES];
    
    tempImage = croppedImage;//[Util scaleImg:croppedImage maxsize:140];
    
    if (mNowSelected == 1) {
        tempImage1 = croppedImage;//[Util scaleImg:croppedImage maxsize:140];
    }else if (mNowSelected == 2){
        
        tempImage2 = croppedImage;//[Util scaleImg:croppedImage maxsize:140];
    }else{
        tempImage3 = croppedImage;//[Util scaleImg:croppedImage maxsize:140];
    }
    [self.tableView reloadData];
    
    
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
    
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:@"complaint" forKey:@"type"];
    [para setObject:mmm forKey:@"file"];
    [SVProgressHUD showWithStatus:@"正在保存中..." maskType:SVProgressHUDMaskTypeClear];
    
    NSString    *mUrlStr = [NSString stringWithFormat:@"%@resource/legwork/uploadcomplaintlegwork",[HTTPrequest returnNowURL]];
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
        
        if (mNowSelected == 1) {
            [mImgArr removeObject:mImgPath];
            mImgPath = [resb.mData objectForKey:@"pic"];
            [mImgArr addObject:mImgPath];
        }else if (mNowSelected == 2){
            [mImgArr removeObject:mImgPath2];
            mImgPath2 = [resb.mData objectForKey:@"pic"];
            [mImgArr addObject:mImgPath2];
        }else{
            [mImgArr removeObject:mImgPath3];
            mImgPath3 = [resb.mData objectForKey:@"pic"];
            [mImgArr addObject:mImgPath3];
        }
        
        
    }else{
        [SVProgressHUD showErrorWithStatus:resb.mMessage];
    }
    
}


- (void)loadMHActionSheetView{
    
    NSMutableArray *mTT = [NSMutableArray new];
    
    for (GFeedTags *mTags in self.tempArray) {
        [mTT addObject:mTags.mTagName];
    }
    
    
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择投诉标签" style:MHSheetStyleWeiChat itemTitles:mTT];
    actionSheet.cancleTitle = @"取消选择";
    
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        
        GFeedTags *mTags = self.tempArray[index];
        
        mTagString = mTags.mTagName;
        
        mTagId = mTags.mTagId;
        
        [self.tableView reloadData];
        
    }];
   
}
-(void)textFieldDidEndEditing:(UITextField *)textField{

    [self.tableView reloadData];
    
}
@end
