//
//  AddServiceVC.m
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/10/30.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "AddServiceVC.h"
#import "SellerVC.h"
#import "SellerDetaillVC.h"
#import "WebVC.h"
#import "APIClient.h"

@interface AddServiceVC ()<UIActionSheetDelegate,RSKImageCropViewControllerDelegate,RSKImageCropViewControllerDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{

    UIImage *tempImage;
    
    NSMutableArray *myPeople;
    
    NSString *htmlContent;
    
}

@end

@implementation AddServiceVC

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
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}

- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mPageName = @"服务添加";
    
    self.Title = self.mPageName;
    
    self.rightBtnTitle = @"完成";

    
//    if (_mGoods) {
//        
//        _mPaiZhao.hidden = YES;
//        _mPzText.hidden = YES;
//        
//        if(_mSelect == 1){
//            _mTopLB.hidden = YES;
//            _mShangjia.text = @"下架";
//            _mLeftImg.image = [UIImage imageNamed:@"dp_xiajia"];
//        }else{
//            _mShangjia.text = @"上架";
//            _mLeftImg.image = [UIImage imageNamed:@"dp_shangjia"];
//        }
//        
//        if (_mGoods.mImgs.count > 0) {
//            [_mBgImg sd_setImageWithURL:[NSURL URLWithString:[_mGoods.mImgs objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"img_def"]];
//        }
//        _mServiceName.text = _mGoods.mName;
//        _mPrice.text = [NSString stringWithFormat:@"%.2f",_mGoods.mPrice];
//        _mMinTime.text = [NSString stringWithFormat:@"%d",_mGoods.mDuration];
//        
//        if (_mGoods.mStaff.count>0) {
//            
//            NSString *string = @"";
//            for (SPeople *people in _mGoods.mStaff) {
//                string = [string stringByAppendingString:[NSString stringWithFormat:@" %@",people.mName]];
//            }
//            
//            _mSellerName.text = string;
//        }
//        
////        _mRemark.text = _mGoods.mBrief;
//        htmlContent = _mGoods.mBrief;
//        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[_mGoods.mBrief dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//        _mRemark.attributedText = attrStr;
//        
//        
//        myPeople = [[NSMutableArray alloc] initWithArray:_mGoods.mStaff];
//        //tempImage = _mBgImg.image;
//       
//        
//    }else{
//    
//        _mXjView.hidden = YES;
//        _mDelView.hidden = YES;
//        _mTopLB.hidden = YES;
//        _mBottomLB.hidden = YES;
//    }
}

