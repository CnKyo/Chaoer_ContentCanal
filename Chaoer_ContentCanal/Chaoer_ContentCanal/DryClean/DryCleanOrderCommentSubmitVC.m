//
//  DryCleanOrderCommitSubmitVC.m
//  Chaoer_ContentCanal
//
//  Created by 瞿伦平 on 16/8/17.
//  Copyright © 2016年 zongyoutec.com. All rights reserved.
//

#import "DryCleanOrderCommentSubmitVC.h"
#import "UIView+AutoSize.h"
#import "RateView.h"
#import "APIClient.h"
#import "UIImage+QUAdditons.h"
#import "IQTextView.h"

@interface DryCleanOrderCommentSubmitVC ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, RateViewDelegate>
@property(nonatomic,strong) UIImage *img1;
@property(nonatomic,strong) UIImage *img2;
@property(nonatomic,strong) UIImage *img3;
@property(nonatomic,strong) UIImage *img4;
@property(nonatomic,strong) NSString *imgFile1;
@property(nonatomic,strong) NSString *imgFile2;
@property(nonatomic,strong) NSString *imgFile3;
@property(nonatomic,strong) NSString *imgFile4;
@property(nonatomic,strong) UIButton *imgFileBtn1;
@property(nonatomic,strong) UIButton *imgFileBtn2;
@property(nonatomic,strong) UIButton *imgFileBtn3;
@property(nonatomic,strong) UIButton *imgFileBtn4;
@property(nonatomic,assign) BOOL    imgHaveUpdate1;
@property(nonatomic,assign) BOOL    imgHaveUpdate2;
@property(nonatomic,assign) BOOL    imgHaveUpdate3;
@property(nonatomic,assign) BOOL    imgHaveUpdate4;
@property(nonatomic,assign) NSInteger imgChooseIndex; //选择的哪一张图片

@property(nonatomic,strong) UIImageView *shopImgView;
@property(nonatomic,strong) UILabel     *shopTitleLable;
@property(nonatomic,strong) RateView     *rateView;
@property(nonatomic,strong) UILabel     *rateViewLable;
@property(nonatomic,strong) IQTextView     *noteTextView;
@end

@implementation DryCleanOrderCommentSubmitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Title = self.mPageName = @"评价";
    self.hiddenBackBtn = NO;
    self.hiddenlll = YES;
    self.hiddenRightBtn = YES;
    self.hiddenTabBar = YES;
    
    self.page = 1;
    
    [self.view bringSubviewToFront:self.scrollView];
    [self initView];
    
    
    self.shopTitleLable.text = _orderItem.mShopName.length>0 ? _orderItem.mShopName : @"暂无";
    [self.shopImgView setImageWithURL:[NSURL imageurl:_orderItem.mShopLogo] placeholderImage:IMG(@"DefaultImg.png")];
    
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

