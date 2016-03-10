//
//  AddGoodsVC.m
//  O2O_Communication_seller
//
//  Created by 周大钦 on 15/11/3.
//  Copyright © 2015年 zongyoutec.com. All rights reserved.
//

#import "AddGoodsVC.h"
#import "SellerDetaillVC.h"
#import "AddGoodsView.h"
#import "ServiceHeadView.h"
#import "WebVC.h"
#import "APIClient.h"

@interface AddGoodsVC ()<UIActionSheetDelegate,RSKImageCropViewControllerDelegate,RSKImageCropViewControllerDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{

    BOOL isNorm;
    int normNum;
    
    NSMutableArray *normViewAry;
    
    UIImage *tempImage;
    
    float y;
    
    NSString *htmlContent;
}

@end

@implementation AddGoodsVC


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
    self.Title = self.mPageName = @"商品添加";
    
    self.rightBtnTitle = @"完成";
    normNum = 0;
    y = 0;
    normViewAry = [[NSMutableArray alloc] initWithCapacity:0];
    
    if (_mGoods) {
        
        _mPaizhao.hidden = YES;
        _mPzText.hidden = YES;
        
        if(_mSelect == 1){
            _mTopLB.hidden = YES;
            _mLeftText.text = @"下架";
            _mLeftImg.image = [UIImage imageNamed:@"dp_xiajia"];
        }else{
            _mLeftText.text = @"上架";
            _mLeftImg.image = [UIImage imageNamed:@"dp_shangjia"];
        }
        
        if (_mGoods.mImgs.count > 0) {
            [_mBgImg sd_setImageWithURL:[NSURL URLWithString:[_mGoods.mImgs objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"img_def"]];
        }
        _mGoodsName.text = _mGoods.mName;
        _mPrice.text = [NSString stringWithFormat:@"%.2f",_mGoods.mPrice];
        _mNum.text = [NSString stringWithFormat:@"%d",_mGoods.mStock];
        
        htmlContent = _mGoods.mBrief;
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[_mGoods.mBrief dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        _mRemark.attributedText = attrStr;
        
        //tempImage = _mBgImg.image;
        
        
        if(_mGoods.mNorms.count > 0){
            
            _mPriceView.hidden = YES;
            
            normNum = (int)_mGoods.mNorms.count;
            y = 156*normNum;
        
            for (int i = 0 ; i < _mGoods.mNorms.count ; i++) {
                
                SNorms *norm = [_mGoods.mNorms objectAtIndex:i];
                AddGoodsView *goodsV = [AddGoodsView shareView];
                CGRect rect = goodsV.frame;
                rect.origin.y = i*156;
                rect.size.width = DEVICE_Width;
                goodsV.frame = rect;
                [_mMiddleView addSubview:goodsV];
                goodsV.mNormId = norm.mId;
                goodsV.mNorm.text = norm.mName;
                goodsV.mPrice.text = [NSString stringWithFormat:@"%.2f",norm.mPrice];
                goodsV.mNum.text = [NSString stringWithFormat:@"%d",norm.mStock];
                [goodsV.mDelBT addTarget:self action:@selector(DelClick:) forControlEvents:UIControlEventTouchUpInside];
                
                [normViewAry addObject:goodsV];
               
            }
            _mMiddleViewHeight.constant = 156*normNum;
        }
        
        
    }else{
        
        _mLeftView.hidden = YES;
        _mRightView.hidden = YES;
        _mTopLB.hidden = YES;
        _mBottomLB.hidden = YES;
    }

}

- (void)rightBtnTouched:(id)sender{
    
    if (_mGoodsName.text.length<=0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入商品名称" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
        return;
    }
    
    if(normViewAry.count > 0){
        
        for (AddGoodsView *ag in normViewAry) {
            
            if (![Util checkNum:ag.mPrice.text]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确价格" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                [alert show];
                
                return;
            }
            
            if (![Util isPureInt:ag.mNum.text]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确库存" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                [alert show];
                
                return;
            }
        }
        
    }else{
    
        if (![Util checkNum:_mPrice.text]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确价格" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
            
            return;
        }
        
        if (![Util isPureInt:_mNum.text]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确库存" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
            
            return;
        }
    }
    
   
    
    
    if ( self.mGoods == nil && tempImage == nil ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择图片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
        return;
    }
    
    SGoods *mGoods = [[SGoods alloc] init];
    mGoods.mName = _mGoodsName.text;
   
    NSMutableArray *imgAry = NSMutableArray.new;
    
    if( tempImage )
    {
        [imgAry addObject:tempImage];
        mGoods.mImgs = imgAry;
    }
    else
        mGoods.mImgs = _mGoods.mImgs;
    
    mGoods.mBrief = htmlContent;
    mGoods.mTradeId = _mCate.mId;
    
    NSMutableArray *norms = [[NSMutableArray alloc] init];
    
    if(normViewAry.count > 0){
    
        for (AddGoodsView *ag in normViewAry) {
            
            SNorms *norm = [[SNorms alloc] init];
            norm.mName = ag.mNorm.text;
            norm.mPrice = [ag.mPrice.text floatValue];
            norm.mStock = [ag.mNum.text intValue];
            norm.mId = ag.mNormId;
            
            [norms addObject:norm];
        }
        
        mGoods.mNorms = norms;
    
    }else{
        mGoods.mPrice = [_mPrice.text floatValue];
        mGoods.mStock = [_mNum.text intValue];
    }
    
    mGoods.mId = _mGoods.mId;
    
    [SVProgressHUD showWithStatus:@"操作中.." maskType:SVProgressHUDMaskTypeClear];
    [mGoods addThis:^(SResBase *resb) {
        if (resb.msuccess) {
            [SVProgressHUD showSuccessWithStatus:resb.mmsg];
            
            if (_block) {
                _block(YES);
            }
            [self popViewController];
        }else{
            
            [SVProgressHUD showErrorWithStatus:resb.mmsg];
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

- (IBAction)mRemarkClick:(id)sender {
    
    WebVC *w = [WebVC new];
    w.mName = @"商品描述";
    w.mUrl = [NSString stringWithFormat:@"%@/goods.detail?token=%@&userId=%d&id=%d",[APIClient APiWithUrl:@"api" andOtherUrl:nil],[APIClient getmToken],[SUser currentUser].mUserId,_mGoods.mId];
    
    w.itgoodsblock = ^(NSString *content){
    
        htmlContent = content;
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        _mRemark.attributedText = attrStr;
    };

    [self pushViewController:w];

}

- (IBAction)mAddClick:(id)sender {
    
    [UIView animateWithDuration:0.2 animations:^{
        normNum ++;
        
        _mPriceView.hidden = YES;
        
        
        AddGoodsView *goodsV = [AddGoodsView shareView];
        CGRect rect = goodsV.frame;
        rect.origin.y = y;
        rect.size.width = DEVICE_Width;
        goodsV.frame = rect;
        [goodsV.mDelBT addTarget:self action:@selector(DelClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [normViewAry addObject:goodsV];
        
        [_mMiddleView addSubview:goodsV];
        
        _mMiddleViewHeight.constant = 156*normNum;
        y+=156;
        
    }];
    
    
    
}

- (void)DelClick:(UIButton *)sender{
    
    [UIView animateWithDuration:0.2 animations:^{
    
        normNum --;
        y-=156;
        [sender.superview removeFromSuperview];
        
        [normViewAry removeObject:sender.superview];
        
        for (int i = 0 ; i < normNum ; i++) {
            
            AddGoodsView *goodsV = [normViewAry objectAtIndex:i];
            CGRect rect = goodsV.frame;
            rect.origin.y = i*156;
            goodsV.frame = rect;
        }
        _mMiddleViewHeight.constant = 156*normNum;
        
        if (normNum == 0) {
            _mMiddleViewHeight.constant = 98;
            _mPriceView.hidden = NO;
        }
       
    }];
    
}

- (IBAction)mBottomClick:(id)sender {
    
    SGoods *mGoods = [[SGoods alloc] init];
    
    mGoods.mName = _mGoodsName.text;
    mGoods.mBrief = _mRemark.text;
    
    
    NSMutableArray *norms = [[NSMutableArray alloc] init];
    
    if(normViewAry.count > 0){
        
        for (AddGoodsView *ag in normViewAry) {
            
            SNorms *norm = [[SNorms alloc] init];
            norm.mName = ag.mNorm.text;
            norm.mPrice = [ag.mPrice.text floatValue];
            norm.mStock = [ag.mNum.text intValue];
            
            [norms addObject:norm];
        }
        
        AddGoodsView *v = [normViewAry objectAtIndex:0];
        
        mGoods.mNorms = norms;
        mGoods.mPrice = [v.mPrice.text floatValue];
        
    }else{
        mGoods.mPrice = [_mPrice.text floatValue];
        mGoods.mStock = [_mNum.text intValue];
    }
    
    UIButton *button = (UIButton *)sender;
    if (button.tag == 11) {
        
        
        NSMutableArray *imgAry = NSMutableArray.new;
        
        if (_mBgImg.image) {
            [imgAry addObject:_mBgImg.image];
            mGoods.mImgs = imgAry;
        }
        
        mGoods.mBrief = htmlContent;
        SellerDetaillVC *sellerDetaill = [[SellerDetaillVC alloc] initWithNibName:@"SellerDetaillVC" bundle:nil];
        
        sellerDetaill.mGoods = mGoods;
        sellerDetaill.mType = 1;
        [self pushViewController:sellerDetaill];
        
        return;
    }
    
    NSMutableArray *selectArry = [[NSMutableArray alloc] initWithObjects:@(_mGoods.mId), nil];
    if (button.tag == 10) {
        
        if (_mSelect == 1) {
            [SVProgressHUD showWithStatus:@"操作中.." maskType:SVProgressHUDMaskTypeClear];
            [SGoods getOff:selectArry block:^(SResBase *resb) {
                if (resb.msuccess) {
                    [SVProgressHUD showSuccessWithStatus:@"操作成功"];
                    
                    if (_block) {
                        _block(YES);
                    }
                    [self popViewController];
                }else{
                    [SVProgressHUD showErrorWithStatus:resb.mmsg];
                }
            }];
        }else{
            [SVProgressHUD showWithStatus:@"操作中.." maskType:SVProgressHUDMaskTypeClear];
            [SGoods getOn:selectArry block:^(SResBase *resb) {
                if (resb.msuccess) {
                    [SVProgressHUD showSuccessWithStatus:@"操作成功"];
                    if (_block) {
                        _block(YES);
                    }
                    [self popViewController];
                }else{
                    [SVProgressHUD showErrorWithStatus:resb.mmsg];
                }
            }];
            
        }
        
        return;
    }
    
    if (button.tag == 12) {
        [SVProgressHUD showWithStatus:@"操作中.." maskType:SVProgressHUDMaskTypeClear];
        [SGoods delSome:selectArry block:^(SResBase *resb) {
            if (resb.msuccess) {
                [SVProgressHUD showSuccessWithStatus:resb.mmsg];
                [SVProgressHUD showSuccessWithStatus:@"操作成功"];
                
                if (_block) {
                    _block(YES);
                }
                [self popViewController];
            }else{
                [SVProgressHUD showErrorWithStatus:resb.mmsg];
            }
        }];
    }

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
    
    _mPaizhao.hidden = YES;
    _mPzText.hidden = YES;
    
}


- (IBAction)mGoPhotoClick:(id)sender {
    
    
    UIActionSheet *ac = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择", nil];
    ac.tag = 1001;
    [ac showInView:[self.view window]];
}
@end