- (void)rightBtnTouched:(id)sender{
    
    if (_mServiceName.text.length<=0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入服务名称" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
        return;
    }
    
    if (![Util checkNum:_mPrice.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确价格" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
        return;
    }
    
    if (![Util isPureInt:_mMinTime.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确时长" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
        return;
    }
    
//    if ( self.mGoods == nil &&  tempImage == nil) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择图片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        
//        [alert show];
//        
//        return;
//    }
//
//    SGoods *mGoods = [[SGoods alloc] init];
//    NSMutableArray *imgAry = NSMutableArray.new;
//    if( tempImage )
//    {
//        [imgAry addObject:tempImage];
//        mGoods.mImgs = imgAry;
//    }
//    else
//        mGoods.mImgs = _mGoods.mImgs;
//    
//    mGoods.mName = _mServiceName.text;
//    mGoods.mPrice = [_mPrice.text floatValue];
//    mGoods.mDuration = [_mMinTime.text intValue];
//    
//    NSMutableArray *arry = NSMutableArray.new;
//    for (SPeople *p in myPeople) {
//        [arry addObject:@(p.mId)];
//    }
//    mGoods.mStaff = arry;
//    mGoods.mBrief = htmlContent;
//    mGoods.mTradeId = _mCate.mId;
//    if (_mGoods) {
//        mGoods.mId = _mGoods.mId;
//    }
    
    
    [SVProgressHUD showWithStatus:@"操作中.." maskType:SVProgressHUDMaskTypeClear];
//    [mGoods addThis:^(SResBase *resb) {
//        if (resb.msuccess) {
//            [SVProgressHUD showSuccessWithStatus:resb.mmsg];
//            
//            if (_block) {
//                _block(YES);
//            }
//            [self popViewController];
//        }else{
//        
//            [SVProgressHUD showErrorWithStatus:resb.mmsg];
//        }
//    }];
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
    
    imageCropVC = [[RSKImageCropViewController alloc] initWithImage:photo cropMode:RSKImageCropModeCustom];
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
    return   CGRectMake(self.view.center.x-self.mBgImg.frame.size.width/2, self.view.center.y-self.mBgImg.frame.size.height/2, self.mBgImg.frame.size.width, self.mBgImg.frame.size.height);
    
}
- (UIBezierPath *)imageCropViewControllerCustomMaskPath:(RSKImageCropViewController *)controller
{
    return [UIBezierPath bezierPathWithRect:CGRectMake(self.view.center.x-self.mBgImg.frame.size.width/2, self.view.center.y-self.mBgImg.frame.size.height/2, self.mBgImg.frame.size.width, self.mBgImg.frame.size.height)];
    
}
- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage
{
    
    [controller.navigationController popViewControllerAnimated:YES];
    
    tempImage = croppedImage;//[Util scaleImg:croppedImage maxsize:140];
    
    self.mBgImg.image = tempImage;
    
    _mPaiZhao.hidden = YES;
    _mPzText.hidden = YES;
    
}


- (IBAction)mRemarkClick:(id)sender {
    
    WebVC *w = [WebVC new];
    w.mName = @"商品描述";
//    w.mUrl = [NSString stringWithFormat:@"%@/goods.detail?token=%@&userId=%d&id=%d",[APIClient APiWithUrl:@"api" andOtherUrl:nil],[APIClient getmToken],[SUser currentUser].mUserId,_mGoods.mId];
    
    w.itgoodsblock = ^(NSString *content){
        
        htmlContent = content;
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        _mRemark.attributedText = attrStr;
    };
    
    [self pushViewController:w];
}

- (IBAction)mPhotoClick:(id)sender {
    
    UIActionSheet *ac = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择", nil];
    ac.tag = 1001;
    [ac showInView:[self.view window]];
}

- (IBAction)mBottomClick:(id)sender {
    
//    SGoods *mGoods = [[SGoods alloc] init];
//    
//    mGoods.mName = _mServiceName.text;
//    mGoods.mPrice = [_mPrice.text floatValue];
//    mGoods.mDuration = [_mMinTime.text intValue];
//    
//    NSMutableArray *arry = NSMutableArray.new;
//    for (SPeople *p in myPeople) {
//        [arry addObject:@(p.mId)];
//    }
//    mGoods.mStaff = arry;
//    mGoods.mBrief = _mRemark.text;
//    
//    UIButton *button = (UIButton *)sender;
//    if (button.tag == 11) {
//        
//        
//        NSMutableArray *imgAry = NSMutableArray.new;
//        
//        if (_mBgImg.image) {
//            [imgAry addObject:_mBgImg.image];
//            mGoods.mImgs = imgAry;
//        }
//
//        mGoods.mImgs = imgAry;
//        SellerDetaillVC *sellerDetaill = [[SellerDetaillVC alloc] initWithNibName:@"SellerDetaillVC" bundle:nil];
//        
//        sellerDetaill.mGoods = mGoods;
//        sellerDetaill.mType = 2;
//        [self pushViewController:sellerDetaill];
//        
//        return;
//    }
    
//     NSMutableArray *selectArry = [[NSMutableArray alloc] initWithObjects:@(_mGoods.mId), nil];
//    if (button.tag == 10) {
//        
//        if (_mSelect == 1) {
//            [SVProgressHUD showWithStatus:@"操作中.." maskType:SVProgressHUDMaskTypeClear];
//            [SGoods getOff:selectArry block:^(SResBase *resb) {
//                if (resb.msuccess) {
//                    [SVProgressHUD showSuccessWithStatus:@"操作成功"];
//                    
//                    if (_block) {
//                        _block(YES);
//                    }
//                    [self popViewController];
//                }else{
//                    [SVProgressHUD showErrorWithStatus:resb.mmsg];
//                }
//            }];
//        }else{
//            [SVProgressHUD showWithStatus:@"操作中.." maskType:SVProgressHUDMaskTypeClear];
//            [SGoods getOn:selectArry block:^(SResBase *resb) {
//                if (resb.msuccess) {
//                    [SVProgressHUD showSuccessWithStatus:@"操作成功"];
//                    if (_block) {
//                        _block(YES);
//                    }
//                     [self popViewController];
//                }else{
//                    [SVProgressHUD showErrorWithStatus:resb.mmsg];
//                }
//            }];
//            
//        }
//        
//        return;
//    }
//    
//    if (button.tag == 12) {
//        [SVProgressHUD showWithStatus:@"操作中.." maskType:SVProgressHUDMaskTypeClear];
//        [SGoods delSome:selectArry block:^(SResBase *resb) {
//            if (resb.msuccess) {
//                [SVProgressHUD showSuccessWithStatus:resb.mmsg];
//                [SVProgressHUD showSuccessWithStatus:@"操作成功"];
//                
//                if (_block) {
//                    _block(YES);
//                }
//                [self popViewController];
//            }else{
//                [SVProgressHUD showErrorWithStatus:resb.mmsg];
//            }
//        }];
//    }
//    
}

- (IBAction)GoSellerClick:(id)sender {
    
//    SellerVC *seller = [[SellerVC alloc] init];
//    seller.block = ^(NSArray *peoples){
//        if (peoples.count >0) {
//            
//            NSString *string = @"";
//            for (SPeople *people in peoples) {
//                string = [string stringByAppendingString:[NSString stringWithFormat:@" %@",people.mName]];
//            }
//            
//            _mSellerName.text = string;
//            myPeople = [[NSMutableArray alloc] initWithArray:peoples];
//        }
//    };
//    
//    [self pushViewController:seller];
}
@end