- (void)initView{

    self.scrollContentView.backgroundColor = [UIColor whiteColor];
    self.scrollView.backgroundColor = [UIColor colorWithRed:0.961 green:0.965 blue:0.969 alpha:1.000];
    UIView *superView = self.scrollContentView;
    int padding = 10;
    
    UIView *btnView = ({
        UIView *view = [self.view newUIViewWithBgColor:[UIColor colorWithRed:0.961 green:0.965 blue:0.969 alpha:1.000]];
        UIButton *btn = [view newUIButtonWithTarget:self mehotd:@selector(goSubmmitMethod:) title:@"确认提交" titleColor:[UIColor whiteColor] titleFont:[UIFont systemFontOfSize:18]];
        [btn setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithRed:0.525 green:0.753 blue:0.129 alpha:1.000]] forState:UIControlStateNormal];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.left).offset(padding);
            make.right.equalTo(view.right).offset(-padding);
            make.top.equalTo(view.top).offset(padding/2);
            make.bottom.equalTo(view.bottom).offset(-padding/2);
        }];
        view;
    });
    [btnView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(btnView.mas_width).multipliedBy(0.14);
    }];
    
    
    [self.scrollView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(64);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(btnView.top);
    }];
    
    
    UIView *aView = ({
        UIView *view = [superView newUIView];
        UIImageView *iconImgView = [view newUIImageViewWithImg:IMG(@"icon_headerdefault.png")];
        UILabel *titleLable = [view newUILableWithText:@"干洗店干洗店干洗店" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]];
        titleLable.numberOfLines = 0;
        self.shopImgView = iconImgView;
        self.shopTitleLable = titleLable;
        [iconImgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.left).offset(padding);
            make.height.equalTo(view.mas_height).multipliedBy(0.7);
            make.centerY.equalTo(view.centerY);
            make.width.equalTo(iconImgView.mas_height);
        }];
        [titleLable makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconImgView.right).offset(padding);
            make.right.equalTo(view.right).offset(-padding);
            make.top.equalTo(view.top).offset(padding/2);
            make.bottom.equalTo(view.bottom).offset(-padding/2);
        }];
        view;
    });
    UIView *lineView1 = [superView newDefaultLineView];
    UIView *bView = ({
        UIView *view = [superView newUIView];
        view.frame = CGRectMake(0, 0, DEVICE_Width, 70);
        UILabel *noteLable = [view newUILableWithText:@"满意" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:18] textAlignment:QU_TextAlignmentCenter];
        noteLable.frame = CGRectMake(0, 0, view.bounds.size.width, 30);
        
        RateView *barView = [RateView rateViewWithRating:0];
        //bar.rating = 4.0f;
        barView.starNormalColor = [UIColor colorWithRed:0.804 green:0.808 blue:0.812 alpha:1.000];
        barView.starFillColor = [UIColor colorWithRed:0.976 green:0.675 blue:0.165 alpha:1.000];
        //barView.starSize = 30;
        barView.padding = 30/4;
        barView.canRate = YES;
        barView.delegate = self;
        barView.starCount = 5;
        barView.frame = CGRectMake((view.bounds.size.width-200)/2, 30, 200, 30);
        //RatingBar *barView = [[RatingBar alloc] initWithFrame:CGRectMake((view.bounds.size.width-250)/2, 30, 250, 30)];
        [view addSubview:barView];
        self.rateViewLable = noteLable;
        self.rateView = barView;
        view;
    });
    UIView *lineView2 = [superView newDefaultLineView];
    UIView *cView = ({
        UIView *view = [superView newUIView];
        UIView *lastView = nil;
        for (int i=0; i<4; i++) {
            UIButton *btn = [view newUIButtonWithTarget:self mehotd:@selector(editPicMethod:)];
            btn.tag = 100 + i;
            [btn setBackgroundImage:IMG(@"dryClean_addPic.png") forState:UIControlStateNormal];
            switch (i) {
                case 0:
                    self.imgFileBtn1 = btn;
                    break;
                case 1:
                    self.imgFileBtn2 = btn;
                    break;
                case 2:
                    self.imgFileBtn3 = btn;
                    break;
                case 3:
                    self.imgFileBtn4 = btn;
                    break;
                default:
                    break;
            }
            [btn makeConstraints:^(MASConstraintMaker *make) {
                if (lastView == nil) {
                    make.left.equalTo(view.left);
                    make.height.equalTo(btn.mas_width);
                } else {
                    if (i == 3)
                        make.right.equalTo(view.right);
                    make.left.equalTo(lastView.right).offset(padding);
                    make.width.height.equalTo(lastView);
                }
                make.top.equalTo(view.top).offset(padding);
            }];
            lastView = btn;
        }
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lastView.bottom).offset(padding);
        }];
        view;
    });
    UILabel *noteLable = [superView newUILableWithText:@"传几张真实图片，让更多人看到" textColor:[UIColor colorWithWhite:0.3 alpha:1] font:[UIFont systemFontOfSize:13] textAlignment:QU_TextAlignmentCenter];
    IQTextView *textView = [[IQTextView alloc] init];
    [superView addSubview:textView];
    textView.placeholder = @"写下您对商家的评价或者发布你自己的看法吧～";
    textView.textColor = [UIColor grayColor];
    textView.layer.masksToBounds = YES;
    textView.layer.borderColor = [UIColor colorWithRed:0.937 green:0.941 blue:0.945 alpha:1.000].CGColor;
    textView.layer.borderWidth = 1;
    textView.layer.cornerRadius = 5;
    textView.returnKeyType = UIReturnKeyDone;
    self.noteTextView = textView;
    
    [aView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(superView);
        make.height.equalTo(aView.mas_width).multipliedBy(0.2);
    }];
    [lineView1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(aView.bottom);
        make.height.equalTo(OnePixNumber);
    }];
    [bView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(lineView1.bottom);
        make.height.equalTo(70);
    }];
    [lineView2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(bView.bottom);
        make.height.equalTo(OnePixNumber);
    }];
    [cView updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.left).offset(padding);
        make.right.equalTo(superView.right).offset(-padding);
        make.top.equalTo(lineView2.bottom);
    }];
    [noteLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cView.bottom);
        make.left.right.equalTo(cView);
        make.height.equalTo(30);
    }];
    [textView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(noteLable.bottom);
        make.left.right.equalTo(cView);
        make.height.equalTo(textView.mas_width).multipliedBy(0.3);
    }];
    

    [self.scrollContentView updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(textView.bottom).offset(padding);
    }];

}


-(void)rateView:(RateView*)rateView didUpdateRating:(float)rating
{
    if (rating > 5)
        rating = 5;
    
    self.rateViewLable.text = [NSString stringWithFormat:@"满意(%.1f)", rating];
}

-(void)editPicMethod:(UIButton *)sender
{
    NSInteger index = sender.tag - 100;
    self.imgChooseIndex = index;
    
    UIActionSheet *ac = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择", nil];
    ac.tag = 1001;
    [ac showInView:[self.view window]];
}


-(void)goSubmmitMethod:(id)sender
{
    NSMutableString *imgStr = [NSMutableString new];
    
    if (_img1 != nil) {
        if (_imgHaveUpdate1 == NO) {
            [self updateImgIndex:0];
            return;
        } else
            [imgStr appendString:_imgFile1];
    }
    
    if (_img2 != nil) {
        if (_imgHaveUpdate2 == NO) {
            [self updateImgIndex:1];
            return;
        } else {
            if (imgStr.length > 0)
                [imgStr appendString:@","];
            [imgStr appendString:_imgFile2];
        }
    }

    if (_img3 != nil) {
        if (_imgHaveUpdate3 == NO) {
            [self updateImgIndex:2];
            return;
        } else {
            if (imgStr.length > 0)
                [imgStr appendString:@","];
            [imgStr appendString:_imgFile3];
        }
    }
    
    if (_img4 != nil) {
        if (_imgHaveUpdate4 == NO) {
            [self updateImgIndex:3];
            return;
        } else {
            if (imgStr.length > 0)
                [imgStr appendString:@","];
            [imgStr appendString:_imgFile4];
        }
    }
    
    float rate = _rateView.rating;
    if (rate > 5)
        rate = 5;
    
    
    DryClearnShopOrderCommentPostObject *it = [DryClearnShopOrderCommentPostObject new];
    it.device = @"ios";
    it.userId = [Util RSAEncryptor:[NSString stringWithFormat:@"%d",[mUserInfo backNowUser].mUserId]];
    it.shopId = [Util RSAEncryptor:[NSString stringWithFormat:@"%d", _orderItem.mShopId]];
    it.orderCode = [Util RSAEncryptor:_orderItem.mOrderCode];
    it.context = _noteTextView.text;
    it.satisfaction = [NSString stringWithFormat:@"%.1f", rate];
    it.images = imgStr;
    
    [SVProgressHUD showWithStatus:@"评论中..."];
    [[APIClient sharedClient] dryClearnShopOrderCommentSubmmitWithTag:self postItem:it call:^(APIObject *info) {
        if (info.state == RESP_STATUS_YES) {
            [self performSelector:@selector(popViewController) withObject:nil afterDelay:0.5];
            [SVProgressHUD showSuccessWithStatus:info.message];
        } else
            [SVProgressHUD showErrorWithStatus:info.message];
    }];;

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
    
    UIImage* img = [info objectForKey:UIImagePickerControllerOriginalImage];

    
    [imagePickerController dismissViewControllerAnimated:YES completion:^() {
        
        switch (_imgChooseIndex) {
            case 0:
                self.img1 = img;
                self.imgHaveUpdate1 = NO;
                [self.imgFileBtn1 setBackgroundImage:img forState:UIControlStateNormal];
                break;
            case 1:
                self.img2 = img;
                self.imgHaveUpdate2 = NO;
                [self.imgFileBtn2 setBackgroundImage:img forState:UIControlStateNormal];
                break;
            case 2:
                self.img3 = img;
                self.imgHaveUpdate3 = NO;
                [self.imgFileBtn3 setBackgroundImage:img forState:UIControlStateNormal];
                break;
            case 3:
                self.img4 = img;
                self.imgHaveUpdate4 = NO;
                [self.imgFileBtn4 setBackgroundImage:img forState:UIControlStateNormal];
                break;
            default:
                break;
        }
        [self updateImgIndex:_imgChooseIndex];

    }];
    
}

-(void)updateImgIndex:(NSInteger)index
{
    UIImage *img = nil;
    switch (index) {
        case 0:
            img = self.img1;
            break;
        case 1:
            img = self.img2;
            break;
        case 2:
            img = self.img3;
            break;
        case 3:
            img = self.img4;
            break;
        default:
            break;
    }
    
    [SVProgressHUD showWithStatus:@"图片上传中..."];
    [[APIClient sharedClient] shopCommentImgUpdateWithTag:self img:img call:^(NSString *file, APIObject *info) {
        
        if (file.length > 0) {
            switch (index) {
                case 0:
                    self.imgFile1 = file;
                    self.imgHaveUpdate1 = YES;
                    break;
                case 1:
                    self.imgFile2 = file;
                    self.imgHaveUpdate2 = YES;
                    break;
                case 2:
                    self.imgFile3 = file;
                    self.imgHaveUpdate3 = YES;
                    break;
                case 3:
                    self.imgFile4 = file;
                    self.imgHaveUpdate4 = YES;
                    break;
                default:
                    break;
            }
            
            [SVProgressHUD showSuccessWithStatus:@"上传成功"];
        } else {
            if (info.message.length > 0)
                [SVProgressHUD showErrorWithStatus:info.message];
        }
    }];
}




@end
